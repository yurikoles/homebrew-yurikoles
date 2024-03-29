cask "openzfs-dev" do
  on_arm do
    on_ventura :or_newer do
      arch arm: "Ventura-13-arm64"

      version "2.1.7rc3,469"
      sha256 "1293e9bb9fc5238f0d0f51cec454fb4faea18c6411e411ebe6fbc88cece52b97"
    end
  end
  on_intel do
    arch intel: "Catalina-10.15"

    version "2.1.7rc3,468"
    sha256 "9fd6e694f4da9e8732b14855549328f66bd6c6272026d8c1315629d669b99534"
  end

  url "https://openzfsonosx.org/forum/download/file.php?id=#{version.csv.second}"
  name "OpenZFS on OS X"
  desc "ZFS driver and utilities"
  homepage "https://openzfsonosx.org/"

  livecheck do
    url "https://openzfsonosx.org/forum/viewforum.php?f=20"
    regex(/viewtopic.*t=(\d+).*OpenZFSonOsX[._-]v?(\d+(?:(?:\.|(?:rc))\d+)+)[< "]/i)
    strategy :page_match do |page|
      match = page.scan(regex)
      next if match.blank?

      post_id, version = match.first

      post_url = "https://openzfsonosx.org/forum/viewtopic.php?f=20&t=#{post_id}"
      download_id_regex = /href=.*file.php\?id=(\d+).+OpenZFSonOsX[._-]v?#{version}-#{arch}/i

      download_id = Homebrew::Livecheck::Strategy::PageMatch
                    .find_versions(url: post_url, regex: download_id_regex)[:matches].values.first
      next if download_id.blank?

      "#{version},#{download_id}"
    end
  end

  conflicts_with cask: "openzfs"
  depends_on macos: ">= :catalina"

  pkg "OpenZFSonOsX-#{version.csv.first}-#{arch}.pkg"

  postflight do
    set_ownership "/usr/local/zfs"
  end

  uninstall_preflight do
    system "sudo", "/usr/local/zfs/bin/zpool", "export", "-af"
  end

  uninstall launchctl: [
              "org.openzfsonosx.InvariantDisks",
              "org.openzfsonosx.zconfigd",
              "org.openzfsonosx.zed",
              "org.openzfsonosx.zpool-import",
              "org.openzfsonosx.zpool-import-all",
            ],
            pkgutil:   "org.openzfsonosx.zfs"

  # No zap stanza required

  caveats do
    kext
  end
end
