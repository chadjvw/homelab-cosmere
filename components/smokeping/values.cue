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
	route: main: {
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: {
		config: {
			existingClaim: "smokeping-config"
		}
		data: {
			existingClaim: "smokeping-data"
		}
	}
	service: main: {
		controller: "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 80
		type: "LoadBalancer"
	}
}
