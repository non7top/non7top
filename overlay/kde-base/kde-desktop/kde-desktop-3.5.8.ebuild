# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="A lighter meta ebuild to pull in KDE packages from split ebuilds"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="admin arts artwork browserplugin graphics kdm multimedia nls pdf print svg utils network bluetooth cdr"

RDEPEND="
~kde-base/kdelibs-${PV}
$(deprange $PV $MAXKDEVER kde-base/kdebase-startkde)
$(deprange $PV $MAXKDEVER kde-base/kate)
$(deprange $PV $MAXKDEVER kde-base/kcheckpass)
$(deprange $PV $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/kcontrol)
$(deprange $PV $MAXKDEVER kde-base/kdcop)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)
$(deprange $PV $MAXKDEVER kde-base/kdebase-kioslaves)
$(deprange $PV $MAXKDEVER kde-base/kdepasswd)
$(deprange $PV $MAXKDEVER kde-base/kdesktop)
$(deprange $PV $MAXKDEVER kde-base/kdesu)
$(deprange $PV $MAXKDEVER kde-base/kfind)
$(deprange $PV $MAXKDEVER kde-base/kicker)
$(deprange $PV $MAXKDEVER kde-base/kmenuedit)
$(deprange $PV $MAXKDEVER kde-base/konqueror)
$(deprange $PV $MAXKDEVER kde-base/konsole)
$(deprange $PV $MAXKDEVER kde-base/kpager)
$(deprange $PV $MAXKDEVER kde-base/kreadconfig)
$(deprange $PV $MAXKDEVER kde-base/kstart)
$(deprange $PV $MAXKDEVER kde-base/ksysguard)
$(deprange $PV $MAXKDEVER kde-base/ksystraycmd)
$(deprange $PV $MAXKDEVER kde-base/kwin)
$(deprange $PV $MAXKDEVER kde-base/kxkb)
$(deprange $PV $MAXKDEVER kde-base/libkonq)
$(deprange $PV $MAXKDEVER kde-base/kicker-applets)

kdm? ( $(deprange $PV $MAXKDEVER kde-base/kdm) )
nls? ( $(deprange $PV $MAXKDEVER kde-base/kde-i18n)
	kde-misc/kkbswitch
)
browserplugin? ( $(deprange $PV $MAXKDEVER kde-base/nsplugins) )
print? (
	$(deprange $PV $MAXKDEVER kde-base/kdeprint)
	$(deprange $PV $MAXKDEVER kde-base/kghostview)
)
admin? (
	$(deprange $PV $MAXKDEVER kde-base/kdeadmin-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/kuser)
	$(deprange $PV $MAXKDEVER kde-base/secpolicy)
	kde-misc/kdiff3

)
artwork? (
	$(deprange $PV $MAXKDEVER kde-base/kdeartwork-emoticons)
	$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kwin-styles)
	$(deprange $PV $MAXKDEVER kde-base/kdeartwork-styles)
	x11-themes/nuvola
	x11-themes/gtk-engines-qt
)
graphics? (
	$(deprange $PV $MAXKDEVER kde-base/kdegraphics-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/ksnapshot)
	$(deprange $PV $MAXKDEVER kde-base/kcoloredit)
	$(deprange $PV $MAXKDEVER kde-base/kolourpaint)
	media-gfx/gwenview
	media-gfx/digikam
)
pdf? ( $(deprange $PV $MAXKDEVER kde-base/kpdf) )
svg? ( $(deprange $PV $MAXKDEVER kde-base/ksvg) )
multimedia? (
	arts? ( $(deprange $PV $MAXKDEVER kde-base/kdemultimedia-arts) )
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-kappfinder-data)
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-kioslaves)
	$(deprange $PV $MAXKDEVER kde-base/kmix)
	media-sound/amarok
	media-video/kaffeine

)
utils? (
	$(deprange $PV $MAXKDEVER kde-base/ark)
	$(deprange $PV $MAXKDEVER kde-base/kcalc)
	$(deprange $PV $MAXKDEVER kde-base/kwalletmanager)
	kde-misc/dolphin
	kde-misc/yakuake
	kde-misc/ksensors
	$(deprange $PV $MAXKDEVER kde-base/kfloppy)
	$(deprange $PV $MAXKDEVER kde-base/kgpg)
	$(deprange $PV $MAXKDEVER kde-base/kcron)
	$(deprange $PV $MAXKDEVER kde-base/kregexpeditor)
)
network? (
	$(deprange $PV $MAXKDEVER kde-base/kopete)
	$(deprange $PV $MAXKDEVER kde-base/kmail)
	$(deprange $PV $MAXKDEVER kde-base/akregator)
	net-irc/konversation
	net-p2p/ktorrent
	net-misc/knemo
	$(deprange $PV $MAXKDEVER kde-base/kget)
)
bluetooth? (net-wireless/kdebluetooth)
cdr? (app-cdr/k3b)
"
