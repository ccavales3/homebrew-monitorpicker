class Monitorpicker < Formula
  desc "Lightweight monitor picker for macOS using Hammerspoon"
  homepage "https://github.com/ccavales3/homebrew-monitorpicker"
  url "https://github.com/ccavales3/homebrew-monitorpicker/raw/main/monitorpicker.zip"
  sha256 "452c23858c707ffbc5c8ea1414ac40b3da84e898bf8e48b11ea30bcd7286c3a9"
  version "1.0.0"

  def install
    hsp_dir = File.expand_path("~/.hammerspoon")
    mkdir_p hsp_dir
    cp_r "monitorpicker", "#{hsp_dir}/monitorpicker"

    ohai "✅ MonitorPicker installed to ~/.hammerspoon/monitorpicker"
    puts  "👉 Add the following line to your ~/.hammerspoon/init.lua if you haven't already:"
    puts  "   require(\"monitorpicker\")"
    puts  "Then reload Hammerspoon."
  end
end
