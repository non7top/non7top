# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdeedu
inherit kde4svn-meta

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
KEYWORDS=""
IUSE="debug htmlhandbook neo2"

RDEPEND=">=kde-base/knotify-${PV}:${SLOT}"

src_install() {
	kde4-base_src_install

	if use neo2; then
		insinto "${KDEDIR}"/share/apps/${PN}/
		doins "${FILESDIR}"/*.xml
	fi
}
