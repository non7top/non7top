# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME=kdeadmin
inherit kde4svn-meta

DESCRIPTION="KDE Task Scheduler"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND="virtual/cron
	>=kde-base/knotify-${PV}:${SLOT}"
