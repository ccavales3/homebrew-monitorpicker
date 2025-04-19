class Monitorpicker < Formula
  desc "Lightweight monitor picker for macOS using Hammerspoon"
  homepage "https://github.com/ccavales3/homebrew-monitorpicker"
  url "https://github.com/ccavales3/homebrew-monitorpicker/raw/main/monitorpicker.zip"
  sha256 "5870af8dc927edb1a28f0c6315e11dd681b0134dee5e0529056461d2904bb744"
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
