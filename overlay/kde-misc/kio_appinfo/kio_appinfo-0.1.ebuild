# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ARTS_REQUIRED="never"
inherit kde

MY_PN=${PN/kio_/}

APPID=72928

DESCRIPTION="The appinfo:/ KIO slave combines an application's configuration, data, manual and temp files and folders into a single view"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=${APPID}"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${APPID}-${MY_PN}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
need-kde 3.3
