cask "prusa-statusbar" do
  version "1.0.0"

  on_arm do
    sha256 "ff1141cf00b6a5e3a0a150bb645dd257067d2f1e25bd9e0a893c9daff059940d"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.0/PrusaStatusBar-1.0.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "853012e42674c9b4f3fbcf32d5cb302cd215e5d196ee1753c4e225695dd26ec7"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.0/PrusaStatusBar-1.0.0-x86_64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  name "Prusa StatusBar"
  desc "Menu bar app to monitor PrusaLink-equipped 3D printers"
  homepage "https://github.com/deimosfr/Prusa-StatusBar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "PrusaStatusBar.app"

  # Build is ad-hoc signed, not notarized. Strip the quarantine xattr so
  # Gatekeeper does not block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/PrusaStatusBar.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.deimosfr.prusastatusbar.plist",
    "~/Library/Application Support/PrusaStatusBar",
    "~/Library/Caches/com.deimosfr.prusastatusbar",
    "~/Library/Saved Application State/com.deimosfr.prusastatusbar.savedState",
  ]
end
