package app

#AppTemplate: {
	controllers: main: containers: main: {
		env: {
			PGID: int | *1000
			PUID: int | *1000
			TZ:   string | *"America/Denver"
		}
		image: {
			repository: string
			tag:        string
		}
	}
	route: main: {
		hostnames: [string]
		parentRefs: [{
			name:        "internal" | "external"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	service: main: {
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: int
		type: "LoadBalancer"
	}
}

#InternalAppTemplate: #AppTemplate & {
	route: main: {
		hostnames: ["{{ .Release.Name }}.int.vanwyhe.xyz"]
		parentRefs: [{
			name: "internal"
		}]
	}
}

#ExternalAppTemplate: #AppTemplate & {
	route: main: {
		annotations: "external-dns.alpha.kubernetes.io/hostname": "home.vanwyhe.xyz"
		hostnames: ["{{ .Release.Name }}.vanwyhe.xyz"]
		parentRefs: [{
			name: "external"
		}]
	}
}
