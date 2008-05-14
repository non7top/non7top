# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
KMNAME=koffice
KMMODULE=libs
CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Shared KOffice libraries."
KEYWORDS=""
#doc
IUSE="${IUSE} crypt"

RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	>=media-libs/lcms-1.15
	>=media-libs/openexr-1.2.2-r2
	crypt? ( >=app-crypt/qca-2 )
	opengl? ( virtual/opengl virtual/glu )"
DEPEND="${RDEPEND}"
#	doc? ( app-doc/doxygen )"

KMEXTRA="
	doc/koffice/
	doc/thesaurus/
	filters/xsltfilter/
	filters/generic_wrapper/
	interfaces/
	kounavail/
	plugins/
	tools/"
#	doc/api/
KMEXTRACTONLY="
	changes-1.4
	changes-1.5
	doc/koffice.desktop"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_OpenEXR=ON
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with opengl OpenGL)"

	if use crypt; then
		mycmakeargs="${mycmakeargs}
			-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2"
	fi

	kde4-meta_src_compile

#	if use doc; then
#		cd "${WORKDIR}/${PN}_build" && \
#		make apidox || die "Make apidox failed."
#	fi
}

src_install() {
	dodoc changes-*
	newdoc kounavail/README README.kounavail

	kde4-meta_src_install

# there is no install target for the api docs :(
#	if use doc; then
#		cd "${WORKDIR}/${PN}_build" && \
#		emake DESTDIR="${D}" install-apidox || \
#			die "Install of apidox failed."
#	fi
}
