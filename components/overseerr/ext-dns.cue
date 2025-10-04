package holos

Component: {
	Namespace: string

	Resources: DNSEntry: dns: {
		metadata: namespace: Namespace
		metadata: name:      "req-ext-dns"
		spec: {
			dnsName: "k8s-req.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
}
