cask "prusa-statusbar" do
  version "1.0.0"

  on_arm do
    sha256 "4ad00d41c4322d7eb28226cba1b71a0b87fa880415f9c312c467f4d2764b73d8"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.0/PrusaStatusBar-1.0.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "7136453782a7001f5317fc134b03823a34ce199033707e2b62113386fbc63ef2"
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
