# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvola/nuvola-1.0-r1.ebuild,v 1.12 2006/11/28 00:28:32 flameeyes Exp $

inherit subversion eutils

ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/KDE/kdebase/runtime/pics/oxygen"

DESCRIPTION="Oxygen KDE4 icon theme."
HOMEPAGE="http://techbase.kde.org/Projects/Oxygen"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~x86"
SLOT="0"

RESTRICT="strip binchecks"

S="${WORKDIR}"

src_unpack(){
	subversion_src_unpack

}


src_install(){
	dodoc AUTHORS CONTRIBUTING COPYING
	rm AUTHORS CONTRIBUTING COPYING

	cd "${S}"
	insinto /usr/share/icons/oxygen
	doins -r *
}
