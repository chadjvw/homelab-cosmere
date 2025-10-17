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
				tag:        "11.5.0"
			}
			env: {
				ZWAVEJS_EXTERNAL_CONFIG: "/usr/src/app/store/.config-db"
			}
		}
	}

	securityContext: privileged:               true
	securityContext: allowPrivilegeEscalation: true

	persistence: {
		config: {
			existingClaim: "zwavejs-config"
			globalMounts: [{path: "/usr/src/app/store"}]
		}
		zwave: {
			enabled:      true
			type:         "hostPath"
			hostPathType: "Directory"
			hostPath:     "/dev/serial/by-id"
			globalMounts: [{path: "/dev/serial/by-id"}]
		}
	}

	service: main: {
		ports: {
			http: port: 8091
			mqtt: port: 3000
		}
	}
}
