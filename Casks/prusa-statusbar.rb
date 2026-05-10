cask "prusa-statusbar" do
  version "1.0.0"

  on_arm do
    sha256 "f0862dc8770358181bf49b2a930bb8bf4a0799b0fcaa1b67d0f87e4641b2d5eb"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.0/PrusaStatusBar-1.0.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "160a2527c262402511f312ce5b27999cc69c26831fda9fbe8184c63cd966f82c"
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
