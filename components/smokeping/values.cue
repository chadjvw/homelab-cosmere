package holos

import "homelab.cosmere/config/app"

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/smokeping"
			tag:        "2.9.0"
		}
	}
	persistence: {
		config: existingClaim: "smokeping-config"
		data: existingClaim:   "smokeping-data"
	}
	service: main: ports: http: port: 80
}
