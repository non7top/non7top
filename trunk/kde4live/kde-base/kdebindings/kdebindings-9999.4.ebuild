# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE bindings for different languages."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="python ruby mono java php"
LICENSE="GPL-2 LGPL-2"

DEPEND="python? ( >=dev-python/PyQt4-4.4.2 )"

RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/pykde-9999-rem-soprano-akonadi.patch"

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
		-DENABLE_SMOKE=off
		-DENABLE_KORUNDUM=off
		####Ruby
		$(cmake-utils_use_enable ruby QTRUBY)
		$(cmake-utils_use_enable ruby KROSSRUBY)
		$(cmake-utils_use_enable ruby QTWEBKIT_RUBY)
		$(cmake-utils_use_enable ruby QTUITOOLS_RUBY)
		$(cmake-utils_use_enable ruby PHONON_RUBY)
		$(cmake-utils_use_enable ruby KORUNDUM_RUBY)
		$(cmake-utils_use_enable ruby KHTML_RUBY)
		$(cmake-utils_use_enable ruby KTEXTEDITOR_RUBY)
		$(cmake-utils_use_enable ruby SOLID_RUBY)
		####CSharp
		$(cmake-utils_use_enable mono QYOTO)
		$(cmake-utils_use_enable mono SOPRANO_SHARP)
		$(cmake-utils_use_enable mono PLASMA_SHARP)
		$(cmake-utils_use_enable mono KIMONO)
		$(cmake-utils_use_enable mono KHTML_SHARP)
		####Java
		$(cmake-utils_use_enable java KROSSJAVA)
		$(cmake-utils_use_enable php PHP-Qt)"
	kde4overlay-base_src_compile
}
