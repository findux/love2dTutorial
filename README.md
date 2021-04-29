# love2dTutorial
love2d kurcalamalarım

love2d visual studio code da çalıştrımak için yaptıklarım şunlardır.
## Çevrsel araçları hazırlama

Love2d yi kurudum. Tom Blind' in "Local Lua Debuuger" eklentisini VSCode'a kurdum. Bağlantısı şurda  

(https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode)

Sitesindede yazdığı gibi kök love2d dosyasının başına şunları eklemek gerek.

```lua
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end 
```

diğer bir eklenti ise "Love2d Support".

diğer bir eklenti ise "vscode-lua" kaynak kodu formatlama için çok güzel bir araç.Ben bunun Eklenti ayarlarından line with değerinide artırıyorum ki uzun satırları kesip satır çoklaması yapmasın.

VSCode için launch.json şöyle;

```json
{
    "version": "0.2.0",
    "configurations": [
      {
        "name": "Debug Love",
        "type": "lua-local",
        "request": "launch",
        "program": {
          "command": "KURULUMYERİ\love"
        },
        "args": [
          "\"${workspaceFolder}/\""
        ],
        "scriptRoots": [
          "${workspaceFolder}"
        ]
      }
    ]
  }
 ```

  
  NOT: Love3d kullanmak için love.exe nin yanına lua klasörü açıp cpml,iqm,love3d klasörlerini kopyalamız gerekiyor.
  
  ## Örnek lua kodları
  
###  Lua da regular expression yerine match ve gmatch kullanılabilir. şöyle;
```lua
local line = "G1 X 64.000 Y 550.500 Z 4.000 F 1500"

local line2 = line:gsub(' ','') -- find replace
local line3 = line:gsub("00","11") -- find replace
print(line2)
print(line3) 

local patterns = line:gmatch"[A-Z][-]?[0-9.]+"
print(#line )
print(patterns )

for word in line2:gmatch"[A-Z][-]?[0-9.]+" do
    print(word)
end
```

### split fonsiyonu
```lua
function adeSplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

local linePieces = adeSplit(line, " ") 

for k,v in pairs(linePieces) do
  print(v)
end
```


G1X64.000Y550.500Z4.000F1500
G1 X 64.110 Y 550.511 Z 4.110 F 1511
36
function: 0x1ca0180
G1
X64.000
Y550.500
Z4.000
F1500
G1
X
64.000
Y
550.500
Z
4.000
F
1500
