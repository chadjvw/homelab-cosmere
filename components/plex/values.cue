package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			// repository: "ghcr.io/advplyr/audiobookshelf"
			repository: "docker.io/kennethreitz/httpbin"
			tag:        "latest"
		}
		resources: {
			requests: "gpu.intel.com/i915": "1"
			limits: "gpu.intel.com/i915":   "1"
		}
		env: {
			VERSION:      "latest"
			ADVERTISE_IP: "https://plex.vanwyhe.xyz"
			PLEX_CLAIM: valueFrom: secretKeyRef: {
				name: "plex-claim-token"
				key:  "PLEX_CLAIM"
			}
		}
	}

	securityContext: privileged: true
	securityContext: supplementalGroups: [100]

	persistence: {
		config: {
			existingClaim: "plex-config"
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

	route: main: hostnames: ["plex.vanwyhe.xyz"]

	service: main: ports: http: port: 32400
}
