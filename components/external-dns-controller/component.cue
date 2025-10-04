package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "dns-controller"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		name:    "oci://europe-docker.pkg.dev/gardener-project/releases/charts/dns-controller-manager"
		version: "v0.28.0"
		release: "external-dns-management"
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace

	// Resources: DNSProvider: cloudflare: {
	// 	spec: {
	// 		type: "cloudflare"
	// 		secretRef: name: "external-dns-cloudflare-api-token"
	// 		domains: include: ["vanwyhe.xyz"]
	// 	}
	// }
}
