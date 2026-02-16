package holos

import (
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/sct/overseerr"
			tag:        "1.35.0"
		}
	}

	persistence: {
		config: {
			existingClaim: "overseerr-config"
			globalMounts: [{path: "/app/config"}]
		}
	}

	route: main: hostnames: ["req.vanwyhe.xyz", "req.vw4.lol"]

	service: main: ports: http: port: 5055
}
