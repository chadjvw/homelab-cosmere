package holos

import "homelab.cosmere/config/csi"

Component: Resources: PersistentVolumeClaim: {
	config: {
		apiVersion: "v1"
		metadata: name: "plex-config"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "20Gi"
			storageClassName: csi.config.iscsiStorageClass
		}
	}
}
