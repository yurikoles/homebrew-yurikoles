class Far2l < Formula
  include Language::Python::Virtualenv

  desc "Linux port of FAR Manager v2"
  homepage "https://github.com/elfmz/far2l"
  url "https://github.com/elfmz/far2l/archive/refs/tags/v_2.4.0.tar.gz"
  version "2.4.0"
  sha256 "a595f7f2b48aaf6cfd61c1539bb52207f8f985576ee928915f54b675666e9f88"
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

  depends_on "python@3.10" => :optional

  def install
    args = std_cmake_args + %w[
      -G Ninja
      -B build
      -S .
    ]

    if build.with? "python@3.10"
      ENV.prepend_path "PATH", Formula["python@3.10"].opt_libexec/"bin"

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
