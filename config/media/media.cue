package media

#NfsMountPath: {
	path: string
}

#NasNfsMount: {
	enabled: bool | *true
	type:    string | *"nfs"
	server:  string | *"truenas.vanwyhe.xyz"
	path:    string
	globalMounts?: [#NfsMountPath]
}

books: #NasNfsMount & {
	path: "/mnt/mongo/data/media/books"
}

tv: #NasNfsMount & {
	path: "/mnt/mongo/data/media/tv"
}

movies: #NasNfsMount & {
	path: "/mnt/mongo/data/media/movies"
}

music: #NasNfsMount & {
	path: "/mnt/mongo/data/media/music"
}

torrents: #NasNfsMount & {
	path: "/mnt/mongo/data/torrents"
}
