class SourcekitXcodeBsp < Formula
  desc "Build Server Protocol server for Xcode projects"
  homepage "https://github.com/slime-studio/sourcekit-xcode-bsp"
  url "https://github.com/slime-studio/sourcekit-xcode-bsp/archive/refs/tags/0.0.7.tar.gz"
  sha256 "1a3c6d9f0b481a3649b98baf87dec8786a08fc30526d56efa5d3cbb8ac4e9c00"
  license "Apache-2.0"
  head "https://github.com/slime-studio/sourcekit-xcode-bsp.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on macos: :sequoia

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    libexec.install ".build/release/sourcekit-xcode-bsp"
    libexec.install ".build/release/SWBBuildServiceBundle"
    %w[
      SwiftBuild_SWBAndroidPlatform
      SwiftBuild_SWBApplePlatform
      SwiftBuild_SWBCore
      SwiftBuild_SWBGenericUnixPlatform
      SwiftBuild_SWBQNXPlatform
      SwiftBuild_SWBUniversalPlatform
      SwiftBuild_SWBWebAssemblyPlatform
      SwiftBuild_SWBWindowsPlatform
    ].each { |b| cp_r ".build/release/#{b}.bundle", libexec }
    bin.write_exec_script libexec/"sourcekit-xcode-bsp"
  end

  test do
    assert_match "xcode-bsp", shell_output("#{bin}/sourcekit-xcode-bsp --help 2>&1")
  end
end
