# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Blingful TUIs and character graphics"
HOMEPAGE="https://notcurses.com"
EGIT_REPO_URI="https://github.com/dankamongmen/notcurses.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cxx ffi gpm media static-libs test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/libunistring:=[static-libs?]
	media? (
		media-video/ffmpeg:=
	)
	gpm? (
		sys-libs/gpm
	)
	sys-libs/ncurses:=[static-libs?]
	sys-libs/zlib:=[static-libs?]"
RDEPEND="${DEPEND}"

src_prepare() {
	case "${CTARGET:-${CHOST}}" in
		*-gnu*)
			if use static-libs; then
				eapply "${FILESDIR}/glibc-static.patch"
			fi;;
	esac
	eapply_user
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex test RelWithDebInfo Release)
		-DBUILD_FFI_LIBRARY=$(usex ffi)
		-DBUILD_TESTING=$(usex test)
		-DUSE_CXX=$(usex cxx)
		-DUSE_DEFLATE=OFF
		-DUSE_DOCTEST=OFF
		-DUSE_GPM=$(usex gpm)
		-DUSE_MULTIMEDIA=$(usex media ffmpeg none)
		-DUSE_PANDOC=OFF
		-DUSE_QRCODEGEN=OFF
		-DUSE_STATIC=$(usex static-libs)
	)
	cmake_src_configure
}

src_test() {
	ewarn "Tests will fail if you don't have a UTF8 locale available,"
	ewarn "or if you're missing the proper terminfo database for your TERM."
	cmake_src_test
}

src_install() {
	cmake_src_install
}
