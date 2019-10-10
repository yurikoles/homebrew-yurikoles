class SvtHevc < Formula
  desc "Scalable Video Technology for HEVC Encoder"
  homepage "https://01.org/svt"
  url "https://github.com/OpenVisualCloud/SVT-HEVC/archive/v1.4.1.tar.gz"
  sha256 "8ceb14acddd0af48e87deb17dc0a54fc9f82c50d6e0b392076fa8f7d0533f74b"
  head "https://github.com/OpenVisualCloud/SVT-HEVC.git"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end
end
