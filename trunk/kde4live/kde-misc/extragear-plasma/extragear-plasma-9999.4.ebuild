# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

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
IUSE="opengl"

DEPEND="
	>=kde-base/qimageblitz-0.0.4
	|| ( (
		>=kde-base/krunner-${PV}:${SLOT}
		>=kde-base/libtaskmanager-${PV}:${SLOT}
		>=kde-base/plasma-${PV}:${SLOT}
			)
		>=kde-base/kdebase-${PV}:${SLOT} )
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use opengl; then
		if has_version kde-base/libplasma:${SLOT}; then
			KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
				kde-base/libplasma:${SLOT} opengl" ;
		elif has_version kde-base/kdebase:${SLOT}; then
			KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
				kde-base/kdebase:${SLOT} opengl"
		else
			die "You don't seem to have either kde-base/libplasma or kde-base/kdebase installed"
		fi
	fi

	kde4svn_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with opengl OpenGL)"
	kde4-base_src_compile
}
