class Gimp < Formula
  desc "GNU Image Manipulation Program"
  homepage "https://www.gimp.org"

  stable do
    url "https://download.gimp.org/pub/gimp/v2.8/gimp-2.8.16.tar.bz2"
    sha256 "95e3857bd0b5162cf8d1eda8c78b741eef968c3e3ac6c1195aaac2a4e2574fb7"

    resource "gegl" do
      url "https://download.gimp.org/pub/gegl/0.2/gegl-0.2.0.tar.bz2"
      sha256 "df2e6a0d9499afcbc4f9029c18d9d1e0dd5e8710a75e17c9b1d9a6480dd8d426"
    end
  end

  devel do
    url "https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.0-RC2.tar.bz2"
    sha256 "8b7de80c312d4a774d773e2713d7089cf99d1c0ff8f64d8bd476e88d7978ec3d"

    resource "gegl" do
      url "https://download.gimp.org/pub/gegl/0.3/gegl-0.3.34.tar.bz2"
      sha256 "5ca2227655ebf1ab2e252cee3eede219c758336394288ef301b93264b9411304"
    end
  end

  head do
    url "git://git.gnome.org/gimp"
    depends_on "gegl"
  end

  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "babl"
  depends_on "fontconfig"
  depends_on "pango"
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "cairo"
  depends_on "pygtk"
  depends_on "glib"
  depends_on "gdk-pixbuf"
  depends_on "freetype"
  depends_on "xz" # For LZMA
  depends_on "dbus"
  depends_on "aalib"
  depends_on "librsvg"
  depends_on "json-glib"
  depends_on "gexiv2"
  depends_on "libmypaint"
  depends_on "poppler"
  # depends_on "mypaint-brushes"
  # depends_on "poppler-glib"
  # depends_on "poppler-data"
  depends_on "little-cms2"
  depends_on "libpng" => :recommended
  depends_on "libwmf" => :recommended
  depends_on "libtiff" => :recommended
  depends_on "ghostscript" => :optional
  depends_on "poppler" => :optional
  depends_on "libexif" => :optional

  def install
    # if build.stable?
    resource("gegl").stage do
      ENV.no_optimization if ENV.compiler == :llvm
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{libexec}/gegl", "--disable-docs"
      system "make", "install"
    end
    ENV.prepend_path "PATH", libexec/"gegl/bin"
    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"gegl/lib/pkgconfig"
    # end

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

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/gimp", "--version"
  end
end
