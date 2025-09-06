package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "piraeus"
	Namespace: "piraeus-datastore"

	Resources: {
        LinstorCluster: LinstorCluster: {
            metadata: name:      "linstorcluster"
			metadata: namespace: Namespace
			spec: {}
        }
	}
}