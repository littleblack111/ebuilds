# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools
DESCRIPTION="syshud"
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/System64fumo/syshud.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="pulseaudio"
DEPEND="
  dev-qt/qtbase
  dev-qt/qtdeclarative
  dev-qt/qtsvg
  x11-libs/xcb-util-wm
"
RDEPEND="${DEPEND}"
BDEPEND="
  dev-build/cmake
  dev-build/ninja
"

src_compile() {
  emake PULSEAUDIO=$(usex pulseaudio 1 0)
}

src_install() {
  emake DESTDIR="${D}" install
}

