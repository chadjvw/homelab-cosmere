package holos

import "homelab.cosmere/config/app"

#Values: app.#InternalAppTemplate & {
	controllers: main: containers: main: {
		image: {
			// default to httpbin for data xfer
			// repository: "docker.io/nodered/node-red"
			// tag:        "4.1.1"
		}
	}

	persistence: {
		data: existingClaim: "node-red-data"
	}

	service: main: ports: http: port: 1880
}
