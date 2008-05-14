# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdenetwork
inherit kde4svn-meta

DESCRIPTION="A DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS=""
IUSE="debug"

DEPEND="|| ( net-dns/avahi[mdnsresponder-compat] net-misc/mDNSResponder )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF -DWITH_DNSSD=ON"

	kde4-meta_src_compile
}
