class SvtAv1 < Formula
  desc "Scalable Video Technology for AV1 Encoder"
  homepage "https://01.org/svt"
  url "https://github.com/OpenVisualCloud/SVT-AV1/archive/v0.8.1.tar.gz"
  sha256 "b3508ff8b36465193e120458be960192088ac2b0cf859beda88d004c977d124f"
  head "https://github.com/OpenVisualCloud/SVT-AV1.git"

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
