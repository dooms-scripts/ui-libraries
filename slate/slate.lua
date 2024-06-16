--! doom.lol
cloneref=cloneref or function(...) return(...) end

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
local Library = {
	INSTANCE = AddInstance("ScreenGui", { Parent = cloneref(game.CoreGui), ZIndexBehavior = Enum.ZIndexBehavior.Sibling,}),
}

function Library:Window(...)
	local Window = {}

	-- ! Window Frame
	local WindowFrame = AddInstance("Frame", { Parent = ScreenGui, Name = [[Window]], BorderSizePixel = 0, Size = UDim2.new(0, 500, 0, 350), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.567754686, 0, 0.499145299, 0), BackgroundColor3 = Color3.fromRGB(15, 15, 15),})

	-- ! Main Categories
	local Topbar = AddInstance("Frame", { Parent = WindowFrame, Name = [[Topbar]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 25), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9900000095367432, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local Sidebar = AddInstance("Frame", { Parent = WindowFrame, Name = [[Sidebar]], BorderSizePixel = 0, Size = UDim2.new(0, 120, 1, -25), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, 0, 0.0714285746, 0), BackgroundTransparency = 0.9900000095367432, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local Tabs = AddInstance("Frame", { Parent = WindowFrame, Name = [[Tabs]], AnchorPoint = Vector2.new(1, 1), BorderSizePixel = 0, Size = UDim2.new(1, -120, 1, -25), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})

	-- ! Subsidiaries
	local Buttons = AddInstance("Frame", { Parent = Topbar, Name = [[Buttons]], AnchorPoint = Vector2.new(1, 0), BorderSizePixel = 0, Size = UDim2.new(0, 32, 1, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local Minimize = AddInstance("ImageButton", { Parent = Buttons, Name = [[Minimize]], LayoutOrder = 1, BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, Image = [[http://www.roblox.com/asset/?id=6026568240]], BorderSizePixel = 0, Size = UDim2.new(0, 16, 0, 14), BorderColor3 = Color3.fromRGB(0, 0, 0), ImageColor3 = Color3.fromRGB(125, 125, 125), Position = UDim2.new(0.920000017, 0, 0.239999995, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local Resize = AddInstance("ImageButton", { Parent = WindowFrame, Name = [[Resize]], ResampleMode = Enum.ResamplerMode.Pixelated, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1), Image = [[http://www.roblox.com/asset/?id=17736105571]], BorderSizePixel = 0, Size = UDim2.new(0, 9, 0, 9), BorderColor3 = Color3.fromRGB(0, 0, 0), ImageColor3 = Color3.fromRGB(50, 50, 50), Rotation = 180, Position = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local Close = AddInstance("ImageButton", { Parent = Buttons, Name = [[Close]], LayoutOrder = 2, BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, Image = [[http://www.roblox.com/asset/?id=6031094678]], BorderSizePixel = 0, Size = UDim2.new(0, 16, 0, 14), BorderColor3 = Color3.fromRGB(0, 0, 0), ImageColor3 = Color3.fromRGB(125, 125, 125), Position = UDim2.new(0.952000022, 0, 0.239999995, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local Title = AddInstance("TextLabel", { Parent = Topbar, Name = [[Title]], TextWrapped = true, BorderSizePixel = 0, RichText = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, Size = UDim2.new(1, -36, 0, 25), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = [[doom.lol <font color="rgb(75,75,75)">| slate ui</font>]], FontFace = Font.new('rbxassetid://11702779409', Enum.FontWeight.Regular, Enum.FontStyle.Normal), TextColor3 = Color3.fromRGB(173, 173, 173), BackgroundTransparency = 1,})

	-- ! UI Elements
	AddInstance("UIListLayout", { Parent = Buttons, VerticalAlignment = Enum.VerticalAlignment.Center, FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder,})
	AddInstance("UIListLayout", { Parent = Sidebar, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder,})
	AddInstance("UIPadding", { Parent = Tabs, PaddingTop = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), PaddingLeft = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12),})
	AddInstance("UIPadding", { Parent = Topbar, PaddingRight = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6),})
	AddInstance("UIPadding", { Parent = Sidebar, PaddingRight = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4),})
	AddInstance("UICorner", { Parent = WindowFrame, CornerRadius = UDim.new(0, 5),})
	AddInstance("UIPadding", { Parent = Title, PaddingTop = UDim.new(0, 3),})

	-- ! Functions
	function Window:Tab(name, icon)
		if not name or not icon then return end

		local TabFrame
		local TabButton
	end
	
	return Window
end

return Library
