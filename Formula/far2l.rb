class Far2l < Formula
  desc "Linux port of FAR v2"
  homepage "https://github.com/elfmz/far2l"
  url "https://github.com/elfmz/far2l/archive/alpha-23jun19.tar.gz"
  version "0.2-alpha.2019-07-23"
  sha256 "0e9a3a25f0954a201d210baab12c14a496df8e49c6d3188d921ba4ff50b72800"
  head "https://github.com/elfmz/far2l.git"

  depends_on "cmake" => :build
  depends_on "gawk"
  depends_on "glib"
  depends_on "neon"
  depends_on "pkg-config"
  depends_on "wget"
  depends_on "wxmac"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    mv bin/"far2l", bin/"far2l.orig"
    mkdir_p bin.to_s
    (bin/"far2l").write <<~EOS
      #!/bin/sh
      "#{prefix}/bin/far2l.orig"
    EOS
  end
end
