--[[Player inside game]]--
-- Makes itself an object --
local player = {}

-- Initializer --
function player.initialize(screenObj, inputObj, barObj, ballObj)
  screen = screenObj
  input = inputObj
  bar = barObj
  ball = ballObj

  -- Score vars --
  player.score1 = 0
  player.score2 = 0
  player.deltat = nil

  -- Player pos --
  player.pos1 = 320
  player.pos2 = 320
  player.direction1=0
  player.direction2=0
  player.delay=0

  floor=160

  changed = true
  changed2 = true
  place = 160
  floorImg = love.graphics.newImage("game/sprites/floor.png")
end

-- Function to draw score --
function player.draw()
  
  love.graphics.setColor( 0,255,0,255)
  love.graphics.rectangle( "fill", (800/2)/2-10-30-90, 30, 20*(5-player.score2), 20 )
  love.graphics.rectangle( "fill", (800/2)+((800/2)/2)+50+100-20*(5-player.score1), 30, 20*(5-player.score1), 20 )
  love.graphics.setColor( 255,0,0,255)
  love.graphics.rectangle( "fill", (800/2)+((800/2)/2)+50, 30, 100-20*(5-player.score1), 20 )
  love.graphics.setColor( 255,255,255,255)

  for i=0, 6 do
    love.graphics.draw(floorImg, place*i, 600-floor, 0, 0.38)
  end
end

function player.update(dt)
  
    ---delay
    player.delay=player.delay+dt

    if player.delay>dt*10 then
      player.delay=0
    end
    if ((ball.velx*dt*75*(math.cos(ball.ang)))) ~=0 then
      player.deltat=math.floor(( (bar.pos2-ball.posx)/(ball.velx*dt*75*(math.cos(ball.ang)))))
    end
    --print(ball.posy+math.sin(ball.ang)*ball.vely*dt*75*player.deltat<=player.pos2+bar.height/2-10*75*dt,player.pos2-10*dt*75 >= 0,player.direction2, player.deltat<0)
   -- print(ball.posx>300 and player.delay==1)
    --[[Player movement]]--

    -- w to go up as player 1 --

      -- This condition makes the bar not pass the border limits --
      
      if (input.isDown("w") or input.isGamepadDown("a")) and player.pos1>=600-bar.height-floor then
          player.direction1=1
      elseif ((player.deltat>0 and (ball.posx<=ball.size/2+bar.pos1+bar.width+5)) or player.pos1 <= ball.size/2 )or(not input.isDown("w") and not input.isGamepadDown("a"))then
          player.direction1=0
          
      end

      if player.pos1==320 then
        if changed then
          changed = false
          screen.parseAnimation("game/pong/sprites/charbar.png", 46, 128, 1)
        end
      else
        if not changed then
          changed = true
          screen.parseAnimation("game/pong/sprites/charjump.png", 46, 128, 1)
        end
      end
      if player.pos2==320 then
        if changed2 then
          changed2 = false
          screen.parseAnimation("game/pong/sprites/gansostop.png", 46, 128, 3)
        end
      else
        if not changed2 then
          changed2 = true
          screen.parseAnimation("game/pong/sprites/gansojump.png", 46, 128, 3)
        end
      end

      -- Player 2 "A.I." --
      if player.direction2==1 then
        -- This condition makes the bar not pass the border limits --
        if player.pos2-10*dt*75 >= 0 then
          player.pos2 = player.pos2 - 10*dt*75
        end

      -- l to go down as player 2 --
      else 
        -- This condition makes the bar not pass the border limits --
        if player.pos2<= 320 then
          player.pos2 = player.pos2 + 10*dt*75
          if player.pos2>320 then
            player.pos2=320
          end
        end
    end

    if player.direction1==1 then
      -- This condition makes the bar not pass the border limits --
      if player.pos1-10*dt*75 >= 0 then
        player.pos1 = player.pos1 - 10*dt*75
      end

    -- l to go down as player 2 --
    else --player.direction2==0  then
      -- This condition makes the bar not pass the border limits --
      if player.pos1 <= 320 then
        player.pos1 = player.pos1 + 10*dt*75
        if player.pos1>320 then
          player.pos1=320
        end
      end
    end

    if ball.posx>400 and player.delay==0  then
      if player.deltat<0 then
        player.direction2=0
      elseif player.pos2>=320 and ((player.deltat*75*dt*ball.vely*math.sin(ball.ang)+ball.posy<=player.pos2+bar.height/2-player.deltat*10*80*dt and player.deltat*75*dt*ball.vely*math.sin(ball.ang)+ball.posy>50)or (player.deltat*75*dt*ball.vely*math.sin(ball.ang)+ball.posy<=player.pos2-(player.deltat+5)*10*80*dt and player.deltat*75*dt*ball.vely*math.sin(ball.ang)+ball.posy<50 ))then
        player.direction2=1
      elseif player.pos2<ball.size/2  then-- ball.posy-math.abs(ball.vely)>player.pos2+bar.height*0.6 then
        player.direction2=0
      end
    end
    if input.isDown("r")then
      -- This condition makes the bar not pass the border limits --
      player.score1=0
      player.score2=0
    end
end


return player
