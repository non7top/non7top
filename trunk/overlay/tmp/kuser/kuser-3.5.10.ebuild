# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-3.5.10.ebuild,v 1.1 2008/09/14 00:00:06 carlo Exp $
KMNAME=kdeadmin
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=""

# TODO add NIS support
