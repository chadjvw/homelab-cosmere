package holos

import "homelab.cosmere/config/app"

#Values: app.#ExternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			// default to httpbin for data xfer
			// repository: "ghcr.io/home-assistant/home-assistant"
			// tag:        "2025.11.0"
		}
		securityContext: privileged: true
	}

	persistence: {
		config: existingClaim: "home-assistant-config"
	}

	service: main: ports: http: port: 8123
}
