package holos

#Values: {
	rollOutCiliumPods:     true
	priorityClassName:     "system-cluster-critical"
	autoDirectNodeRoutes:  true
	routingMode:           "native"
	ipv4NativeRoutingCIDR: "10.244.0.0/16"
	bandwidthManager: {
		bbr:     true
		enabled: true
	}
	endpointRoutes: enabled: true
	bpf: {
		datapathMode:    "netkit"
		masquerade:      true
		preallocateMaps: true
		events: trace: enabled: false
		events: monitorInterval: "10s"
	}
	bpfClockProbe: true
	bgpControlPlane: {
		enabled: true
	}
	enableIPv4BIGTCP: true
	k8sNetworkPolicy: {
		enabled: false
	}
	hubble: enabled:                false
	localRedirectPolicies: enabled: true
	loadBalancer: {
		acceleration: "best-effort"
		algorithm:    "maglev"
		mode:         "dsr"
	}
	operator: {
		enabled:           true
		rollOutPods:       true
		replicas:          1
		priorityClassName: "system-cluster-critical"
	}
	// enableCriticalPriorityClass: false
	// prometheus: {
	// 	enabled: true
	// 	serviceMonitor: enabled:        true
	// 	serviceMonitor: trustCRDsExist: true
	// }

	tls: secretsNamespace: create: false

	// Talos requirements
	ipam: mode: "kubernetes"
	kubeProxyReplacement: true
	securityContext: capabilities: {
		ciliumAgent: [
			"CHOWN",
			"KILL",
			"NET_ADMIN",
			"NET_RAW",
			"IPC_LOCK",
			"SYS_ADMIN",
			"SYS_RESOURCE",
			"DAC_OVERRIDE",
			"FOWNER",
			"SETGID",
			"SETUID",
		]
		cleanCiliumState: [
			"NET_ADMIN",
			"SYS_ADMIN",
			"SYS_RESOURCE",
		]
	}
	cgroup: autoMount: enabled: false
	cgroup: hostRoot: "/sys/fs/cgroup"

	k8sServiceHost: "localhost" // Kubeprism
	k8sServicePort: "7445"

	externalIPs: enabled: true
	devices: "enp+"
}
