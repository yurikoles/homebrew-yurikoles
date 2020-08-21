cask "sublime-text-dev-4" do
  version "4.084"
  sha256 "bdebc9c4fbab475cb84260b605a7aca27666ca85b9b3fdaa5b6818bef0838053"

  url "https://download.sublimetext.com/sublime_text_build_#{version.no_dots}_mac.zip"
  appcast "https://www.sublimetext.com/updates/#{version.major}/dev_update_check",
          configuration: version.no_dots
  name "Sublime Text"
  homepage "https://www.sublimetext.com/dev"

  auto_updates true
  conflicts_with cask: [
    "sublime-text",
    "sublime-text-dev",
  ]

  app "Sublime Text.app"
  binary "#{appdir}/Sublime Text.app/Contents/SharedSupport/bin/subl"

  uninstall quit: "com.sublimetext.#{version.major}"

  zap trash: [
    "~/Library/Application Support/Sublime Text",
    "~/Library/Application Support/Sublime Text (Safe Mode)",
    "~/Library/Caches/com.sublimetext.#{version.major}",
    "~/Library/Preferences/com.sublimetext.#{version.major}.plist",
    "~/Library/Saved Application State/com.sublimetext.#{version.major}.savedState",
  ]
end
