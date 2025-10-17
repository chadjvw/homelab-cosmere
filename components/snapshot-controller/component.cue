package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "snapshot-controller"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		release: "snapshot-controller"
		version: "0.3.0"
		name:    "oci://ghcr.io/democratic-csi/charts/snapshot-controller"
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
