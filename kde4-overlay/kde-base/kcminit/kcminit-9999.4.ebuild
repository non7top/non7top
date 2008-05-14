# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase-workspace
inherit kde4svn-meta

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS=""
IUSE="debug"

DEPEND=">=kde-base/ksplash-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
