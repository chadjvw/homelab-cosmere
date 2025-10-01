package holos

Component: {
	Name:      string
	Namespace: string

	Resources: CiliumBGPClusterConfig: (Name): {
		metadata: name: "cilium-bgp"
		spec: bgpInstances: [{
			name:     "node"
			localASN: 64513
			peers: [{
				name:        "opnsense"
				peerASN:     64512
				peerAddress: "10.0.10.1"
				peerConfigRef: name: "cilium-peer"
			}]
		}]
	}

	Resources: CiliumBGPPeerConfig: (Name): {
		metadata: name: "cilium-peer"
		spec: {
			authSecretRef: "bgp-auth-secret"
			gracefulRestart: {
				enabled:            true
				restartTimeSeconds: 15
			}
			families: [{
				afi:  "ipv4"
				safi: "unicast"
				advertisements: matchLabels: advertise: "bgp"
			}]
		}
	}

	Resources: CiliumBGPAdvertisement: (Name): {
		metadata: name: "bgp-advertisements"
		metadata: labels: advertise: "bgp"
		spec: advertisements: [{
			advertisementType: "Service"
			service: addresses: ["LoadBalancerIP"]
			selector: matchExpressions: [{
				key:      "io.cilium/bgp"
				operator: "NotIn"
				values: ["deny", "false"]
			}, {
				key:      "io.cilium/internal"
				operator: "NotIn"
				values: ["true"]
			}]
			attributes: communities: standard: ["64512"]
		}]
	}

	Resources: CiliumL2AnnouncementPolicy: (Name): {
		metadata: name: "l2-policy"
		spec: {
			nodeSelector: matchLabels: "kubernetes.io/os": "linux"
			loadBalancerIPs: true
			externalIPs:     true
			interfaces: ["^enp+"]
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
