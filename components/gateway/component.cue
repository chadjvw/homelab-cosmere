package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "gateway"
	Namespace: "kube-system"

	Resources: {
		Certificate: "vanwyhe.xyz": {
			metadata: name:      "vanwyhe.xyz"
			metadata: namespace: Namespace
			spec: {
				secretName: "vanwyhe.xyz-tls"
				issuerRef: {
					name: "letsencrypt-production"
					kind: "ClusterIssuer"
				}
				commonName: "vanwyhe.xyz"
				dnsNames: [
					"vanwyhe.xyz",
					"*.vanwyhe.xyz",
				]
			}
		}
		Certificate: "int.vanwyhe.xyz": {
			metadata: name:      "int.vanwyhe.xyz"
			metadata: namespace: Namespace
			spec: {
				secretName: "int.vanwyhe.xyz-tls"
				issuerRef: {
					name: "letsencrypt-production"
					kind: "ClusterIssuer"
				}
				commonName: "int.vanwyhe.xyz"
				dnsNames: [
					"int.vanwyhe.xyz",
					"*.int.vanwyhe.xyz",
				]
			}
		}
		HTTPRoute: Redirect: {
			metadata: name:      "https-redirect"
			metadata: namespace: Namespace
			spec: {
				parentRefs: [
					{
						name:        "internal"
						namespace:   "kube-system"
						sectionName: "http"
					},
					{
						name:        "external"
						namespace:   "kube-system"
						sectionName: "http"
					},
				]
				rules: [{
					filters: [{
						requestRedirect: {
							scheme:     "https"
							statusCode: 301
						}
						type: "RequestRedirect"
					}]
				}]
			}
		}
		Gateway: {
			External: {
				metadata: name:      "external"
				metadata: namespace: Namespace
				spec: {
					gatewayClassName: "envoy"
					listeners: [{
						name:     "http"
						protocol: "HTTP"
						port:     80
						allowedRoutes: namespaces: from: "Same"
					}, {
						name:     "https"
						protocol: "HTTPS"
						port:     443
						allowedRoutes: namespaces: from: "All"
						tls: certificateRefs: [{
							kind: "Secret"
							name: "vanwyhe.xyz-tls"
						},
						]
					}]
				}
			}
			Internal: {
				metadata: name:      "internal"
				metadata: namespace: Namespace
				spec: {
					gatewayClassName: "envoy"
					listeners: [{
						name:     "http"
						protocol: "HTTP"
						port:     80
						allowedRoutes: namespaces: from: "Same"
					}, {
						name:     "https"
						protocol: "HTTPS"
						port:     443
						allowedRoutes: namespaces: from: "All"
						tls: certificateRefs: [{
							kind: "Secret"
							name: "int.vanwyhe.xyz-tls"
						}]
					}]
				}
			}
		}
	}
}
