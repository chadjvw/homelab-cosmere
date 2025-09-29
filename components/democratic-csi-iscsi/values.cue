package holos

#Values: {
	csiDriver: name: "org.democratic-csi.iscsi"

	storageClasses: [{
		name:                 "iscsi"
		defaultClass:         false
		reclaimPolicy:        "Delete"
		volumeBindingMode:    "Immediate"
		allowVolumeExpansion: true
		parameters: fsType: "xfs"
		detachedVolumesFromSnapshots: "false"
	}]

	volumeSnapshotClasses: [{
		name: "iscsi"
		parameters: detachedSnapshots: "true"
	}]

	driver: existingConfigSecret: "democratic-csi-iscsi-config"
	driver: config: driver: "freenas-api-iscsi"

	node: {
		hostPID: true
		driver: {
			extraEnv: [{
				name:  "ISCSIADM_HOST_STRATEGY"
				value: "nsenter"
			}, {
				name:  "ISCSIADM_HOST_PATH"
				value: "/usr/local/sbin/iscsiadm"
			}]
			iscsiDirHostPath:     "/usr/local/etc/iscsi"
			iscsiDirHostPathType: ""
			enabled:              true
			image: {
				registry:   "ghcr.io/democratic-csi/democratic-csi"
				pullPolicy: "Always"
				tag:        "next"
			}
		}
	}

	controller: {
		driver: {
			logLevel: "debug"
			enabled:  true
			image: {
				registry:   "ghcr.io/democratic-csi/democratic-csi"
				pullPolicy: "Always"
				tag:        "next"
			}
		}
	}
}
