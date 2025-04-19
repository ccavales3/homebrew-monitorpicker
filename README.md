# MonitorPicker for macOS

**MonitorPicker** is a lightweight monitor selector powered by [Hammerspoon](https://www.hammerspoon.org).  
Quickly move your mouse between displays using a visual picker or keyboard shortcuts.

---

## 🛠 Installation

1. **Install Hammerspoon**  
   Download from [https://www.hammerspoon.org](https://www.hammerspoon.org) and run it once.

2. **Copy files into your Hammerspoon config**  
   Extract this `.zip`, then move the `monitorpicker/` folder into your Hammerspoon config:

   ```bash
   cp -R monitorpicker ~/.hammerspoon/
   ```

3. **Modify (or create) your ~/.hammerspoon/init.lua**  
   Add this line at the bottom of the file:

   ```lua
   require("monitorpicker.init")
   ```

   If you don’t have an init.lua, you can create a new one with just that line.

4. **Reload Hammerspoon**  
   Click the Hammerspoon menubar icon → choose Reload Config
   Or run this in the Hammerspoon console:

   ```lua
   hs.reload()
   ```
---

## 🚀 Usage

- Press `⌘ + ⌃ + Space` to activate the monitor picker
- Either:
  - **Click** on a monitor box  
  - Or press the corresponding **number key** (1, 2, etc.)
- Cursor will move to the center of the selected display

---

## ⚙️  Customization

You can edit monitorpicker/init.lua or monitor_picker.lua to change:

- Hotkey (e.g., cmd + ctrl + space)
- Picker mode: "keyboard", "click", or "both"
- Highlighting: toggle, color, animation, etc.

---

## 🧾 License

This project is licensed under the [MIT License](./LICENSE.md).

---

Enjoy!
