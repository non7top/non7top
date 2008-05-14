# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

NEED_KDE="none"
KMNAME="kdereview"
inherit eutils flag-o-matic kde4-base kde4svn

DESCRIPTION="Decibel is a realtime communications framework"
HOMEPAGE="http://decibel.kde.org/"

SLOT="0"
KEYWORDS=""
LICENSE="LGPL-2"
IUSE=""

RESTRICT="test"

DEPEND="
	net-voip/tapioca-qt"
#	doc? ( app-doc/doxygen )"
# FIXME: handle doxygen documentation.

src_compile() {
	append-ldflags -Wl,--no-as-needed
	kde4-base_src_compile
}
