# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.0.0"
inherit kde4-base

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

MY_P="${P/_/-}"
DESCRIPTION="KBlogger is a simple to use blogging application for the K Destkop Environment."
HOMEPAGE="http://kblogger.pwsp.net/"
SRC_URI="http://${PN}.pwsp.net/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-4"
IUSE=""

DEPEND=">=kde-base/kdelibs-4.0.0:${SLOT}
	>=kde-base/kdepimlibs-4.0.0:${SLOT}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

