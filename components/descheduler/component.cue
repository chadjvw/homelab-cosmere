package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "descheduler"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		name:    "descheduler"
		version: "0.34.0"
		repository: {
			name: "descheduler"
			url:  "https://kubernetes-sigs.github.io/descheduler/"
		}
	}
}
