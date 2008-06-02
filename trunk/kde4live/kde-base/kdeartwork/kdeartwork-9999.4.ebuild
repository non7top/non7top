# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
OPENGL_REQUIRED="optional"
inherit kde4svn

DESCRIPTION="KDE artwork package."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="debug htmlhandbook opengl xscreensaver"
LICENSE="GPL-2 LGPL-2"

DEPEND="|| ( >=kde-base/kdebase-${PV}:${SLOT}
		>=kde-base/kscreensaver-${PV}:${SLOT} )
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use opengl; then
		if has_version kde-base/kscreensaver:${SLOT}; then
			KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
				kde-base/kscreensaver:${SLOT} opengl"
		else
			KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
				kde-base/kdebase:${SLOT} opengl"
		fi
	fi

	kde4svn_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	# FIXME Unhandled CMake arguments
	# KDE4_SOUND_SUPPORT -> Build with sound support (?)

	kde4-base_src_compile
}

src_install() {
	kde4-base_src_install
	# Fix collision protect issues with icons of the crystalsvg theme
	for i in $(< "${FILESDIR}"/icons-collision-list) ; do
		if [[ -f "${D}"/usr/kde/svn/$i ]]; then
			rm "${D}"/usr/kde/svn/$i || die "Remove of $i failed"
		fi
	done
}
