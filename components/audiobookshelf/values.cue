package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/advplyr/audiobookshelf"
			tag:        "2.29.0"
		}
	}

	persistence: {
		config: {
			existingClaim: "audiobookshelf-config"
		}
		metadata: {
			existingClaim: "audiobookshelf-metadata"
		}
		books: media.books
	}

	service: main: ports: http: port: 80
}
