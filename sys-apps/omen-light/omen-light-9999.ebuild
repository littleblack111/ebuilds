# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A command line tool to control LED lights for HP Omen machines"
HOMEPAGE="https://github.com/littleblack111/omen-light"
EGIT_REPO_URI="https://github.com/littleblack111/omen-light.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/hidapi"
RDEPEND="${DEPEND}"

src_compile() {
  g++ ${CXXFLAGS} -o omen_light omen_light.cc -lhidapi-libusb
}

src_install() {
  dobin omen_light
  dobin omen_light_all

  insinto /etc/systemd/system
  doins omen_light.service
}
