# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME="extragear/libs"
NEED_KDE="svn"
OPENGL_REQUIRED="optional"

inherit kde4svn-meta

DESCRIPTION="Plugins for the KDE Image Plugin Interface (libkipi)."
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="scanner"
SLOT="kde-svn"

# TODO: Check deps
DEPEND="
	media-libs/libkdcraw:${SLOT}
	media-libs/libkexiv2:${SLOT}
	media-libs/libkipi:${SLOT}
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/tiff-3.5
	scanner? ( media-gfx/sane-backends 
		media-libs/libksane:${SLOT} )
	"

RDEPEND="${DEPEND}"
# app-cdr/k3b: Burning support
# media-gfx/imagemagick: Handle many image formats
# media-video/mjpegtools: Multi image jpeg support
PDEPEND="
	suggested:
		app-cdr/k3b
		media-gfx/imagemagick
		media-video/mjpegtools
	"

# Install to KDEDIR to slot the package
PREFIX="${KDEDIR}"
PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

src_compile() {
	# This Plugin hard depends on libksane, deactivate it if use flag scanner is
	# not set.
	if ! use scanner; then
		sed -e '/acquireimages/ s:^:#DONOTCOMPILE :' -i "${S}"/${PN}/CMakeLists.txt \
			|| die "Deactivating acquireimages plugin failed."
	fi

	# Fix linkage
	sed -e '/KDE4_KDEUI_LIBS/ c\\${KDE4_KIO_LIBS}'\
		-i "${S}"/${PN}/common/libkipiplugins/CMakeLists.txt \
		|| die "Fixing kipi-plugins linkage failed."

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with OpenGl)
		$(cmake-utils_use_with scanner Sane)"

	kde4-base_src_compile
}
