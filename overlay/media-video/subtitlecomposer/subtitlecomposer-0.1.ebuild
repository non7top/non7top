# Tasty Menu Gentoo ebuild by franzf (http://www.alpine-art.de/)

inherit kde eutils

DESCRIPTION="Subtitle Editor for KDE Desktop"
HOMEPAGE="http://kde-apps.org/content/show.php/Subtitle+Composer?content=69822&PHPSESSID=8df1e7382606eea38757f73b6ecbc6b6"
SRC_URI="mirror://sourceforge/subcomposer/${P}.tar.bz2"
LICENSE="GPL"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="kde-base/kdelibs"

need-kde 3.3

