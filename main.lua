if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end 


local l3d = require "love3d" 

function love.update()
  love.graphics.print("dddd")
end
function love.load()
  whale = love.graphics.newImage("whale.png")
end
function love.draw()
  love.graphics.draw(whale, 300, 200)
end