# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="KDE library for encryption handling."
KEYWORDS=""
IUSE="debug"

DEPEND="app-crypt/gnupg
	app-crypt/gpgme"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_QGpgme=ON"

	kde4-meta_src_compile
}
