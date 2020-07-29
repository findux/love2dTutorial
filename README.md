# love2dTutorial
love2d kurcalamalarım

love2d visual studio code da çalıştrımak için yaptıklarım şunlardır.

"love" komutunun konsolda çalışması için çevresel değişkenlere love'nin kurulu olduğu yeri Path'e ekledim. Tabikide öncesinde love2d yi kurdum.
------>
Tom Blind'in "Local Lua Debuuger" eklentisini VSCode'a kurdum. Bağlantısı şurda -> https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode

Sitesindede yazdığı gibi kök love2d dosyasının başına şunları eklemek gerek.

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end 
----->
diğer bir eklenti ise "Love2d Support".
----->
VSCode için launch.json şöyle;
{
    "version": "0.2.0",
    "configurations": [
      {
        "name": "Debug Love",
        "type": "lua-local",
        "request": "launch",
        "program": {
          "command": "love"
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
  ---->
  
  NOT: Love3d kullanmak için love.exe nin yanına lua klasörü açıp cpml,iqm,love3d klasörlerini kopyalamız gerekiyor.

  
