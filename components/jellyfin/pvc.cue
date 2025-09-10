package holos

Component: Resources: PersistentVolumeClaim: {
	data: {
		apiVersion: "v1"
		metadata: name: "jellyfin-data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "5Gi"
			storageClassName: "piraeus-storage"
		}
	}
	cache: {
		apiVersion: "v1"
		metadata: name: "jellyfin-cache"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: "piraeus-storage-file"
		}
	}
}
