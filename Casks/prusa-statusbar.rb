cask "prusa-statusbar" do
  version "1.1.2"

  on_arm do
    sha256 "9819b7376ab459aa02811a999e4218a2266a63f7839a14e3ccc40d0e1859857e"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.1.2/PrusaStatusBar-1.1.2-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "583afe2df1c18dcddd6cca1f800af93dbcfa2c6171faddb44e4fe6a6c1a1cea3"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.1.2/PrusaStatusBar-1.1.2-x86_64.dmg",
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
