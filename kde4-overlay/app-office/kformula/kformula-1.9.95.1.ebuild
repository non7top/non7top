# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
KMNAME=koffice
inherit kde4-meta

DESCRIPTION="KOffice formula editor."
KEYWORDS=""
IUSE=""

KMEXTRA="filters/kformula/"
KMEXTRACTONLY="libs/"
KMCOPYLIB="libko"

src_compile() {
	epatch "${FILESDIR}"/${P}-link_lib.patch

	kde4-meta_src_compile
}
