# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-2.1.4.ebuild,v 1.9 2006/11/12 04:46:33 vapier Exp $

inherit libtool

DESCRIPTION="Client library to access metadata of mp3/vorbis/CD media"
HOMEPAGE="http://www.musicbrainz.org/"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="3"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/lib${P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize
}

src_compile() {
	                cmake \
                -DCMAKE_INSTALL_PREFIX=/usr                                     \
                -DCMAKE_BUILD_TYPE=Release                                      \
                -DLIB_INSTALL_DIR=/usr/lib
                ${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS.txt COPYING.txt INSTALL.txt NEWS.txt README.txt
}
