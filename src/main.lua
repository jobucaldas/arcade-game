--[[This file calls the main objects]]--
-- Creates objects --
local loader = {}
local input = {}
local audio = {}
local screen = {}

-- Main loader function --
function love.load()
  -- Main objects and initialization --
  screen = require("objects.screen")
  audio = require("objects.audio")
  input = require("objects.input")
  loader = require("objects.loader")
  screen.initialize(loader)
  audio.initialize(loader)
  input.initialize(loader)
  loader.initialize(screen, audio, input)
end

-- Main draw function --
function love.draw()
  screen.draw()
  loader.draw()
end

-- Main update function --
function love.update()
  screen.update()
  audio.update()
  input.update()
  loader.update()
end