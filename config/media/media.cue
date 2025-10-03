package media

#NfsMountPath: {
	path: string
}

#NasNfsMount: {
	enabled: bool | *true
	type:    string | *"nfs"
	server:  string | *"nas.int.vanwyhe.xyz"
	path:    string
	globalMounts: [#NfsMountPath]
}

tv: #NasNfsMount & {
	path: "/mnt/mongo/data/media/tv"
	globalMounts: [{path: "/media/tv"}]
}

movies: #NasNfsMount & {
	path: "/mnt/mongo/data/media/movies"
	globalMounts: [{path: "/media/movies"}]
}

music: #NasNfsMount & {
	path: "/mnt/mongo/data/media/music"
	globalMounts: [{path: "/media/music"}]
}
