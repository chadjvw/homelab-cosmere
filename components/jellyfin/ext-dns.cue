package holos

Component: {
	Name:      string
	Namespace: string

	Resources: DNSEntry: (Name): {
		metadata: namespace: "network"
		metadata: name:      "\(Name)-ext-dns"
		spec: {
			dnsName: "k8s-\(Name).vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
}
