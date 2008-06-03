# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion cmake-utils

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://www.kde.org"
SRC_URI=""
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/akonadi"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql"

RDEPEND=">=x11-libs/qt-core-4.4.0_rc1:4
	>=x11-libs/qt-dbus-4.4.0_rc1:4
	>=x11-libs/qt-sql-4.4.0_rc1:4
	>=x11-libs/qt-test-4.4.0_rc1:4
	>=x11-misc/shared-mime-info-0.20
	mysql? ( virtual/mysql )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	kde-base/automoc"

src_unpack() {
	subversion_src_unpack

	# Don't check for mysql, avoid an automagic dep.
	if ! use mysql; then
		sed -e '/mysqld/s/find_program/#DONOTWANT &/' \
			-i "${S}"/server/CMakeLists.txt || die 'Sed failed.'
	fi
}

