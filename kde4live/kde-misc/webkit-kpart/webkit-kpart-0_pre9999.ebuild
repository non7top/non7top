# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
KMNAME="playground/libs"
KMMODULE="webkitkde"
NEED_KDE_PRE=true

inherit kde4svn

# Install to KDEDIR rather than /usr, allows slotting
PREFIX="${KDEDIR}"

DESCRIPTION="A WebKit KPart for konqueror"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="x11-libs/qt-webkit:4"
RDEPEND="${RDEPEND}
	kde-base/konqueror:${SLOT}"
