class Amule < Formula
  desc "'All-platform' P2P client based on eMule"
  homepage "http://www.amule.org"
  head "https://github.com/amule-project/amule.git"

  option "with-headless", "Compile aMule daemon and command line"
  option "with-webserver", "Compile aMule WebServer"
  option "with-remote", "Compile aMule remote GUI"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "pkg-config" => :build

  depends_on "cryptopp"
  depends_on "wxmac"

  depends_on "boost" => :recommended
  depends_on "libupnp" => :recommended

  depends_on "geoip" => :optional

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --disable-static
      --disable-xas
      --disable-fileview
      --disable-plasmamule
      --disable-rpath
      --enable-mmap
      --enable-optimize
    ]

    if build.without? "libupnp"
      args << "--disable-upnp"
    else
      args << "--enable-upnp"
    end

    if build.without? "boost"
      args << "--without-boost"
    else
      args << "--with-boost"
    end

    if build.with? "geoip"
      args << "--enable-geoip"
    else
      args << "--disable-geoip"
    end

    if build.with? "webserver"
      args << "--enable-webserver"
    else
      args << "--disable-webserver"
    end

    if build.with?("headless") || build.with?("remote")
      args << "--disable-monolithic"
    else
      args << "--enable-monolithic"
    end

    if build.with? "headless"
      args << "--enable-amule-daemon"
      args << "--enable-amulecmd"
      args << "--enable-cas"
      args << "--enable-alcc"
    else
      args << "--disable-amule-daemon"
      args << "--disable-amulecmd"
      args << "--disable-cas"
      args << "--disable-alcc"
    end

    if build.with? "remote"
      args << "--enable-amule-gui"
    else
      args << "--disable-amule-gui"
    end

    if build.with?("remote") || build.without?("headless")
      args << "--enable-alc"
      args << "--enable-wxcas"
    else
      args << "--disable-alc"
      args << "--disable-wxcas"
    end

    system "./autogen.sh"
    system "./configure", *args
    system "make", "install"
  end
end
