# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/d4x/d4x-2.5.7.1-r1.ebuild,v 1.2 2006/12/19 13:57:51 gustavoz Exp $

inherit eutils flag-o-matic

DESCRIPTION="GTK based download manager for X."
SRC_URI="http://d4x.krasu.ru/files/miniupnpc-1.0-RC10.tar.gz"
HOMEPAGE="http://www.krasu.ru/soft/chuchelo/"

KEYWORDS="~amd64 sparc ~x86"
SLOT="0"

DEPEND=""
S=${WORKDIR}/miniupnpc-1.0-RC10
src_compile() {

	emake || die

}

src_install () {
	INSTALLPREFIX=${D}/usr einstall || die
	dobin upnpc-shared
	dobin upnpc-static
	dobin minixmlvalid
	dobin testminixml
	dobin testupnpreplyparse
	
	dosym /usr/bin/upnpc-shared /usr/bin/upnpc
	rm -rf ${D}/usr/lib/libminiupnpc.so
	dosym libminiupnpc.so.0 /usr/lib/libminiupnpc.so
	dodoc LICENCE README Changelog.txt
	doman man3/*

}
