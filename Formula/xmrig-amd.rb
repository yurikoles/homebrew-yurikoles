class XmrigAmd < Formula
  desc "Monero AMD (OpenCL) miner"
  homepage "https://github.com/xmrig/xmrig-amd"
  url "https://github.com/xmrig/xmrig-amd/archive/v2.8.6.tar.gz"
  sha256 "df300404220481ac655348358116823e16b6077cf48408e0cc91265968e56b0f"
  head "https://github.com/xmrig/xmrig-amd.git"

  depends_on "cmake" => :build
  depends_on "libmicrohttpd"
  depends_on "libuv"
  depends_on "openssl"

  def install
    mkdir "build" do
      system "cmake", "..", "-DUV_LIBRARY=#{Formula["libuv"].opt_lib}/libuv.dylib",
                            *std_cmake_args
      system "make"
      bin.install "xmrig-amd"
    end
    pkgshare.install "src/config.json"
  end

  test do
    assert_match "2.8.6", shell_output("#{bin}/xmrig-amd -V")
    test_server="donotexist.localhost:65535"
    timeout=10
    begin
      read, write = IO.pipe
      pid = fork do
        exec "#{bin}/xmrig-amd", "--no-color", "--print-time=1",
             "--retries=1", "--url=#{test_server}", :out => write
      end
      start_time=Time.now
      loop do
        assert (Time.now - start_time <= timeout), "No server connect after timeout"
        break if read.gets.include? "\] \[#{test_server}\] DNS error: \"unknown node or service\""
      end
    ensure
      Process.kill("SIGINT", pid)
    end
  end
end
