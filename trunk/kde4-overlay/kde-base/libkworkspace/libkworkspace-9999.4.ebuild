# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdebase-workspace
KMMODULE=libs/kworkspace
inherit kde4svn-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS=""
IUSE="debug"

KMEXTRACTONLY="ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml"
KMSAVELIBS="true"
