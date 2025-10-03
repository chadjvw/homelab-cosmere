package holos

import "homelab.cosmere/config/media"

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
			sectionName: "http"
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
		tv:     media.tv
		movies: media.movies
		music:  media.music
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
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8096
		type: "LoadBalancer"
	}
}
