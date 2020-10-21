class Far2l < Formula
  desc "Linux port of FAR Manager v2"
  homepage "https://github.com/elfmz/far2l"
  head "https://github.com/elfmz/far2l.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "gawk"
  depends_on "libarchive"
  depends_on "libssh"
  depends_on "neon"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "pkg-config"
  depends_on "wget"
  depends_on "wxmac"
  depends_on "minizip"
  depends_on "spdlog"
  depends_on "xerces-c"
  depends_on "uchardet"

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Ninja", *std_cmake_args
      system "cmake", "--build", "."
      system "cmake", "--install", "."
    end
  end

  test do
    assert_match "help", `#{bin}/far2l -h`
  end
end
