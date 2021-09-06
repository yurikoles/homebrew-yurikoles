class Far2l < Formula
  include Language::Python::Virtualenv

  desc "Linux port of FAR Manager v2"
  homepage "https://github.com/elfmz/far2l"
  url "https://github.com/elfmz/far2l/archive/refs/tags/v2021-06-30_alpha.tar.gz"
  version "2021-06-30_alpha"
  sha256 "262714a38d20058f745c6bde3af8ed1c26f28fcc3474d0ef577f8f1a2001e419"
  license "GPL-2.0-only"
  head "https://github.com/elfmz/far2l.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "gawk"
  depends_on "libarchive"
  depends_on "libnfs"
  depends_on "libssh"
  depends_on "neon"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "pkg-config"
  depends_on "spdlog"
  depends_on "uchardet"
  depends_on "wget"
  depends_on "xerces-c"

  depends_on "wxwidgets" => :recommended

  depends_on "python@3.9" => :optional

  def install
    args = std_cmake_args + %w[
      -G Ninja
      -B build
      -S .
    ]

    if build.with? "python@3.9"
      ENV.prepend_path "PATH", Formula["python@3.9"].opt_libexec/"bin"

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
