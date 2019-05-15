--[[Main options from menu]]--
-- Makes itself an object --
local options = {}

-- Initializer function --
function options.initialize(loaderObj, screenObj)
  -- Makes an object of pointer --
  loader = loaderObj
  screen = screenObj

  -- Constants to know the current selection --
  press = 0
  pressed = 0

  -- Parser function --
  parser("start")
end

-- Fullscreen toggle --
function toggleFullscreen()
  screen.toggleFullscreen()
end

-- Parser called via loadstring --
function parser(option)
  options.parser(option)
end

-- Parser --
function options.parser(option)
  -- Reads options and inserts into table --
  options.optTable = {}
  for line in love.filesystem.lines("game/menu/" .. option .. ".txt") do
    table.insert(options.optTable, line)
  end

  -- Parses file --
  options.optNames = {}
  options.optActions = {}
  for i=1, #options.optTable do
    pos = string.find(options.optTable[i], ":", 1, true)
    table.insert(options.optNames, string.sub(options.optTable[i], 1, pos-1) )
    table.insert(options.optActions, string.sub(options.optTable[i], pos+1) )
  end

  -- Resets size --
  options.selected = 1
  options.min = 1
  options.max = #options.optTable
end

-- options draw function --
function options.draw()
  -- Prints current option --
  love.graphics.print(options.optNames[options.selected], 800/2-string.len(options.optNames[options.selected])*7, 600/2/2*3-50, 0, 2)
end

-- options update function --
function options.update()
  -- Loads action --
  currentAction = loadstring(options.optActions[options.selected])

  if love.timer.getTime() >= press+0.3 and pressed == 1 then
    pressed = 0;
  end

  -- Does action on button --
  if love.keyboard.isDown("return") and pressed == 0 then
    currentAction()
    pressed=1
    press = love.timer.getTime()
  end

  -- Move menu left --
  if love.keyboard.isDown("left") and pressed == 0  then
    if options.selected == options.min then
      options.selected = options.max
    else
      options.selected = options.selected-1
    end

    pressed=1
    press = love.timer.getTime()
  end

  -- Move menu right --
  if love.keyboard.isDown("right") and pressed == 0 then
    if options.selected == options.max then
      options.selected = options.min
    else
      options.selected = options.selected+1
    end

    pressed=1
    press = love.timer.getTime()
  end
end

-- Returns itself
return options