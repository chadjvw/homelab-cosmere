package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "dns-controller"
	Namespace:   "default"
	EnableHooks: true
	Chart: {
		release: "external-dns-management"
		version: "v0.29.0"
		name:    "oci://europe-docker.pkg.dev/gardener-project/releases/charts/dns-controller-manager"
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace

	Resources: DNSProvider: cloudflare: {
		metadata: name:      "dns-provider-cloudflare"
		metadata: namespace: Namespace
		spec: {
			type: "cloudflare-dns"
			secretRef: name: "external-dns-cloudflare-api-token"
			domains: include: ["vanwyhe.xyz", "vw4.lol"]
		}
	}
}
