# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase-runtime
inherit kde4svn-meta

DESCRIPTION="KDE crash handler, gives the user feedback if a program crashed"
IUSE="debug"
KEYWORDS=""

DEPEND=""
RDEPEND="sys-devel/gdb"
