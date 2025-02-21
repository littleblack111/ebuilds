# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop wrapper xdg

_appimage="Lunar%20Client-${PV}-ow.AppImage"
DESCRIPTION="minecraft client"
HOMEPAGE=""
SRC_URI="https://launcherupdates.lunarclientcdn.com/${_appimage} -> ${P}.AppImage"

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

src_unpack() {
  mkdir "${S}" || die
  cp "${DISTDIR}"/"${P}.AppImage" "${S}"/ || die
  pushd "${S}" || die
  chmod +x "${P}.AppImage" || die
  "${S}/${P}.AppImage" --appimage-extract || die
  rm "${P}.AppImage" || die
  popd || die
}

src_prepare() {
  sed -i -E \
    "s|Exec=AppRun|Exec=env DESKTOPINTEGRATION=false /opt/${PN}/AppRun|" \
    "${S}/squashfs-root/lunarclient.desktop"
  chmod -R a-x+rX "${S}"/squashfs-root/usr

  default
}

src_install() {
  insinto /opt/${PN}
  doins -r "${S}"/squashfs-root/* || die

  fperms +x /opt/${PN}/AppRun
  fperms +x /opt/${PN}/lunarclient
  fperms +x /opt/${PN}/chrome_crashpad_handler

  insinto /usr/share/applications
  doins "${S}"/squashfs-root/lunarclient.desktop

  doicon -s 1024 "${S}"/squashfs-root/usr/share/icons/hicolor/1024x1024/apps/lunarclient.png
  domenu "${S}"/squashfs-root/lunarclient.desktop || die
  make_wrapper ${PN} /opt/${PN}/AppRun || die
}
