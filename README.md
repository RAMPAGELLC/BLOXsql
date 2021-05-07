# BLOXsql
BLOXsql
Roblox Side of the code, unfortunatly we lost the files to the PHP side of things accessing your mySQL database. We plan to fix this in the future. Until then, enjoy the code!

LUA Example:
```
local RAMPAGEPluginHook = require(6401987963) 
local settings = {
	SQL = {
		-- Insert your real mySQL Administrator account details here or get your own from RAMPAGE Interactive for free at 
		-- https://bloxsql.rampagestudios.org/get-account/ (COMING-SOON)
		Admin = "rampage_admin",
		Password = "1234567890",
		Host = "localhost",
		Database = "rampage_main"
	},
}
RAMPAGEPluginHook:loadplugin("BLOXSQL", settings)

local BLOXsql = RAMPAGEPluginHook:getplugin("BLOXSQL", settings.SQL.Password)

BLOXsql:execute("INSERT INTO example (name) VALUES('Roblox')", settings.SQL.Password)
```

Requires: https://www.roblox.com/library/6401987963/ALPHA-RAMPAGEPluginHook
https://devforum.roblox.com/t/introducing-bloxsql-mysql-databases-to-your-roblox-game/1050829