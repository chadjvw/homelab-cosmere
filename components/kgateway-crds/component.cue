package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "kgateway-crds"
	Namespace:   "kgateway-system"
	Chart: {
		release: "kgateway-crds"
		name:    "oci://cr.kgateway.dev/kgateway-dev/charts/kgateway-crds"
		version: "v2.0.4"
	}

	Values: #Values
}
