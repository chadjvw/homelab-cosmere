package holos

import "homelab.cosmere/config/app"

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/smokeping"
			tag:        "5.1.2"
		}
	}

	persistence: config: existingClaim: "qbittorrent-config"

	service: main: ports: http: port: 9092
}
