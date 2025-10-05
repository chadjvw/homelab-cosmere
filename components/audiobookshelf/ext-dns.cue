package holos

Component: {
	Namespace: string

	Resources: DNSEntry: {"xyz-dns": {
		metadata: namespace: Namespace
		metadata: name:      "books-ext-xyz-dns"
		spec: {
			dnsName: "books.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
		"lol-dns": {
			metadata: namespace: Namespace
			metadata: name:      "books-ext-lol-dns"
			spec: {
				dnsName: "books.vw4.lol"
				ttl:     300
				targets: ["home.vanwyhe.xyz"]
			}
		}
	}
}
