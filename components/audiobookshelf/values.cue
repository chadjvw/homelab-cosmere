package holos

import (
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
		audiobooks: {
			type:   "nfs"
			server: "truenas.vanwyhe.xyz"
			path:   "/mnt/mongo/data/media/books"
		}
	}

	route: main: hostnames: ["books.vanwyhe.xyz"]

	service: main: ports: http: port: 80
}
