# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME="playground/base"
KMMODULE="plasma"

NEED_KDE="svn"
SLOT="kde-svn"

OPENGL_REQUIRED="optional"
inherit kde4svn 

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE=""
LICENSE="GPL-2 LGPL-2"

DEPEND="kde-base/kdebase:${SLOT}
	kde-base/kdepim:${SLOT}
	x11-libs/qt-webkit
	kde-base/qimageblitz"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		-DSENSORS_FOUND=No
		-DWITH_Sensors=Off
		-DWITH_Blitz=On
		-DWITH_KdepimLibs=On
		$(cmake-utils_use_with opengl OpenGL)"

	# Fix:
#		$(cmake-utils_use_with sensors Sensors)
	kde4-base_src_compile
}
