cask "codepilot" do
  arch arm: "arm64", intel: "x64"
  version "0.38.4"
  sha256 :no_check

  url "https://github.com/op7418/CodePilot/releases/download/v#{version}/CodePilot-#{version}-#{arch}.dmg"

  name "CodePilot"
  desc "A desktop GUI for Claude Code — chat, code, and manage projects visually"
  homepage "https://www.codepilot.sh/"

  livecheck do
    url "https://github.com/op7418/CodePilot/releases/latest"
    strategy :page_match
    regex(/CodePilot[._-]v?(\d+(?:\.\d+)+)[._-]#{arch}\.dmg/i)
  end

  app "CodePilot.app"

  zap trash: [
    "~/Library/Application Support/codepilot",
    "~/Library/Saved Application State/sh.codepilot.CodePilot.savedState",
  ]
end
