# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ktorrent/ktorrent-2.2.2.ebuild,v 1.1 2007/09/01 15:15:18 philantrop Exp $

inherit kde

#MY_P="${P/_/}"
#MY_PV="${PV/_/}"
S="${WORKDIR}/${PN}"

DESCRIPTION="DirectConnect Client for KDE."
HOMEPAGE="http://directkonnect.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
#${S}=${S}/${PN}

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND=""
RDEPEND="${DEPEND}"

need-kde 3.5

src_compile(){
	kde_src_compile
}
