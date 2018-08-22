class AppstreamGlib < Formula
  desc "This library makes it easy to read and write AppStream metadata"
  homepage "https://people.freedesktop.org/~hughsient/appstream-glib/"
  url "https://people.freedesktop.org/~hughsient/appstream-glib/releases/appstream-glib-0.7.12.tar.xz"
  sha256 "bacab112fc15f37932570ac8287ba050b0a1d0fdc842913f8b8345f6de128bc9"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gobject-introspection" => :build
  depends_on "libtool" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gdk-pixbuf"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "json-glib"
  depends_on "libarchive"
  depends_on "libsoup"
  depends_on "libyaml"
  depends_on "util-linux"

  def install
    ENV.refurbish_args

    mkdir "build" do
      system "meson", "--prefix=#{prefix}", "-Dstemmer=false", "-Dgtk-doc=false", "-Dman=false", "-Drpm=false", ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test appstream-glib`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
