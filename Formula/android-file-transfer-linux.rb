class AndroidFileTransferLinux < Formula
  desc "Android File Transfer for Linux"
  homepage "https://whoozle.github.io/android-file-transfer-linux/"
  url "https://github.com/whoozle/android-file-transfer-linux/archive/v4.2.tar.gz"
  sha256 "cc607d68e8a18273c9b56975a70a0e68fbdf9d5b903b2727a345a605ff48a19f"
  head "https://github.com/whoozle/android-file-transfer-linux.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  depends_on "openssl"
  depends_on "qt"
  depends_on "taglib"

  def install
    args = std_cmake_args
    args << "-DBUILD_FUSE=OFF"
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aft-mtp-cli --version")
  end
end
