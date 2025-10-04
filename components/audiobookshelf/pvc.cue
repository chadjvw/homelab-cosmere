package holos

import "homelab.cosmere/config/csi"

Component: Resources: PersistentVolumeClaim: {
	config: {
		apiVersion: "v1"
		metadata: name: "audiobookshelf-config"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: csi.config.iscsiStorageClass
		}
	}
	metadata: {
		apiVersion: "v1"
		metadata: name: "audiobookshelf-metadata"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "10Gi"
			storageClassName: csi.config.iscsiStorageClass
		}
	}
}
