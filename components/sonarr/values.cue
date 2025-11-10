package holos

import (
	"homelab.cosmere/config/app"
	"homelab.cosmere/config/media"
)

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/sonarr"
			tag:        "4.0.16"
		}
	}

	persistence: {
		config: existingClaim: "sonarr-config"
		tv:        media.tv
		downloads: media.torrents
	}

	service: main: ports: http: port: 8989
}
