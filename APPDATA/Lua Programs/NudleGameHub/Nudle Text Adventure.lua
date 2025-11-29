--Nudle Text Adventure 
--A text-based adventure game.

--Nudle Text Adventure by Nudle
--This is a simple text adventure game.

-- Define the player's starting location
local playerLocation = "start"

-- Define the locations in the game
local locations = {
  start = {
    description = "You are standing in a forest. There is a path to the north and a path to the east.",
    north = "forest",
    east = "river"
  },
  forest = {
    description = "You are in a dark forest. There are trees all around you.",
    south = "start"
  },
  river = {
    description = "You are standing next to a river. The water is cold and clear.",
    west = "start"
  }
}

-- Define the items in the game
local items = {
  sword = {
    description = "A rusty sword.",
    location = "forest"
  },
  key = {
    description = "A small key.",
    location = "river"
  }
}

-- Define the player's inventory
local playerInventory = {}

-- Function to get the description of the current location
local function getLocationDescription()
  return locations[playerLocation].description
end

-- Function to get the available directions from the current location
local function getAvailableDirections()
  local directions = {}
  for direction, location in pairs(locations[playerLocation]) do
    if direction ~= "description" then
      table.insert(directions, direction)
    end
  end
  return directions
end

-- Function to move the player to a new location
local function movePlayer(direction)
  if locations[playerLocation][direction] then
    playerLocation = locations[playerLocation][direction]
    print(getLocationDescription())
  else
    print("You can't go that way.")
  end
end

-- Function to get an item
local function getItem(itemName)
  if items[itemName] and items[itemName].location == playerLocation then
    table.insert(playerInventory, itemName)
    items[itemName].location = "inventory"
    print("You picked up the " .. itemName .. ".")
  else
    print("There is no " .. itemName .. " here.")
  end
end

-- Function to use an item
local function useItem(itemName)
  if table.indexOf(playerInventory, itemName) then
    print("You used the " .. itemName .. ".")
  else
    print("You don't have a " .. itemName .. ".")
  end
end

-- Function to display the player's inventory
local function displayInventory()
  if #playerInventory > 0 then
    print("You are carrying:")
    for i, itemName in ipairs(playerInventory) do
      print("- " .. itemName)
    end
  else
    print("You are not carrying anything.")
  end
end

-- Main game loop
print(getLocationDescription())
while true do
  -- Get the player's input
  local input = io.read()

  -- Process the player's input
  if input == "north" or input == "east" or input == "south" or input == "west" then
    movePlayer(input)
  elseif input == "get sword" or input == "get key" then
    getItem(string.sub(input, 5))
  elseif input == "use sword" or input == "use key" then
    useItem(string.sub(input, 5))
  elseif input == "inventory" then
    displayInventory()
  elseif input == "help" then
    print("Available commands:")
    print("- north, east, south, west")
    print("- get <item>")
    print("- use <item>")
    print("- inventory")
    print("- help")
    print("- quit")
  elseif input == "quit" then
    break
  else
    print("I don't understand.")
  end
end

print("Thanks for playing!")
