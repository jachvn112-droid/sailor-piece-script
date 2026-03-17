local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local OldNameKick
OldNameKick = hookmetamethod(game,"__namecall",function(self, ...)
    local method = getnamecallmethod()
    local arg = {...}

    if (method == "Kick" or method == "kick") and (self == LocalPlayer or self == Players) then
        warn("Kick cái đb")
        print(arg[1])
        return nil
    end
    return OldNameKick(self, ...)
end)