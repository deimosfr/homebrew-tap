cask "prusa-statusbar" do
  version "1.0.0"

  on_arm do
    sha256 "599603a4098051fcdf3812832086a2224ec82ecce15e37a12d3f89cb699c185e"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.0/PrusaStatusBar-1.0.0-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "8314352b47d2f37fd4c00014b88404baa53b20cd1ad3457e9efd0bec0328e0e3"
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
