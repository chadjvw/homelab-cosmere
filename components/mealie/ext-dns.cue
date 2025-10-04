package holos

Component: {
	Namespace: string

	Resources: DNSEntry: dns: {
		metadata: namespace: Namespace
		metadata: name:      "noms-ext-dns"
		spec: {
			dnsName: "k8s-noms.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
}
