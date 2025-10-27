package holos

import "homelab.cosmere/config/app"

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/prowlarr"
			tag:        "2.1.5"
		}
	}
	persistence: config: existingClaim: "prowlarr-config"
	service: main: ports: http: port: 9696
}
