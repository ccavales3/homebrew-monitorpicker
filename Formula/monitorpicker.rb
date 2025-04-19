class Monitorpicker < Formula
  desc "Lightweight monitor picker for macOS using Hammerspoon"
  homepage "https://github.com/ccavales3/homebrew-monitorpicker"
  url "https://github.com/ccavales3/homebrew-monitorpicker/raw/main/monitorpicker.zip"
  sha256 "19044ed0fce11b3c33f1820b3eb510766ae9274f83ac12c420c9c0584c853c2e"
  version "1.0.0"

  keg_only "this formula installs configuration files directly to ~/.hammerspoon"

  def install
    # Save the files inside the Homebrew prefix so they persist through install
    prefix.install "init.lua"
    prefix.install "monitor_picker.lua"
  end

  def post_install
    user_home = ENV["HOME"]
    hsp_dir = File.join(user_home, ".hammerspoon", "monitorpicker")
    mkdir_p hsp_dir

    cp prefix/"init.lua", "#{hsp_dir}/init.lua"
    cp prefix/"monitor_picker.lua", "#{hsp_dir}/monitor_picker.lua"

    ohai "✅ MonitorPicker installed to #{hsp_dir}"
    puts  "👉 Add this to your ~/.hammerspoon/init.lua if not already present:"
    puts  "   require(\"monitorpicker\")"
    puts  "Then reload Hammerspoon."
  end
end
