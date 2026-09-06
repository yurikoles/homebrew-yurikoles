cask "steamtokendumper" do
  arch arm: "arm64", intel: "x64"

  version "2026.08.20"
  sha256 arm:   "08475f6b87b3013e33034c4551ca7c3096a73bcd61a39fc041d7c1d4c52efa34",
         intel: "ba15369f72f98e9828be28db9b179780f867425ecb8023582649136eeaddae01"

  url "https://github.com/SteamDatabase/SteamTokenDumper/releases/download/#{version}/SteamTokenDumper-osx-#{arch}.tar.gz"
  name "steamtokendumper"
  desc "Submit users' PICS access tokens to SteamDB"
  homepage "https://steamdb.info/tokendumper/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  binary "#{staged_path}/SteamTokenDumper"

  zap trash: ""
end
