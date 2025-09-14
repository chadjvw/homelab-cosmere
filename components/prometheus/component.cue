package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "prometheus"
	Namespace:   "monitoring"
	EnableHooks: true
	Chart: {
		name:    "oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack"
		version: "77.5.0"
		release: "prometheus"
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
