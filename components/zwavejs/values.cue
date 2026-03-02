package holos

import "homelab.cosmere/config/app"

#Values: app.#InternalAppTemplate & {
	controllers: main: {
		pod: nodeSelector: {
			"attached-usb": "zwave"
		}
		containers: main: {
			image: {
				repository: "docker.io/zwavejs/zwave-js-ui"
				tag:        "11.12.0"
			}
			env: {
				ZWAVEJS_EXTERNAL_CONFIG: "/usr/src/app/store/.config-db"
			}
			resources: limits: "squat.ai/zwave": 1
			securityContext: privileged:               true
			securityContext: allowPrivilegeEscalation: true
		}
	}

	persistence: {
		config: {
			existingClaim: "zwavejs-config"
			globalMounts: [{path: "/usr/src/app/store"}]
		}
	}

	service: main: {
		ports: {
			http: port: 8091
			mqtt: port: 3000
		}
	}
}
