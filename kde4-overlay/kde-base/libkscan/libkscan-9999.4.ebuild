# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdegraphics
inherit kde4svn-meta

DESCRIPTION="KDE scanner library"
KEYWORDS=""
IUSE="debug htmlhandbook"
LICENSE="LGPL-2"

DEPEND="kde-base/qimageblitz
	media-gfx/sane-backends"
RDEPEND="${DEPEND}"
