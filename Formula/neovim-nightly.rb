class NeovimNightly < Formula
  desc "Neovim Nightly"
  homepage "https://github.com/neovim/neovim"
  url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz"
  version "nightly"

  def install
    lib.install Dir["lib/*"]
    share.install Dir["share/*"]
    bin.install "bin/nvim"
    bin.install_symlink "nvim" => "neovim"
  end
end
