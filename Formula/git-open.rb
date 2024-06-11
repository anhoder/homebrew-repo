class GitOpen < Formula
  desc "Type `git open` to open the GitHub page or website for a repository in your browser."
  homepage "https://github.com/paulirish/git-open"
  url "https://github.com/paulirish/git-open/archive/refs/heads/master.tar.gz"
  license "MIT"
  version "latest"

  def install
    bin.install "git-open"
  end
end
