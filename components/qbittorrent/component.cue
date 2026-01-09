package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "qbittorrent"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "4.6.0"
		release: "qbit"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	APIVersions: ["gateway.networking.k8s.io/v1/HTTPRoute"]

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
