cask "prusa-statusbar" do
  version "1.0.0"

  on_arm do
    sha256 "f83359223a3d9b7abe83196c08ac9029367b206d1ccc327eaf6fb3ee591b6195"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.0/PrusaStatusBar-1.0.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "6f849a9459971c30ff801aae7295cc1963b1193c56b410ff46a12f3277f870f1"
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
