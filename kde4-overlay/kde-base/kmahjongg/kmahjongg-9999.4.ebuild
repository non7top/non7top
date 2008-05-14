# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdegames
inherit kde4svn-meta

DESCRIPTION="Mahjongg for KDE"
KEYWORDS=""
IUSE="debug htmlhandbook"
DEPEND="${DEPEND}
		>=kde-base/libkmahjongg-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdegames libkmahjongg"
