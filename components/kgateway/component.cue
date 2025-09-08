package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "kgateway"
	Namespace:   "kgateway-system"
	Chart: {
        		release: "kgateway"
		name:    "oci://cr.kgateway.dev/kgateway-dev/charts/kgateway"
		version: "v2.0.4"
	}

	Values: #Values
}
