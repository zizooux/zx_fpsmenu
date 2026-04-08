# ZX_FPSMENU —  FPS Menu for FiveM

> A sleek, futuristic FPS control menu for FiveM servers — featuring a spinning radar ring, live FPS tracking, detailed graphic settings, and a full cyberpunk aesthetic built with `#967969` bronze tones.

---

## Preview

![Uploading Screenshot 2026-04-08 165133.png…]()


> **Replace the image above** with a screenshot of your menu in-game.

---

## Features

- **Live FPS counter** with spinning radar ring animation
- **Status indicator** — STABLE / WARNING / CRITICAL based on real-time FPS
- **4 Detailed Setting profiles** — FPS+, Advanced, Extra Light, Ultra Quality
- **Live stat bar** — Ping, Files, Net Load updated in real time
- **Cyberpunk aesthetic** — grid background, scan beam, flicker animation, corner brackets
- **ESC key** to close the menu
- **F6 key** or `/fpsmenu` chat command to open
- **Server-side logging** for preset changes and resets
- Fully customizable via `Config` block in `client.lua`

---

## File Structure

```
zx_fpsmenu/
├── fxmanifest.lua       — FiveM resource manifest
├── client.lua           — Client-side logic & NUI callbacks
├── server.lua           — Server-side event logging
└── html/
    ├── ui.html          — Menu UI markup
    ├── main.css         — All styles & animations
    └── js.js            — NUI message handling & button logic
```

---

## Installation

**1. Download** the latest release and extract the `zx_fpsmenu` folder.

**2. Place** the folder inside your server's `resources` directory:
```
your-server/
└── resources/
    └── zx_fpsmenu/
```

**3. Add** the following line to your `server.cfg`:
```
ensure zx_fpsmenu
```

**4. Restart** your server or use `refresh` + `start zx_fpsmenu` in the console.

---

## Configuration

Open `client.lua` and edit the `Config` block at the top:

```lua
local Config = {
    ServerName  = "YOUR SERVER",       -- Displayed in the top-left header
    SubName     = "FPS CONTROL UNIT",  -- Subtitle under server name
    Discord     = "discord.gg/zizooux",  -- Footer discord link
    Web         = "zizooux.shop",        -- Footer website link
    OpenKey     = 167,                 -- Key to open menu (167 = F6)
}
```

### Key Codes
| Key | Code |
|-----|------|
| F5  | 166  |
| F6  | 167  |
| F7  | 168  |
| F8  | 169  |
| F9  | 170  |
| F10 | 171  |

---

## Detailed Setting Presets

You can customize what each setting does inside `client.lua`:

```lua
local DetailPresets = {
    [1] = "FPS+ Graphics",
    [2] = "Advanced Graphics",
    [3] = "Extra Light",
    [4] = "Ultra Quality",
}
```

Add your own graphic logic inside `applyDetailPreset(id)`:

```lua
local function applyDetailPreset(id)
    if id == 1 then
        -- your FPS+ logic here
    elseif id == 2 then
        -- your Advanced logic here
    elseif id == 3 then
        -- your Extra Light logic here
    elseif id == 4 then
        -- your Ultra Quality logic here
    end
end
```

---

## Events

You can listen to these events from other resources:

```lua
-- Fires when a detail preset is applied
AddEventHandler("zx_fpsmenu:detailApplied", function(id, name)
    print("Preset applied: " .. name)
end)

-- Fires when settings are reset
AddEventHandler("zx_fpsmenu:reset", function()
    print("Settings reset")
end)
```

---

## Commands

| Command     | Description              |
|-------------|--------------------------|
| `/fpsmenu`  | Toggle the FPS menu open/close |

---

## Dependencies

- **FiveM** server running `cfx-server` (cerulean fx_version or higher)
- **jQuery 3.6** — loaded via CDN in the NUI
- **Font Awesome 6.3** — loaded via CDN for footer icons
- **Google Fonts** — Rajdhani + Share Tech Mono (loaded via CSS)

> No additional scripts or frameworks required.

---

## Compatibility

| Resource      | Compatible |
|---------------|------------|
| ESX           | ✅ Yes      |
| QBCore        | ✅ Yes      |
| Standalone    | ✅ Yes      |
| vRP           | ✅ Yes      |

---

## Support

- Discord: [discord.gg/zizooux](https://discord.gg/zizooux)
- Shop: [zizooux.shop](https://zizooux.shop)

---

## License

This resource is provided for personal and server use.
Reselling or redistributing as your own work is **not permitted**.

---

<div align="center">
  Made with ♥ by <strong>ZX | zizooux</strong>
</div>
