package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "democratic-csi-nfs"
	Namespace:   "storage"
	EnableHooks: true
	Chart: {
		release: "democratic-csi"
		name:    "oci://ghcr.io/democratic-csi/charts/democratic-csi"
		version: "0.15.0"
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
