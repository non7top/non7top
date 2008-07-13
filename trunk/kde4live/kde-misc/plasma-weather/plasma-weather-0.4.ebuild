# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit kde4-helper

DESCRIPTION="Weather plasmoid similiar to liquid weather"
HOMEPAGE="http://kde-look.org/content/show.php/Weather+Plasmoid?content=84251"
SRC_URI="http://non7top.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}/${PN}

PREFIX="${KDEDIR}"

RDEPEND=""
DEPEND="${RDEPEND}"
