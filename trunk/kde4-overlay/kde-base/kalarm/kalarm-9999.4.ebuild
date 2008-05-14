# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS=""
IUSE=""
DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}"
# For sending mails:
PDEPEND="suggested: kde-base/kmail:${SLOT}"

RDEPEND="${DEPEND}"

KMEXTRACTONLY="kmail
	libkdepim"
