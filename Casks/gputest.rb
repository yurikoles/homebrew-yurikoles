cask "gputest" do
  version "0.7.0,391"
  sha256 "b02cd3c381c751bdc080e7bd004267d219d6112f5ecf9ab1db94196ccc85d7c0"

  url "https://www.geeks3d.com/dl/get/#{version.csv.second}"
  name "GpuTest"
  desc "Cross Platform OpenGL Benchmark"
  homepage "https://www.geeks3d.com/GpuTest/"

  livecheck do
    skip "No version information available"
  end

  depends_on :macos

  app "GpuTest.app"
  app "GpuTest_GUI.app"

  caveats do
    requires_rosetta
  end
end
