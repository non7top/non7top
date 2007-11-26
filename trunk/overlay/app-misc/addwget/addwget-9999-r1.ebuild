# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="This is a program to update all files from various live repositories in portage"
HOMEPAGE="http://avuton.googlepages.com"
ESVN_REPO_URI="http://non7top.googlecode.com/svn/trunk/xlam/addwget/"
#ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/svn-src/"
LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

DEPENDS=">=app-shells/bash-3*
	sys-apps/findutils"

src_unpack() {
#        ESVN_UPDATE_CMD="svn update -N"
#        ESVN_FETCH_CMD="svn checkout -N"
#        ESVN_REPO_URI=`dirname ${ESVN_REPO_URI}`
        subversion_src_unpack
}

src_install() {
	dobin addwget.sh
}
