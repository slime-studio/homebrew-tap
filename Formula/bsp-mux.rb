class BspMux < Formula
  desc "Build Server Protocol multiplexer that dedupes sourcekit-lsp's build backend"
  homepage "https://github.com/slime-studio/bsp-mux"
  url "https://github.com/slime-studio/bsp-mux/archive/refs/tags/0.1.0.tar.gz"
  sha256 "62f3d128a974714e6dea964d56230b10452d07ad2422675da042b44bc1490e0b"
  license "Apache-2.0"
  head "https://github.com/slime-studio/bsp-mux.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/bsp-mux"
  end

  test do
    output = shell_output("#{bin}/bsp-mux 2>&1", 64)
    assert_match "USAGE: bsp-mux <subcommand>", output
    assert_match "install", output
    assert_match "stop", output
  end
end
