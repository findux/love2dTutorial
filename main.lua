if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end 


local l3d = require "love3d" --NOT: Love3d kullanmak için love.exe nin yanına lua klasörü açıp cpml,iqm,love3d klasörlerini kopyalamız gerekiyor.

function love.update()
  love.graphics.print("dddd")
end
function love.load()
  whale = love.graphics.newImage("whale.png")
end
function love.draw()
  love.graphics.draw(whale, 300, 200)
end