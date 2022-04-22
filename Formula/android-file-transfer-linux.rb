class AndroidFileTransferLinux < Formula
  desc "Android File Transfer for Linux"
  homepage "https://whoozle.github.io/android-file-transfer-linux/"
  url "https://github.com/whoozle/android-file-transfer-linux/archive/v4.2.tar.gz"
  sha256 "cc607d68e8a18273c9b56975a70a0e68fbdf9d5b903b2727a345a605ff48a19f"
  revision 3
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
      -DBUILD_FUSE=OFF
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
