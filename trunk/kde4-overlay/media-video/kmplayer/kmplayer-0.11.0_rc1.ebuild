# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.0.0"
inherit kde4-base

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

MY_P="${P/_/-}"
DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend for KDE."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://${PN}.kde.org/pkgs/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"
IUSE="cairo npp"

DEPEND="x11-libs/libXv
	>=dev-libs/expat-2.0.1
	cairo? ( x11-libs/cairo )
	npp? ( >=dev-libs/nspr-4.6.7
			>=x11-libs/gtk+-2.10.14 )"
RDEPEND="${DEPEND}
	|| ( media-video/mplayer media-video/mplayer-bin )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use amd64 && ! has_version media-video/mplayer; then
		echo
		elog 'NOTICE: You have mplayer-bin installed; you will need to configure'
		elog 'NOTICE: kmplayer to use it from within the application.'
		echo
	fi
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=${PREFIX}
		$(cmake-utils_use_with cairo CAIRO)
		$(cmake-utils_use_with npp NPP)"
	kde4-base_src_compile
}

src_install() {
	kde4-base_src_install
	# Fix collision protect issues with icons of the oxygen theme
	for i in $(< "${FILESDIR}"/icons-collision-list) ; do
		if [[ -f "${D}"/usr/kde/4.0/$i ]]; then
			rm "${D}"/usr/kde/4.0/$i || die "Remove of $i failed."
		fi
	done
}
