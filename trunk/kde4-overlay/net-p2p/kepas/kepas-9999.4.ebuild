# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="playground/network"
NEED_KDE="svn"
inherit kde4svn

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="KDE Easy Publish and Share."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=73968"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"
IUSE="avahi oscar zeroconf"

DEPEND="|| ( kde-base/libplasma:${SLOT}
		kde-base/kdebase:${SLOT} )
	avahi? (
		|| ( kde-base/kdnssd:${SLOT}
			kde-base/kdenetwork:${SLOT} ) )
	zeroconf? (
		|| ( kde-base/kdnssd:${SLOT}
			kde-base/kdenetwork:${SLOT} ) )
	oscar? (
		|| ( kde-base/kopete:${SLOT}
			kde-base/kdenetwork:${SLOT} ) )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use oscar; then
		if has_version kde-base/kopete:${SLOT}; then
			KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
				kde-base/kopete:${SLOT} oscar" ;
		elif has_version kde-base/kdenetwork:${SLOT}; then
			KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
				kde-base/kdenetwork:${SLOT} oscar"
		else
			die "You don't seem to have either kde-base/kopete or kde-base/kdenetwork installed."
		fi
	fi

	kde4svn_pkg_setup
}
