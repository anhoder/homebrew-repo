class NeovimNightly < Formula
  desc "This is a nightly neovim repo"
  homepage "https://github.com/neovim/neovim"
  url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz"
  version "latest"
  sha256 :no_check

  def install
    lib.install Dir["lib/*"]
    share.install Dir["share/*"]
    bin.install "bin/nvim"
    bin.install_symlink "nvim" => "neovim"
  end
end
