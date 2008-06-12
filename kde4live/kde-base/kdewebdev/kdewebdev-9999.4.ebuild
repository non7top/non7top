# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE web development - Quanta"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="debug htmlhandbook tidy"
LICENSE="GPL-2 LGPL-2"

DEPEND="
	kde-base/kdevplatform:${SLOT}
	tidy? ( app-text/htmltidy )"

src_compile() {
	mycmakeargs="${mycmakeargs}
				$(cmake-utils_use_with tidy LibTidy)"
	kde4overlay-base_src_compile
}
