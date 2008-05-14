# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdemultimedia
inherit kde4svn-meta

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS=""
IUSE="debug htmlhandbook tunepimp"

DEPEND="
	media-libs/taglib
	tunepimp? ( media-libs/tunepimp )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with tunepimp TunePimp)"
	kde4-meta_src_compile
}
