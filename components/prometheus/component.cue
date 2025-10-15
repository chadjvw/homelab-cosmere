package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "prometheus"
	Namespace:   "monitoring"
	EnableHooks: true
	Chart: {
		release: "prometheus"
		version: "77.14.0"
		name:    "oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack"
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
