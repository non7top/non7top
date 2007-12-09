# Tasty Menu Gentoo ebuild by franzf (http://www.alpine-art.de/)

inherit kde eutils

DESCRIPTION="This is small wrapper for netstat for KDE. It lives in system tray and shows incoming/outgoing connections as popup messages"
HOMEPAGE="http://kde-apps.org/content/show.php/KConnections?content=71204"
SRC_URI="mirror://sourceforge/ksquirrel/${P}.tar.bz2"
LICENSE="GPL"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kicker kde-base/kdebase )"

need-kde 3.3

