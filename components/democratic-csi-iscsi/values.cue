package holos

#Values: {
	csiDriver: name: "iscsi"

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

	driver: config: {
		driver: "freenas-api-iscsi"
		httpConnection: {
			protocol: "http"
			host: valueFrom: secretKeyRef: {
				key:  "TRUENAS_IP"
				name: "democratic-csi-iscsi-truenas"
			}
			port: 80
			apiKey: valueFrom: secretKeyRef: {
				key:  "TRUENAS_API_KEY"
				name: "democratic-csi-iscsi-truenas"
			}
			allowInsecure: true
		}
		zfs: {
			datasetParentName:                  "mongo/k8s/iscsi/v"
			detachedSnapshotsDatasetParentName: "mongo/k8s/iscsi/s"
			zvolEnableReservation:              false
		}
		iscsi: {
			targetPortal: valueFrom: secretKeyRef: {
				key:  "TRUENAS_TARGET_PORTAL"
				name: "democratic-csi-iscsi-truenas"
			}
			targetPortals: []
			interface:
				namePrefix: "csi-"
			nameSuffix: "-cosmere"
			targetGroups: [{
				targetGroupPortalGroup:    8
				targetGroupInitiatorGroup: 14
				targetGroupAuthType:       "None"
			},
			]
			extentInsecureTpc:              true
			extentXenCompat:                false
			extentDisablePhysicalBlocksize: true
			extentBlocksize:                512
			extentRpm:                      "SSD"
			extentAvailThreshold:           0
		}
	}

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
			enabled: true
			image: {
				registry:   "ghcr.io/democratic-csi/democratic-csi"
				pullPolicy: "Always"
				tag:        "next"
			}
		}
	}
}
