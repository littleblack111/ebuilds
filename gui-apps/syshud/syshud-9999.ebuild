# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 
DESCRIPTION="syshud"
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/System64fumo/syshud.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="pulseaudio"
DEPEND="
  dev-cpp/gtkmm
  gui-libs/gtk4-layer-shell
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_compile() {
  emake PULSEAUDIO=$(usex pulseaudio 1 0)
}

src_install() {
  emake DESTDIR="${D}" install
}

