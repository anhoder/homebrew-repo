cask "cmux-nightly" do
  version :latest
  sha256 :no_check

  url "https://github.com/manaflow-ai/cmux/releases/download/nightly/cmux-nightly-macos.dmg"

  livecheck do
    url "https://github.com/manaflow-ai/cmux/releases/download/nightly/appcast.xml"
    strategy :sparkle
  end

  name "cmux-nightly"
  desc "Lightweight native macOS terminal with vertical tabs for AI coding agents"
  homepage "https://cmux.dev"

  depends_on macos: ">= :sonoma"

  app "cmux NIGHTLY.app"
  binary "#{appdir}/cmux NIGHTLY.app/Contents/Resources/bin/cmux"

  zap trash: [
    "~/Library/Application Support/cmux",
    "~/Library/Caches/cmux",
    "~/Library/Preferences/ai.manaflow.cmuxterm.plist",
  ]
end
