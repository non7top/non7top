# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ktorrent/ktorrent-2.2.2.ebuild,v 1.1 2007/09/01 15:15:18 philantrop Exp $

inherit qt4

#MY_P="${P/_/}"
#MY_PV="${PV/_/}"
S="${WORKDIR}/${PN}"

DESCRIPTION="QPhoton is an open source photo editor and image viewer"
HOMEPAGE="http://www.qphoton.org/qphoton/index.htm"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV}.tar.gz"
LICENSE="GPL-2"
#${S}=${S}/${PN}

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND=""
RDEPEND="${DEPEND}"
