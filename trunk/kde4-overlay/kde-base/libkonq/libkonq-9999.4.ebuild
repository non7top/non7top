# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase
KMMODULE=apps/lib/konq
CPPUNIT_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS=""
IUSE="debug"
RESTRICT="test"
# Remove this if patch has been applied upstream.
PATCHES="${FILESDIR}/fix_includes_install.patch"

KMSAVELIBS="true"
