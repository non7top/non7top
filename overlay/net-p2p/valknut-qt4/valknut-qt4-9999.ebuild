# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="Port of Valknut to Qt4"
HOMEPAGE="http://wxdcgui.sourceforge.net/"
ESVN_REPO_URI="https://wxdcgui.svn.sourceforge.net/svnroot/wxdcgui/branches/valknut-qt4/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$(qt4_min_version 4.2.0)
	>=net-p2p/dclib-0.3.12"
RDEPEND="${DEPEND}"

QT4_BUILT_WITH_USE_CHECK="qt3support"

src_compile() {
	make -f admin/Makefile.common
	econf
	emake
}

src_install() {
	einstall PREFIX="${D}/usr" \
		DOC_PATH="${D}/usr/share/doc/${P}" \
		CONF_PREFIX="${D}" || die "Failed to install smplayer"
	dodoc Changelog Configurable_shortcuts.txt Icon_themes.txt Not_so_obvious_things.txt
	dodoc Readme.txt Release_notes.txt Translations.txt
}
