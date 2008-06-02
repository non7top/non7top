# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE graphics-related apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE=""
LICENSE="GPL-2 LGPL-2"

DEPEND=""

RDEPEND="${DEPEND}"

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
	kde4-base_src_compile
}
