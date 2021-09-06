class SvtVp9 < Formula
  desc "Scalable Video Technology for VP9 Encoder"
  homepage "https://01.org/svt"
  license "BSD-2-Clause-Patent"
  head "https://github.com/OpenVisualCloud/SVT-VP9.git", branch: "master"

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
      #{bin}/SvtHevcEncApp -i #{testpath}/akiyo_qcif.y4m -b #{mp4out}
    EOS
    chmod 0555, testpath/"command.sh"
    system "./command.sh"
    assert_predicate mp4out, :exist?
  end
end
