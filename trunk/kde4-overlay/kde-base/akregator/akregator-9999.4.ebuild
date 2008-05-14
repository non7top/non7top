# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="KDE news feed aggregator."
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdepim/"
KMLOADLIBS="libkdepim"
