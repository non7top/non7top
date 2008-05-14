# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="extragear"
KMMODULE="base"

inherit kde4svn

MY_PV="${PV%_pre*}"
PREFIX="${KDEDIR}"
SLOT="kde-svn"

DESCRIPTION="Konqueror plugins."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""

DEPEND="
	kde-base/konqueror:${SLOT}
	kde-base/libkonq:${SLOT}"
RDEPEND="${DEPEND}"
