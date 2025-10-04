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
		env: {
			ALLOW_SIGNUP: false
			BASE_URL:     "https://noms.vanwyhe.xyz"
			TOKEN_TIME:   2160
		}
	}

	persistence: {
		data: {
			existingClaim: "mealie-data"
			globalMounts: [{path: "/app/data"}]
		}
	}

	route: main: hostnames: ["noms.vanwyhe.xyz"]

	service: main: ports: http: port: 9000
}
