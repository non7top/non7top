# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="debug htmlhandbook subversion"
LICENSE="GPL-2 LGPL-2"

# FIXME: Add || ( ) deps when splits are ready
DEPEND="
	kde-base/kdesdk:${SLOT}
	subversion? ( >=dev-util/subversion-1.3 )"
RDEPEND="${DEPEND}"

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

	echo
	ewarn "WARNING! This is alpha software. Do _NOT_ file bugs at bugs.kde.org. If it breaks you"
	ewarn "get to keep the pieces. Bug reports got to the dev mailing list."
	ewarn "See: http://apaku.wordpress.com/2007/12/09/dont-file-bugreports-against-kdevelop4/"
	echo
}

src_compile() {
	if use subversion; then
		if [[ -n "$(ldd /usr/bin/svn | grep -o libapr-0)" ]] ; then
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-config"
		else
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
		fi
	fi

	kde4-base_src_compile
}
