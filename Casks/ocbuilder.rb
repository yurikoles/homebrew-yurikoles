cask "ocbuilder" do
  version "7.5.0"
  sha256 "ac1e6be728e5cb0cd00a7ea8a153f09d00406c1824c23de9d6e3e6eebedede3c"

  url "https://github.com/Pavo-IM/ocbuilder/releases/download/#{version}/OCBuilder.app.zip"
  appcast "https://github.com/Pavo-IM/ocbuilder/releases.atom"
  name "OCBuilder"
  homepage "https://github.com/Pavo-IM/ocbuilder"

  auto_updates true

  app "OCBuilder.app"
end
