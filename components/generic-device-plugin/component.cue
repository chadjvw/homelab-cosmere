package holos

import "encoding/yaml"

holos: Component.BuildPlan

Component: #Kustomize & {
	Name:      "generic-device-plugin"
	Namespace: "kube-system"

	Resources: DaemonSet: (Name): {
		metadata: {
			namespace: Namespace
			labels: "app.kubernetes.io/name": Name
		}

		spec: {
			selector: matchLabels: "app.kubernetes.io/name": Name
			template: metadata: labels: "app.kubernetes.io/name": Name

			template: spec: {
				priorityClassName: "system-node-critical"
				tolerations: [{
					operator: "Exists"
					effect:   "NoExecute"
				}, {
					operator: "Exists"
					effect:   "NoSchedule"
				}]
				containers: [{
					name:  "generic-device-plugin"
					image: "ghcr.io/squat/generic-device-plugin:f4a6475"
					args: [
						"--device",
						yaml.Marshal({
							name: "zwave"
							groups: [{paths: [{path: "/dev/serial/by-id/usb-Silicon_Labs_Zooz_ZST10_700_Z-Wave_Stick_0001-if00-port0"}]}]
						}),
					]
				}]
			}
		}
	}
}
