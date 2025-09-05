package holos

Component: {
	Name:      string
	Namespace: string

	Resources: CiliumGatewayClassConfig: (Name): {
        metadata: name:      Name
        metadata: namespace: Namespace,
        spec: service: ipFamilyPolicy: "SingleStack"
	}
}