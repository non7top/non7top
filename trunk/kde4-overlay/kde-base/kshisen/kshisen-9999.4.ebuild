# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdegames
inherit kde4svn-meta

DESCRIPTION="A KDE game similiar to Mahjongg"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkmahjongg-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
