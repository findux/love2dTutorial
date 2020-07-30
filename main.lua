if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end 


local l3d = require "love3d" --NOT: Love3d kullanmak için love.exe nin yanına lua klasörü açıp cpml,iqm,love3d klasörlerini kopyalamız gerekiyor.

function love.load()
  sprites = {}
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')
  sprites.tank = love.graphics.newImage('sprites/tankYesil.png')
  sprites.background = love.graphics.newImage('sprites/background.png')

  player = {}
  player.x=200
  player.y=200
  player.v =1
end

function love.update(dt)
  if love.keyboard.isDown("s") then
    player.y = player.y +player.v
  end
  if love.keyboard.isDown("w") then
    player.y = player.y -player.v
  end
  if love.keyboard.isDown("d") then
    player.x = player.x +player.v
  end
  if love.keyboard.isDown("a") then
    player.x = player.x -player.v
  end
  if love.keyboard.isDown("p") then
    player.v = player.v +1
  end
  if love.keyboard.isDown("l") then
    player.v = player.v -1
  end

  if love.keyboard.isDown("x") then
    love.window.close()-- windows kapanıyor ama program çalışmaya devam ediyor.
  end
end

function love.draw()
  love.graphics.push()
  love.graphics.translate(0, love.graphics.getHeight())
  love.graphics.scale(1,-1)
  
  love.graphics.draw(sprites.background,0,0)
  love.graphics.draw(sprites.player,player.x,player.y,math.pi*0.25)

  love.graphics.push()
  love.graphics.scale(0.5,0.5)
  love.graphics.draw(sprites.tank,100,200)
  love.graphics.pop()

  love.graphics.pop()



  love.graphics.print(player.v)
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end