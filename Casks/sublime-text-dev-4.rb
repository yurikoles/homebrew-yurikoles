cask "sublime-text-dev-4" do
  version "4.097"
  sha256 "83b19fec48ce6f51ffc6051adda8b82d2ebefdedda7eb8d87cbb66f1f2b3224d"

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
