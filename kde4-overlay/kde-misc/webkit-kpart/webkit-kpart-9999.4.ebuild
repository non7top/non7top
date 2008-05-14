# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="playground/libs"
KMMODULE="webkitkde"
NEED_KDE=":kde-svn"
SLOT="kde-svn"
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

src_unpack() {
	kde4svn_src_unpack

	# CMakeLists bugs.
	sed -e '/CMAKE_MODULE_PATH/s/^/#DONOTWANT /' \
		-e '/add_subdirectory(cmake)/s/^/#DONOTWANT /' \
		-i "${S}"/CMakeLists.txt || die 'Sed failed.'
}
