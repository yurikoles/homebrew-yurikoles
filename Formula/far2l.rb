class Far2l < Formula
  include Language::Python::Virtualenv

  desc "Linux port of FAR Manager v2"
  homepage "https://github.com/elfmz/far2l"
  url "https://github.com/elfmz/far2l/archive/refs/tags/v_2.6.5.tar.gz"
  sha256 "0e68efff1c5d950c86cdad0387bf1aae7b152dbdd7d24b70bbefeeb4f873a9c9"
  license "GPL-2.0-only"
  head "https://github.com/elfmz/far2l.git", branch: "master"

  # This check should be updated to avoid unstable versions if/when stable
  # versions become available in the future.
  livecheck do
    url "https://github.com/elfmz/far2l/releases"
    regex(%r{href=["']?[^"' >]*?/tree/[^"' >]*?(\d+(?:\.\d+)+)(?:[._-]?(?:alpha|beta))?["' >]}i)
    strategy :page_match
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "libarchive"
  depends_on "libnfs"
  depends_on "libssh"
  depends_on "neon"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "pkg-config"
  depends_on "uchardet"
  depends_on "wget"
  depends_on "xerces-c"

  depends_on "wxwidgets" => :recommended

  depends_on "aws-sdk-cpp" => :optional
  depends_on "python@3.13" => :optional
  depends_on "samba" => :optional

  def install
    args = std_cmake_args + %w[
      -G Ninja
      -B build
      -S .
    ]

    if build.with? "python@3.13"
      ENV.prepend_path "PATH", Formula["python@3.13"].opt_libexec/"bin"

      venv_root = libexec/"venv"
      virtualenv_create(venv_root, "python3")
      ENV.prepend_path "PATH", "#{venv_root}/bin"
      args << "-DPYTHON=yes"
    end

    args << if build.with? "wxwidgets"
      "-DUSEWX=ON"
    else
      "-DUSEWX=OFF"
    end

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "help", shell_output("#{bin}/far2l -h")
  end
end
