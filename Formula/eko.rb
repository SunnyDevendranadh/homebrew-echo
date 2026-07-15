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
  url "https://github.com/SunnyDevendranadh/Echo/releases/download/v1.7.0/eko-v1.7.0-aarch64-apple-darwin"
  version "1.7.0"
  sha256 "dc0b0c90af0cbbd8639103236374687a19adc155afd9bfd450925de7eb193fb8"
  license "MIT"

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

    bin.install "eko-v1.7.0-aarch64-apple-darwin" => "eko"
  end

  test do
    assert_match "eko", shell_output("#{bin}/eko --version")
  end
end
