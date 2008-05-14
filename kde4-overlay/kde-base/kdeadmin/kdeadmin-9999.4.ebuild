# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE administration tools (user manager, etc.)"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="debug htmlhandbook"
LICENSE="GPL-2 LGPL-2"

DEPEND="~kde-base/kdebase-${PV}"
RDEPEND="${DEPEND}
		virtual/cron"

src_unpack() {
	kde4svn_src_unpack
	rm -rf "${S}"/kpackage/
}
