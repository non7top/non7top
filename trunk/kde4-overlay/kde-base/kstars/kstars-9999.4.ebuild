# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdeedu
inherit kde4svn-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS=""
IUSE="debug fits htmlhandbook nova sbig usb"

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
		fits? ( sci-libs/cfitsio )
		nova? ( >=sci-libs/libnova-0.12.1 )
		sbig? ( sci-libs/indilib
			usb? ( dev-libs/libusb ) )"
RDEPEND="${DEPEND}"
ESVN_PATCHES="${FILESDIR}/${P}-destdir.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with fits CFitsio)
		$(cmake-utils_use_with nova Nova)
		$(cmake-utils_use_with sbig SBIG)
		$(cmake-utils_use_with usb USB)"

	kde4-meta_src_compile

	# FIXME Unhandled arguments - added sbig but not sure about use descriptions or flag names...
	# WITH_SBIG - Switch which controls the detection of the proprietary and binary only SBIG CCD universal library. No ebuild for this package
	# are available at the moment.
	# ssh_tunnel ->  INDI Server binds locally. Remote clients may only connect
	# via SSH Tunneling.
}
