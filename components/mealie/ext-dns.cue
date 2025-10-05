package holos

Component: {
	Namespace: string

	Resources: DNSEntry: {"xyz-dns": {
		metadata: namespace: Namespace
		metadata: name:      "noms-ext-xyz-dns"
		spec: {
			dnsName: "noms.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
		"lol-dns": {
			metadata: namespace: Namespace
			metadata: name:      "noms-ext-lol-dns"
			spec: {
				dnsName: "noms.vw4.lol"
				ttl:     300
				targets: ["home.vanwyhe.xyz"]
			}
		}
	}
}
