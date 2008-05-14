# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4svn-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
IUSE="debug htmlhandbook"
KEYWORDS=""
RESTRICT="test"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kfind-${PV}:${SLOT}
	>=kde-base/kurifilter-plugins-${PV}:${SLOT}"

# If you want to use konqueror as a filemanager, install the dolphin kpart
# To use Java on webpages, install a jre
#PDEPEND="suggested: kde-base/dolphin:${SLOT} >=virtual/jre-1.4"

KMEXTRA="apps/doc/${PN}"
KMEXTRACTONLY="apps/lib/konq/"
