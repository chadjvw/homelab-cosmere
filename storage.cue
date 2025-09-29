package holos

import (
	vs "snapshot.storage.k8s.io/volumesnapshot/v1"
	vsc "snapshot.storage.k8s.io/volumesnapshotclass/v1"
	vscontent "snapshot.storage.k8s.io/volumesnapshotcontent/v1"
)

#Resources: {
	VolumeSnapshot?: [_]:        vs.#VolumeSnapshot
	VolumeSnapshotClass?: [_]:   vsc.#VolumeSnapshotClass
	VolumeSnapshotContent?: [_]: vscontent.#VolumeSnapshotContent
}
