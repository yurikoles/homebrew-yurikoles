class SvtAv1 < Formula
  desc "Scalable Video Technology for AV1"
  homepage "https://01.org/svt"
  url "https://github.com/AOMediaCodec/SVT-AV1/archive/v0.8.5.tar.gz"
  sha256 "8ce94359ea9450745c17c12d4cc054d45f6b2498e63e2ebaa5a5273bb36f6f95"
  head "https://github.com/AOMediaCodec/SVT-AV1.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "yasm" => :build

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-G" << "Ninja"

      system "cmake", "..", *args
      system "cmake", "--build", "."
      system "cmake", "--install", "."
    end
  end

  test do
    assert_match "-help", `#{bin}/SvtAv1DecApp -help`
  end
end
