package holos

import ("encoding/yaml"
	"homelab.cosmere/config/csi"
)

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: "iscsi-driver-config-secret": {
		metadata: name:      csi.config.iscsiDriverConfig
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: {
				engineVersion: "v2"
				data: {
					"driver-config-file.yaml": yaml.Marshal({
						driver:      "freenas-api-iscsi"
						instance_id: null
						httpConnection: {
							protocol:      "http"
							host:          "{{ .TRUENAS_IP }}"
							port:          80
							apiKey:        "{{ .TRUENAS_API_KEY }}"
							allowInsecure: true
						}
						zfs: {
							datasetParentName:                  "mongo/k8s/iscsi/v"
							detachedSnapshotsDatasetParentName: "mongo/k8s/iscsi/s"
							datasetProperties: "org.freenas:description": "{{ `{{ parameters.[csi.storage.k8s.io/pvc/namespace] }}/{{ parameters.[csi.storage.k8s.io/pvc/name] }}` }}"
							zvolEnableReservation: false
							// zvolBlocksize:         ""
							// zvolDedup:             ""
							// zvolCompression:       ""
						}
						iscsi: {
							targetPortal: "{{ .TRUENAS_IP }}:3260"
							targetPortals: []
							interface:  ""
							namePrefix: "csi-"
							nameSuffix: "-cosmere"
							targetGroups: [{
								targetGroupPortalGroup:    1
								targetGroupInitiatorGroup: 1
								targetGroupAuthType:       "None"
							}]
							extentCommentTemplate: "{{ `{{ parameters.[csi.storage.k8s.io/pvc/namespace] }}/{{ parameters.[csi.storage.k8s.io/pvc/name] }}` }}"
							extentInsecureTpc:     true
							extentXenCompat:       false
							// extentDisablePhysicalBlocksize: true
							extentBlocksize:      512
							extentRpm:            "SSD"
							extentAvailThreshold: 0
						}
					})
				}
			}
			data: [
				{secretKey: "TRUENAS_IP", remoteRef: {key: "TRUENAS_IP"}},
				{secretKey: "TRUENAS_API_KEY", remoteRef: {key: "TRUENAS_API_KEY"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
