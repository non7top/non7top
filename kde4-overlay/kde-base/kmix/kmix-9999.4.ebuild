# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdemultimedia
inherit kde4svn-meta

DESCRIPTION="KDE mixer gui"
KEYWORDS=""
IUSE="alsa debug htmlhandbook"

DEPEND="
	>=kde-base/plasma-${PV}:${SLOT}
	alsa? ( >=media-libs/alsa-lib-1.0.14a )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)"
	kde4-meta_src_compile
}
