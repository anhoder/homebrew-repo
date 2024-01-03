class Neovim < Formula
  desc "This is a neovim repo"
  homepage "https://github.com/neovim/neovim"
  url "https://github.com/neovim/neovim/releases/latest/download/nvim-macos.tar.gz"
  version "latest"
  #sha256 :no_check

  def install
    lib.install Dir["lib/*"]
    share.install Dir["share/*"]
    bin.install "bin/nvim"
    bin.install_symlink "nvim" => "neovim"
  end
end
