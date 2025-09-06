package holos

holos: Component.BuildPlan

Component: #Kustomize & {
	Name:      "flux"
	Namespace: "flux-system"
	KustomizeConfig: Kustomization: namespace: Namespace
	Resources: OCIRepository: {
		flux: {
			metadata: name:      "flux"
			metadata: namespace: Namespace
			spec: {
				interval: "10m"
				ref: {
					// renovate: datasource=github-releases depName=fluxcd/flux2
					tag: "v2.6.4"
				}
				url: "oci://ghcr.io/fluxcd/flux-manifests"
			}
		}
		default: {
			metadata: name:      "default"
			metadata: namespace: Namespace
			spec: {
				interval: "1m"
				ref: tag: "main"
				url: "oci://ghcr.io/chadjvw/homelab/cosmere"
			}
		}
	}

	Resources: Kustomization: "cluster-apps": {
		metadata: name:      "cluster-apps"
		metadata: namespace: Namespace
		spec: {
			interval: "1m"
			path:     "./gitops"
			prune:    true
			wait:     true
			sourceRef: {
				kind: "OCIRepository"
				name: "default"
			}
		}
	}
}
