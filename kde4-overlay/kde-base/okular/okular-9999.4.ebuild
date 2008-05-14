# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdegraphics
inherit kde4svn-meta

DESCRIPTION="Okular is an universal document viewer based on KPDF for KDE 4."
KEYWORDS=""
IUSE="chm crypt debug djvu htmlhandbook jpeg +ps pdf tiff"

DEPEND="kde-base/qimageblitz
	media-libs/freetype
	chm? ( app-doc/chmlib )
	crypt? ( app-crypt/qca:2 )
	djvu? ( >=app-text/djvu-3.5.17 )
	jpeg? ( media-libs/jpeg )
	ps? ( >=app-text/libspectre-0.2 )
	pdf? ( >=app-text/poppler-0.8
		>=app-text/poppler-bindings-0.8[qt4] )
	tiff? ( media-libs/tiff )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with chm CHM)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with ps LibSpectre)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff TIFF)"

	kde4-meta_src_compile
}
