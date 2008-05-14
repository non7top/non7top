# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdeutils
inherit kde4svn-meta

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND=""
RDEPEND=">=kde-base/kcmshell-${PV}:${SLOT}"
