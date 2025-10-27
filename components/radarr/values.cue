package holos

import (
	"homelab.cosmere/config/app"
	"homelab.cosmere/config/media"
)

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/radarr"
			tag:        "5.28.0"
		}
	}

	persistence: {
		config: existingClaim: "radarr-config"
		movies:    media.movies
		downloads: media.torrents
	}

	service: main: ports: http: port: 7878
}
