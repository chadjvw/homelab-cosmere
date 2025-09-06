package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 1000
			PUID: 1000
			TZ:   "America/Denver"
		}
		image: {
			repository: "ghcr.io/linuxserver/smokeping"
			tag:        "2.9.0"
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.4.200"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 7878
		type: "LoadBalancer"
	}
}