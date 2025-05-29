class AndroidFileTransferLinux < Formula
  desc "Android File Transfer for Linux"
  homepage "https://whoozle.github.io/android-file-transfer-linux/"
  url "https://github.com/whoozle/android-file-transfer-linux/archive/refs/tags/v4.5.tar.gz"
  sha256 "0f366a8d659926d3859a8628d4f7592692389b060f67da9a936d19b252b42d96"
  head "https://github.com/whoozle/android-file-transfer-linux.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  option "with-fuse"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "openssl"
  depends_on "qt@5"
  depends_on "taglib"

  depends_on "pybind11" => :recommended

  def install
    args = std_cmake_args + %w[
      -S .
      -B build
      -G Ninja
    ]

    args << if build.with? "fuse"
      "-D BUILD_FUSE=ON"
    else
      "-D BUILD_FUSE=OFF"
    end

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "help", shell_output("#{bin}/aft-mtp-cli --help 2>&1")
  end
end
