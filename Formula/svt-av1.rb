class SvtAv1 < Formula
  desc "Scalable Video Technology for AV1 Encoder"
  homepage "https://github.com/OpenVisualCloud/SVT-AV1"
  url "https://github.com/OpenVisualCloud/SVT-AV1/archive/v0.6.0.tar.gz"
  sha256 "4ff6f05a9528fe8a7b3d6708fe1115d15d26a5a9b0b676d8a250a0b2e8630579"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    assert `"#{bin}/SvtAv1DecApp" -help | grep -- -help` =~ /-help/
  end
end
