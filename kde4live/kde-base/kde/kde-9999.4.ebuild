# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="KDE - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS=""
SLOT="kde-svn"
IUSE="accessibility"

# excluded: kdebindings, kdesdk, kdevelop, since these are developer-only packages
RDEPEND="
	kde-base/kdelibs:${SLOT}
	kde-base/kdepimlibs:${SLOT}
	kde-base/kdebase:${SLOT}
	kde-base/kdeadmin:${SLOT}
	kde-base/kdeartwork:${SLOT}
	kde-base/kdeedu:${SLOT}
	kde-base/kdegames:${SLOT}
	kde-base/kdegraphics:${SLOT}
	kde-base/kdemultimedia:${SLOT}
	kde-base/kdenetwork:${SLOT}
	kde-base/kdepim:${SLOT}
	kde-base/kdetoys:${SLOT}
	kde-base/kdeutils:${SLOT}
	accessibility? ( kde-base/kdeaccessibility:${SLOT} )"
