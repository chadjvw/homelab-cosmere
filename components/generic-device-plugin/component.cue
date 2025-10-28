package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "generic-device-plugin"
	Namespace: "kube-system"

	Resources: DaemonSet: "generic-device-plugin": {
		metadata: {
			name:      "generic-device-plugin"
			namespace: "kube-system"
			labels: "app.kubernetes.io/name": "generic-device-plugin"
		}

		spec: {
			selector: matchLabels: "app.kubernetes.io/name": "generic-device-plugin"
			template: metadata: labels: "app.kubernetes.io/name": "generic-device-plugin"

			template: spec: {
				priorityClassName: "system-node-critical"
				tolerations: [{
					operator: "Exists"
					effect:   "NoExecute"
				}, {
					operator: "Exists"
					effect:   "NoSchedule"
				}]
				containers: {
					image: "ghcr.io/squat/generic-device-plugin"
					tag:   "f4a6475"
					args: [
						"--device={\"name\": \"zwave\", \"groups\": [{\"paths\": [{\"path\": \"/dev/serial/by-id/usb-Silicon_Labs_Zooz_ZST10_700_Z-Wave_Stick_0001-if00-port0\"}]}]}",
					]
				}
			}
		}
	}
}
