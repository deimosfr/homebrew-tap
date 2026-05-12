cask "prusa-statusbar" do
  version "1.0.2"

  on_arm do
    sha256 "cd880b0ac1916667b17bec2d9ddba3643970733e6b1fd7cc4e2e852aa095d281"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.2/PrusaStatusBar-1.0.2-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "a367e380d7f8b4afba32fa1343861dd0022074ca890e7afb43ddc0823cd44c4d"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.0.2/PrusaStatusBar-1.0.2-x86_64.dmg",
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
