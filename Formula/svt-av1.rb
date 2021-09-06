class SvtAv1 < Formula
  desc "Scalable Video Technology for AV1"
  homepage "https://01.org/svt"
  url "https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v0.8.7/SVT-AV1-v0.8.7.tar.gz"
  sha256 "de24e4a6c557498b2e8caf9cca438411db5f837d232b9390dc3899d974fec16f"
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
