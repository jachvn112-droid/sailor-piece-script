local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Modules", 10)
if v1 then
	local v_u_2 = require(v1:WaitForChild("VFXPreloader", 5))
	if v_u_2 then
		task.spawn(function()
			-- upvalues: (copy) v_u_2
			v_u_2:PreloadAll()
			v_u_2:PreloadCommon()
		end)
	else
		warn("[VFXPreloaderClient] VFXPreloader module not found!")
	end
else
	warn("[VFXPreloaderClient] Modules folder not found!")
	return
end