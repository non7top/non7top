# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="KDE feed library"
IUSE="debug"
KEYWORDS=""

# Tests seem to hang, restrict them. Checked with revision 806230.
RESTRICT="test"
