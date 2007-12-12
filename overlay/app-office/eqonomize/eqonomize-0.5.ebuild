# Tasty Menu Gentoo ebuild by franzf (http://www.alpine-art.de/)

inherit kde eutils

DESCRIPTION="Eqonomize! is a personal accounting software, with focus on efficiency and ease of use for the small household economy"
HOMEPAGE="http://eqonomize.sourceforge.net/"
SRC_URI="mirror://sourceforge/eqonomize/${P}.tar.gz"
LICENSE="GPL"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

need-kde 3.3

