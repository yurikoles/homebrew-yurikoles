class Far2l < Formula
  include Language::Python::Virtualenv

  desc "Linux port of FAR Manager v2"
  homepage "https://github.com/elfmz/far2l"
  license "GPL-2.0-only"
  head "https://github.com/elfmz/far2l.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "gawk"
  depends_on "libarchive"
  depends_on "libssh"
  depends_on "neon"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "pkg-config"
  depends_on "spdlog"
  depends_on "wget"
  depends_on "xerces-c"
  depends_on "python@3.9" => :optional
  depends_on "wxmac" => :optional

  resource "virtualenv" do
    url "https://files.pythonhosted.org/packages/06/8c/eb8a0ae49eba5be054ca32b3a1dca432baee1d83c4f125d276c6a5fd2d20/virtualenv-20.1.0.tar.gz"
    sha256 "b8d6110f493af256a40d65e29846c69340a947669eec8ce784fcf3dd3af28380"
  end

  def install
    mkdir "build" do
      args = std_cmake_args
      if build.with? "python@3.9"
        ENV.prepend_path "PATH", Formula["python@3.9"].opt_libexec/"bin"

        venv_root = libexec/"venv"
        venv = virtualenv_create(venv_root, "python3")
        venv.pip_install resource("virtualenv")
        ENV.prepend_path "PATH", "#{venv_root}/bin"
        args << "-DPYTHON=yes"
      else
        args << "-DPYTHON=no"
      end

      args << if build.with? "wxmac"
        "-DUSEWX=yes"
      else
        "-DUSEWX=no"
      end

      system "cmake", "..", "-G", "Ninja", *args
      system "cmake", "--build", "."
      system "cmake", "--install", "."
    end
  end

  test do
    assert_match "help", `#{bin}/far2l -h`
  end
end
