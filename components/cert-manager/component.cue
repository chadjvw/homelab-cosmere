package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "cert-manager"
	Namespace:   "cert-manager"
	EnableHooks: true
	Chart: {
		release: "cert-manager"
		version: "v1.19.3"
		name:    "oci://quay.io/jetstack/charts/cert-manager"
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
