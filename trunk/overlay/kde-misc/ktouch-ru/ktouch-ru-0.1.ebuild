# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-init-scripts/mysql-init-scripts-1.1.ebuild,v 1.1 2007/01/12 16:54:20 chtekk Exp $

DESCRIPTION="Russian keyboard layout"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="|| (kde-base/kdeedu kde-base/ktouch)"
RDEPEND=""

src_install() {
	insinto "/usr/kde/3.5/share/apps/ktouch"
	newins "${FILESDIR}/ru.keyboard" "ru.keyboard"

#	exeinto /etc/init.d
#	newexe "${FILESDIR}/icqbot.init.0.2" "icqbot"

#	exeinto /usr/bin
#	newexe "${FILESDIR}/0.1-compile" "compile"
}