package holos

import "homelab.cosmere/config/csi"

Component: Resources: PersistentVolumeClaim: {
	data: {
		apiVersion: "v1"
		metadata: name: "jellyfin-data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "5Gi"
				storageClassName: csi.config.iscsiStorageClass
		}
	}
	cache: {
		apiVersion: "v1"
		metadata: name: "jellyfin-cache"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: csi.config.iscsiStorageClass
		}
	}
}
