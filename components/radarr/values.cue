package holos

import "homelab.cosmere/config/app"

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/radarr"
			tag:        "5.27.5"
		}
	}

	persistence: config: existingClaim: "radarr-config"

	service: main: ports: http: port: 7878
}
