# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME="playground/games"

NEED_KDE="svn"
SLOT="kde-svn"

inherit kde4svn-meta

PREFIX="${KDEDIR}"

DESCRIPTION="A KDE Pacman Game."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""

DEPEND="kde-base/libkdegames:${SLOT}"
RDEPEND="${DEPEND}"
RESTRICT="test"
