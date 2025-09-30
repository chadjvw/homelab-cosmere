package csi

#CsiConfig: {
	iscsiStorageClass: string
	iscsiDriverConfig: string
}

config: #CsiConfig & {
	iscsiStorageClass: "org.democratic-csi.iscsi"
	iscsiDriverConfig: "truenas-iscsi-driver-config"
}
