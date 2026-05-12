cask "prusa-statusbar" do
  version "1.0.1"

  on_arm do
    sha256 "7944528e9fb7abc6d9115d8fd9d082b838e8afd59dbc73370531ac40507ac4a3"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.1/PrusaStatusBar-1.0.1-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "aba5478f6d15d783c7bb87fc35cde6538f63bd422e02c5c5e68ce697bd89931d"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.1/PrusaStatusBar-1.0.1-x86_64.dmg",
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
