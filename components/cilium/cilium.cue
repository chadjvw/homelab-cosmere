package holos

Component: {
	Name:      string
	Namespace: string

	// Resources: CiliumL2AnnouncementPolicy: (Name): {
	// 	metadata: name: "l2-policy"
	// 	spec: {
	// 		loadBalancerIPs: true
	// 		interfaces: ["^enp+"]
	// 		nodeSelector: matchLabels: "kubernetes.io/os": "linux"
	// 	}
	// }

	Resources: CiliumLoadBalancerIPPool: (Name): {
		metadata: name: "default"
		spec: blocks: [{cidr: "192.168.5.0/24"}]
	}
}