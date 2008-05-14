# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdesdk
inherit kde4svn-meta

DESCRIPTION="Kate is an MDI texteditor."
KEYWORDS=""
IUSE="debug htmlhandbook plasma"

DEPEND=">=app-misc/strigi-0.5.7
	>=kde-base/plasma-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_unpack() {
	use htmlhandbook && KMEXTRA="doc/kate-plugins"

	kde4svn-meta_src_unpack
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_compile
}
