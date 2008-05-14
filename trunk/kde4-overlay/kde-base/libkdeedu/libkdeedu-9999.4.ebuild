# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdeedu
inherit kde4svn-meta

# get weird "Exception: Other". broken.
RESTRICT="test"

DESCRIPTION="common library for kde educational apps."
KEYWORDS=""
IUSE="debug"
