# Maintainer: Juergen Hoetzel <juergen@archlinux.org>
# Maintainer: Frederik Schwan <freswa at archlinux dot org>
# Contributor: Jaroslav Lichtblau <svetlemodry@archlinux.org>
# Contributor: Renchi Raju <renchi@green.tam.uiuc.edu>

pkgname=emacs31
pkgver=31.0.90
arch=('x86_64')
url='https://www.gnu.org/software/emacs/emacs.html'
license=(GPL-3.0-or-later)
depends=(
  gmp
  gnutls
  lcms2
  libgccjit
  libice
  libotf
  libpng
  libsm
  libxfixes
  m17n-lib
  zlib
)
makedepends=(libgccjit)
source=("git+file:///home/stradlater/git/emacs#branch=emacs-31")
b2sums=('SKIP')
sha256sums=('SKIP')


build() {
  local _confflags=(
	  --sysconfdir=/etc
	  --prefix=/usr
	  --libexecdir=/usr/lib
      --localstatedir=/var
	  --disable-build-details
      --with-cairo
	  --with-harfbuzz
	  --with-libsystemd
      --with-modules
	  --with-tree-sitter
	  --with-native-compilation=aot
  )
  export ac_cv_lib_gif_EGifPutExtensionLast=yes

  cd ${pkgname}
  ./autogen.sh
  ./configure --with-pgtk "${_confflags[@]}"
  make bootstrap
}

package() {
  pkgdesc='The extensible, customizable, self-documenting real-time display editor. Custom build by Stradlater.'
  depends+=(
    libacl.so
    libasound.so
    libdbus-1.so
    libfontconfig.so
    libfreetype.so
    libgdk-3.so
    libgdk_pixbuf-2.0.so
    libgif.so
    libgio-2.0.so
    libglib-2.0.so
    libgobject-2.0.so
    libgpm.so
    libgtk-3.so
    libharfbuzz.so
  )

  provides=(emacs31)
  replaces=(emacs-nativecomp)

  cd ${pkgname}
  make DESTDIR="${pkgdir}" install

  # fix user/root permissions on usr/share files
  chown -R root:root "${pkgdir}/usr/share/emacs/${pkgver}"
}

