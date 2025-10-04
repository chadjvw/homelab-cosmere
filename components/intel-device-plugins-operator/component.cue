package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "intel-device-plugins-operator"
	Namespace:   "node-feature-discovery"
	EnableHooks: true
	Chart: {
		name:    "intel-device-plugins-operator"
		version: "0.34.0"
		repository: {
			name: "intel"
			url:  "https://intel.github.io/helm-charts/"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
