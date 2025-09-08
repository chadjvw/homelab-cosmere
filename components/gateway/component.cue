package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "gateway"
	Namespace: "kgateway-system"

	Resources: {
		HTTPRoute: Redirect: {
			metadata: name:      "http-route"
			metadata: namespace: Namespace
			spec: {
				parentRefs: [
					{
						name:        "internal"
						namespace:   "kgateway-system"
						sectionName: "http"
					},
				]
			}
		}
		Gateway: {
			Internal: {
				metadata: name:      "internal"
				metadata: namespace: Namespace
				spec: {
					gatewayClassName: "kgateway"
					listeners: [{
						name:     "http"
						protocol: "HTTP"
						port:     80
					}]
				}
			}
		}
	}
}
