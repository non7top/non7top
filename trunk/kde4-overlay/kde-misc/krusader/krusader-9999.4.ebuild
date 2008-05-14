# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

NEED_KDE="svn"
SLOT="kde-svn"
inherit kde4svn

# Install to KDEDIR to slot the package
PREFIX="${KDEDIR}"

ESVN_REPO_URI="http://krusader.svn.sourceforge.net/svnroot/krusader/trunk/krusader_kde4"
DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://www.krusader.org"
LICENSE="GPL-2"

KEYWORDS=""
IUSE=""

DEPEND="sys-devel/gettext"

# Krusader can make use of other programs.
# Tools:
# md5deep: Create and check recursive MD5/SHA1/SHA256/Tiger checksums
# cfv: Create and check recursive checksums
# xxdiff:
# kdesu: Put krusader in admin mode
# kget: Fetch files
# kmail: Send files per mail
# kompare: Compare files
# kdiff3:
# krename: Batch-rename multiple files
# eject: Eject the cdrom drive
# slocate: Index files
PDEPEND="
	suggested:
		app-crypt/md5deep
		app-arch/cfv
		dev-util/xxdiff
		kde-base/kdesu:${SLOT}
		kde-base/kget:${SLOT}
		kde-base/kmail:${SLOT}
		kde-misc/kdiff3
		kde-misc/krename
		sys-apps/eject
		sys-apps/slocate
	"
# Readd when kde-svn version available:
#		kde-base/kompare

# Packagers:
# arj: Package arj archives
# dpkg: Handling debian packages
# lha: Handle lha archives
# rar: Handle rar archives
# rpm: Handle rpm packages
# p7zip: Handle 7z archives
# unace: Unpack ace archives
# unarj: Unpack arj archives
# unrar: Unpack rar archives
# unzip: Unpack zip archives
# zip: Handle zip archives
PDEPEND="${PDEPEND}
		app-arch/arj
		app-arch/dpkg
		app-arch/lha
		app-arch/rar
		app-arch/rpm
		app-arch/p7zip
		app-arch/unace
		app-arch/unarj
		app-arch/unrar
		app-arch/unzip
		app-arch/zip
	"
