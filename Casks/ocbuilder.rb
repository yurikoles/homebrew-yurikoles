cask "ocbuilder" do
  version "7.5.3"
  sha256 "804813bfaba06cc0175a137583d6e70dff97aa985608d598a1d711971ccbaf71"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
