class NeovimNightly < Formula
  desc "This is a nightly neovim repo"
  homepage "https://github.com/neovim/neovim"
  version "nightly"
  #sha256 :no_check

  livecheck do
    url "https://github.com/neovim/neovim/releases/tag/nightly"
    strategy :page_match
    regex(/NVIM\s+v\d+(?:\.\d+)+-dev-(\d+\+g[0-9a-f]+)/i)
  end

  if Hardware::CPU.arm?
    url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz"
  else
    url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz"
  end

  def install
    lib.install Dir["lib/*"]
    share.install Dir["share/*"]
    bin.install "bin/nvim"
    bin.install_symlink "nvim" => "neovim"
  end
end
