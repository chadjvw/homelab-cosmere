package holos

Component: Resources: ClusterIssuer: {
	_common: {
		privateKeySecretRef: name: string
		solvers: [{
			dns01: cloudflare: {
				email: "postmaster@vanwyhe.xyz"
				apiTokenSecretRef: {
					name: "cloudflare-api-token-secret"
					key:  "api-token"
				}
			}
			selector: dnsZones: ["vanwyhe.xyz", "vw4.lol"]
		}]
	}

	letsencrypt_staging: {
		metadata: name: "letsencrypt-staging"
		spec: acme: {
			server: "https://acme-staging-v02.api.letsencrypt.org/directory"
			privateKeySecretRef: _common.privateKeySecretRef & {name: metadata.name}
			solvers: _common.solvers
		}
	}

	letsencrypt_prod: {
		metadata: name: "letsencrypt-production"
		spec: acme: {
			server: "https://acme-v02.api.letsencrypt.org/directory"
			privateKeySecretRef: _common.privateKeySecretRef & {name: metadata.name}
			solvers: _common.solvers
		}
	}
}
