package holos

Component: {
	Namespace: string

	Resources: DNSEntry: dns: {
		metadata: namespace: Namespace
		metadata: name:      "jellyfin-ext-dns"
		spec: {
			dnsName: "k8s-jellyfin.vanwyhe.xyz"
			ttl:     300
			targets: ["home.vanwyhe.xyz"]
		}
	}
}
