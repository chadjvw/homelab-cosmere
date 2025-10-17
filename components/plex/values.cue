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
				repository: "ghcr.io/linuxserver/plex"
				tag:        "1.42.2"
			}
			resources: {
				requests: "gpu.intel.com/i915": "1"
				limits: "gpu.intel.com/i915":   "1"
			}
			env: {
				VERSION: "latest"
				PLEX_CLAIM: valueFrom: secretKeyRef: {
					name: "plex-claim-token"
					key:  "PLEX_CLAIM"
				}
			}
		}
	}

	securityContext: privileged: true
	securityContext: supplementalGroups: [100]

	persistence: {
		config: {
			existingClaim: "plex-config"
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

	route: main: hostnames: ["plex.vanwyhe.xyz", "plex.vw4.lol"]

	service: main: ports: http: port: 32400
}
