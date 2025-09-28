package holos

Component: {
	Name: string

	Resources: ClusterSecretStore: doppler: {
		metadata: name: "doppler"
		spec: provider: doppler: {
			auth: secretRef: dopplerToken: {
				name:      "doppler-token-auth-api"
				key:       "dopplerToken"
				namespace: "security"
			}
		}
	}
}
