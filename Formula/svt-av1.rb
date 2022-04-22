class SvtAv1 < Formula
  desc "Scalable Video Technology for AV1"
  homepage "https://01.org/svt"
  url "https://github.com/AOMediaCodec/SVT-AV1/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "34bc7fa4daf9c0431c70b0e4818046dbec93d33a2d45926d1df2274c47b8c8a8"
  license all_of: ["BSD-2-Clause", "BSD-3-Clause-Clear"]
  head "https://gitlab.com/AOMediaCodec/SVT-AV1.git", branch: "master"

  livecheck do
    url :stable
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "yasm" => :build

  resource "akiyo_qcif.y4m" do
    url "https://media.xiph.org/video/derf/y4m/akiyo_qcif.y4m"
    sha256 "df88d83cbf6d99f3ec41f2c1fd2e67665d2a71ff8caa08f8b6bc46bf4567ea2e"
  end

  def install
    args = std_cmake_args
    args << "-G" << "Ninja"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    resource("akiyo_qcif.y4m").stage testpath
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    (testpath/"command.sh").write <<~EOS
      #!/bin/sh
      ulimit -n 512
      #{bin}/SvtAv1EncApp -i #{testpath}/akiyo_qcif.y4m -b #{mp4out}
    EOS
    chmod 0555, testpath/"command.sh"
    system "./command.sh"
    assert_predicate mp4out, :exist?
  end
end
