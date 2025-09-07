package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "piraeus"
	Namespace: "piraeus-datastore"

	Resources: {
		LinstorCluster: LinstorCluster: {
			metadata: name: "linstorcluster"
			spec: {}
		}

		LinstorSatelliteConfiguration: pool1: {
			metadata: name: "storage-pool"
			spec: {
				storagePools: [
					{
						name: "pool1"
						fileThinPool: directory: "/var/piraeus-datastore/pool1"
					},
				]
			}
		}
	}

	Resources: {
		StorageClass: "piraeus-storage": {
			apiVersion: "storage.k8s.io/v1"
			metadata: name: "piraeus-storage"
			provisioner:          "linstor.csi.linbit.com"
			allowVolumeExpansion: true
			volumeBindingMode:    "WaitForFirstConsumer"
			parameters: "linstor.csi.linbit.com/storagePool": "pool1"
		}
	}
}
