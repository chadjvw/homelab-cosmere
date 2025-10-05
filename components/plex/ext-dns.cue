package holos

Component: {
	Namespace: string

	Resources: DNSEntry: {"xyz-dns": {
		metadata: namespace: Namespace
		metadata: name:      "plex-ext-xyz-dns"
		spec: {
			dnsName: "plex.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
		"lol-dns": {
			metadata: namespace: Namespace
			metadata: name:      "plex-ext-lol-dns"
			spec: {
				dnsName: "plex.vw4.lol"
				ttl:     300
				targets: ["home.vanwyhe.xyz"]
			}
		}
	}
}
