# Village Gatherer (Godot 4)

Portrait idle village game: workers gather wood / stone / food, you sell for coins, upgrade, and build.

## Requirements met

- **Engine:** Godot **4.4.1** stable
- **Orientation:** Portrait `720×1280`, stretch `canvas_items` + `keep`
- **Art:** Runtime 16-bit pixel sprites (nearest-neighbor), limited palette
- **Layout:** Square playfield (`AspectRatioContainer` + `SubViewport`) centered in the upper/middle area; **Sell / Upgrades / Build** control panel below; resource HUD above the square
- **Loop:** Auto-path gather → camp deposit → sell → coin upgrades → resource buildings
- **Save:** `ConfigFile` at `user://village_gatherer_save.cfg`

## Open in the editor

1. Install [Godot 4.4.x](https://godotengine.org/download) (Linux/Windows/macOS).
2. Project → Import → select `project.godot` in this folder.
3. Press **F5** (or Play). Window is portrait; on desktop it opens at 360×640 override.

Headless smoke check:

```bash
godot --headless --path /path/to/village-gatherer-godot --quit-after 2
```

## Android export (sideload)

Editor settings (already used on the build machine):

- Android SDK path
- Java SDK path (JDK 17+)
- Debug keystore
- Export templates for **4.4.1.stable**

Preset **Android**:

| Field | Value |
|-------|--------|
| Package | `com.vsarts.village_gatherer` |
| Name | Village Gatherer |
| Arch | **arm64-v8a** only |
| Orientation | Portrait (project `window/handheld/orientation`) |

CLI:

```bash
godot --headless --path . --export-debug "Android" ../village-gatherer-godot-phone.apk
```

Sideload:

```bash
adb install -r village-gatherer-godot-phone.apk
```

APK size is ~26 MB (mostly `libgodot_android.so`). Under 25 MB is not realistic for a stock Godot 4.4 arm64 template without a custom stripped engine build.

## Gameplay cheatsheet

| Action | Cost |
|--------|------|
| Sell wood/food | 1 coin each |
| Sell stone | 2 coins each |
| Gather speed / carry | Coins (scales with level + workshop tier) |
| Hire worker | Coins (needs free house slots) |
| House | Wood/Stone/Food → +2 max workers |
| Storehouse | Resources → +carry |
| Workshop | Resources → raise upgrade tier |

## Project layout

```
project.godot
scenes/main.tscn          # Portrait shell + square SubViewport + tabs
scripts/game_state.gd     # Economy + ConfigFile save (autoload)
scripts/pixel_art.gd      # Generated chunky sprites (autoload)
scripts/playfield.gd      # Square world: camp, nodes, workers, buildings
scripts/worker.gd
scripts/resource_node.gd
scripts/building.gd
scripts/main.gd           # HUD / Sell / Upgrades / Build panels
export_presets.cfg
```

## License

Game content: Venture Studio Arts. Engine: Godot (MIT).
