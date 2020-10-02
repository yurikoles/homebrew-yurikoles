cask "deadbeef" do
  version :latest
  sha256 :no_check

  url "https://downloads.sourceforge.net/deadbeef/travis/osx/master/deadbeef-devel-osx-x86_64.zip"
  name "DeaDBeeF"
  desc "Modular audio player for UNIX-like systems"
  homepage "https://deadbeef.sourceforge.io/"

  app "deadbeef.app"
end
