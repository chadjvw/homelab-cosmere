package holos

#Values: {
	csiDriver: name: "nfs"

	storageClasses: [{
		name:                 "nfs"
		defaultClass:         false
		reclaimPolicy:        "Delete"
		volumeBindingMode:    "Immediate"
		allowVolumeExpansion: true
		parameters: fsType: "nfs"
		detachedVolumesFromSnapshots: "false"
		mountOptions: ["noatime", "nfsvers=4.2", "hard", "nodiratime"]
	}]

	volumeSnapshotClasses: [{
		name: "nfs"
		parameters: detachedSnapshots: "true"
	}]

	driver: config: {
		driver: "freenas-api-nfs"
		httpConnection: {
			protocol: "http"
			host: valueFrom: secretKeyRef: {
				key:  "TRUENAS_IP"
				name: "democratic-csi-nfs-truenas"
			}
			port: 80
			apiKey: valueFrom: secretKeyRef: {
				key:  "TRUENAS_API_KEY"
				name: "democratic-csi-nfs-truenas"
			}
			allowInsecure: true
		}
		zfs: {
			datasetParentName:                  "mongo/k8s/nfs/v"
			detachedSnapshotsDatasetParentName: "mongo/k8s/nfs/s"
			datasetEnableQuotas:                true
			datasetEnableReservation:           false
			datasetPermissionsMode:             "0777"
			datasetPermissionsUser:             0
			datasetPermissionsGroup:            0
		}
		nfs: {
			shareHost: valueFrom: secretKeyRef: {
				key:  "TRUENAS_IP"
				name: "democratic-csi-nfs-truenas"
			}
			shareAlldirs: false
			shareAllowedHosts: []
			shareAllowedNetworks: []
			shareMaprootUser:  "root"
			shareMaprootGroup: "root"
			shareMapallUser:   ""
			shareMapallGroup:  ""
		}
	}

	controller: {
		driver: {
			enabled: true
			image: {
				registry:   "ghcr.io/democratic-csi/democratic-csi"
				pullPolicy: "Always"
				tag:        "next"
			}
		}
	}

	node: {
		driver: {
			enabled: true
			image: {
				registry:   "ghcr.io/democratic-csi/democratic-csi"
				pullPolicy: "Always"
				tag:        "next"
			}
		}
	}
}
