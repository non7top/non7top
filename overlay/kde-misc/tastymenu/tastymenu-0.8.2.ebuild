# Tasty Menu Gentoo ebuild by franzf (http://www.alpine-art.de/)

inherit kde eutils

DESCRIPTION="KMenu Replacement."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=41866"
SRC_URI="http://www.notmart.org/files/${P}.tar.bz2"
LICENSE="GPL"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kicker kde-base/kdebase )"

need-kde 3.3
