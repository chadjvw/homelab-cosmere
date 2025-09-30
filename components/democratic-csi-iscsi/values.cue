package holos

let driverName = "org.democratic-csi.iscsi"
let driverImage = {
	registry:   "ghcr.io/democratic-csi/democratic-csi"
	pullPolicy: "Always"
	tag:        "next"
}

#Values: {
	csiDriver: name: driverName

	storageClasses: [{
		name:                 driverName
		defaultClass:         false
		reclaimPolicy:        "Delete"
		volumeBindingMode:    "Immediate"
		allowVolumeExpansion: true
		parameters: fsType:                       "xfs"
		parameters: detachedVolumesFromSnapshots: "false"
	}]

	volumeSnapshotClasses: [{
		name: driverName
		parameters: detachedSnapshots: "true"
	}]

	driver: existingConfigSecret: "truenas-iscsi-driver-config"
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
			logLevel: "debug"
			enabled:  true
			image:    driverImage
		}
	}
}
