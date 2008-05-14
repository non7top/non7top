# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE accessibility module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="alsa debug htmlhandbook kde ktts"
LICENSE="GPL-2 LGPL-2"

COMMONDEPEND="
	ktts? ( alsa? ( >=media-libs/alsa-lib-1.0.14a ) )
	kde? ( kde-base/kdebase:${SLOT} )"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}
	ktts? (
		app-accessibility/festival
		app-accessibility/epos
		app-accessibility/freetts
		)
	app-accessibility/flite"

src_compile() {
	# Create plasma switch.
	sed -i -e "/Plasma/s:find_package:macro_optional_find_package:" \
		"${S}/CMakeLists.txt"

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)
		-DKDE4_KTTSD_PHONON=$(use alsa && echo ON || echo OFF)
		-DKDE4_KTTSD_ALSA=$(use alsa && echo ON || echo OFF)
		$(cmake-utils_use_with ktts Kttsmodule)
		$(cmake-utils_use_with kde Plasma)"

	kde4-base_src_compile
}
