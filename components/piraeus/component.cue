package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "piraeus"
	Namespace: "piraeus-datastore"

	Resources: {
        LinstorCluster: LinstorCluster: {
            metadata: name:      "linstorcluster"
			spec: {}
        }

        LinstorSatelliteConfiguration: pool1: {
            metadata: name:      "storage-pool"
			spec: {
                storagePools: [
                    {
                        name: "pool1",
                        fileThinPool: directory: "/var/piraeus-datastore/pool1"
                    }
                ]
            }
        }
	}
}