package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 100
			PUID: 1000
			TZ:   "America/Denver"
		}
		image: {
			repository: "ghcr.io/jellyfin/jellyfin"
			tag:        "10.10.7"
		}
	}
	securityContext: privileged: true
	route: main: {
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: {
		config: {
			existingClaim: "jellyfin-data"
		}
		cache: {
			enabled:       true
			existingClaim: "jellyfin-cache"
			globalMounts: [{path: "/config/cache"}]
		}
		tv: {
			enabled: true
			type:    "nfs"
			server:  "PrincessDonut"
			path:    "/mnt/user/tv"
			globalMounts: [{path: "/media/tv"}]
		}
		movies: {
			enabled: true
			type:    "nfs"
			server:  "PrincessDonut"
			path:    "/mnt/user/movies"
			globalMounts: [{path: "/media/movies"}]
		}
		transcode: {
			enabled: true
			type:    "emptyDir"
		}
		dri: {
			enabled:      true
			type:         "hostPath"
			hostPathType: "Directory"
			hostPath:     "/dev/dri"
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.5.7"
		controller: "main"
		// doesnt work with l2 annouce, remove once bgp
		// externalTrafficPolicy: "Local"
		loadBalancerClass: "io.cilium/l2-announcer"
		ports: http: port: 8096
		type: "LoadBalancer"
	}
}
