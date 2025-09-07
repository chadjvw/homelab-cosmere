package holos

Component: {
	Name:      string
	Namespace: string
	Resources: {
		StorageClass: (Name): {
			metadata: name: "piraeus-storage"
			provisioner:          "linstor.csi.linbit.com"
			allowVolumeExpansion: true
			volumeBindingMode:    "WaitForFirstConsumer"
			parameters: "linstor.csi.linbit.com/storagePool": "pool1"
		}
	}
}
