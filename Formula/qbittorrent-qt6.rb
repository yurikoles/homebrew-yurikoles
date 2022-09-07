class QbittorrentQt6 < Formula
  desc "BitTorrent client"
  homepage "https://www.qbittorrent.org/"
  url "https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.4.5/qbittorrent-4.4.5.tar.xz"
  sha256 "0d6ed3948d4ad0d63f01510fe902639ae7b383ccfc1c01e88b75fba5b29ff3b3"
  license "GPL-2.0-or-later"
  head "https://github.com/qbittorrent/qBittorrent.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "libtorrent-rasterbar"
  depends_on "openssl"
  depends_on "qt"

  def install
    args = std_cmake_args + %w[
      -S .
      -B build
      -G Ninja
      -D WEBUI=OFF
      -D QT6=ON
    ]

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\"",
      "#{prefix}/qbittorrent.app/Contents/Info.plist"
  end

  test do
    system "false"
  end
end
