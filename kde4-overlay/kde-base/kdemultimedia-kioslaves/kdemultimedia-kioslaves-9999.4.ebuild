# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMMODULE=kioslave
KMNAME=kdemultimedia
inherit kde4svn-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS=""
IUSE="debug encode flac vorbis"

# Tests are broken. Last checked at revision 796343.
RESTRICT="test"

DEPEND="${DEPEND}
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
	media-sound/cdparanoia
	encode? ( flac? ( >=media-libs/flac-1.1.2 )
		vorbis? ( media-libs/libvorbis ) )"
RDEPEND="${DEPEND}"
# Needed to encode mp3 files.
PDEPEND="suggested: encode? ( media-sound/lame )"

KMEXTRACTONLY="libkcddb/
	libkcompactdisc/"
KMLOADLIBS="libkcddb"

src_compile() {
	ln -s "${PREFIX}"/include/libkcddb/configbase.h \
		"${WORKDIR}"/${PN}/kioslave/audiocd/ \
		|| die "linking generated header into sources failed"

	if use encode; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_with flac Flac)
			$(cmake-utils_use_with vorbis OggVorbis)"
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OggVorbis=OFF -DWITH_Flac=OFF"
	fi

	kde4-meta_src_compile
}
