# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="crypt debug gnokii htmlhandbook mysql sasl ssl"
LICENSE="GPL-2 LGPL-2"

# FIXME missing deps for pda and exchange support
#		exchange? ( net-libs/libmapi )
#		pda? ( >=app-pda/libopensync-0.19 >=app-pda/pilot-link-0.12 >=dev-libs/libmal-0.40 )
COMMONDEPEND="
	app-office/akonadi:${SLOT}
	>=app-misc/strigi-0.5.7
	dev-libs/libxslt
	dev-libs/boost
	kde-base/kdebase:${SLOT}
	crypt? ( app-crypt/gpgme
		|| ( >=app-crypt/gnupg-2.0.1-r1
			<app-crypt/gnupg-1.9 ) )
	gnokii? ( >=app-mobilephone/gnokii-0.6.14 )
	mysql? ( dev-db/mysql )
	sasl?  ( >=dev-libs/cyrus-sasl-2 )
	ssl? ( dev-libs/openssl )"
DEPEND="${COMMONDEPEND}
	x11-proto/scrnsaverproto"
RDEPEND="${DEPEND}
	crypt? ( app-crypt/pinentry )"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gnokii GNOKII)
		$(cmake-utils_use_with crypt Gpgme)
		$(cmake-utils_use_with mysql MySQL)
		$(cmake-utils_use_with sasl Sasl2)
		$(cmake-utils_use_with ssl OpenSSL)"

# Re-add when the proper deps are added to the tree
#		$(cmake-utils_use_with pda Opensync)
#		$(cmake-utils_use_with pda Pilotlink)
#		$(cmake-utils_use_with pda Mal)

	# FIXME Currently not handled
	#  KDE4_KDEPIM_NEW_DISTRLISTS ->  Whether to use new distribution lists, to
	#  store them like normal contacts; useful for Kolab
	# WITH_INDEXLIB ->  Enable full-text indexing in KMail

	kde4-base_src_compile
}
