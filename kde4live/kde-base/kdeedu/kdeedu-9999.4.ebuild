# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
CPPUNIT_REQUIRED="optional"
inherit kde4svn

DESCRIPTION="KDE educational apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="${IUSE} cviewer debug designer-plugin fits gps htmlhandbook kig-scripting opengl
readline solver nova sbig usb"
LICENSE="GPL-2 LGPL-2"

COMMONDEPEND="
	cviewer? ( >=dev-cpp/eigen-1.0.5
		>=sci-chemistry/openbabel-2.1
		|| ( x11-libs/qt-opengl:4
			>=x11-libs/qt-4.3.3:4 )
		virtual/opengl )
	fits? ( sci-libs/cfitsio )
	gps? ( sci-geosciences/gpsd )
	kig-scripting? ( >=dev-libs/boost-1.32 )
	nova? ( >=sci-libs/libnova-0.12.1 )
	opengl? ( virtual/opengl
		|| ( x11-libs/qt-opengl:4
			>=x11-libs/qt-4.3.3:4 ) )
	readline? ( sys-libs/readline )
	sbig? ( sci-libs/indilib
		usb? ( dev-libs/libusb ) )
	solver? ( dev-ml/facile )
"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}
	|| ( ( >=kde-base/knotify-${PV}:${SLOT} >=kde-base/phonon-${PV}:${SLOT} )
		>=kde-base/kdebase-${PV}:${SLOT} )"

PATCHES="${FILESDIR}/kstars-${PV}-destdir.patch
		${FILESDIR}/marble-${PV}-fix-tests.patch
		${FILESDIR}/kalgebra-${PV}-opengl.patch"

pkg_setup() {
	if has_version '<x11-libs/qt-4.4.0_alpha:4' && use cviewer || use opengl; then
		QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} opengl"
	fi

	kde4-base_pkg_setup
}

src_compile() {
	# Either of these needs OpenGL support, but using cmake-utils_use_with
	# and appending that to $mycmakeargs would let them override each other.
	if use cviewer || use opengl; then
		mycmakeargs="${mycmakeargs}
			-DWITH_OpenGL=ON"
	else
		mycmakeargs="${mycmakeargs}
			-DWITH_OpenGL=OFF"
	fi

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with cviewer Eigen)
		$(cmake-utils_use_with cviewer OpenBabel2)
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)
		$(cmake-utils_use_with fits CFitsio)
		$(cmake-utils_use_with kig-scripting BoostPython)
		$(cmake-utils_use_with nova Nova)
		$(cmake-utils_use_with readline Readline)
		$(cmake-utils_use_with sbig SBIG)
		$(cmake-utils_use_with solver Libfacile)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with usb USB)"

	if use gps; then
		mycmakeargs="${mycmakeargs} -DHAVE_LIBGPS=1"
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed failed."
	fi

	kde4-base_src_compile
}

src_test() {
	mycmakeargs="${mycmakeargs} -DENABLE_TESTS=TRUE"

	kde4-meta_src_test
}
