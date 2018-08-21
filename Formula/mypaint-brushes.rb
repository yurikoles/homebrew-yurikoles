class MypaintBrushes < Formula
  desc "Default MyPaint brushes"
  homepage "https://github.com/Jehan/mypaint-brushes"
  url "https://github.com/Jehan/mypaint-brushes/archive/v1.3.0.tar.gz"
  sha256 "704bb6420e65085acfd7a61d6050e96b0395c5eab078433f11406c355f16b214"

  depends_on "autoconf"
  depends_on "automake"

  patch :DATA

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test mypaint-brushes`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

__END__

diff --git a/autogen.sh b/autogen.sh
index 52d9d52..daa1fff 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -7,9 +7,9 @@
 # tools and you shouldn't use this script. Just call ./configure
 # directly.
 
-ACLOCAL=${ACLOCAL-aclocal-1.13}
+ACLOCAL=${ACLOCAL-aclocal}
 AUTOCONF=${AUTOCONF-autoconf}
-AUTOMAKE=${AUTOMAKE-automake-1.13}
+AUTOMAKE=${AUTOMAKE-automake}
 
 AUTOCONF_REQUIRED_VERSION=2.62
 AUTOMAKE_REQUIRED_VERSION=1.13
