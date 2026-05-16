cask "prusa-statusbar" do
  version "1.1.0"

  on_arm do
    sha256 "838ca979a7c98a4279ef79b8e071a403d258c5d1d55d3fc54101d6b753f169dc"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.1.0/PrusaStatusBar-1.1.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "c2b12a0a7dfaa6880997ac68deed17a5d18929c485ef2c24b6b76ae543225776"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.1.0/PrusaStatusBar-1.1.0-x86_64.dmg",
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
