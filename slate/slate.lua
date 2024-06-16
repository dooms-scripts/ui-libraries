--! doom.lol

-- >> SERVICES
local Players = game:GetService('Players')
local Tween = game:GetService('TweenService')

-- >> VARIABLES
local Player = Players.LocalPlayer

-- >> FUNCTIONS
local function AddInstance(class : string, properties : {})
	local i

	local madeInstance, errorMessage = pcall(function()
		i = Instance.new(class)	
	end)

	if not madeInstance then
		return error(errorMessage, 99)
	end

	for property, value in properties do
		local _, err = pcall(function()
			i[property] = value
		end)

		if err then 
			return warn(`[!] Problem adding instance: {err}`) 
		end
	end

	return i or nil
end

-- >> Overwrites data of the same index in T1 with data of the same index in T2
local function Overwrite(to_overwrite : {}, overwrite_with : {})
	for i, v in pairs(overwrite_with) do
		if type(v) == 'table' then
			to_overwrite[i] = Overwrite(to_overwrite[i] or {}, v)
		else
			to_overwrite[i] = v
		end
	end

	return to_overwrite or nil
end

-- >> Tween but better
local function TweenInstance(... : {})
	local Defaults = {
		Object = nil,
		Info = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
		Data = {},
	}

	local Data = Overwrite(Defaults, ... or {})
	local NewTween = Tween:Create(Data.Object, Data.Info, Data.Data)

	task.spawn(function()
		NewTween:Play()
	end)

	return NewTween
end

-- >> LIBRARY
local Library = {}

function Library:Window(...)
	local Window = {}
	
	function Window:Tab(name, icon)
		if not name or not icon then return end

		local TabFrame
		local TabButton
	end
	
	return Window
end

return Library
