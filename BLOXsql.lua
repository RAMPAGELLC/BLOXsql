--[[
Copyright 2020 RAMPAGE Interactive LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

This Software was developed by RAMPAGE Interactive Engineers:
vq9o - Programmer, Web Developer, Project Manager
12Gauge_Nick - Programmer, Web Developer
pasdalover - Programmer, Web Developer

sha1 Encryption Module was developed by 12Gauge_Nick. future usage of shal encryption is in-mind.
]]

local bloxsql = {}
local RAMPAGEPluginHook = require(script.Parent.Parent.Parent.RAMPAGEPluginHook)
local server = game:GetService("HttpService")
local settings
local host

local function print(message)
	RAMPAGEPluginHook.print("BLOXSQL", message)
end

local function error(message)
	RAMPAGEPluginHook.print("BLOXSQL", message)
end

local function warn(message)
	RAMPAGEPluginHook.print("BLOXSQL", message)
end

local function post(packet)
	local posted = server:PostAsync("https://public.api.rampagestudios.org/v1/bloxsql/", packet, Enum.HttpContentType.ApplicationJson, false)
	print(posted)
	local returnData = server:JSONDecode(posted)
	if returnData.code == "100" then
		if returnData.method == "SELECT" then
			return returnData.json
		elseif returnData.method == "ELSE" then
			return returnData.json
		end
	else
		return "Database Error: ".. returnData.reason
	end
end

function bloxsql:check(password)
	repeat wait() until (host ~= nil)
	wait(1)
	if password == settings.SQL.Password then
		return true
	else
		return false
	end
end

function bloxsql:execute(query, password)
	if host == "rampage" then
		RAMPAGEPluginHook.crashlog("BLOXSQL", "RAMPAGE Hosting is no-longer supported.")
	else
		if settings.SQL.Host ~= nil then
			if settings.SQL.Admin ~= nil then
				if settings.SQL.Password ~= nil then
					if password == settings.SQL.Password then
						local method = false
						if string.find(query, "SELECT") then
							method = "SELECT"
						else
							method = "QUERY"
						end
						repeat wait(.5) until (method ~= false)
						local data = {
							action = "execute",
							Host = host,
							Admin = settings.SQL.Admin,
							Password = settings.SQL.Password,
							Database = settings.SQL.Database,
							Query = query,
							SubAction = method
						}
						local returnData = post(server:JSONEncode(data))
						return returnData
					else
						return "Invalid SQL Password"
					end
				else
					return "Invalid SQL Password"
				end
			else
				return "Invalid SQL Admin"
			end
		else
			return "Invalid SQL Host"
		end
	end
end

function bloxsql:init(setting)
	settings = setting
	if settings.SQL.Host == "rampage" then
		RAMPAGEPluginHook.print("BLOXSQL", "Default Host: 'localhost', Only to be used by RAMPAGE Studios ONLY")
		host = "rampage"
	else
		RAMPAGEPluginHook.print("BLOXSQL", "Default Host: '".. settings.SQL.Host .."'")
		host = settings.SQL.Host
	end
end
return bloxsql
