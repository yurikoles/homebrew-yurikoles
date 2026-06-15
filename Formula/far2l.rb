class Far2l < Formula
  include Language::Python::Virtualenv

  desc "Linux port of FAR Manager v2"
  homepage "https://github.com/elfmz/far2l"
  url "https://github.com/elfmz/far2l/archive/refs/tags/v_2.8.0.tar.gz"
  sha256 "b0fddad2e3985f245f9e691e23b90fb97f7d29d9a0b131fe686aa3cbb2e4ea01"
  license "GPL-2.0-only"
  head "https://github.com/elfmz/far2l.git", branch: "master"

  # This check should be updated to avoid unstable versions if/when stable
  # versions become available in the future.
  livecheck do
    url :homepage
    regex(/v?(\d+(?:\.\d+)+(?:\w)*)/i)
    strategy :github_latest
  end

  depends_on "cmake" => :build

  depends_on "libarchive"
  depends_on "libnfs"
  depends_on "libssh"
  depends_on "libxml2"
  depends_on "neon"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "pkg-config"
  depends_on "uchardet"
  depends_on "wget"
  depends_on "xerces-c"

  depends_on "wxwidgets" => :recommended

  depends_on "aws-sdk-cpp" => :optional
  depends_on "python@3.14" => :optional
  depends_on "samba" => :optional

  def install
    args = std_cmake_args + %w[
      -B build
      -S .
    ]

    if build.with? "python@3.14"
      ENV.prepend_path "PATH", Formula["python@3.14"].opt_libexec/"bin"

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
