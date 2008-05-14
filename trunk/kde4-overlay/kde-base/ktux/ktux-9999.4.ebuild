# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdetoys
inherit kde4svn-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS=""
IUSE="debug"

DEPEND=">=app-misc/strigi-0.5.7
	>=kde-base/kscreensaver-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
