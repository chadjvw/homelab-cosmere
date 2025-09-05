package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "gateway"
	Namespace: "kube-system"

	Resources: {
        HTTPRoute: Redirect: {
			metadata: name:      "http-route"
			metadata: namespace: Namespace
			spec: {
				parentRefs: [
					{
						name:        "internal"
						namespace:   "kube-system"
						sectionName: "http"
					}
				]
			}
		}
        Gateway: {
			Internal: {
				metadata: name:      "internal"
				metadata: namespace: Namespace
				spec: {
                    gatewayClassName: "cilium"
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