# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE graphics-related apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="chm debug djvu gphoto2 htmlhandbook jpeg pdf scanner tetex tiff"
LICENSE="GPL-2 LGPL-2"

DEPEND="
	media-libs/lcms
	>=app-misc/strigi-0.5.9
	kde-base/qimageblitz
	>=media-gfx/exiv2-0.12
	>=media-libs/freetype-2
	media-libs/libpng
	virtual/opengl
	virtual/ghostscript
	chm? ( dev-libs/chmlib )
	djvu? ( >=app-text/djvu-3.5.17 )
	gphoto2? ( media-libs/libgphoto2 )
	jpeg? ( media-libs/jpeg )
	pdf? ( >=app-text/poppler-0.5.4 >=app-text/poppler-bindings-0.5.4 )
	scanner? ( media-gfx/sane-backends )
	tiff? ( media-libs/tiff )"

RDEPEND="${DEPEND}
	tetex? (
		|| ( >=app-text/tetex-2
			app-text/ptex
			app-text/cstetex
			app-text/dvipdfm ) )"

pkg_setup() {
	for ghostscript in app-text/ghostscript-{gnu,esp,afpl}; do
		if has_version ${ghostscript}; then
			KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
				${ghostscript} X"
		fi
	done

	use pdf && KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
		app-text/poppler-bindings qt4"

	kde4svn_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_BLITZ=ON
		-DWITH_Exiv2=ON
		$(cmake-utils_use_with chm CHM)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with gphoto2 Gphoto2)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with scanner Sane)
		$(cmake-utils_use_with tiff TIFF)"
	kde4overlay-base_src_compile
}
