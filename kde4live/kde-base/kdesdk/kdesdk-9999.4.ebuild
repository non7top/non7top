# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="debug htmlhandbook subversion"
LICENSE="GPL-2 LGPL-2"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	subversion? ( dev-util/subversion )"
RDEPEND="${DEPEND}
	dev-util/cvs
	media-gfx/graphviz"

pkg_setup() {
	if use subversion ; then
		if [[ -n "$(ldd /usr/bin/svn | grep -o libapr-0)" ]] \
			&& ! has_version =dev-libs/apr-0* ;
		then
			eerror "Subversion has been built against =dev-libs/apr-0*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
		if [[ -n "$(ldd /usr/bin/svn | grep -o libapr-1)" ]] \
			&& ! has_version =dev-libs/apr-1* ;
		then
			eerror "Subversion has been built against =dev-libs/apr-1*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
	fi

	kde4svn_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with subversion SVN)"

	if use subversion; then
		if [[ -n "$(ldd /usr/bin/svn | grep -o libapr-0)" ]] ; then
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-config"
		else
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
		fi
	fi

	kde4overlay-base_src_compile
}
