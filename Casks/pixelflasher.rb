cask "pixelflasher" do
  version "6.8.0.4"
  sha256 "c1421ddad553c8b59247e3bbd9e13858e93cf1be4e360c5513bee280a2f9dba3"

  url "https://github.com/badabing2005/PixelFlasher/releases/download/v#{version}/PixelFlasher.dmg"
  name "PixelFlasher"
  desc "Pixel phone flashing GUI utility with features"
  homepage "https://github.com/badabing2005/PixelFlasher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :high_sierra"

  app "PixelFlasher.app"

  zap trash: [
    "~/Library/Application Support/PixelFlasher",
    "~/Library/Preferences/com.badabing.pixelflasher.plist",
    "~/Library/Saved Application State/com.badabing.pixelflasher.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
