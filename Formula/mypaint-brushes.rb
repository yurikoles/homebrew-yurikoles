class MypaintBrushes < Formula
  desc "Brushes used by MyPaint and other software using libmypaint"
  homepage "https://github.com/mypaint/mypaint-brushes"
  url "https://github.com/mypaint/mypaint-brushes/archive/v2.0.1.tar.gz"
  sha256 "5572c849c3cf01c33bceddb97f9ced55a219265738a46e406ddb5220ac59e22a"
  head "https://github.com/Jehan/mypaint-brushes.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_predicate share/"pkgconfig/mypaint-brushes-2.0.pc", :exist?
  end
end
