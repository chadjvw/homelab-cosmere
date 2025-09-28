package holos

#Values: {
	driver: config: driver: "freenas-api-nfs"

	csiDriver: name: "nfs"

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
