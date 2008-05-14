# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="KDE personal information manager"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="app-crypt/gnupg
	app-crypt/gpgme
	>=kde-base/libkdepim-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
# kontact always tries to load the mail plugin at runtime.
# therefore we PDEPEND on kmail. remove this when the kmail
# plugin can be disabled without editing config files manually.
PDEPEND=">=kde-base/kmail-${PV}:${SLOT}"

# We remove plugins that are related to external kdepim programs. This way
# kontact doesn't have to depend on all programs it has plugins for.
#
# xml targets from kmail/ are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="libkdepim/
	kmail/
	kontact/plugins/akregator/
	kontact/plugins/kaddressbook/
	kontact/plugins/kmail/
	kontact/plugins/kmobiletools
	kontact/plugins/knode/
	kontact/plugins/knotes/
	kontact/plugins/korganizer/
	kontact/plugins/ktimetracker/
	kontact/plugins/planner/
	kontact/plugins/specialdates/"
KMLOADLIBS="libkdepim"
KMSAVELIBS="true"
