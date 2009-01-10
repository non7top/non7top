# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker/kicker-3.5.10.ebuild,v 1.2 2008/09/14 02:27:31 mr_bones_ Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="Kicker is the KDE application starter panel, also capable of some useful applets and extensions."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xcomposite"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	xcomposite? ( x11-libs/libXcomposite )"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY="libkonq
	kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
