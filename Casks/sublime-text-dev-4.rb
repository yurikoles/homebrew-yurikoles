cask "sublime-text-dev-4" do
  version "4.079"
  sha256 "7c1ce3a8fced1a68d55c69291e3befa041a3e04f10e48d28d10f8cd06b999d80"

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
