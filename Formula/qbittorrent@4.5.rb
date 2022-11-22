class QbittorrentAT45 < Formula
  desc "BitTorrent client"
  homepage "https://www.qbittorrent.org/"
  url "https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.4.5/qbittorrent-4.4.5.tar.xz"
  sha256 "0d6ed3948d4ad0d63f01510fe902639ae7b383ccfc1c01e88b75fba5b29ff3b3"
  license "GPL-2.0-or-later"
  head "https://github.com/qbittorrent/qBittorrent.git", branch: "v4_5_x"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "libtorrent-rasterbar"
  depends_on "openssl@1.1"
  depends_on "qt" => :recommended
  depends_on "qt@5" => :optional

  def install
    args = %w[
      -S .
      -B build
      -G Ninja
    ]

    qt_dep = ""
    if build.with? "qt"
      qt_dep = "qt"
      args << "-D QT6=ON"
    elsif build.with? "qt@5"
      qt_dep = "qt@5"
      args << "-D QT6=OFF"
    end

    system "cmake", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula[qt_dep].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\"",
      "#{prefix}/qbittorrent.app/Contents/Info.plist"
  end

  test do
    system "false"
  end
end
