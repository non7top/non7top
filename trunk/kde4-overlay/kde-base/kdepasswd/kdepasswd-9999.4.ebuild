# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase
KMMODULE=apps/${PN}

inherit kde4svn-meta

DESCRIPTION="KDE GUI for passwd"
KEYWORDS=""
IUSE="debug"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/kdesu-${PV}:${SLOT}"

KMLOADLIBS="libkonq"
