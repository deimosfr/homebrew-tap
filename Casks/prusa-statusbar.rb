cask "prusa-statusbar" do
  version "1.3.0"

  on_arm do
    sha256 "7dfeb047283c769a9c237b524c4a7479c97a3320b71e70f3f03a390116bd8824"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.3.0/PrusaStatusBar-1.3.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "bf0d3aa4f6a4ec666e08c0d7a909866da921106bf5b6a6fbe13b89e3db15588a"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.3.0/PrusaStatusBar-1.3.0-x86_64.dmg",
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
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/PrusaStatusBar.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.deimosfr.prusastatusbar.plist",
    "~/Library/Application Support/PrusaStatusBar",
    "~/Library/Caches/com.deimosfr.prusastatusbar",
    "~/Library/Saved Application State/com.deimosfr.prusastatusbar.savedState",
  ]
end
