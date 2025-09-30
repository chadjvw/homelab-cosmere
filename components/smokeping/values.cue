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
		annotations: "lbipam.cilium.io/ips": "10.0.10.25"
		controller: "main"
		// doesnt work with l2 annouce, remove once bgp
		// externalTrafficPolicy: "Local"
		loadBalancerClass: "io.cilium/l2-announcer"
		ports: http: port: 80
		type: "LoadBalancer"
	}
}
