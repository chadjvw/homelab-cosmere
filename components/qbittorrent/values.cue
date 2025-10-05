package holos

import (
	"homelab.cosmere/config/app"
	"homelab.cosmere/config/media"
)

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/linuxserver/qbittorrent"
			tag:        "5.1.2"
		}
		env: {
			WEBUI_PORT:      9092
			TORRENTING_PORT: 51413
		}
	}

	persistence: {
		config: existingClaim: "qbittorrent-config"
		downloads: media.torrents
	}

	service: main: {
		annotations: "lbipam.cilium.io/ips": "10.0.40.8"
		ports: {
			http: port:    9092
			torrent: port: 51413
			"torrent-udp": {
				port:     51413
				protocol: "UDP"
			}
		}
	}
}
