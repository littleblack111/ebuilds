# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Windows Hello style facial authentication for Linux"
HOMEPAGE="https://github.com/boltgolt/howdy"

EGIT_REPO_URI="https://github.com/boltgolt/howdy.git"
EGIT_BRANCH="beta"
PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=no
inherit distutils-r1 git-r3 meson

LICENSE="MIT"
SLOT="0"

PATCHES=(
	"${FILESDIR}/${P}-fix-dlib-data.patch"
)

RDEPEND="
	dev-python/elevate[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-pam[${PYTHON_USEDEP}]
	media-libs/opencv[png,python,v4l]
	sci-libs/dlib[python]
	sys-auth/howdy-models
"

src_prepare() {
	default
	rm "${S}/README.md" || die
}
