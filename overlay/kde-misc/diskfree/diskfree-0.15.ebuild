# Tasty Menu Gentoo ebuild by franzf (http://www.alpine-art.de/)

inherit kde eutils

DESCRIPTION="Free Disk Space monitoring applet for kicker"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=23396"
SRC_URI="http://www.ricardis.tudelft.nl/~vincent/diskfree/download/${P}.tar.gz"
LICENSE="GPL"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kicker kde-base/kdebase )"

need-kde 3.3

