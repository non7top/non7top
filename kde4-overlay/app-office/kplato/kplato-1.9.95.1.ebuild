# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
KMNAME=koffice
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KPlato is a project management application."
KEYWORDS=""

# this is only used by kplato. if it ever gets converted to kdgantt1 that should
# be splitted out of korganizer from kdepim and it should dep on that..
KMEXTRA="kdgantt/"
KMEXTRACTONLY="libs/"

src_compile() {
	epatch "${FILESDIR}"/${P}-link_lib.patch

	kde4-meta_src_compile
}
