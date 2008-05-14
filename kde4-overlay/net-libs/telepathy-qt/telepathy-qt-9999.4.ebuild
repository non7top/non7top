# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit cmake-utils subversion

DESCRIPTION="libtelepathy QT4 Bindings"
HOMEPAGE="https://tapioca-voip.svn.sourceforge.net/svnroot/tapioca-voip/trunk/telepathy-qt/"
ESVN_REPO_URI="https://tapioca-voip.svn.sourceforge.net/svnroot/tapioca-voip/trunk/telepathy-qt/"

KEYWORDS=""
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="debug"

RDEPEND="|| ( ( x11-libs/qt-core:4
		x11-libs/qt-dbus:4 )
	>=x11-libs/qt-4.2.0[dbus] )"
DEPEND="${RDEPEND}"

pkg_setup() {
	echo
	ewarn "WARNING! This an experimental ebuild of ${PN} SVN tree. Use at your own risk."
	ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
	echo
}
