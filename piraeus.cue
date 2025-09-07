package holos

import (
	// pireaus/linstore
	linstorcluster "piraeus.io/linstorcluster/v1"
	linstornodeconnection "piraeus.io/linstornodeconnection/v1"
	linstorsatellite "piraeus.io/linstorsatellite/v1"
	linstorsatelliteconfig "piraeus.io/linstorsatelliteconfiguration/v1"
	scv1 "k8s.io/api/storage/v1"
	corev1 "k8s.io/api/core/v1"
)

#Resources: {
	// pireaus/linstore
	LinstorCluster?: [_]:                linstorcluster.#LinstorCluster
	LinstorNodeConnection?: [_]:         linstornodeconnection.#LinstorNodeConnection
	LinstorSatellite?: [_]:              linstorsatellite.#LinstorSatellite
	LinstorSatelliteConfiguration?: [_]: linstorsatelliteconfig.#LinstorSatelliteConfiguration
	StorageClass?: [_]:                  scv1.#StorageClass
	PersistentVolumeClaim?: [_]:         corev1.#PersistentVolumeClaim
}
