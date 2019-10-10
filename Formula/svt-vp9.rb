class SvtVp9 < Formula
  desc "Scalable Video Technology for VP9 Encoder"
  homepage "https://01.org/svt"
  url "https://github.com/OpenVisualCloud/SVT-VP9/archive/v0.1.0.tar.gz"
  sha256 "a38ea33d86b7e56219a8d2d10ba8acaf545a84e72545f72a0d53de346dff2b0f"
  head "https://github.com/OpenVisualCloud/SVT-VP9.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Ninja", *std_cmake_args
      system "ninja"
      system "ninja", "install"
    end
  end
end
