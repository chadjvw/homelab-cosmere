package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/jellyfin"
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
		tv: media.tv & {
			globalMounts: [{path: "/media/tv"}]
		}
		movies: media.movies & {
			globalMounts: [{path: "/media/movies"}]
		}
		music: media.music & {
			globalMounts: [{path: "/media/music"}]
		}
		transcode: {
			enabled:   true
			medium:    "Memory"
			sizeLimit: "4Gi"
			type:      "emptyDir"
		}
		dri: {
			enabled:      true
			type:         "hostPath"
			hostPathType: "Directory"
			hostPath:     "/dev/dri"
		}
	}

	route: main: hostnames: ["jellyfin.vanwyhe.xyz"]

	service: main: ports: http: port: 8096
}
