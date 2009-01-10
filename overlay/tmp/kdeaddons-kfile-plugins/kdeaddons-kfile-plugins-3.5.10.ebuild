# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-kfile-plugins/kdeaddons-kfile-plugins-3.5.10.ebuild,v 1.1 2008/09/13 23:57:47 carlo Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/"
EAPI="1"
inherit kde-meta

DESCRIPTION="kdeaddons kfile plugins"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="dev-libs/openssl"

src_compile() {
	myconf="--with-ssl"
	kde_src_compile
}
