package holos

import "encoding/yaml"

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: "democratic-csi-iscsi": {
		metadata: name:      "democratic-csi-iscsi-config"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: {
				engineVersion: "v2"
				data: {
					"driver-config-file.yaml": yaml.Marshal({
						driver:      "freenas-api-iscsi"
						instance_id: ""
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
							zvolEnableReservation:              false
							zvolBlocksize:                      ""
							zvolDedup:                          ""
							zvolCompression:                    ""
						}
						iscsi: {
							targetPortal: "{{ .TRUENAS_IP }}:3260"
							targetPortals: []
							interface:  ""
							namePrefix: "csi-"
							nameSuffix: "-cosmere"
							targetGroups: [{
								targetGroupPortalGroup:    8
								targetGroupInitiatorGroup: 14
								targetGroupAuthType:       "None"
							}]
							extentInsecureTpc:              true
							extentXenCompat:                false
							extentDisablePhysicalBlocksize: true
							extentBlocksize:                4096
							extentRpm:                      "SSD"
							extentAvailThreshold:           0
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
