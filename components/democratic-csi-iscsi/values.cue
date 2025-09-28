package holos

#Values: {
	driver: config: driver: "freenas-api-iscsi"

	csiDriver: name: "iscsi"

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
		}
	}

	controller: {
		driver: {
			enabled: true
			image: {
				registry:   "docker.io/democraticcsi/democratic-csi"
				pullPolicy: "Always"
				tag:        "next"
			}
		}
	}
}
