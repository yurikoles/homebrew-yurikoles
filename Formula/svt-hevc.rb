class SvtHevc < Formula
  desc "Scalable Video Technology for HEVC Encoder"
  homepage "https://01.org/svt"
  url "https://github.com/OpenVisualCloud/SVT-HEVC/archive/v1.5.0.tar.gz"
  sha256 "5331213ce3fe73d5fe2887cf3aabcd8ffde2fafd0e5f09928d412dc8306f3992"
  head "https://github.com/OpenVisualCloud/SVT-HEVC.git"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/SvtHevcEncApp --version")
  end
end
