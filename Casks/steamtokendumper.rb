cask "steamtokendumper" do
  arch arm: "arm64", intel: "x64"

  version "2025.12.17"
  sha256 arm:   "abf2710eb44feb750304dfc34d2b0684430a8c8dcc142d74da5eb04f3b645fd8",
         intel: "52f2bb346594bddaf68fec9a6beeb12527c8b219f114e214f68aca444d3de32c"

  url "https://github.com/SteamDatabase/SteamTokenDumper/releases/download/#{version}/SteamTokenDumper-osx-#{arch}.tar.gz",
      verified: "github.com/SteamDatabase/SteamTokenDumper/"
  name "steamtokendumper"
  desc "Submit users' PICS access tokens to SteamDB"
  homepage "https://steamdb.info/tokendumper/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :catalina

  binary "#{staged_path}/SteamTokenDumper"

  zap trash: ""
end
