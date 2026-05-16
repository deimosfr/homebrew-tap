cask "prusa-statusbar" do
  version "1.1.1"

  on_arm do
    sha256 "48fee083eb860fd95415f1eed59c0b829435243a1fb635b13fc0d26184110c24"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.1.1/PrusaStatusBar-1.1.1-arm64.dmg",
        verified: "github.com/deimosfr/Prusa-StatusBar/"
  end

  on_intel do
    sha256 "1afa671db2437f414d1f51eb1b42494b6bd82feb158a3bc86bddc9944606ec86"
    url "https://github.com/deimosfr/Prusa-StatusBar/releases/download/v1.1.1/PrusaStatusBar-1.1.1-x86_64.dmg",
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
