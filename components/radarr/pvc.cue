package holos

import "homelab.cosmere/config/csi"

Component: Resources: PersistentVolumeClaim: {
	config: {
		apiVersion: "v1"
		metadata: name: "radarr-config"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "2Gi"
			storageClassName: csi.config.iscsiStorageClass
		}
	}
}
