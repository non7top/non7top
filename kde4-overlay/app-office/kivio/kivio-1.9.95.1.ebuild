# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
KMNAME=koffice
inherit kde4-meta

DESCRIPTION="KOffice flowchart and diagram tool."
KEYWORDS=""
# There is a python switch in the cmake files. But nothing in kivio seems to
# actually use it. Maybe in the future that'll change..
#IUSE="python"

#DEPEND="python? ( virtual/python )"
#RDEPEND="${DEPEND}"

KMEXTRA="filters/kivio/"
KMEXTRACTONLY="libs/"

src_compile() {
	epatch "${FILESDIR}"/${P}-link_lib.patch

	#mycmakeargs="${mycmakeargs}
		#$(cmake-utils_use_with python PythonLibs)"

	kde4-meta_src_compile
}
