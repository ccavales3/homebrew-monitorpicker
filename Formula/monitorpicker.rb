class Monitorpicker < Formula
  desc "Lightweight monitor picker for macOS using Hammerspoon"
  homepage "https://github.com/ccavales3/homebrew-monitorpicker"
  url "https://github.com/ccavales3/homebrew-monitorpicker/raw/main/monitorpicker.zip"
  sha256 "19044ed0fce11b3c33f1820b3eb510766ae9274f83ac12c420c9c0584c853c2e"
  version "1.0.0"
  keg_only "this formula installs configuration files directly to ~/.hammerspoon"

  def install
    puts "Current Dir: #{Dir.pwd}"
    puts "Dir contents:"
    puts Dir.entries(".").join("\n")

    # hsp_dir = File.expand_path("~/.hammerspoon")
    hsp_dir = File.expand_path("~/.hammerspoon/monitorpicker")
    mkdir_p hsp_dir
    # cp_r "monitorpicker", "#{hsp_dir}/monitorpicker"
    cp "init.lua", "#{hsp_dir}/init.lua"
    cp "monitor_picker.lua", "#{hsp_dir}/monitor_picker.lua"

    ohai "✅ MonitorPicker installed to ~/.hammerspoon/monitorpicker"
    puts  "👉 Add the following line to your ~/.hammerspoon/init.lua if you haven't already:"
    puts  "   require(\"monitorpicker\")"
    puts  "Then reload Hammerspoon."
  end
end
