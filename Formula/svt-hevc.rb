class SvtHevc < Formula
  desc "Scalable Video Technology for HEVC Encoder"
  homepage "https://01.org/svt"
  url "https://github.com/OpenVisualCloud/SVT-HEVC/archive/v1.5.0.tar.gz"
  sha256 "5331213ce3fe73d5fe2887cf3aabcd8ffde2fafd0e5f09928d412dc8306f3992"
  revision 2
  head "https://github.com/OpenVisualCloud/SVT-HEVC.git"

  depends_on "cmake" => :build
  depends_on "yasm" => :build

  resource "akiyo_qcif.y4m" do
    url "https://media.xiph.org/video/derf/y4m/akiyo_qcif.y4m"
    sha256 "df88d83cbf6d99f3ec41f2c1fd2e67665d2a71ff8caa08f8b6bc46bf4567ea2e"
  end

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "cmake", "--build", "."
      system "cmake", "--install", "."
    end
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
