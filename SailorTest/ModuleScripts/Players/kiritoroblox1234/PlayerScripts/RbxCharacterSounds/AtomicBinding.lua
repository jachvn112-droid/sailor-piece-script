local function v_u_4(p1)
	local v2 = string.split(p1, "/")
	for v3 = #v2, 1, -1 do
		if v2[v3] == "" then
			table.remove(v2, v3)
		end
	end
	return v2
end
local function v_u_11(p5, p6)
	-- upvalues: (copy) v_u_11
	if p5.instance ~= nil then
		p5.instance = nil
		local v7 = p5.connections
		if v7 then
			for _, v8 in ipairs(v7) do
				v8:Disconnect()
			end
			table.clear(v7)
		end
		if p6 and p5.alias then
			p6[p5.alias] = nil
		end
		local v9 = p5.children
		if v9 then
			for _, v10 in pairs(v9) do
				v_u_11(v10, p6)
			end
		end
	end
end
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12.new(p13, p14)
	-- upvalues: (copy) v_u_4, (copy) v_u_12
	local v15 = {}
	local v16 = 1
	local v17 = {}
	local v18 = {}
	local v19 = {}
	local v20 = {}
	for v21, v22 in pairs(p13) do
		v15[v21] = v_u_4(v22)
		v16 = v16 + 1
	end
	local v23 = v_u_12
	return setmetatable({
		["_boundFn"] = p14,
		["_parsedManifest"] = v15,
		["_manifestSizeTarget"] = v16,
		["_dtorMap"] = v17,
		["_connections"] = v18,
		["_rootInstToRootNode"] = v19,
		["_rootInstToManifest"] = v20
	}, v23)
end
function v_u_12._startBoundFn(p24, p25, p26)
	local v27 = p24._boundFn
	local v28 = p24._dtorMap
	local v29 = v28[p25]
	if v29 then
		v29()
		v28[p25] = nil
	end
	local v30 = v27(p26)
	if v30 then
		v28[p25] = v30
	end
end
function v_u_12._stopBoundFn(p31, p32)
	local v33 = p31._dtorMap
	local v34 = v33[p32]
	if v34 then
		v34()
		v33[p32] = nil
	end
end
function v_u_12.bindRoot(p_u_35, p_u_36)
	-- upvalues: (copy) v_u_11
	debug.profilebegin("AtomicBinding:BindRoot")
	local v37 = p_u_35._parsedManifest
	local v38 = p_u_35._rootInstToRootNode
	local v39 = p_u_35._rootInstToManifest
	local v_u_40 = p_u_35._manifestSizeTarget
	local v41 = v39[p_u_36] == nil
	assert(v41)
	local v_u_42 = {}
	v39[p_u_36] = v_u_42
	debug.profilebegin("BuildTree")
	local v43 = {
		["alias"] = "root",
		["instance"] = p_u_36
	}
	if next(v37) then
		v43.children = {}
		v43.connections = {}
	end
	v38[p_u_36] = v43
	for v44, v45 in pairs(v37) do
		local v46 = v43
		for v47, v48 in ipairs(v45) do
			local v49 = v47 == #v45
			local v50 = v43.children[v48] or {}
			if v49 then
				if v50.alias ~= nil then
					error("Multiple aliases assigned to one instance")
				end
				v50.alias = v44
			else
				v50.children = v50.children or {}
				v50.connections = v50.connections or {}
			end
			v43.children[v48] = v50
			v43 = v50
		end
		v43 = v46
	end
	debug.profileend()
	local function v_u_77(p51)
		-- upvalues: (copy) v_u_42, (copy) v_u_77, (copy) p_u_35, (copy) p_u_36, (ref) v_u_11, (copy) v_u_40
		local v52 = p51.instance
		local v_u_53 = assert(v52)
		local v_u_54 = p51.children
		local v55 = p51.alias
		local v56 = not v_u_54
		if v55 then
			v_u_42[v55] = v_u_53
		end
		if not v56 then
			local function v59(p57)
				-- upvalues: (copy) v_u_54, (ref) v_u_77
				local v58 = v_u_54[p57.Name]
				if v58 and v58.instance == nil then
					v58.instance = p57
					v_u_77(v58)
				end
			end
			local function v66(p60)
				-- upvalues: (copy) v_u_54, (ref) p_u_35, (ref) p_u_36, (ref) v_u_11, (ref) v_u_42, (copy) v_u_53, (ref) v_u_77
				local v61 = p60.Name
				local v62 = v_u_54[v61]
				if v62 then
					if v62.instance == p60 then
						p_u_35:_stopBoundFn(p_u_36)
						v_u_11(v62, v_u_42)
						local v63 = v62.instance == nil
						assert(v63)
						local v64 = v_u_53:FindFirstChild(v61)
						local v65 = v64 and v_u_54[v64.Name]
						if v65 then
							if v65.instance ~= nil then
								return
							end
							v65.instance = v64
							v_u_77(v65)
						end
					end
				else
					return
				end
			end
			for _, v67 in ipairs(v_u_53:GetChildren()) do
				local v68 = v_u_54[v67.Name]
				if v68 then
					if v68.instance == nil then
						v68.instance = v67
						v_u_77(v68)
					end
				end
			end
			local v69 = p51.connections
			local v70 = v_u_53.ChildAdded
			table.insert(v69, v70:Connect(v59))
			local v71 = p51.connections
			local v72 = v_u_53.ChildRemoved
			table.insert(v71, v72:Connect(v66))
		end
		if v56 then
			local v73 = v_u_42
			local v74 = v_u_40
			local v75 = 0
			for _ in pairs(v73) do
				v75 = v75 + 1
			end
			local v76 = v75 <= v74
			assert(v76, v75)
			if v75 == v74 then
				p_u_35:_startBoundFn(p_u_36, v_u_42)
			end
		end
	end
	debug.profilebegin("ResolveTree")
	v_u_77(v43)
	debug.profileend()
	debug.profileend()
end
function v_u_12.unbindRoot(p78, p79)
	-- upvalues: (copy) v_u_11
	local v80 = p78._rootInstToRootNode
	local v81 = p78._rootInstToManifest
	p78:_stopBoundFn(p79)
	local v82 = v80[p79]
	if v82 then
		local v83 = v81[p79]
		v_u_11(v82, (assert(v83)))
		v80[p79] = nil
	end
	v81[p79] = nil
end
function v_u_12.destroy(p84)
	-- upvalues: (copy) v_u_11
	debug.profilebegin("AtomicBinding:destroy")
	for _, v85 in pairs(p84._dtorMap) do
		v85:destroy()
	end
	table.clear(p84._dtorMap)
	for _, v86 in ipairs(p84._connections) do
		v86:Disconnect()
	end
	table.clear(p84._connections)
	local v87 = p84._rootInstToManifest
	for v88, v89 in pairs(p84._rootInstToRootNode) do
		local v90 = v87[v88]
		v_u_11(v89, (assert(v90)))
	end
	table.clear(p84._rootInstToManifest)
	table.clear(p84._rootInstToRootNode)
	debug.profileend()
end
return v_u_12