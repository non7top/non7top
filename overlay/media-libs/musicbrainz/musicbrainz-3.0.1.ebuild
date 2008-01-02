# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils

DESCRIPTION="Client library to access metadata of mp3/vorbis/CD media"
HOMEPAGE="http://www.musicbrainz.org/"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/neon
	media-libs/libdiscid
	test? ( dev-util/cppunit )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/lib${P}

src_compile() {
	cmake-utils_src_configurein
	cmake-utils_src_make
}

src_install() {
	cmake-utils_src_install
	dodoc README.txt NEWS.txt AUTHORS.txt
}