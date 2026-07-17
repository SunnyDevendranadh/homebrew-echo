# typed: true
# frozen_string_literal: true

# Homebrew formula for Echo.
#
# Lives in the tap repo SunnyDevendranadh/homebrew-echo as Formula/eko.rb.
# Install with:
#   brew install sunnydevendranadh/echo/eko
#
# Binary-first for Apple Silicon: a prebuilt release asset, no toolchain
# required. Other platforms are pointed at a source build with a clear
# message. Replace PLACEHOLDER_SHA256_ARM64 at release time with the real
# sha256 of the arm64 asset.
class Eko < Formula
  desc "Rust-native AI coding agent — BYOK, always-on kernel sandbox, one static binary"
  homepage "https://github.com/SunnyDevendranadh/Echo"
  url "https://github.com/SunnyDevendranadh/Echo/releases/download/v1.8.1/eko-v1.8.1-aarch64-apple-darwin"
  version "1.9.0"
  sha256 "cd79813ab85046cfac0e6bfb39d8822eb326ae8d503cf98fb44b8cb44ef17422"
  # The binary embeds Apache-2.0 grok-build adaptations (see THIRD-PARTY-NOTICES).
  license all_of: ["MIT", "Apache-2.0"]

  # Apache-2.0 §4(a)/(d): the license copy + attribution notices must travel
  # with every binary distribution. Both MUST be uploaded as release assets
  # starting with the FIRST release containing the M19 grok-port code
  # (packaging/README.md "Release-time steps"); replace the PLACEHOLDER shas
  # at release time alongside PLACEHOLDER_SHA256_ARM64. URLs track `version`
  # so the release bump can't strand them on an older tag.
  resource "license" do
    url "https://github.com/SunnyDevendranadh/Echo/releases/download/v#{version}/LICENSE"
    sha256 "031650d3b697669201a00b713ea9697ac39ffca0b69a8e8902ebce0a48c613ad"
  end

  resource "third-party-notices" do
    url "https://github.com/SunnyDevendranadh/Echo/releases/download/v#{version}/THIRD-PARTY-NOTICES"
    sha256 "e06f4a877108a593ed4e22c85e5f32724ddbb4bb2fe8ac01954c2c4ee7602b3a"
  end

  def install
    if OS.linux? || Hardware::CPU.intel?
      odie <<~MSG
        No prebuilt Echo binary for this platform yet.
        Build from source instead:

          git clone https://github.com/SunnyDevendranadh/Echo
          cd Echo
          cargo build --release
          install -m 0755 target/release/eko "#{bin}/eko"
      MSG
    end

    bin.install "eko-v1.8.1-aarch64-apple-darwin" => "eko"
    resource("license").stage { prefix.install "LICENSE" }
    resource("third-party-notices").stage { doc.install "THIRD-PARTY-NOTICES" }
  end

  test do
    assert_match "eko", shell_output("#{bin}/eko --version")
  end
end
