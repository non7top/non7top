# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase-runtime
KMMODULE=phonon
inherit kde4svn-meta

DESCRIPTION="KDE multimedia API"
KEYWORDS=""
IUSE="debug xcb"

# There's currently only a xine backend for phonon available,
# a gstreamer backend from TrollTech is in the works.
DEPEND=">=media-libs/xine-lib-1.1.9
	xcb? ( x11-libs/libxcb )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcb XCB)
		-DWITH_Xine=ON"

	kde4-meta_src_compile
}
