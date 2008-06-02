# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE multimedia apps: Noatun, KsCD, Juk..."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="alsa debug encode flac htmlhandbook mp3 musicbrainz taglib theora vorbis"
LICENSE="GPL-2 LGPL-2"

DEPEND="
	kde-base/kdebase:${SLOT}
	media-sound/cdparanoia
	alsa? ( >=media-libs/alsa-lib-1.0.14a )
	encode? (
		mp3? ( media-sound/lame )
		flac? ( >=media-libs/flac-1.1.2 )
		vorbis? ( media-sound/vorbis-tools ) )
	musicbrainz? ( media-libs/musicbrainz media-libs/tunepimp )
	taglib? ( >=media-libs/taglib-1.5 )
	theora? (
		media-libs/libvorbis
		media-libs/libtheora )"
RDEPEND="${DEPEND}"

KDE4_BUILT_WITH_USE_CHECK="media-libs/xine-lib xcb"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)
		$(cmake-utils_use_with flac Flac)
		$(cmake-utils_use_with musicbrainz MusicBrainz)
		$(cmake-utils_use_with taglib Taglib)
		$(cmake-utils_use_with musicbrainz TunePimp)
		$(cmake-utils_use_with theora Theora)
		$(cmake-utils_use_with vorbis OggVorbis)"
	kde4-base_src_compile
}

src_install() {
	kde4-base_src_install
	# Fix collision protect issues with icons of the crystalsvg theme
	for i in $(< "${FILESDIR}"/icons-collision-list) ; do
		[[ -f "${D}"/usr/kde/svn/$i ]] && \
		rm "${D}"/usr/kde/svn/$i || die "Remove of $i failed"
	done
}
