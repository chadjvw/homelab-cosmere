package holos

import "homelab.cosmere/config/csi"

let driverImage = {
	registry:   "ghcr.io/democratic-csi/democratic-csi"
	pullPolicy: "Always"
	tag:        "next"
}

#Values: {
	csiDriver: name: csi.config.iscsiStorageClass

	storageClasses: [{
		name:                 csi.config.iscsiStorageClass
		defaultClass:         false
		reclaimPolicy:        "Delete"
		volumeBindingMode:    "Immediate"
		allowVolumeExpansion: true
		parameters: fsType:                       "xfs"
		parameters: detachedVolumesFromSnapshots: "false"
	}]

	volumeSnapshotClasses: [{
		name: csi.config.iscsiStorageClass
		parameters: detachedSnapshots: "true"
	}]

	driver: existingConfigSecret: csi.config.iscsiDriverConfig
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
			iscsiDirHostPath:     "/var/iscsi"
			iscsiDirHostPathType: ""
			enabled:              true
			image:                driverImage
		}
	}

	controller: {
		driver: {
			enabled: true
			image:   driverImage
		}
	}
}
