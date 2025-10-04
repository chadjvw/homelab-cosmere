package holos

Component: {
	Namespace: string

	Resources: DNSEntry: dns: {
		metadata: namespace: Namespace
		metadata: name:      "books-ext-dns"
		spec: {
			dnsName: "books.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
}
