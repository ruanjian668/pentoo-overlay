# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"
#SRC_URI="http://files.pinguin.lu/${P}.tar.gz"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/xmount_${PV}.orig.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare(){
	epatch "${FILESDIR}"/configure.ac.diff
	epatch "${FILESDIR}"/configure.diff
	eautomake
}

src_configure() {
	use aff || export ac_cv_lib_afflib_af_open=no
	use ewf || export ac_cv_lib_ewf_libewf_open=no
	econf
}
