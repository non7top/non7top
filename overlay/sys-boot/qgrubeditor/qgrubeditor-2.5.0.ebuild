# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4

MY_PN=QGRUBEditor

DESCRIPTION="Qt GUI editor for grub config"
HOMEPAGE="http://www.qt-apps.org/content/show.php/QGRUBEditor?content=60391&PHPSESSID=84ce6c48739111400dc2154f5bfbb261"
#SRC_URI="mirror://sourceforge/cdfly/${PN}-${PV}.tar.bz2"
SRC_URI="http://www.qt-apps.org/CONTENT/content-files/60391-${MY_PN}-${PV}-src.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=x11-libs/qt-4.3.0
	media-gfx/imagemagick
	app-arch/gzip
	sys-boot/grub"
	
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}

 src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${S}
	qmake
        emake PREFIX=\\\"/usr\\\" \
                KDE_PREFIX=\\\"${KDE_PREF}\\\" \
                CONF_PATH=\\\"/etc/${PN}\\\" \
                DATA_PATH=\\\"/usr/share/${PN}\\\" \
                TRANSLATION_PATH=\\\"/usr/share/${PN}/translations\\\" \
                DOC_PATH=\\\"/usr/share/doc/${P}\\\" || die "emake failed"
}

src_install() {
        einstall INSTALL_ROOT="${D}" || die "Failed to install qgrubeditor"
        dodoc AUTHORS ChangeLog COPYING INSTALL README

}

