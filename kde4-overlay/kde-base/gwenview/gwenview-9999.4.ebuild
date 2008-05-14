# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdegraphics
inherit kde4svn-meta

DESCRIPTION="KDE image viewer"
KEYWORDS=""
IUSE="debug htmlhandbook kipi +semantic-desktop"
RESTRICT="test"

DEPEND="kde-base/kdelibs:${SLOT}[semantic-desktop?]
	media-gfx/exiv2
	media-libs/jpeg
	kipi? ( media-libs/libkipi:${SLOT} )
	semantic-desktop? ( kde-base/nepomuk:${SLOT} )"
RDEPEND="${DEPEND}"
# Required for svg support
PDEPEND="suggested: kde-base/svgpart:${SLOT}"

# Needed to find the slotted libkipi
PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

src_compile() {
	# Disable Kipi support until it has been added.
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kipi KIPI)"
	if use semantic-desktop; then
		mycmakeargs="${mycmakeargs}
			-DGWENVIEW_METADATA_BACKEND=Nepomuk"
	else
		mycmakeargs="${mycmakeargs}
			-DGWENVIEW_METADATA_BACKEND=None"
	fi

	kde4-meta_src_compile
}
