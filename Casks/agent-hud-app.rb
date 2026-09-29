cask "agent-hud-app" do
  version "0.3.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/ganggangstone/agent-hud/archive/refs/tags/v#{version}.tar.gz"
  name "Agent HUD"
  desc "App icon that opens the Agent HUD dashboard"
  homepage "https://ganggangstone.github.io/agent-hud/"

  depends_on macos: :big_sur
  depends_on formula: "ganggangstone/tap/agent-hud"

  app "agent-hud-#{version}/packaging/Agent HUD.app"

  # The app is not signed. Clear the download mark so macOS opens it without the
  # "cannot verify the developer" prompt.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Agent HUD.app"]
  end
end
