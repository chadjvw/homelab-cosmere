package holos

import (
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "docker pull ghcr.io/sct/overseerr"
			tag:        "1.34.0"
		}
	}

	persistence: {
		config: {
			existingClaim: "overseerr-config"
			globalMounts: [{path: "/app/config"}]
		}
	}

	route: main: hostnames: ["req.vanwyhe.xyz"]

	service: main: ports: http: port: 5055
}
