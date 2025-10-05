package holos

Component: {
	Namespace: string

	Resources: DNSEntry: {"xyz-dns": {
		metadata: namespace: Namespace
		metadata: name:      "req-ext-xyz-dns"
		spec: {
			dnsName: "req.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
		"lol-dns": {
			metadata: namespace: Namespace
			metadata: name:      "req-ext-lol-dns"
			spec: {
				dnsName: "req.vw4.lol"
				ttl:     300
				targets: ["home.vanwyhe.xyz"]
			}
		}
	}
}
