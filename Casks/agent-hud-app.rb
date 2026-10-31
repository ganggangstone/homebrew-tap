cask "agent-hud-app" do
  version "0.6.4"
  sha256 "6d66e297310e46d9ec7cd1372b588040eae0fd4517107aefddd38834a6cc77f0"

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
