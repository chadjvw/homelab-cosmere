package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/jellyfin/jellyfin"
			tag:        "10.10.7"
		}
		resources: {
			requests: "gpu.intel.com/i915": "1"
			limits: "gpu.intel.com/i915":   "1"
		}
	}
	securityContext: privileged: true
	securityContext: supplementalGroups: [100]
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
	service: main: ports: http: port: 8096
}
