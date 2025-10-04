package holos

Component: {
	Namespace: string

	Resources: DNSEntry: dns: {
		metadata: namespace: Namespace
		metadata: dnsHost:   "plex"
		metadata: name:      "\(metadata.dnsHost)-ext-dns"
		spec: {
			dnsName: "k8s-\(metadata.dnsHost).vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
}
