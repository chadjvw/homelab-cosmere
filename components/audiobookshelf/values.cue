package holos

import (
	"homelab.cosmere/config/media"
	"homelab.cosmere/config/app"
)

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/advplyr/audiobookshelf"
			tag:        "2.32.1"
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

	route: main: {
		hostnames: ["books.vanwyhe.xyz", "books.vw4.lol"]
		parentRefs: [{
			name:        "external"
			namespace:   "kube-system"
			sectionName: "https"
		}]
		rules: [
			{
				backendRefs: [
					{
						group:     ""
						kind:      "Service"
						name:      "audiobookshelf"
						namespace: "default"
						port:      80
						weight:    1
					},
				]
				timeouts: {
					request: "1h"
				}
			},
		]
	}

	service: main: ports: http: port: 80
}
