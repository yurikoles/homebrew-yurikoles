cask "virtualbox-snapshot" do
  version :latest
  sha256 :no_check

  url do
    require "open-uri"
    downloads_url = "https://www.virtualbox.org/wiki/Testbuilds"
    version = URI(downloads_url.to_s)
              .open.read
              .scan(/href=".*(VirtualBox-\d+.\d+.+\d+-\d+-OSX.dmg)"/)
              .flatten.last
    "https://www.virtualbox.org/download/testcase/#{version}"
  end
  name "Oracle VirtualBox Development Snapshot"
  homepage "https://www.virtualbox.org/wiki/Testbuilds"

  conflicts_with cask: [
    "virtualbox",
    "virtualbox-beta",
  ]

  pkg "VirtualBox.pkg"

  uninstall script:  {
              executable: "VirtualBox_Uninstall.tool",
              args:       ["--unattended"],
              sudo:       true,
            },
            pkgutil: "org.virtualbox.pkg.*"

  zap trash: [
        "/Library/Application Support/VirtualBox",
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.virtualbox.app.virtualbox.sfl*",
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.virtualbox.app.virtualboxvm.sfl*",
        "~/Library/Preferences/org.virtualbox.app.VirtualBox.plist",
        "~/Library/Preferences/org.virtualbox.app.VirtualBoxVM.plist",
        "~/Library/Saved Application State/org.virtualbox.app.VirtualBox.savedState",
        "~/Library/Saved Application State/org.virtualbox.app.VirtualBoxVM.savedState",
        "~/Library/VirtualBox",
      ],
      rmdir: "~/VirtualBox VMs"

  caveats do
    kext
  end
end
