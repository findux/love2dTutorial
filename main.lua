if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end 


local l3d = require "love3d" --NOT: Love3d kullanmak için love.exe nin yanına lua klasörü açıp cpml,iqm,love3d klasörlerini kopyalamız gerekiyor.
local zoom = 1.5
local printx = 0
local printy = 0
local text = "text"
local movementActive = 0

local mgl = require("MGL")
mgl.gen_mat(2); mgl.gen_vec(2)
mgl.gen_mat(3); mgl.gen_vec(3)
mgl.gen_mat(4); mgl.gen_vec(4)
local panVector = mgl.vec2(0)



function love.load()
  
  local m = mgl.mat4(1)
  --m = m * mgl.translate(mgl.vec3(panVector))
  m = m * mgl.scale(mgl.vec3(zoom,zoom,zoom))
  print(m)

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

  effect = love.graphics.newShader [[
    extern number time;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
    {
        return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);
    }
]]
end

local t = 0
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
  if love.keyboard.isDown("r") then
    zoom = 1
  end

  if love.keyboard.isDown("x") then
    love.window.close()-- windows kapanıyor ama program çalışmaya devam ediyor.
  end

  t = t + dt
  effect:send("time", t)
end

function love.wheelmoved(x, y)
  if y > 0 then
      zoom = zoom +0.1
  elseif y < 0 then
    zoom = zoom -0.1
    if zoom <= 0 then
      zoom = 0.1
    end 
  end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
     printx = x
     printy = y
     movementActive = 1
  end
end

function love.mousereleased( x, y, button, istouch, presses )
  if button == 1 then
    movementActive = 0
  end
end

function love.mousemoved( x, y, dx, dy, istouch )
  text = string.format("x:%d y:%d dx:%d dy:%d",x,y,dx,dy)
  if movementActive == 1 then
    panVector.x = panVector.x + dx 
    panVector.y = panVector.y + dy
  end
end

function love.draw()
  love.graphics.push()
  love.graphics.translate(0 + panVector.x , love.graphics.getHeight() + panVector.y )
  love.graphics.scale(1*zoom,-1*zoom)
  
  love.graphics.draw(sprites.background,0,0)
  --[[
  love.graphics.draw(sprites.player,player.x,player.y,math.pi*0.25)

  love.graphics.push()
  love.graphics.scale(0.5,0.5)
  love.graphics.draw(sprites.tank,100,200)
  love.graphics.pop()
  --]]

  
  love.graphics.setLineStyle("smooth")
  love.graphics.setLineWidth(2)
  --love.graphics.line(15, 25, 69, 89)

  --love.graphics.setLineStyle("rough")
  --love.graphics.setLineWidth(2)
  love.graphics.line(0.000000,0.000000,0.000000,500.000000)
  love.graphics.line(0.000000,500.000000,500.000000,0.000000)
  love.graphics.line(500.000000,0.000000,500.000000,500.000000)
  love.graphics.line(500.000000,500.000000,0.000000,0.000000)
  love.graphics.setColor(1, 0, 0)
  love.graphics.line(228.786797,250.000000,15.000000,36.213203)
  love.graphics.line(15.000000,36.213203,15.000000,463.786797)
  love.graphics.line(15.000000,463.786797,228.786797,250.000000)
  love.graphics.setColor(0, 0, 1)
  love.graphics.line(271.213203,250.000000,485.000000,36.213203)
  love.graphics.line(485.000000,36.213203,485.000000,463.786797)
  love.graphics.line(485.000000,463.786797,271.213203,250.000000)

  --[[ --how to draw point
  love.graphics.setColor(1, 0, 0) -- işin sonunda coloru 1,1,1 yapmayı unutma
  love.graphics.setPointSize(10)
  love.graphics.points( 15, 25, 69, 89 )
  --]]

  --love.graphics.setColor(1, 0, 0)
  --love.graphics.circle("fill", 200, 200,3,36)
  --love.graphics.circle("fill", 100, 200,3,10)


  love.graphics.setColor(1, 1, 1)
  love.graphics.pop()


  local aaa = mgl.vec2(0) - panVector 
  love.graphics.print(mgl.length(aaa))
  love.graphics.print(text, printx, printy)
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end