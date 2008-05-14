# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME="extragear"
KMMODULE="plasma"

NEED_KDE="svn"
SLOT="kde-svn"
OPENGL_REQUIRED="optional"
inherit eutils kde4svn

PREFIX="${KDEDIR}"

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-base/qimageblitz-0.0.4
	>=kde-base/krunner-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/plasma-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}[opengl?]
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with opengl OpenGL)"
	kde4-base_src_compile
}
