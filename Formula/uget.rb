class Uget < Formula
  desc "#1 Open Source Download Manager"
  homepage "https://ugetdm.com/"
  url "https://downloads.sourceforge.net/project/urlget/uget%20%28stable%29/2.2.3/uget-2.2.3-1.tar.gz"
  sha256 "11356e4242151b9014fa6209c1f0360b699b72ef8ab47dbeb81cc23be7db9049"
  revision 1

  head do
    url "https://git.code.sf.net/p/urlget/uget2.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
  end

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "aria2"
  depends_on "gstreamer"
  depends_on "gtk+3"
  depends_on "libnotify"
  uses_from_macos "curl"

  def install
    chmod "+x", "./autogen.sh" if build.head?
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "help", `#{bin}/uget-gtk --help`
  end
end
