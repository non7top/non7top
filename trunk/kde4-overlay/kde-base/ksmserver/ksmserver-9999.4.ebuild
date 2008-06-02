# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase-workspace
inherit kde4svn-meta

DESCRIPTION="The reliable KDE session manager that talks the standard X11R6"
KEYWORDS=""
IUSE="debug"

DEPEND=">=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	>=kde-base/solid-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="kcminit/main.h
	libs/kworkspace/
	libs/plasma/
	solid/"
KMLOADLIBS="libkworkspace libplasma"