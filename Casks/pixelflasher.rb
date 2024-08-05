cask "pixelflasher" do
  version "7.3.1.1"
  sha256 "93cddfd9cd12005591c312768fdaea04b1e0a5244c855248b849c45eeb46ed67"

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
