# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE bindings for different languages."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="python ruby mono"
LICENSE="GPL-2 LGPL-2"

DEPEND=""

RDEPEND="${DEPEND}"

src_compile() {
#cmake -DENABLE_SMOKE=on -DENABLE_SMOKEKDE=off .
# Disable compiling of Qyoto
#cmake -DENABLE_QYOTO=off .
# Disable compiling of QtRuby and Korundum
#cmake -DENABLE_QTRUBY=off -DENABLE_KORUNDUM=off .
# Disable compiling of the Kross ruby and python backends
#cmake -DENABLE_KROSSRUBY=off -DENABLE_KROSSPYTHON=off .
# Disable compiling of PyKDE
#cmake -DENABLE_PYKDE4=off .
	mycmakeargs="${mycmakeargs}
		-DENABLE_SMOKEKDE=off
		$(cmake-utils_use_enable ruby QTRUBY)
		$(cmake-utils_use_enable ruby KROSSRUBY)
		$(cmake-utils_use_enable mono QYOTO)"
	kde4-base_src_compile
}
