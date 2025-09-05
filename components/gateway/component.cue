package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "gateway"
	Namespace: "kube-system"

	Resources: {
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