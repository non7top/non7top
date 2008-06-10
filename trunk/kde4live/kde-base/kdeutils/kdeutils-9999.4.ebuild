# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE utilities."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="archive crypt debug htmlhandbook python tpctl xscreensaver zip"
LICENSE="GPL-2 LGPL-2"

COMMON_DEPEND="dev-libs/gmp
	>=kde-base/kdebase-${PV}:${SLOT}
	x11-libs/libXtst
	tpctl? ( app-laptop/tpctl )
	python? ( dev-lang/python )
	archive? ( app-arch/libarchive )
	zip? ( >=dev-libs/libzip-0.8 )"
RDEPEND="${COMMON_DEPEND}
	!x11-misc/superkaramba
	crypt? ( app-crypt/gnupg )
	virtual/ssh"
DEPEND="${COMMON_DEPEND}
	virtual/os-headers
	xscreensaver? ( x11-libs/libXScrnSaver )
	x11-libs/libX11
	x11-proto/xproto"

src_compile() {
	# Disabling xmms support: not in portage.
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with tpctl TPCTL)
		$(cmake-utils_use_with python PythonLibs)
		$(cmake-utils_use_with zip LibZip)"

	kde4overlay-base_src_compile
}
