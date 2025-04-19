# 🖥️ MonitorPicker (Homebrew Tap)

MonitorPicker is a lightweight monitor-switching utility powered by [Hammerspoon](https://www.hammerspoon.org).  
Quickly move your cursor between monitors using a visual overlay or number key shortcuts.

---

## ✅ Features

- Jump to monitors via keyboard (`⌘ + ⌃ + Space`, then 1–9)
- Optional visual monitor picker
- Configurable colors, animations, and timeout
- Uses pure Hammerspoon + Lua — no binaries

---

## 🧰 Prerequisite: Install Hammerspoon

```bash
brew install --cask hammerspoon
```

Then launch the Hammerspoon app at least once to create the `~/.hammerspoon` config folder.

---

## 🍺 Installation via Homebrew

### 1. Tap & install

```bash
brew tap ccavales3/monitorpicker
brew install monitorpicker
```

This installs the config files into Homebrew’s internal `libexec` folder.

---

### 2. Run setup script to install into Hammerspoon

```bash
/bin/bash -c "$(brew --prefix)/opt/monitorpicker/setup.sh"
```

✅ This will:
- Copy MonitorPicker files into `~/.hammerspoon/monitorpicker/`
- Prompt you to add `require("monitorpicker")` to your `~/.hammerspoon/init.lua` if needed

---

## 🛠 Manual Setup (if preferred)

```bash
mkdir -p ~/.hammerspoon/monitorpicker
cp $(brew --prefix)/opt/monitorpicker/libexec/*.lua ~/.hammerspoon/monitorpicker/
```

Then in your `~/.hammerspoon/init.lua`:

```lua
require("monitorpicker")
```

---

## 🔁 How to Reload Hammerspoon

After installing or updating MonitorPicker:

1. Click the Hammerspoon icon in your macOS menu bar
2. Choose **"Reload Config"**

Or from the Hammerspoon Console, type:

```lua
hs.reload()
```

---

## 🎨 Customization

All configuration options are located in:

```bash
~/.hammerspoon/monitorpicker/init.lua
```

You can customize:
- Keyboard vs click selection mode
- Highlight color, opacity, and animation
- Timeout duration and cancellation key
- Whether to show the picker overlay UI

Just open the file in any text editor and adjust the Lua settings at the top.

---

## 🧾 License

MIT License — see [LICENSE.md](LICENSE.md)

---

Enjoy!
