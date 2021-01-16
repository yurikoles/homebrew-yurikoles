cask "ocbuilder" do
  version "7.5.6"
  sha256 "23959b1d26eb475f14f6e54a00067c578acd75ad0d2ee6015483b55d56491005"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  desc "Compile OpenCore, common drivers and kexts"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
