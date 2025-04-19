class Monitorpicker < Formula
  desc "Lightweight monitor picker for macOS using Hammerspoon"
  homepage "https://github.com/ccavales3/homebrew-monitorpicker"
  url "https://github.com/ccavales3/homebrew-monitorpicker/raw/main/monitorpicker.zip"
  sha256 "0ca019e15e3e78974a82db2fb6442115c835f07a36f7a0702fde8d77764cfd7f"
  version "1.0.0"

  keg_only "this formula installs configuration files directly to ~/.hammerspoon"

  def install
    libexec.install "init.lua"
    libexec.install "monitor_picker.lua"
    libexec.install "setup.sh"
  end

  def caveats
    <<~EOS
      📦 MonitorPicker config files were installed to:

          #{libexec}

      ✅ To finish setup, run this command:

          /bin/bash -c "$(brew --prefix)/opt/monitorpicker/setup.sh"

      📌 This will copy files to ~/.hammerspoon/monitorpicker and prompt you to update ~/.hammerspoon/init.lua

      Or you can do it manually:

          mkdir -p ~/.hammerspoon/monitorpicker
          cp #{libexec}/init.lua ~/.hammerspoon/monitorpicker/
          cp #{libexec}/monitor_picker.lua ~/.hammerspoon/monitorpicker/

      Then add this to your ~/.hammerspoon/init.lua if not already present:

          require("monitorpicker")

      🚀 Reload Hammerspoon and enjoy!
    EOS
  end
end
