cask "goneovim-nightly" do
  version "nightly"
  # sha256 ""
  name "Goneovim-nightly"
  desc "This is a nightly neovim repo"
  homepage "https://github.com/akiyosi/goneovim"

  if Hardware::CPU.arm?
    url "https://github.com/akiyosi/goneovim/releases/download/nightly/goneovim-macos-arm64.tar.bz2"
    app "goneovim-macos-arm64/goneovim.app"
  else
    url "https://github.com/akiyosi/goneovim/releases/download/nightly/goneovim-macos-x86_64.tar.bz2"
    app "goneovim-macos-x86_64/goneovim.app"
  end
  
  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/goneovim.wrapper.sh"
  binary shimscript, target: "goneovim"

  preflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      exec '#{appdir}/goneovim.app/Contents/MacOS/goneovim' "$@"
    EOS
  end

  zap trash: [
    "~/.goneovim",
    "~/Library/Saved Application State/com.ident.goneovim.savedState",
  ]
end
