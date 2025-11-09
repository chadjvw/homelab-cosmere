package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/pennydreadful/bookshelf"
			tag:        "hardcover-v0.4.20.91"
		}
	}

	persistence: {
		config: {
			existingClaim: "bookshelf-audio-config"
		}
		downloads: media.torrents
		books:     media.books
	}

	service: main: ports: http: port: 8787
}
