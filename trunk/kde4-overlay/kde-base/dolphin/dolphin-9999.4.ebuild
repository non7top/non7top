# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4svn-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS=""
IUSE="debug htmlhandbook +semantic-desktop"

DEPEND="kde-base/kdelibs:${SLOT}
	>=kde-base/libkonq-${PV}:${SLOT}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"
# Embedded terminal in dolphin uses konsole
#PDEPEND="suggested: kde-base/konsole:${SLOT}"

KMEXTRA="apps/doc/${PN}"
KMLOADLIBS="libkonq"

# Without this patch, things don't link properly,
# unless we recompile lib/konq here too.
PATCHES=("${FILESDIR}/${P}-make-semantic-desktop-optional.patch")

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-meta_src_compile
}
