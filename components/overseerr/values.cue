package holos

import (
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			// repository: "ghcr.io/advplyr/audiobookshelf"
			repository: "docker.io/kennethreitz/httpbin"
			tag:        "latest"
		}
	}

	persistence: {
		config: {
			existingClaim: "overseerr-config"
			globalMounts: [{path: "/app/config"}]
		}
	}

	service: main: ports: http: port: 5055
}
