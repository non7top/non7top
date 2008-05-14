# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdegraphics
inherit kde4svn-meta

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="x11-apps/xgamma
	x11-libs/libXxf86vm
	x11-proto/xf86vidmodeproto"
RDEPEND="${DEPEND}"
