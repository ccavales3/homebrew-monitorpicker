class Monitorpicker < Formula
  desc "Lightweight monitor picker for macOS using Hammerspoon"
  homepage "https://github.com/ccavales3/homebrew-monitorpicker"
  url "https://github.com/ccavales3/homebrew-monitorpicker/raw/main/monitorpicker.zip"
  sha256 "bfb74f840adf94b96c265dfaac89902afafdce06a8398b18c30f5376769a9696"
  version "1.0.0"

  def install
    hammerspoon_path = File.expand_path("~/.hammerspoon")
    mkdir_p hammerspoon_path
    cp_r "monitorpicker", "#{hammerspoon_path}/monitorpicker"
    ohai "MonitorPicker installed to ~/.hammerspoon/monitorpicker"
    puts "Add the following line to your ~/.hammerspoon/init.lua:"
    puts "require('monitorpicker')"
  end
end
