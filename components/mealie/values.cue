package holos

import (
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/mealie-recipes/mealie"
			tag:        "v3.3.2"
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

	route: main: hostnames: ["noms.vanwyhe.xyz", "noms.vw4.lol"]

	service: main: ports: http: port: 9000
}
