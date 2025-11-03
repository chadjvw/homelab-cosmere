package holos

holos: Component.BuildPlan

Component: #Kustomize & {
	Name:      "flux"
	Namespace: "flux-system"
	KustomizeConfig: Kustomization: namespace: Namespace

	Resources: OCIRepository: {
		flux: {
			metadata: name:      "flux"
			metadata: namespace: Namespace
			spec: {
				interval: "10m"
				url:      "oci://ghcr.io/fluxcd/flux-manifests"
				ref: {
					// renovate: datasource=docker depName=ghcr.io/fluxcd/flux-manifests
					tag: "v2.7.3"
				}
			}
		}
		default: {
			metadata: name:      "default"
			metadata: namespace: Namespace
			spec: {
				interval: "1m"
				ref: tag: "main"
				url: "oci://ghcr.io/chadjvw/homelab/cosmere"
			}
		}
	}

	Resources: Kustomization: {
		"cluster-apps": {
			metadata: name:      "cluster-apps"
			metadata: namespace: Namespace
			spec: {
				interval: "1m"
				path:     "./gitops"
				prune:    true
				wait:     true
				sourceRef: {
					kind: "OCIRepository"
					name: "default"
				}
			}
		}
	}
}
