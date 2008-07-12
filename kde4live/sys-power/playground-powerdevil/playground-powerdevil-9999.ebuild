# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="playground/utils"
KMMODULE="powerdevil"

inherit kde4svn

NEED_KDE="svn"
SLOT="kde-svn"

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
LICENSE="GPL"

KEYWORDS=""
IUSE=""

DEPEND="
	|| ( kde-base/solid:${SLOT}
		kde-base/kdebase:${SLOT} )"
RDEPEND="${DEPEND}"
