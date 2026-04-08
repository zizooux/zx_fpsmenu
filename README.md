![FiveM](https://img.shields.io/badge/FiveM-Resource-blue?style=flat-square)  
![Lua](https://img.shields.io/badge/Lua-5.4-purple?style=flat-square)  
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

# 🎮 ZX FPS Menu

A clean and optimized **FPS Menu UI** for FiveM servers (QBCore / standalone compatible) designed to help players boost performance, monitor FPS, and improve gameplay experience with a modern interface.

---

## ✨ Features

- 📊 **Live FPS Counter**
- 📡 **Real-time Ping Display**
- 📁 **Resource/File Counter**
- ⚡ **Optimized Performance Settings**
- 🎯 **Clean & Modern UI (NUI)**
- ⌨️ **Custom Command & Keybind**
- 🔄 **Real-time UI Updates**
- 🧠 **Low CPU Usage Optimized**

---

## 📂 Resource Structure

```
zx_fpsmenu/
│── client.lua
│── server.lua
│── config.lua
│── fxmanifest.lua
│── html/
│   ├── ui.html
│   ├── main.css
│   ├── js.js
│   └── img/
```

---

## ⚙️ Installation

1. Download or clone this repository  
2. Put the folder into your `resources` directory  
3. Add this line to your `server.cfg`:

```
ensure zx_fpsmenu
```

---

## 🔧 Configuration

Edit `config.lua`:

```lua
Config.Command = "fpsmenu"
Config.OpenKey = "F10"
Config.ServerName = "Your Server Name"
Config.SubName = "Your Subtitle"
Config.Discord = "your discord link"
Config.Web = "your website"
Config.Version = "1.0.0"
```

---

## 🎮 Usage

- Use command:
```
/fpsmenu
```

- Or press your configured key (default: **F10**)

---

## 🚀 Performance

This script is designed with optimization in mind:

- Uses cached FPS instead of constant calculation  
- Reduces unnecessary loops (`Wait` optimization)  
- Sends NUI updates only when needed  
- Lightweight UI rendering  

---

## 🔌 Compatibility

- ✅ QBCore  
- ✅ Standalone  
- ✅ ESX (basic compatibility)  

---

## 📸 Preview

```html
<img width="100%" src="YOUR_IMAGE_LINK_HERE" />
```

---

## 🛠️ Future Updates

- [ ] More advanced FPS presets  
- [ ] GPU/Graphics toggles  
- [ ] Save player settings  
- [ ] Better ping sync (match F8)  

---

## 🤝 Support

If you have issues or suggestions:

- Open an issue on GitHub  
- Contact via Discord  

---

## 📜 License

MIT License  

---

## ❤️ Credits

Developed by **ZX**

---

## ⭐ Show Support

If you like this script, don't forget to ⭐ the repo!
