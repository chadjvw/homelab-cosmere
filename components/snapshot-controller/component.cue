package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "snapshot-controller"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		release: "snapshot-controller"
		name:    "oci://ghcr.io/democratic-csi/charts/snapshot-controller"
		version: "0.3.0"
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
