cask "steamtokendumper" do
  arch arm: "arm64", intel: "x64"

  version "2024.06.27"
  sha256 arm:   "166f2458b6b6ce22867d258deafe483f81f935de8b28978f8429f98df6f4c467",
         intel: "d5f8255f64d1db629681cd1d73690edd9dc08a4d5fdc9ddfeae3460bdaeee1d9"

  url "https://github.com/SteamDatabase/SteamTokenDumper/releases/download/#{version}/SteamTokenDumper-osx-#{arch}.tar.gz",
      verified: "github.com/SteamDatabase/SteamTokenDumper/"
  name "steamtokendumper"
  desc "Submit users' PICS access tokens to SteamDB"
  homepage "https://steamdb.info/tokendumper/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :catalina"

  binary "#{staged_path}/SteamTokenDumper"

  zap trash: ""
end
