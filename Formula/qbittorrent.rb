class Qbittorrent < Formula
  desc "BitTorrent client"
  homepage "https://www.qbittorrent.org/"
  url "https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.5.4/qbittorrent-4.5.4.tar.xz"
  sha256 "f92bcd3ed25600796c59257c507e56a252a65af60bd042b71f1e7ff3fe5264da"
  license "GPL-2.0-or-later"
  head "https://github.com/qbittorrent/qBittorrent.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "libtorrent-rasterbar"
  depends_on "openssl@1.1"
  depends_on "qt" => :recommended
  depends_on "molten-vk" => :optional
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

    args << "-D Vulkan_INCLUDE_DIR=#{Formula["molten-vk"].opt_include}" if build.with? "molten-vk"

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
    system "true"
  end
end
