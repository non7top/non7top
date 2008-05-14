# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME="extragear/libs"
NEED_KDE="svn"

inherit kde4svn-meta

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""
SLOT="kde-svn"

DEPEND=">=media-gfx/exiv2-0.12
	>=media-libs/jpeg-6b
	>=media-libs/lcms-1.14"
RDEPEND="${DEPEND}"

# Install to KDEDIR to slot the package
PREFIX="${KDEDIR}"
