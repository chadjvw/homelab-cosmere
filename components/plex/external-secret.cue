package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      "plex-claim-token"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: data: "PLEX_CLAIM": "{{ .PLEX_CLAIM_TOKEN }}"
			data: [{secretKey: "PLEX_CLAIM_TOKEN", remoteRef: {key: "PLEX_CLAIM_TOKEN"}}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
