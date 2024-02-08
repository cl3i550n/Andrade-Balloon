# Andrade-Balloon

This project adds a balloon vendor feature to your game server, allowing players to purchase balloons at specified locations. It's configurable, with options for language settings, key bindings, tax application, and balloon pricing.

## Installation

1. Clone this repository into your server's resources directory.
2. Add `ensure Andrade-Balloon` to your resources.cfg configuration file to ensure the resource starts with the server.

## Configuration

The `config.lua` file contains several configurable options:

- `Config.Lang`: Sets the default language for server messages.
- `Config.KeyToBuyBalloon`: The keyboard key (e.g., `[ SPACE ]`) that players must press to initiate a balloon purchase.
- `Config.EnableTax`: Toggle this to `true` to apply tax on balloon purchases or `false` to disable it.
- `Config.BallonPrice`: Set the base price for a balloon. Note: Tax is applied if `EnableTax` is set to `true`.
- `Config.BalloonLocations`: An array of locations where balloons can be purchased. Each location has `coords` (coordinates) and a `name`.

### Adding More Locations

To add more balloon purchase locations, append new entries to the `Config.BalloonLocations` array in the `config.lua` file, like so:

```lua
{
    coords = vector3(-YourXCoord, YourYCoord, YourZCoord),
    name = "Location Name"
}
```

## 🤝 Support and Contributions

Join our vibrant community! For support, questions, or to contribute to this project, connect with us:

🔗 [Join the Community](https://discord.gg/fBAQTBRvat)

---
