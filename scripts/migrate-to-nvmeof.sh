#!/usr/bin/env bash
# migrate-to-nvmeof.sh <app>
# Migrates an app's PVCs from iSCSI to NVMe-oF using pv-migrate.
# Expects <pvc>-nvmeof destination PVCs to already exist (created by Flux).
set -euo pipefail

NAMESPACE="default"

PATH="$PATH:/home/chad/.krew/bin"

# ── colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; BOLD='\033[1m'; NC='\033[0m'
info()  { echo -e "${BLUE}[info]${NC}  $*"; }
ok()    { echo -e "${GREEN}[ok]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[warn]${NC}  $*"; }
err()   { echo -e "${RED}[error]${NC} $*" >&2; exit 1; }
header(){ echo -e "\n${BOLD}${BLUE}── $* ──${NC}"; }

confirm() {
    local prompt="${1:-Continue?}"
    echo -e "${YELLOW}?${NC} ${prompt} [y/N] " && read -r _resp
    [[ "$_resp" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 1; }
}

# ── args & deps ───────────────────────────────────────────────────────────────
APP="${1:-}"
[[ -z "$APP" ]] && { echo "Usage: $0 <app-name>"; exit 1; }

for cmd in kubectl flux; do
    command -v "$cmd" &>/dev/null || err "'$cmd' not found in PATH"
done
kubectl pv-migrate --version &>/dev/null || err "'kubectl pv-migrate' plugin not found"

# ── 1. verify HelmRelease ─────────────────────────────────────────────────────
header "Checking app '$APP'"

HR_NS=""
for ns in "$NAMESPACE" flux-system; do
    if kubectl get helmrelease "$APP" -n "$ns" &>/dev/null; then
        HR_NS="$ns"
        break
    fi
done
[[ -z "$HR_NS" ]] && err "HelmRelease '$APP' not found in namespace '$NAMESPACE' or 'flux-system'"
ok "HelmRelease '$APP' found in namespace '$HR_NS'"

HR_STATUS=$(kubectl get helmrelease "$APP" -n "$HR_NS" -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}')
HR_REASON=$(kubectl get helmrelease "$APP" -n "$HR_NS" -o jsonpath='{.status.conditions[?(@.type=="Ready")].message}')
info "HelmRelease status: Ready=${HR_STATUS} — ${HR_REASON}"

# ── 2. find workload ──────────────────────────────────────────────────────────
WORKLOAD_KIND=""
WORKLOAD_NAME="$APP"
if kubectl get deployment "$APP" -n "$NAMESPACE" &>/dev/null; then
    WORKLOAD_KIND="deployment"
elif kubectl get statefulset "$APP" -n "$NAMESPACE" &>/dev/null; then
    WORKLOAD_KIND="statefulset"
else
    # Try with common suffixes (e.g. app-template names)
    err "No deployment or statefulset named '$APP' found in namespace '$NAMESPACE'"
fi
ok "Found $WORKLOAD_KIND/$WORKLOAD_NAME"

CURRENT_REPLICAS=$(kubectl get "$WORKLOAD_KIND" "$WORKLOAD_NAME" -n "$NAMESPACE" \
    -o jsonpath='{.spec.replicas}')
info "Current replicas: $CURRENT_REPLICAS"

# ── 3. discover PVCs ──────────────────────────────────────────────────────────
header "Discovering PVCs"

ALL_PVCS=$(kubectl get "$WORKLOAD_KIND" "$WORKLOAD_NAME" -n "$NAMESPACE" \
    -o jsonpath='{range .spec.template.spec.volumes[*]}{.persistentVolumeClaim.claimName}{"\n"}{end}' \
    | grep -v '^$' || true)

[[ -z "$ALL_PVCS" ]] && err "No PVC volumes found in $WORKLOAD_KIND/$WORKLOAD_NAME"

ISCSI_PVCS=()
while IFS= read -r pvc; do
    SC=$(kubectl get pvc "$pvc" -n "$NAMESPACE" \
        -o jsonpath='{.spec.storageClassName}' 2>/dev/null || echo "")
    if [[ "$SC" == "org.democratic-csi.iscsi" ]]; then
        ISCSI_PVCS+=("$pvc")
    else
        info "Skipping '$pvc' (storageClass: ${SC:-not found})"
    fi
done <<< "$ALL_PVCS"

[[ ${#ISCSI_PVCS[@]} -eq 0 ]] && err "No iSCSI PVCs found — app may already be migrated"

# ── 4. verify destinations ────────────────────────────────────────────────────
header "Migration plan"

PAIRS=()
ALL_OK=true
for pvc in "${ISCSI_PVCS[@]}"; do
    dest="${pvc}-nvmeof"
    SIZE=$(kubectl get pvc "$pvc" -n "$NAMESPACE" \
        -o jsonpath='{.spec.resources.requests.storage}')
    DEST_PHASE=$(kubectl get pvc "$dest" -n "$NAMESPACE" \
        -o jsonpath='{.status.phase}' 2>/dev/null || echo "NOT FOUND")
    DEST_SC=$(kubectl get pvc "$dest" -n "$NAMESPACE" \
        -o jsonpath='{.spec.storageClassName}' 2>/dev/null || echo "")

    if [[ "$DEST_PHASE" == "Bound" && "$DEST_SC" == "org.democratic-csi.nvmeof" ]]; then
        echo -e "  ${GREEN}✓${NC} $pvc (${SIZE}, iSCSI)  →  $dest [${DEST_PHASE}]"
        PAIRS+=("${pvc}:${dest}")
    else
        echo -e "  ${RED}✗${NC} $pvc  →  $dest [${DEST_PHASE:-NOT FOUND}, sc=${DEST_SC:-unknown}]"
        ALL_OK=false
    fi
done

echo ""
$ALL_OK || err "One or more destination PVCs are not ready. Has Flux reconciled the pvc.yaml changes?"

confirm "Proceed with migrating ${#PAIRS[@]} PVC(s) for app '$APP'?"

# ── 5. suspend HelmRelease ────────────────────────────────────────────────────
header "Suspend HelmRelease"
info "This pauses Flux reconciliation for '$APP'."
confirm "Suspend HelmRelease '$APP' in '$HR_NS'?"
flux suspend hr "$APP" -n "$HR_NS"
ok "HelmRelease '$APP' suspended"

# ── 6. scale down ─────────────────────────────────────────────────────────────
header "Scale down workload"
info "Scaling down $WORKLOAD_KIND/$WORKLOAD_NAME to 0 replicas to free RWO PVCs."
confirm "Scale down $WORKLOAD_KIND/$WORKLOAD_NAME?"
kubectl scale "$WORKLOAD_KIND" "$WORKLOAD_NAME" --replicas=0 -n "$NAMESPACE"

info "Waiting for pods to terminate (timeout: 120s)..."
# Try common label selectors
TERMINATED=false
for selector in "app.kubernetes.io/name=$APP" "app.kubernetes.io/instance=$APP" "app=$APP"; do
    PODS=$(kubectl get pods -n "$NAMESPACE" -l "$selector" --no-headers 2>/dev/null | wc -l)
    if [[ "$PODS" -gt 0 ]]; then
        kubectl wait --for=delete pod -l "$selector" -n "$NAMESPACE" --timeout=120s && TERMINATED=true && break
    fi
done

if $TERMINATED; then
    ok "All pods terminated"
else
    warn "Could not confirm pod termination via label selector."
    kubectl get pods -n "$NAMESPACE" | grep "$APP" || true
    confirm "Pods appear gone (or label selector didn't match). Safe to continue?"
fi

# Wait for CSI to fully detach the source volumes — a stale lock will cause
# pv-migrate's rsync pod to hang in ContainerCreating and eventually time out.
info "Waiting for iSCSI PVCs to detach from the node (CSI lock release)..."
for pvc in "${ISCSI_PVCS[@]}"; do
    PV=$(kubectl get pvc "$pvc" -n "$NAMESPACE" -o jsonpath='{.spec.volumeName}')
    info "  Polling $pvc (PV: $PV)..."
    for i in $(seq 1 30); do
        ATTACHED=$(kubectl get volumeattachment -o jsonpath=\
"{range .items[?(@.spec.source.persistentVolumeName=='${PV}')]}{.status.attached}{end}" 2>/dev/null || echo "")
        if [[ "$ATTACHED" != "true" ]]; then
            ok "  $pvc detached"
            break
        fi
        [[ $i -eq 30 ]] && { warn "  $pvc still attached after 30s — continuing anyway"; break; }
        sleep 1
    done
done

# ── 7. pv-migrate ─────────────────────────────────────────────────────────────
header "Data migration"

for pair in "${PAIRS[@]}"; do
    src="${pair%%:*}"
    dst="${pair##*:}"
    SRC_SIZE=$(kubectl get pvc "$src" -n "$NAMESPACE" -o jsonpath='{.spec.resources.requests.storage}')
    echo ""
    info "Source:      $src (${SRC_SIZE}, iSCSI)"
    info "Destination: $dst (NVMe-oF)"
    confirm "Run pv-migrate: $src → $dst?"
    kubectl pv-migrate --source="$src" --dest="$dst" --source-namespace="$NAMESPACE" --dest-namespace="$NAMESPACE"
    ok "pv-migrate complete: $src → $dst"
done

# ── 8. prompt for git changes ─────────────────────────────────────────────────
header "Manual git steps"

echo -e "${BOLD}Before resuming, you must commit and push:${NC}"
echo ""
echo "  1. Update Helm values to reference the new PVC names:"
for pair in "${PAIRS[@]}"; do
    src="${pair%%:*}"; dst="${pair##*:}"
    echo -e "       ${RED}${src}${NC}  →  ${GREEN}${dst}${NC}"
done
echo ""
echo "  2. Remove the iSCSI PVC entries from the app's pvc.yaml"
echo "     (keep the -nvmeof entries)"
echo ""
echo "  3. git commit && git push"
echo ""
confirm "Changes committed and pushed to git?"

# ── 9. summary ────────────────────────────────────────────────────────────────
header "Done"
ok "Migration complete for '$APP' — HelmRelease left suspended"
echo ""
info "When ready to resume:"
echo "  flux resume hr $APP -n $HR_NS"
