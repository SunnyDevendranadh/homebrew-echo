# typed: true
# frozen_string_literal: true

# Homebrew formula for Echo.
#
# Lives in the tap repo SunnyDevendranadh/homebrew-echo as Formula/echo.rb.
# Install with:
#   brew install sunnydevendranadh/echo/echo
#
# Binary-first for Apple Silicon: a prebuilt release asset, no toolchain
# required. Other platforms are pointed at a source build with a clear
# message. Replace 9df8790e5c6c8e17afd800b47584b424c09cd800932d39147386dde4d4a6a2f2 at release time with the real
# sha256 of the arm64 asset.
class Echo < Formula
  desc "Rust-native AI coding agent — BYOK, always-on kernel sandbox, one static binary"
  homepage "https://github.com/SunnyDevendranadh/Echo"
  url "https://github.com/SunnyDevendranadh/Echo/releases/download/v1.2.0/echo-v1.2.0-aarch64-apple-darwin"
  version "1.2.0"
  sha256 "9df8790e5c6c8e17afd800b47584b424c09cd800932d39147386dde4d4a6a2f2"
  license "MIT"

  def install
    if OS.linux? || Hardware::CPU.intel?
      odie <<~MSG
        No prebuilt Echo binary for this platform yet.
        Build from source instead:

          git clone https://github.com/SunnyDevendranadh/Echo
          cd Echo
          cargo build --release
          install -m 0755 target/release/echo "#{bin}/echo"
      MSG
    end

    bin.install "echo-v1.2.0-aarch64-apple-darwin" => "echo"
  end

  test do
    assert_match "echo", shell_output("#{bin}/echo --version")
  end
end
