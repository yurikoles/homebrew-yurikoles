cask "steamtokendumper" do
  arch arm: "arm64", intel: "x64"

  version "2025.04.28"
  sha256 arm:   "51d80c3afa49d87425ddac618335f69d430506f67e8fe2cb68c14c83fa2fb97a",
         intel: "3425c7a4c4be3b04746c5e859afaf48f45b2abb5bfddda1a305847f76b560fe6"

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
