# Tasty Menu Gentoo ebuild by franzf (http://www.alpine-art.de/)

inherit kde eutils

DESCRIPTION="This is small process viewer and manager for kicker"
HOMEPAGE="http://kde-apps.org/content/show.php/KPV?content=71592&PHPSESSID=1ecfde383961f62d10594d1aed28486d"
SRC_URI="mirror://sourceforge/ksquirrel/${P}.tar.bz2"
LICENSE="GPL"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kicker kde-base/kdebase )"

need-kde 3.3

