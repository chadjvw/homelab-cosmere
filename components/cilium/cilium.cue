package holos

Component: {
	Name:      string
	Namespace: string

	Resources: CiliumL2AnnouncementPolicy: (Name): {
		metadata: name: "l2-policy"
		spec: {
			loadBalancerIPs: true
			externalIPs:     true
			interfaces: ["^enp+"]
			nodeSelector: matchLabels: "kubernetes.io/os": "linux"
		}
	}

	Resources: CiliumLoadBalancerIPPool: (Name): {
		metadata: name: "default"
		spec: blocks: [{cidr: "10.0.30.0/24"}]
	}
}
