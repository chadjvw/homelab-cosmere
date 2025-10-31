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
			updateStrategy: type: "RollingUpdate"

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
					// renovate: datasource=docker depName=ghcr.io/squat/generic-device-plugin
					image: "ghcr.io/squat/generic-device-plugin:f4a6475"
					args: [
						"--device",
						yaml.Marshal({
							name: "zwave"
							groups: [{paths: [{path: "/dev/serial/by-id/usb-Silicon_Labs_Zooz_ZST10_700_Z-Wave_Stick_0001-if00-port0"}]}]
						}),
					]
					resources: {
						requests: {
							cpu:    "50m"
							memory: "10Mi"
						}
						limits: {
							cpu:    "50m"
							memory: "20Mi"
						}}
					ports: [{containerPort: 8080, name: "http"}]
					securityContext: privileged: true
					volumeMounts: [{
						name:      "device-plugin"
						mountPath: "/var/lib/kubelet/device-plugins"
					}, {
						name:      "dev"
						mountPath: "/dev"
					}]
				}]
				volumes: [{
					name: "device-plugin"
					hostPath: path: "/var/lib/kubelet/device-plugins"
				}, {
					name: "dev"
					hostPath: path: "/dev"
				}]
			}
		}
	}
}
