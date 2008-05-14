# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdenetwork
inherit kde4svn-meta

DESCRIPTION="KDE remote desktop connection (RDP and VNC) client"
KEYWORDS=""
IUSE="debug htmlhandbook jpeg vnc zeroconf"

DEPEND="
	jpeg? ( media-libs/jpeg )
	vnc? ( >=net-libs/libvncserver-0.9 )
	zeroconf? ( || ( net-dns/avahi[mdnsresponder-compat] net-misc/mDNSResponder ) )"
RDEPEND="${DEPEND}"

# You need this for the remote desktop protocol (RDP).
PDEPEND="suggested: >=net-misc/rdesktop-1.4.1"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with vnc LibVNCServer)
		$(cmake-utils_use_with zeroconf DNSSD)"
	kde4-meta_src_compile
}
