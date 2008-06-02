# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME="extragear/office"
NEED_KDE="svn"

inherit kde4svn-meta

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="virtual/tex-base
	virtual/latex-base"

