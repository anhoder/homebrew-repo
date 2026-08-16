cask "display-steward" do
  version "1.1.1"
  sha256 "8d77acb7f07103e686ac100adb03fafc599a642eb9f3aff01014680234d05d5e"

  url "https://github.com/anhoder/display-steward/releases/download/v#{version}/Display-Steward-#{version}.dmg"
  name "Display Steward"
  desc "Menu bar app for rule-driven display management"
  homepage "https://github.com/anhoder/display-steward"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Display Steward.app"

  # Mirror the project's install.sh: register the LaunchAgent so the app
  # starts at login and stays alive, with logs under ~/Library/Logs.
  postflight do
    label = "com.anhoder.display-steward"
    home = Dir.home
    agent_path = "#{home}/Library/LaunchAgents/#{label}.plist"
    app_path = "#{appdir}/Display Steward.app/Contents/MacOS/DisplaySteward"
    log_dir = "#{home}/Library/Logs"

    FileUtils.mkdir_p "#{home}/Library/LaunchAgents"
    FileUtils.mkdir_p log_dir
    # Homebrew applies the quarantine attribute to every cask download (no DSL
    # opt-out in this version), which would make Gatekeeper block manual
    # launches of the ad-hoc-signed app. Strip it so Finder launches work.
    system "xattr", "-dr", "com.apple.quarantine", "#{appdir}/Display Steward.app"
    # v1.1.1 release artifacts lost the executable bit in the GitHub Actions
    # artifact round-trip (actions/upload-artifact does not preserve Unix
    # modes); the CI fix lands in the next release. Restore it so the
    # LaunchAgent can exec the app. No-op once the artifact is fixed.
    FileUtils.chmod 0755, app_path
    File.write agent_path, <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Label</key>
          <string>#{label}</string>
          <key>ProgramArguments</key>
          <array>
              <string>#{app_path}</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <dict>
              <key>SuccessfulExit</key>
              <false/>
          </dict>
          <key>LimitLoadToSessionType</key>
          <string>Aqua</string>
          <key>ProcessType</key>
          <string>Interactive</string>
          <key>StandardOutPath</key>
          <string>#{log_dir}/#{label}.log</string>
          <key>StandardErrorPath</key>
          <string>#{log_dir}/#{label}.error.log</string>
      </dict>
      </plist>
    PLIST

    system "launchctl", "bootout", "gui/#{Process.uid}/#{label}"
    system "launchctl", "bootstrap", "gui/#{Process.uid}", agent_path
  end

  uninstall launchctl: "com.anhoder.display-steward",
            signal:    ["TERM", "DisplaySteward"]

  zap trash: [
    "~/.config/display-steward",
    "~/Library/Application Support/Display Steward",
    "~/Library/LaunchAgents/com.anhoder.display-steward.plist",
    "~/Library/Logs/com.anhoder.display-steward.error.log",
    "~/Library/Logs/com.anhoder.display-steward.log",
    "~/Library/Preferences/com.anhoder.display-steward.plist",
    "~/Library/Saved Application State/com.anhoder.display-steward.savedState",
  ]

  caveats <<~EOS
    Display Steward is ad-hoc signed and not notarized. The cask removes the
    quarantine attribute on install, so the app launches without a Gatekeeper
    prompt; System Settings may still list it under "unidentified developer".
  EOS
end
