# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="The KDE Address Book"
KEYWORDS=""
IUSE="debug gnokii htmlhandbook"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	gnokii? ( app-mobilephone/gnokii )"
RDEPEND="${DEPEND}"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="kmail/
	libkdepim/
	libkleo/"
KMLOADLIBS="libkdepim libkleo"

src_compile(){
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gnokii GNOKII)"

	kde4-meta_src_compile
}

src_install() {
	kde4-meta_src_install

	# install additional generated header that is needed by kresources
	insinto "${PREFIX}"/include/${PN}
	doins "${WORKDIR}"/${PN}_build/${PN}/common/kabprefs_base.h || \
		die "Failed to install extra header files"
}
