class SvtVp9 < Formula
  desc "Scalable Video Technology for VP9 Encoder"
  homepage "https://01.org/svt"
  url "https://github.com/OpenVisualCloud/SVT-VP9/archive/v0.2.2.tar.gz"
  sha256 "988adae5ed5744769f1c990f7b085e1e0fa31d41ea415a75b9cf14c0a5b17947"
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
