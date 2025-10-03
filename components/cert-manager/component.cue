package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "cert-manager"
	Namespace:   "cert-manager"
	EnableHooks: true
	Chart: {
		name:    "oci://quay.io/jetstack/charts/cert-manager"
		release: "cert-manager"
		version: "v1.18.2"
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
