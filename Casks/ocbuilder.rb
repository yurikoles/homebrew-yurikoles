cask "ocbuilder" do
  version "7.4.3"
  sha256 "3fec2ae55e9545679689468ae950f00da66c4ab246fe4fab3450411c8988c7be"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
