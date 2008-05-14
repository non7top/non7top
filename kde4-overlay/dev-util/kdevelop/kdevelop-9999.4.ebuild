# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."
HOMEPAGE="http://www.kde.org/"

SLOT="kde-svn"
KEYWORDS=""
IUSE="cmake cxx debug qmake"
LICENSE="GPL-2 LGPL-2"

DEPEND="
	kde-base/kdevplatform:${SLOT}"
RDEPEND="${DEPEND}
	cmake? ( dev-util/cmake )
	kde-base/kdesdk-kioslaves:${SLOT}"
# These dependencies are at least deactivated, maybe readd later?
#	media-gfx/graphviz
#	kde-base/cervisia:${SLOT}
#	>=sys-libs/db-4:=
#	sys-devel/gdb"

# Suggestions:
# app-arch/rpm: Support for creating RPM packages
# app-doc/doxygen: Generate KDE-style documentation
# app-xemacs/clearcase: Support for Clearcase Version Control for XEmacs
# dev-java/ant: Support for projects using ant build tool
# dev-util/ctags: Fast and powerful code browsing logic
# dev-util/cvs: Support for cvs
# dev-util/kdbg: Kde frontend for gdb
# dev-util/subversion: Support for subversion version control system
# dev-util/valgrind: Integrates valgrind (Memory debugger) commands
# games-emulation/visualboyadvance: Create and run projects for this gameboy
# kde-base/kompare: Show differences between files
# kde-base/konsole: Embedded konsole in Kdevelop
# www-misc/htdig: Index and search project documentation
# Readd when it has been packaged
#		kde-base/kompare:${SLOT}
PDEPEND="
	suggested:
		app-arch/rpm
		app-doc/doxygen
		app-xemacs/clearcase
		dev-java/ant
		dev-util/ctags
		dev-util/cvs
		dev-util/kdbg
		dev-util/subversion
		dev-util/valgrind
		games-emulation/visualboyadvance
		kde-base/konsole:${SLOT}
		www-misc/htdig
	"

# Slot package
PREFIX="${KDEDIR}"

pkg_setup() {
	echo
	ewarn "WARNING! This is alpha software. Do _NOT_ file bugs at bugs.kde.org. If it breaks you"
	ewarn "get to keep the pieces. Bug reports got to the dev mailing list."
	ewarn "See: http://apaku.wordpress.com/2007/12/09/dont-file-bugreports-against-kdevelop4/"
	echo

	kde4-base_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_cmake=$(useq cmake && echo On || echo Off)
		-DBUILD_cmakebuilder=$(useq cmake && echo On || echo Off)
		-DBUILD_qmake=$(useq qmake && echo On || echo Off)
		-DBUILD_qmakebuilder=$(useq qmake && echo On || echo Off)
		-DBUILD_cpp=$(useq cxx && echo On || echo Off)"

	kde4-base_src_compile
}

pkg_postinst() {
	elog "KDevelop can use perforce as a version control system."
	elog "Install perforce, if you want to use it."

	kde4-base_pkg_postinst
}
