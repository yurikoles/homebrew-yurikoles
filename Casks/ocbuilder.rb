cask "ocbuilder" do
  version "7.6.0"
  sha256 "16a97f1de02f830639847480145f5f838573a4d57c60ec728d3fe67932e0dde3"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  desc "Compile OpenCore, common drivers and kexts"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
