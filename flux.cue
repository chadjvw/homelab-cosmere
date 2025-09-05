package holos

import (
	"path"
	flux "kustomize.toolkit.fluxcd.io/kustomization/v1"
)

#ComponentConfig: {
	Name:          _
	OutputBaseDir: _

	let ArtifactPath = path.Join([OutputBaseDir, "gitops", "\(Name).kustomization.gen.yaml"], path.Unix)
	let ResourcesPath = path.Join(["deploy", OutputBaseDir, "components", Name], path.Unix)

	Artifacts: "\(Name)-kustomization": {
		artifact: ArtifactPath
		generators: [{
			kind:   "Resources"
			output: artifact
			resources: Kustomization: (Name): flux.#Kustomization & {
				metadata: name:      Name
				metadata: namespace: "flux-system"
				spec: {
					interval: "5m"
					prune:    true
                    force:    true
					path:     ResourcesPath
					sourceRef: {
						kind: "OCIRepository"
						name: "default"
					}
				}
			}
		}]
	}
}
