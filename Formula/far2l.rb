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
  depends_on "libnfs"
  depends_on "libssh"
  depends_on "neon"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "pkg-config"
  depends_on "spdlog"
  depends_on "wget"
  depends_on "xerces-c"
  depends_on "uchardet"
  depends_on "python@3.9" => :optional
  depends_on "wxmac" => :optional

  if build.with? "python@3.9"
    resource "virtualenv" do
      url "https://files.pythonhosted.org/packages/79/64/203241c2e2b5abfd5edca4e28242c21bf8a9e84490873e4a8a155a9658fc/virtualenv-20.4.2.tar.gz"
      sha256 "147b43894e51dd6bba882cf9c282447f780e2251cd35172403745fc381a0a80d"
    end
  end

  def install
    args = std_cmake_args + %w[
      -G Ninja
      -B build
      -S .
    ]

    if build.with? "python@3.9"
      ENV.prepend_path "PATH", Formula["python@3.9"].opt_libexec/"bin"

      venv_root = libexec/"venv"
      venv = virtualenv_create(venv_root, "python3")
      venv.pip_install resource("virtualenv")
      ENV.prepend_path "PATH", "#{venv_root}/bin"
    end

    args << if build.with? "wxmac"
      "-DUSEWX=ON"
    else
      "-DUSEWX=OFF"
    end

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "help", `#{bin}/far2l -h`
  end
end
