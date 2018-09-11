cask 'fluke' do
  version '0.2.5b'
  sha256 '3a68f42674aeb3a1089df5581bae5bbf8f28525d2d6588a03e257fc3b688f18a'

  # storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/flukeformac was verified as official when first introduced to the cask
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/flukeformac/Fluke_#{version}.zip"
  name 'Fluke'
  homepage 'https://code.google.com/p/flukeformac/'

  pkg 'Fluke_0.2.5.pkg'

  uninstall script:  { executable: 'Uninstall Fluke.tool' },
            pkgutil: 'com.kichenko.fluke.*'
end
