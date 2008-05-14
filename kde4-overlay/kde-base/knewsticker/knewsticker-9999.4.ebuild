# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdenetwork
inherit kde4svn-meta

DESCRIPTION="Plasma widget: rss news ticker"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="|| ( kde-base/plasma:${SLOT} kde-base/kdebase:${SLOT} )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_Plasma=ON"

	kde4-meta_src_compile
}
