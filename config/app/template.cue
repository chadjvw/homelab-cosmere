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
		hostnames: [...string]
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
		hostnames: ["{{ .Release.Name }}.int.vanwyhe.xyz", "{{ .Release.Name }}.i.vw4.lol", "{{ .Release.Name }}.int.vw4.lol"]
		parentRefs: [{
			name: "internal"
		}]
	}
}

#ExternalAppTemplate: #AppTemplate & {
	route: main: {
		parentRefs: [{
			name: "external"
		}]
	}
}
