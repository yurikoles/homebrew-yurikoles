cask "ocbuilder" do
  version "7.5.5"
  sha256 "53d17a929dd8239cd46e00fecadf18a6ec425f27912dccd29969acfd21357bd7"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
