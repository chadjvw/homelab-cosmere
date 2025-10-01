package holos

Component: {
	Name:      string
	Namespace: string

	Resources: CiliumBGPPeeringPolicy: (Name): {
		metadata: name: "bgp-peering-policy"
		spec: {
			nodeSelector: matchLabels: "kubernetes.io/os": "linux"
			virtualRouters: [{
				localASN: 64513
				serviceSelector: matchExpressions: [{
					key:      "io.cilium/bgp"
					operator: "NotIn"
					values: ["deny", "false"]
				}, {
					key:      "io.cilium/internal"
					operator: "NotIn"
					values: ["true"]
				}]
				neighbors: [{
					peerAddress:             "10.0.10.1/32"
					peerASN:                 64512
					eBGPMultihopTTL:         10
					connectRetryTimeSeconds: 120
					holdTimeSeconds:         90
					keepAliveTimeSeconds:    30
					gracefulRestart: enabled:            true
					gracefulRestart: restartTimeSeconds: 120
				}]
			}]
		}
	}

	Resources: CiliumL2AnnouncementPolicy: (Name): {
		metadata: name: "l2-policy"
		spec: {
			loadBalancerIPs: true
			externalIPs:     true
			interfaces: ["^enp+"]
			nodeSelector: matchLabels: "kubernetes.io/os": "linux"
			serviceSelector: matchExpressions: [{
				key:      "io.cilium/l2"
				operator: "Exists"
			}]
		}
	}

	Resources: CiliumLoadBalancerIPPool: (Name): {
		metadata: name: "default"
		spec: blocks: [{cidr: "10.0.40.0/24"}]
	}
}
