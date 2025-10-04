package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
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

	route: main: hostnames: ["plex.vanwyhe.xyz"]

	service: main: ports: http: port: 32400
}
