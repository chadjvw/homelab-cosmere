package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 1000
			PUID: 1000
			TZ:   "America/Denver"
		}
		image: {
			repository: "ghcr.io/jellyfin/jellyfin"
			tag:        "10.10.7"
		}
	}
	securityContext: privileged: true
	securityContext: supplementalGroups: [100]
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
			server:  "10.0.30.156"
			path:    "/mnt/user/tv"
			globalMounts: [{path: "/media/tv"}]
		}
		movies: {
			enabled: true
			type:    "nfs"
			server:  "10.0.30.156"
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
		controller: "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8096
		type: "LoadBalancer"
	}
}
