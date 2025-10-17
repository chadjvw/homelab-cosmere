package holos

import "homelab.cosmere/config/csi"

Component: Resources: PersistentVolumeClaim: {
	config: {
		apiVersion: "v1"
		metadata: name: "zwavejs-config"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: csi.config.iscsiStorageClass
		}
	}
}
