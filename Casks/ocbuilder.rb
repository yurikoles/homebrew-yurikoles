cask "ocbuilder" do
  version "7.4.4"
  sha256 "fb8efed1ad44ec9c0e7020e4b4dc29725b5808baf3848f5eb78b683b36ab69bd"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
