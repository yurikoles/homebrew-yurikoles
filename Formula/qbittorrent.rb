class Qbittorrent < Formula
  desc "BitTorrent client"
  homepage "https://www.qbittorrent.org/"
  url "https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.4.3.1/qbittorrent-4.4.3.1.tar.xz"
  sha256 "b64559ca50b54bc6c5be17302e69f34fba8433059842aa4093865dc2c00d24c8"
  license "GPL-2.0-or-later"
  head "https://github.com/qbittorrent/qBittorrent.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "libtorrent-rasterbar"
  depends_on "openssl"
  depends_on "qt@5"

  def install
    args = std_cmake_args + %w[
      -S .
      -B build
      -G Ninja
      -D QT6=OFF
    ]

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{prefix}/qbittorrent.app/Contents/Info.plist"
  end

  test do
    system "false"
  end
end
