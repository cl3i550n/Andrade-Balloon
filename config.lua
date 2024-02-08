Config = {}

-- Language settings 🌍
Config.Lang = 'English'

-- Interaction key settings 🗝️
Config.KeyToBuyBalloon = 0xD9D0E1C0 -- [ SPACE ] Key to initiate balloon purchase

-- Pricing and tax settings 💰
Config.EnableTax = true  -- Toggle to enable/disable tax on purchases
Config.BallonPrice = 10.00 -- Base price for balloons (tax applied if EnableTax is true)

-- Balloon purchase locations 🎈
Config.BalloonLocations = {
  {
      coords = vector3(-396.19, 716.79, 115.88), -- Coordinates for the balloon vendor
      name = "Balloon Valentine" -- Name or description of the balloon vendor location
  },
  -- Add more locations here using the same format
}
