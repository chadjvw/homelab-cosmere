package holos

import "homelab.cosmere/config/app"

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/sonarr"
			tag:        "4.0.15"
		}
	}
	persistence: config: existingClaim: "sonarr-config"

	service: main: ports: http: port: 8989
}
