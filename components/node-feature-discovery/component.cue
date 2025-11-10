package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "node-feature-discovery"
	Namespace:   "node-feature-discovery"
	EnableHooks: true
	Chart: {
		release: "node-feature-discovery"
		version: "0.18.3"
		name:    "oci://registry.k8s.io/nfd/charts/node-feature-discovery"
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
