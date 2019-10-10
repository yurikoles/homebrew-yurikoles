class Gimp < Formula
  desc "GNU Image Manipulation Program"
  homepage "https://www.gimp.org"

  stable do
    url "https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.6.tar.bz2"
    sha256 "4ec8071f828e918384cf7bc7d1219210467c84655123f802bc55a8bf2415101f"

    resource "gegl" do
      url "https://download.gimp.org/pub/gegl/0.4/gegl-0.4.8.tar.bz2"
      sha256 "719468eec56ac5b191626a0cb6238f3abe9117e80594890c246acdc89183ae49"
    end
  end

  head do
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "appstream-glib"

    url "https://gitlab.gnome.org/GNOME/gimp.git"

    resource "gegl" do
      url "https://gitlab.gnome.org/GNOME/gegl.git"
    end
  end

  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "aalib"
  depends_on "babl"
  depends_on "cairo"
  depends_on "dbus"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gdk-pixbuf"
  depends_on "gexiv2"
  depends_on "glib"
  depends_on "glib-networking"
  depends_on "gtk+"
  depends_on "gtk-doc"
  depends_on "gtk-mac-integration"
  depends_on "json-glib"
  depends_on "libmypaint"
  depends_on "librsvg"
  depends_on "little-cms2"
  depends_on "pango"
  depends_on "poppler"
  depends_on "pygtk"
  depends_on "xz"
  depends_on "yurikoles/yurikoles/mypaint-brushes"
  depends_on "libpng" => :recommended
  depends_on "libtiff" => :recommended
  depends_on "libwmf" => :recommended
  depends_on "ghostscript" => :optional
  depends_on "libexif" => :optional
  depends_on "poppler" => :optional

  def install
    resource("gegl").stage do
      ENV.no_optimization if ENV.compiler == :llvm
      system "./autogen.sh" if build.head?
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{libexec}/gegl", "--disable-docs"
      system "make", "install"
    end
    ENV.prepend_path "PATH", libexec/"gegl/bin"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"gegl/lib/pkgconfig"

    args = %W[
      --prefix=#{prefix}
      --disable-silent-rules
      --disable-dependency-tracking
      --disable-glibtest
      --disable-gtktest
      --datarootdir=#{share}
      --sysconfdir=#{etc}
      --without-x
    ]

    args << "--without-libtiff" if build.without? "libtiff"
    args << "--without-libpng" if build.without? "libpng"
    args << "--without-wmf" if build.without? "libwmf"
    args << "--without-poppler" if build.without? "poppler"
    args << "--without-libexif" if build.without? "libexif"
    args << "--disable-gtk-doc" if build.without? "gtk-doc"

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/gimp", "--version"
  end
end
