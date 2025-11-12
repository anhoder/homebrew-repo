cask "neovide-app-nightly" do
  arch arm: "aarch64", intel: "x86_64"

  url "https://github.com/neovide/neovide/releases/download/nightly/Neovide-#{arch}-apple-darwin.dmg"
  name "Neovide"
  desc "Neovim Client"
  homepage "https://github.com/neovide/neovide"

  app "Neovide.app"
  binary "#{appdir}/Neovide.app/Contents/MacOS/neovide"

  zap trash: [
    "~/Library/Application Support/neovide",
    "~/Library/Saved Application State/com.neovide.neovide.savedState",
  ]
end
