# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="wlrctl"
HOMEPAGE=""
EGIT_REPO_URI="https://git.sr.ht/~brocellous/wlrctl"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
DEPEND="
dev-libs/wayland
"
RDEPEND="$DEPEND"
BDEPEND="$DEPEND"
