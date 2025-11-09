package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/advplyr/audiobookshelf"
			tag:        "2.30.0"
		}
	}

	persistence: {
		config: {
			existingClaim: "audiobookshelf-config"
		}
		metadata: {
			existingClaim: "audiobookshelf-metadata"
		}
		audiobooks: media.books
	}

	route: main: hostnames: ["books.vanwyhe.xyz", "books.vw4.lol"]

	service: main: ports: http: port: 80
}
