# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdeedu
inherit kde4svn-meta

DESCRIPTION="KDE Educational: vocabulary trainer"
KEYWORDS=""
IUSE="debug htmlhandbook +plasma"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
	plasma? ( kde-base/plasma:${SLOT} )"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"

KMEXTRACTONLY="libkdeedu/keduvocdocument"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"
	
	kde4-meta_src_compile
}
