class SourcekitXcodeBsp < Formula
  desc "Build Server Protocol server for Xcode projects"
  homepage "https://github.com/slime-studio/sourcekit-xcode-bsp"
  url "https://github.com/slime-studio/sourcekit-xcode-bsp/releases/download/0.1.0/sourcekit-xcode-bsp-0.1.0-macos.tar.gz"
  sha256 "7f8ef7a64ef1118ff55d8ca705a9cfc0cd945335a37cae3fb4c5dac28d42b7a0"
  license "Apache-2.0"

  depends_on macos: :sequoia

  head do
    url "https://github.com/slime-studio/sourcekit-xcode-bsp.git", branch: "main"
    depends_on xcode: ["26.0", :build]
  end

  def install
    if build.head?
      system "swift", "build", "--configuration", "release", "--disable-sandbox"
      libexec.install ".build/release/sourcekit-xcode-bsp"
      libexec.install ".build/release/SWBBuildServiceBundle"
      Dir.glob(".build/release/*.bundle").each { |b| cp_r b, libexec }
    else
      libexec.install Dir["*"]
    end
    bin.write_exec_script libexec/"sourcekit-xcode-bsp"
  end

  test do
    assert_match "xcode-bsp", shell_output("#{bin}/sourcekit-xcode-bsp --help 2>&1")
  end
end
