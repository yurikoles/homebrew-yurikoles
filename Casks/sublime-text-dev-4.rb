cask "sublime-text-dev-4" do
  version "4.098"
  sha256 "fc669cbcc73eed541e283d55551a4598c3c00520c08424f6d52259f2ddb24d6d"

  url "https://download.sublimetext.com/sublime_text_build_#{version.no_dots}_mac.zip"
  appcast "https://www.sublimetext.com/updates/#{version.major}/dev_update_check",
          must_contain: version.no_dots
  name "Sublime Text"
  desc "Text editor for code, markup and prose"
  homepage "https://www.sublimetext.com/"

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
