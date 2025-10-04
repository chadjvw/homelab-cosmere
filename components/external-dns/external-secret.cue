package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      "external-dns-cloudflare-api-token"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: data: "api-token": "{{ .CLOUDFLARE_API_TOKEN }}"
			data: [{secretKey: "CLOUDFLARE_API_TOKEN", remoteRef: {key: "CLOUDFLARE_API_TOKEN"}}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
