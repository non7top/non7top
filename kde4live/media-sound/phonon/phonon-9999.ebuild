# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="1"

inherit cmake-utils subversion 

DESCRIPTION="KDE multimedia API"
KEYWORDS=""
IUSE="debug gstreamer"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/branches/phonon/4.2/"
SLOT="0"

LICENSE="GPL-2"

RDEPEND="!kde-base/phonon:kde-svn
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	gstreamer? ( media-libs/gstreamer
		media-libs/gst-plugins-base )"
DEPEND="${RDEPEND}
	kde-base/automoc"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)"
	
	cmake-utils_src_compile
}
