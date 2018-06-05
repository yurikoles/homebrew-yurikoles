class Shaderc < Formula
  desc "Collection of tools, libraries and tests for shader compilation"
  homepage "https://github.com/google/shaderc"
  head "https://github.com/google/shaderc.git"

  depends_on "cmake" => :build
  depends_on "glslang"
  depends_on "ninja"

  resource "glslang" do
    url "https://github.com/google/glslang.git"
  end

  resource "googletest" do
    url "https://github.com/google/googletest.git"
  end

  resource "spirv-headers" do
    url "https://github.com/KhronosGroup/SPIRV-Headers.git"
  end

  resource "spirv-tools" do
    url "https://github.com/KhronosGroup/SPIRV-Tools.git"
  end

  def install
    (buildpath/"third_party/glslang").install resource("glslang")
    (buildpath/"third_party/googletest").install resource("googletest")
    (buildpath/"third_party/spirv-headers").install resource("spirv-headers")
    (buildpath/"third_party/spirv-tools").install resource("spirv-tools")

    system "cmake", "-GNinja", ".", *std_cmake_args # "-DSHADERC_SKIP_TESTS=true",
    system "ninja", "install"
  end
end
