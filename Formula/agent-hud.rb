class AgentHud < Formula
  desc "Local dashboard for your coding agents' skills, instructions, and plugin state"
  homepage "https://github.com/ganggangstone/agent-hud"
  url "https://github.com/ganggangstone/agent-hud/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "53b364d1f9cc0529c7e4806cd9196cd896e3e12c84767acd359c7a763ccfc0f9"
  license "MIT"
  head "https://github.com/ganggangstone/agent-hud.git", branch: "main"

  depends_on "python@3.13"
  depends_on :macos # the service block below is launchd; Linux needs systemd instead

  def install
    libexec.install "server.py"

    # The dashboard keeps its data (projects, groups, port) next to the script by
    # default. Under Homebrew that directory is replaced on every upgrade, so point
    # it at the same place install.sh uses -- one location whichever way it was
    # installed, and upgrades leave your groups alone.
    (bin/"agent-hud").write <<~SH
      #!/bin/bash
      export AGENT_HUD_HOME="${AGENT_HUD_HOME:-$HOME/.claude/tools/agent-hud}"
      exec "#{Formula["python@3.13"].opt_bin}/python3.13" "#{libexec}/server.py" "$@"
    SH
  end

  service do
    run [opt_bin/"agent-hud"]
    keep_alive true
    log_path var/"log/agent-hud.log"
    error_log_path var/"log/agent-hud.err.log"
  end

  def caveats
    <<~EOS
      Start it in the background:
        brew services start agent-hud

      Then run `agent-hud open`, or open http://127.0.0.1:41717

      For an app icon in Launchpad as well:
        brew install --cask ganggangstone/tap/agent-hud-app

      To have projects appear in the dashboard as you work, add a SessionStart
      hook to ~/.claude/settings.json:

        "hooks": {
          "SessionStart": [
            { "hooks": [ { "type": "command",
              "command": "nohup agent-hud --register \\"$PWD\\" >/dev/null 2>&1 & disown" } ] }
          ]
        }

      If the service is running, the hook only tells it which folder you are in.
      If not, the hook starts a server and opens a browser tab. You can also add
      folders from the dashboard itself.

      From a terminal:
        agent-hud groups               list groups
        agent-hud apply <group>        apply one to the current folder

      Data (projects, groups) lives in ~/.claude/tools/agent-hud and survives
      upgrades. Set AGENT_HUD_HOME to move it.
    EOS
  end

  test do
    # Point the data directory and the port at the sandbox, so a dashboard already
    # running on this machine is left alone, and check that it answers.
    port = free_port
    ENV["AGENT_HUD_HOME"] = testpath/"data"
    ENV["AGENT_HUD_PORT"] = port.to_s
    pid = spawn bin/"agent-hud"
    begin
      sleep 3
      assert_match "Agent HUD", shell_output("curl -fsS http://127.0.0.1:#{port}/")
      assert_match "panels", shell_output("curl -fsS http://127.0.0.1:#{port}/api/state")
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end
