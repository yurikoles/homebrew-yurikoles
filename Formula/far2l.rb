class Far2l < Formula
  desc "Linux port of FAR v2"
  homepage "https://github.com/elfmz/far2l"
  head "https://github.com/elfmz/far2l.git"
  depends_on "cmake" => :build

  depends_on "cmake"
  depends_on "gawk"
  depends_on "glib"
  depends_on "pkg-config"
  depends_on "wget"
  depends_on "wxmac"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install", "DESTDIR=#{prefix}"
    mkdir_p bin.to_s
    ln_sf "#{prefix}/usr/bin/far2l", bin.to_s
  end
end
