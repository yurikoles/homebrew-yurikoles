class SvtAv1 < Formula
  desc "Scalable Video Technology for AV1 Encoder"
  homepage "https://github.com/OpenVisualCloud/SVT-AV1"
  url "https://github.com/OpenVisualCloud/SVT-AV1/archive/v0.7.0.tar.gz"
  sha256 "69893ec8b8515dd3bcde78ff955a908537acd52f22310f0f188f4e98b239000a"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Ninja", *std_cmake_args
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    assert `"#{bin}/SvtAv1DecApp" -help | grep -- -help` =~ /-help/
  end
end
