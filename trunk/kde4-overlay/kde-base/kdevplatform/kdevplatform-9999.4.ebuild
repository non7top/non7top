# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="cvs debug htmlhandbook subversion teamwork"
LICENSE="GPL-2 LGPL-2"

DEPEND="
	cvs? ( dev-util/cvs )
	subversion? ( >=dev-util/subversion-1.3 )
	teamwork? ( >=dev-libs/boost-1.34.0
		>=dev-cpp/commoncpp2-1.5.9 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use subversion; then
		if ldd /usr/bin/svn | grep -q libapr-0 \
			&& ! has_version dev-libs/apr:0;
		then
			eerror "Subversion has been built against dev-libs/apr:0, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
		if ldd /usr/bin/svn | grep -q libapr-1 \
			&& ! has_version dev-libs/apr:1;
		then
			eerror "Subversion has been built against dev-libs/apr:1, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
	fi

	echo
	ewarn "WARNING! This is alpha software. Do _NOT_ file bugs at bugs.kde.org. If it breaks you"
	ewarn "get to keep the pieces. Bug reports got to the dev mailing list."
	ewarn "See: http://apaku.wordpress.com/2007/12/09/dont-file-bugreports-against-kdevelop4/"
	echo

	kde4-base_pkg_setup
}


src_compile() {
	if use cvs; then
		mycmakeargs="${mycmakeargs} -DBUILD_cvs=On"
	else
		mycmakeargs="${mycmakeargs} -DBUILD_cvs=Off"
	fi

	if use subversion; then
		if ldd /usr/bin/svn | grep -q libapr-0; then
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-config"
		else
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
		fi
	fi
	
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with teamwork Boost)
		$(cmake-utils_use_with teamwork Commoncpp)
		$(cmake-utils_use_with subversion SubversionLibrary)"

	kde4-base_src_compile
}
