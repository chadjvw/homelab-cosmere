package holos

#Values: {
	domainFilters: ["vanwyhe.xyz"]
	excludeDomains: ["int.vanwyhe.xyz"]
	env: [{
		name: "CF_API_TOKEN"
		valueFrom: secretKeyRef: {
			key:  "api-token"
			name: "external-dns-cloudflare-api-token"
		}
	}]
	extraArgs: [
		"--cloudflare-dns-records-per-page=1000",
		"--cloudflare-record-comment='provisioned by external-dns'",
		"--crd-source-apiversion=externaldns.k8s.io/v1alpha1",
		"--crd-source-kind=DNSEndpoint",
		"--gateway-name=external",
	]
	fullnameOverride: "external-dns-cloudflare"
	// podAnnotations: "secret.reloader.stakater.com/reload": "external-dns-cloudflare-secret"
	policy:   "upsert-only"
	provider: "cloudflare"
	// serviceMonitor: enabled: true
	sources: [
		"crd",
		"gateway-httproute",
		"gateway-grpcroute",
		"gateway-tlsroute",
		"gateway-tcproute",
		"gateway-udproute",
	]
	triggerLoopOnEvent: true
	txtOwnerId:         "default"
	txtPrefix:          "k8s."
}
