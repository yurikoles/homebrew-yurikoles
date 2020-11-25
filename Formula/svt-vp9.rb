class SvtVp9 < Formula
  desc "Scalable Video Technology for VP9 Encoder"
  homepage "https://01.org/svt"
  url "https://github.com/OpenVisualCloud/SVT-VP9/archive/v0.3.0.tar.gz"
  sha256 "6ee01b81c43816170b18709c6045b6245cecc2953f01cecc9e98f82b49ea4f73"
  license "BSD-2-Clause-Patent"
  head "https://github.com/OpenVisualCloud/SVT-VP9.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Ninja", *std_cmake_args
      system "cmake", "--build", "."
      system "cmake", "--install", "."
    end
  end
end
