# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMMODULE=kscreensaver
KMNAME=kdeartwork
OPENGL_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS=""
IUSE="debug xscreensaver"

DEPEND="${DEPEND}
	>=kde-base/kscreensaver-${PV}:${SLOT}[opengl?]
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="${DEPEND}"

ESVN_PATCHES="${FILESDIR}/${P}-xscreensaver.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4-meta_src_compile
}
