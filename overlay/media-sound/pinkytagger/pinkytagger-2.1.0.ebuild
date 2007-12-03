# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Pinky-Tagger is the mass tagger for Linux written in C++ using the nice Qt4 widgets. Pinky-Tagger supports the MusicBrainz (PUID & TRM) service to find the correct tag information for your files automatically."
HOMEPAGE="http://pinkytagger.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-2.1-0.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-2.1-0

DEPEND=">=x11-libs/qt-4.2
	media-libs/musicbrainz:1
	media-libs/musicbrainz:3"
RDEPEND="${DEPEND}"

src_compile() {
	cd ${S}
	        cmake \
                -DCMAKE_INSTALL_PREFIX=/usr                                     \
                -DCMAKE_BUILD_TYPE=Release                                      \
                -DCMAKE_C_COMPILER=$(type -P $(tc-getCC))               \
                -DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX))    \
                -DCMAKE_CXX_FLAGS="-DQT_THREAD_SUPPORT"         \
                -DLIB_INSTALL_DIR=/usr/$(get_libdir)
                ${myconf} || die

	emake
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
}
