package holos

import "homelab.cosmere/config/csi"

Component: Resources: PersistentVolumeClaim: {
	data: {
		apiVersion: "v1"
		metadata: name: "mealie-data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: csi.config.iscsiStorageClass
		}
	}
}
