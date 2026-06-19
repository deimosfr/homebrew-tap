cask "prusa-statusbar" do
  version "1.2.0"

  on_arm do
    sha256 "27ddfad99ef951b8c9d49149093ec8fd68f71825e2e9bf660a73a1ed983d9014"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.2.0/PrusaStatusBar-1.2.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "35e0f474ac3d71a1781ab5c201de741ec91a0bedc7f276dfcf418f9a892a2cd6"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.2.0/PrusaStatusBar-1.2.0-x86_64.dmg",
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
