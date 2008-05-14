# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
KMNAME=koffice
inherit kde4-meta

DESCRIPTION="KOffice vector drawing application."
KEYWORDS=""
IUSE=""

DEPEND=">=media-libs/freetype-2
	media-libs/fontconfig"
RDEPEND="${DEPEND}"

KMEXTRA="filters/karbon"
KMEXTRACTONLY="libs/
	plugins/"
KMCOPYLIB="libflake
	libkstore
	libko
	libpigmentcms"

KDE4_BUILT_WITH_USE_CHECK="app-office/koffice-libs:kde-4 crypt"

src_compile() {
	epatch "${FILESDIR}"/${P}-link_lib.patch

	kde4-meta_src_compile
}
