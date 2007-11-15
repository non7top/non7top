# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Kim is a kde service menu which allows to resize, convert, rotate, (...) your images."
HOMEPAGE="http://bouveyron.free.fr/kim/"
SRC_URI="http://thelinux.free.fr/pub/Distributions_Linux/gentoo/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="media-gfx/imagemagick"

S="${WORKDIR}/${PN}"

src_unpack() {
 unpack ${A}
} 

src_install() {
KDE=`kde-config --prefix`

exeopts -m0755
exeinto ${KDE}/share/apps/konqueror/servicemenus/
doexe ${S}/src/kim*.desktop
doexe ${S}/src/plugins/kim*.desktop

exeinto ${KDE}/bin/ 
doexe ${S}/src/bin/kim* 

exeinto ${KDE}/share/apps/kim/slideshow/
doexe ${S}/src/slideshow/*

exeinto ${KDE}/share/apps/kim/galery
doexe ${S}/src/galery/*

}