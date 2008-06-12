# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
OPENGL_REQUIRED="optional"
inherit multilib kde4svn

DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="3dnow altivec bluetooth +bzip2 captury debug ieee1394 htmlhandbook kerberos
lm_sensors mmx networkmanager pam openexr opengl samba sse sse2
ssl test +usb +xcb xcomposite +xine xinerama"

LICENSE="GPL-2 LGPL-2"
RESTRICT="test"

COMMONDEPEND="
	media-sound/phonon
	>=app-misc/strigi-0.5.7
	dev-cpp/clucene
	>=dev-libs/cyrus-sasl-2
	>=dev-libs/glib-2
	>=dev-libs/soprano-9999
	>=kde-base/qimageblitz-0.0.4
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/libpng
	>=sys-apps/dbus-1.0.2
	>=sys-apps/hal-0.5.9
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	>=x11-libs/libxklavier-3.2
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXrender
	x11-libs/libXres
	x11-libs/libXt
	x11-libs/libXtst
	x11-libs/libXxf86misc
	x11-libs/qt-webkit
	bzip2? ( app-arch/bzip2 )
	bluetooth? ( net-wireless/bluez-libs )
	captury? ( media-libs/libcaptury )
	ieee1394? ( sys-libs/libraw1394 )
	kerberos? ( virtual/krb5 )
	lm_sensors? ( sys-apps/lm_sensors )
	networkmanager? ( =net-misc/networkmanager-0.6* )
	samba? ( >=net-fs/samba-3.0.1 )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	opengl? ( virtual/glu virtual/opengl )
	pam? ( >=kde-base/kdebase-pam-7
		sys-libs/pam )
	ssl? ( dev-libs/openssl )
	usb? ( >=dev-libs/libusb-0.1.10a )
	xcomposite? ( x11-libs/libXcomposite )
	xine? ( >=media-libs/xine-lib-1.1.9
		xcb? ( x11-libs/libxcb ) )
	xinerama? ( x11-libs/libXinerama )
"

DEPEND="${COMMONDEPEND}
	x11-apps/bdftopcf
	x11-proto/kbproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xf86miscproto
	xcomposite? ( x11-proto/compositeproto
		x11-proto/damageproto )
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}
	sys-apps/usbutils
	sys-devel/gdb
	>=www-misc/htdig-3.2.0_beta6-r1
	x11-apps/mkfontdir
	x11-apps/setxkbmap
	>=x11-apps/xinit-1.0.5-r2
	x11-apps/xmessage
	x11-apps/xprop
	>=x11-apps/xrandr-1.2.1
	x11-apps/xset
	x11-apps/xsetroot
	|| ( x11-misc/xkeyboard-config
		x11-misc/xkbdata )
	virtual/ssh
	kernel_linux? (
		|| ( >=sys-apps/eject-2.1.5
			sys-block/unieject ) )
"

PDEPEND="
	|| ( kde-base/kdeartwork-iconthemes:${SLOT}
		kde-base/kdeartwork:${SLOT} )"

#IUSE="xscreensaver"
#
#COMMONDEPEND="
#	xscreensaver? ( x11-libs/libXScrnSaver )
#"
#DEPEND="${COMMONDEPEND}
#	x11-apps/xhost
#	xscreensaver? ( x11-proto/scrnsaverproto )"

PATCHES="${FILESDIR}/gentoo-startkde.patch
	${FILESDIR}/${P}-pam-optional.patch"

src_compile() {
	if ! use captury; then
		sed -e 's:^PKGCONFIG..libcaptury:#DONOTFIND &:' \
			-i "${S}"/workspace/kwin/effects/CMakeLists.txt || \
			die "Making captury optional failed."
	fi

	# Patch the startkde script to setup the environment for KDE 4.0
	# Add our KDEDIR
	sed -e "s#@REPLACE_PREFIX@#${PREFIX}#" \
		-i "${S}/workspace/startkde.cmake" || die "Sed for PREFIX failed."

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Complete LDPATH
	sed -e "s#@REPLACE_LIBS@#${_libdirs}#" \
		-i "${S}/workspace/startkde.cmake" || die "Sed for LDPATH failed."

	# Upstream moved kdesu to libexec first, then decided to move it back
	# to /${PREFIX}/bin/ , so I'm doing that now already.
	sed -e '/kdesu_executable/s:LIBEXEC_INSTALL_DIR:BIN_INSTALL_DIR:' \
		-i "${S}"/runtime/kdesu/kdesu/CMakeLists.txt || \
		die "Moving kdesu from libexec to bin failed."

	mycmakeargs="${mycmakeargs}
		-DWITH_LibXKlavier=ON -DWITH_GLIB2=ON -DWITH_GObject=ON
		$(cmake-utils_has 3dnow X86_3DNOW)
		$(cmake-utils_has altivec PPC_ALTIVEC)
		$(cmake-utils_has mmx X86_MMX)
		$(cmake-utils_has sse X86_SSE)
		$(cmake-utils_has sse2 X86_SSE2)
		$(cmake-utils_use_with bluetooth BlueZ)
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with ieee1394 RAW1394)
		$(use kerberos && echo "-DKDE4_KRB5AUTH=ON" || echo "-DKDE4_KRB5AUTH=OFF")
		$(cmake-utils_use_with lm_sensors Sensors)
		$(cmake-utils_use_with networkmanager NetworkManager)
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with pam PAM)
		$(cmake-utils_use_with samba Samba)
		$(cmake-utils_use_with ssl OpenSSL)
		$(cmake-utils_use_with usb USB)
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xine Xine)
		$(cmake-utils_use_with xinerama X11_Xinerama)
	"
	if use xine; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_with xcb XCB)"
		use xcb || mycmakeargs="${mycmakeargs} -DKDE4_DISABLE_MULTIMEDIA=ON"
	fi

	# FIXME: there's no Xscreensaver argument at the moment
	# FIXME There are more flags which currently aren't managed:
	# KDE4_KDM_XCONSOLE -> Build KDM with built-in xconsole - Default OFF
	# KDE4_KERBEROS4 ->  Compile KDM with Kerberos v4 support - Default OFF
	#
	# KDE4_KRB5AUTH -> Use Sun's secure RPC for Xauth cookies in KDM (? -
	# probably an error in cmake help) - Default OFF
	#
	# KDE4_RPCAUTH ->  Use Sun's secure RPC for Xauth cookies in KDM - Default
	# OFF
	#
	# KDE4_XDMCP ->  Build KDM with XDMCP support - Default ON
	#
	# KONSOLE_GENERATE_LINEFONT -> Konsole: regenerate linefont file - Default
	# OFF
	# WITH_XKB -> Enable/Disable building of Konsole with support for XKB

	kde4overlay-base_src_compile
}

src_test() {
	sed -i -e "/testkioarchive/s/^#DONOTTEST /" \
		"${S}"/runtime/kioslave/archive/tests/CMakeLists.txt
	sed -i -e "/testtrash/s/^#DONOTTEST /" \
		"${S}"/runtime/kioslave/trash/tests/CMakeLists.txt
	sed -i -e "/kurifiltertest/s/^#DONOTTEST /" \
		"${S}"/runtime/kurifilter-plugins/tests/CMakeLists.txt
	sed -e "/konqpopupmenutest/s/^/#DONOTTEST /" \
		-i "${S}"/apps/lib/konq/tests/CMakeLists.txt
	sed -e '/guitest/s/^/#DONOTTEST/' \
		-i "${S}"/workspace/libs/ksysguard/tests/CMakeLists.txt
	sed -e "s/packagestructuretest//" \
		-i "${S}"/workspace/libs/plasma/tests/CMakeLists.txt

	kde4overlay-base_src_test
}

src_install() {
	export GENKDMCONF_FLAGS="--no-old --no-backup"

	kde4overlay-base_src_install

	# Customize the kdmrc configuration
	sed -i -e "s:^.*SessionsDirs=.*$:#&\nSessionsDirs=/usr/share/xsessions:" \
		"${D}"/${PREFIX}/share/config/kdm/kdmrc \
		|| die "Failed to set SessionsDirs correctly."

	# startup and shutdown scripts
	insinto "${KDEDIR}/env"
	doins "${FILESDIR}/agent-startup.sh"

	exeinto "${KDEDIR}/shutdown"
	doexe "${FILESDIR}/agent-shutdown.sh"

	# freedesktop environment variables
	cat <<-EOF > "${T}/xdg.sh"
	export XDG_DATA_DIRS="${KDEDIR}/share:/usr/share"
	export XDG_CONFIG_DIRS="${KDEDIR}/etc/xdg"
	EOF
	insinto ${KDEDIR}/env
	doins "${T}/xdg.sh"

	# x11 session script
	cat <<-EOF > "${T}/${SLOT}"
	#!/bin/sh
	exec ${KDEDIR}/bin/startkde
	EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/${SLOT}"

	# freedesktop compliant session script
	sed -e "s:\${KDE4_BIN_INSTALL_DIR}:${KDEDIR}/bin:g;s:Name=KDE:Name=${SLOT}:" \
		"${S}/workspace/kdm/kfrontend/sessions/kde.desktop.cmake" > "${T}/${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/${SLOT}.desktop"
}

pkg_postinst() {
	kde4overlay-base_pkg_postinst

	# set the default kdm face icon if it's not already set by the system admin
	if [[ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ]]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [[ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi

	mkdir -p "${ROOT}${KDEDIR}/share/templates/.source/emptydir"

	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${KDEDIR}/env/agent-startup.sh and"
	elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
	elog "If you can't open new konqueror windows and get something like"
	elog "'WARNING: Outdated database found' when starting konqueror in a console, run"
	elog "kbuildsycoca as the user you're running KDE under."
	elog "This is NOT a bug."
	echo
	elog "To use Java on webpages: emerge >=virtual/jre-1.4"
	echo
}
