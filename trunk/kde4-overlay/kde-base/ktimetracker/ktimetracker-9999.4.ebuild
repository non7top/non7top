# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks."
IUSE="debug"
KEYWORDS=""

DEPEND="kde-base/kontact:${SLOT}
	kde-base/kdepim-kresources:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="kresources
	libkdepim"
KMLOADLIBS="libkdepim
	kontact"
