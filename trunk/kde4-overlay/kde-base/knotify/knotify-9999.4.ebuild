# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase-runtime
inherit kde4svn-meta

DESCRIPTION="The KDE notification daemon."
IUSE="debug"
KEYWORDS=""

DEPEND=">=kde-base/phonon-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
