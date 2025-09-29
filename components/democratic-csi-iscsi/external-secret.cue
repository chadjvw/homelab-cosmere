package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: "democratic-csi-iscsi": {
		metadata: name:      "democratic-csi-iscsi-truenas"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: {
				engineVersion: "v2"
				data: {
					TRUENAS_IP:            "{{ .TRUENAS_IP }}"
					TRUENAS_TARGET_PORTAL: "{{ .TRUENAS_IP }}:3260"
					TRUENAS_API_KEY:       "{{ .TRUENAS_API_KEY }}"
				}
			}
			data: [
				{secretKey: "TRUENAS_IP", remoteRef: {key: "TRUENAS_IP"}},
				{secretKey: "TRUENAS_API_KEY", remoteRef: {key: "TRUENAS_API_KEY"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
