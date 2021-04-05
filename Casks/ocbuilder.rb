cask "ocbuilder" do
  version "7.6.1"
  sha256 "866d416916d6eda6c129a80e3a5bcb9031cb6ad40b2f5ed682a8b773255de3e9"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  desc "Compile OpenCore, common drivers and kexts"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
