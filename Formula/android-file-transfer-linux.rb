class AndroidFileTransferLinux < Formula
  desc "Android File Transfer for Linux"
  homepage "https://whoozle.github.io/android-file-transfer-linux/"
  url "https://github.com/whoozle/android-file-transfer-linux/archive/v3.6.tar.gz"
  sha256 "d3a69d66f285a97c324e3e94e165aabd1e2560d55fe287f427160a383352d98a"
  head

  depends_on "cmake" => :build
  depends_on :osxfuse
  depends_on "qt"

  def install
    system "cmake", ".", *std_cmake_args, "-DBUILD_FUSE=TRUE"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aft-mtp-cli --version")
  end
end
