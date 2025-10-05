package holos

Component: {
	Namespace: string

	Resources: DNSEntry: {"xyz-dns": {
		metadata: namespace: Namespace
		metadata: name:      "jellyfin-ext-xyz-dns"
		spec: {
			dnsName: "jellyfin.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
		"lol-dns": {
			metadata: namespace: Namespace
			metadata: name:      "jellyfin-ext-lol-dns"
			spec: {
				dnsName: "jellyfin.vw4.lol"
				ttl:     300
				targets: ["home.vanwyhe.xyz"]
			}
		}
		"lol-dns-jf": {
			metadata: namespace: Namespace
			metadata: name:      "jf-ext-lol-dns"
			spec: {
				dnsName: "jf.vw4.lol"
				ttl:     300
				targets: ["home.vanwyhe.xyz"]
			}
		}
	}
}
