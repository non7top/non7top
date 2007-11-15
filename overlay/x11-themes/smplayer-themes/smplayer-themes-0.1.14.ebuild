# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Icon themes for smplayer"
HOMEPAGE="http://smplayer.sourceforge.net/"
SRC_URI="http://smplayer.sourceforge.net/en/linux/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="media-video/smplayer"

src_compile() {
	return
}

src_install() {
	dodir /usr/share/smplayer/themes
	insinto /usr/share/smplayer/themes
	doins -r themes/* || die "Failed to install themes"
}
