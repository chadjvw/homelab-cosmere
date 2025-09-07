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

        // https://piraeus.io/docs/stable/how-to/talos/#configure-the-drbd-module-loader
		LinstorSatelliteConfiguration: TalosLoaderOverride: {
			metadata: name: "talos-loader-override"
			spec: {
				podTemplate: spec: {
					initContainers: [
						{
							name:   "drbd-shutdown-guard"
							$patch: "delete"
						},
						{
							name:   "drbd-module-loader"
							$patch: "delete"
						},
					]
					volumes: [
						{
							name:   "run-systemd-system"
							$patch: "delete"
						}, {
							name:   "run-drbd-shutdown-guard"
							$patch: "delete"
						}, {
							name:   "systemd-bus-socket"
							$patch: "delete"
						}, {
							name:   "lib-modules"
							$patch: "delete"
						}, {
							name:   "usr-src"
							$patch: "delete"
						}, {
							name: "etc-lvm-backup"
							hostPath: path: "/var/etc/lvm/backup"
							hostPath: type: "DirectoryOrCreate"
						},
						{
							name: "etc-lvm-archive"
							hostPath: path: "/var/etc/lvm/archive"
							hostPath: type: "DirectoryOrCreate"
						},
					]
				}
			}
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
