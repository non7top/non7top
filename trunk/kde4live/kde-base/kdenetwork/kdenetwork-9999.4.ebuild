# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE network applications: Kopete, KPPP, KGet,..."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="+addbookmarks +alias +autoreplace bittorrent +contactnotes debug gadu groupwise
+highlight +history htmlhandbook +jabber jingle jpeg kde latex -meanwhile messenger msn
+nowlistening oscar ppp +privacy qq slp sms ssl +statistics testbed telepathy
+texteffect +translator +urlpicpreview vnc +webpresence wifi winpopup
yahoo zeroconf"
LICENSE="GPL-2 LGPL-2"

# TODO: SMPPPD = (SuSE Meta PPP Daemon). No ebuild known.
# FIXME: x11-proto/xf86vidmodeproto is in fact an optional dep,
# but without a cmake switch. Hard dep for now, no clue what it enables though.

COMMON_DEPEND="
	dev-libs/libpcre
	kde-base/qimageblitz
	x11-libs/libXScrnSaver
	gadu? ( dev-libs/openssl )
	groupwise? ( app-crypt/qca:2 )
	jabber? ( net-dns/libidn app-crypt/qca:2 )
	jpeg? ( media-libs/jpeg )
	kde? (
		|| ( kde-base/kdebase:${SLOT}
			kde-base/plasma:${SLOT} ) )
	slp? ( net-libs/openslp x11-libs/libXdamage )
	statistics? ( dev-db/sqlite:3 )
	telepathy? ( net-libs/decibel )
	bittorrent? ( net-p2p/ktorrent:${SLOT} )
	vnc? ( >=net-libs/libvncserver-0.9 )
	webpresence? ( dev-libs/libxml2 dev-libs/libxslt )
	wifi? ( net-wireless/wireless-tools )
	zeroconf? ( || ( net-dns/avahi
		!bindist? ( net-misc/mDNSResponder ) ) )
	"
RDEPEND="${COMMON_DEPEND}
	|| ( net-misc/netkit-talk
		net-misc/ytalk
		sys-freebsd/freebsd-ubin )
	ppp? ( net-dialup/ppp )
	ssl? ( dev-perl/IO-Socket-SSL )"
DEPEND="${COMMON_DEPEND}
	x11-proto/scrnsaverproto
	x11-proto/videoproto
	x11-proto/xproto"

pkg_setup() {
	if use zeroconf && has_version net-dns/avahi; then
		KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
			net-dns/avahi mdnsresponder-compat"
	fi
	kde4overlay-base_pkg_setup
}

src_compile() {
	# These arguments have no cmake switches:
	# FIXME: could probably be an eclass function
	if ! use ppp ; then
		sed -i -e '/kppp/s:^:#DONOTCOMPILE :' \
			"${S}/CMakeLists.txt" || die "sed to disable kppp compilation failed."
	fi

	if ! use bittorrent; then
		sed -i -e '/bittorrent/s:^:#DONOTCOMPILE :' \
			"${S}"/kget/transfer-plugins/CMakeLists.txt \
			|| die "sed to disable torrent support failed."
	fi

	if use zeroconf; then
		if has_version net-dns/avahi; then
			mycmakeargs="${mycmakeargs} -DWITH_Avahi=ON -DWITH_DNSSD=OFF"
		elif has_version net-misc/mDNSResponder; then
			mycmakeargs="${mycmakeargs} -DWITH_Avahi=OFF -DWITH_DNSSD=ON"
		else
			die "USE=\"zeroconf\" enabled but neither net-dns/avahi nor net-misc/mDNSResponder were found."
		fi
	fi

	# kdenetwork looks for 'xmms' which isn't in the official portage tree.
	# I've disabled this check to prevent linking to user-installed things.
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF
		$(cmake-utils_use_with addbookmarks)
		$(cmake-utils_use_with alias)
		$(cmake-utils_use_with autoreplace)
		$(cmake-utils_use_with contactnotes)
		$(cmake-utils_use_with gadu OPENSSL)
		$(cmake-utils_use_with groupwise)
		$(cmake-utils_use_with groupwise QCA2)
		$(cmake-utils_use_with highlight)
		$(cmake-utils_use_with history)
		$(cmake-utils_use_with jabber IDN)
		$(cmake-utils_use_with jabber QCA2)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with kde Plasma)
		$(cmake-utils_use_with latex)
		$(cmake-utils_use_with msn)
		$(cmake-utils_use_with messenger)
		$(cmake-utils_use_with nowlistening)
		$(cmake-utils_use_with oscar)
		$(cmake-utils_use_with privacy)
		$(cmake-utils_use_with qq)
		$(cmake-utils_use_with slp SLP)
		$(cmake-utils_use_with sms)
		$(cmake-utils_use_with statistics Sqlite)
		$(cmake-utils_use_with statistics)
		$(cmake-utils_use_with telepathy)
		$(cmake-utils_use_with telepathy Decibel)
		$(cmake-utils_use_with testbed)
		$(cmake-utils_use_with texteffect)
		$(cmake-utils_use_with translator)
		$(cmake-utils_use_with urlpicpreview)
		$(cmake-utils_use_with vnc LibVNCServer)
		$(cmake-utils_use_with webpresence LibXml2)
		$(cmake-utils_use_with webpresence LibXslt)
		$(cmake-utils_use_with webpresence)
		$(cmake-utils_use_with winpopup)
		$(cmake-utils_use_with yahoo)
	"

	kde4overlay-base_src_compile
}

pkg_postinst() {
	if use telepathy; then
		elog "To use kopete telepathy plugins, you need to start gabble first:"
		elog "GABBLE_PERSIST=1 telepathy-gabble &"
		elog "export TELEPATHY_DATA_PATH=/usr/share/telepathy/managers/"
	fi

	if use jabber; then
		elog "In order to use ssl in jabber, messenger and irc you'll need to have qca-ossl"
	fi

	echo
	elog "If you want to use the remote desktop protocol (RDP) in krdc install >=net-misc/rdesktop-1.4.1"
	echo
}
