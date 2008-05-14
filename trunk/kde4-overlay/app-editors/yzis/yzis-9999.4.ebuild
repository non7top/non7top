# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit cmake-utils subversion

DESCRIPTION="Yzis is a vi-compatible editor that is composed of a generic vi engine and independent GUI."
HOMEPAGE="http://www.yzis.org"

ESVN_REPO_URI="svn://svn.freenux.org/yzis/trunk"
ESVN_PROJECT="yzis"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="debug kde ncurses qt4 test X"

COMMONDEPEND="
	=dev-lang/lua-5.1*
	media-libs/jpeg
	>=sys-apps/file-4.0
	qt4? ( || ( x11-libs/qt-gui:4
		>=x11-libs/qt-4.2.0:4 ) )
	kde? ( kde-base/kdelibs:kde-svn )
	ncurses? ( sys-libs/ncurses[unicode] )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.1
	>=sys-devel/gettext-0.12.0"
RDEPEND="${COMMONDEPEND}"

#TODO linguas: svn has translations disabled atm
#LANGS="cn de es fr it ja nl nn no pl pt ru"
#for X in ${LANGS}; do
	#IUSE="${IUSE} linguas_${X}"
#done
# kyzis doesn't get installed, this patch corrects it.
ESVN_PATCHES="${FILESDIR}/kyzis.patch"

S="${WORKDIR}/${PN}"

pkg_setup() {
	if use X && ! use ncurses; then
		elog "You're compiling with USE=\"-ncurses X\", however"
		elog "USE=\"X\" requires USE=\"ncurses\" to enable accessing the X copy/pste buffer in nyzis."
	fi
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable debug SAFE_MODE)
		$(cmake-utils_use_enable kde KPART_YZIS)
		$(cmake-utils_use_enable kde KYZIS)
		$(cmake-utils_use_enable ncurses NYZIS)
		$(cmake-utils_use_enable qt4 QYZIS)
		$(cmake-utils_use_enable test LIBYZISRUNNER)
		$(cmake-utils_use_enable test TESTS)
		$(cmake-utils_use_enable X X_IN_NYZIS)"

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	dodoc "${S}"/{AUTHORS,ChangeLog,README}

	docinto "examples"
	dodoc "${S}"/doc/examples/* || die "dodoc examples/ failed."
}
