# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdeedu
inherit kde4svn-meta

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS=""
IUSE="debug htmlhandbook kig-scripting"

DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kig-scripting BoostPython)"

	kde4-meta_src_compile
}
