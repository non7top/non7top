# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

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
	|| ( >=kde-base/konqueror-${MY_PV}:${SLOT}
		>=kde-base/kdebase-${MY_PV}:${SLOT} )"
RDEPEND="${DEPEND}"
