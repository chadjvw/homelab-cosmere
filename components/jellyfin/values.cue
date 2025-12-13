package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: {
		pod: nodeSelector: {
			"intel-igpu": "intel-graphics-24eu"
		}
		containers: main: {
			image: {
				repository: "ghcr.io/linuxserver/jellyfin"
				tag:        "10.11.4"
			}
			securityContext: privileged: true
			securityContext: supplementalGroups: [100]
		}
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

	route: main: {
		hostnames: ["jellyfin.vanwyhe.xyz", "jellyfin.vw4.lol", "jf.vw4.lol"]
		parentRefs: [{
			name:        "external"
			namespace:   "kube-system"
			sectionName: "https"
		}]
		rules: [
			{
				backendRefs: [
					{
						group:     ""
						kind:      "Service"
						name:      "jellyfin"
						namespace: "default"
						port:      8096
						weight:    1
					},
				]
				timeouts: {
					request: "1h"
				}
			},
		]
	}

	service: main: ports: http: port: 8096
}
