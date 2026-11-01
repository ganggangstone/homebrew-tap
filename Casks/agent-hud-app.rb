cask "agent-hud-app" do
  version "0.6.7"
  sha256 "6aa3b8daa3697417cab5117373aa63cdd02caf247eb63a4a060fe0b3aeb241a9"

  url "https://github.com/ganggangstone/agent-hud/archive/refs/tags/v#{version}.tar.gz"
  name "Agent HUD"
  desc "App icon that opens the Agent HUD dashboard"
  homepage "https://ganggangstone.github.io/agent-hud/"

  depends_on macos: :big_sur
  depends_on formula: "ganggangstone/tap/agent-hud"

  app "agent-hud-#{version}/packaging/Agent HUD.app"

  # The app is not signed. Clear the download mark so macOS opens it without the
  # "cannot verify the developer" prompt.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Agent HUD.app"]
  end
end
