getgenv = getgenv or assert(getgenv, 'Executor not supported.')

local Library = {}
getgenv().MAIN_COLOR = Color3.fromRGB(140, 255, 90)

repeat task.wait() until game:IsLoaded()
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

-- >> FUNCTIONS << ----------------------------------------------------------------
function TableOverwrite(to_overwrite : {}, overwrite_with : {})
	for i, v in pairs(overwrite_with) do
		if type(v) == 'table' then
			to_overwrite[i] = TableOverwrite(to_overwrite[i] or {}, v)
		else
			to_overwrite[i] = v
		end
	end

	return to_overwrite or nil
end

function TweenInstance(DataTable : {}, Dependancy : boolean)
	if Dependancy == false then return end

	local Defaults = {
		Object = nil,
		Info = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
		Data = {},
	}

	local Data = TableOverwrite(Defaults, DataTable or {})
	local NewTween = game:GetService('TweenService'):Create(Data.Object, Data.Info, Data.Data)

	task.spawn(function()
		NewTween:Play()
	end)

	return NewTween
end

function add(class : string, properties : {})
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
			return warn(`Problem adding instance: {err}`) 
		end
	end

	return i or nil
end

-- >> INSTANCES << ----------------------------------------------------------------
local ScreenGui = add("ScreenGui", { Parent = game.CoreGui, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,})
local Window = add("Frame", { Parent = ScreenGui, Name = [[Window]], AnchorPoint = Vector2.new(1,1), Draggable = true, Active = true, BorderSizePixel = 0, Size = UDim2.new(0, 420, 0, 330), ClipsDescendants = true, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, -20, 1, -20), BackgroundColor3 = Color3.fromRGB(25, 25, 25),})
local Topbar = add("Frame", { Parent = Window, Name = [[Topbar]], Size = UDim2.new(1, 0, 0, 25), BorderColor3 = Color3.fromRGB(40, 40, 40), BackgroundColor3 = Color3.fromRGB(35, 35, 35),})
local Title = add("TextLabel", { Parent = Topbar, Name = [[Title]], BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Size = UDim2.new(1, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = [[dooms selling gui]], FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), TextColor3 = Color3.fromRGB(175, 175, 175), BackgroundTransparency = 1,})
local Padding = add("UIPadding", { Parent = Topbar, Name = [[Padding]], PaddingTop = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingBottom = UDim.new(0, 6),})
local ButtonHolder = add("Frame", { Parent = Topbar, Name = [[ButtonHolder]], AnchorPoint = Vector2.new(1, 0.5), BorderSizePixel = 0, Size = UDim2.new(0, 100, 1, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
local Minimize = add("ImageButton", { Parent = ButtonHolder, Name = [[Minimize]], LayoutOrder = 1, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Image = [[http://www.roblox.com/asset/?id=6026568240]], BorderSizePixel = 0, Size = UDim2.new(0, 16, 0, 16), BorderColor3 = Color3.fromRGB(0, 0, 0), ImageColor3 = Color3.fromRGB(150, 150, 150), Position = UDim2.new(0.95110023, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
local Exit = add("ImageButton", { Parent = ButtonHolder, Name = [[Exit]], LayoutOrder = 2, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Image = [[http://www.roblox.com/asset/?id=6031094678]], BorderSizePixel = 0, Size = UDim2.new(0, 16, 0, 16), BorderColor3 = Color3.fromRGB(0, 0, 0), ImageColor3 = Color3.fromRGB(150, 150, 150), Position = UDim2.new(1, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
local UIListLayout = add("UIListLayout", { Parent = ButtonHolder, FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Right,})
local Sidebar = add("Frame", { Parent = Window, Name = [[Sidebar]], AnchorPoint = Vector2.new(0, 1), Size = UDim2.new(0, 115, 1, -26), ClipsDescendants = true, BorderColor3 = Color3.fromRGB(40, 40, 40), Position = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(30, 30, 30),})
local Buttons = add("Frame", { Parent = Sidebar, Name = [[Buttons]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, -45), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
local UIListLayout2 = add("UIListLayout", { Parent = Buttons, SortOrder = Enum.SortOrder.LayoutOrder,})
local ProfileCard = add("Frame", { Parent = Sidebar, Name = [[ProfileCard]], AnchorPoint = Vector2.new(0, 1), Size = UDim2.new(1, 0, 0, 45), BorderColor3 = Color3.fromRGB(40, 40, 40), Position = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(30, 30, 30),})
local ProfilePicture = add("Frame", { Parent = ProfileCard, Name = [[ProfilePicture]], AnchorPoint = Vector2.new(0, 0.5), BorderSizePixel = 0, Size = UDim2.new(0, 32, 0, 32), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
local Background = add("Frame", { Parent = ProfilePicture, Name = [[Background]], AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Size = UDim2.new(0, 32, 0, 32), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundColor3 = getgenv().MAIN_COLOR,})
local UICorner = add("UICorner", { Parent = Background, CornerRadius = UDim.new(0, 6),})
local UIGradient = add("UIGradient", { Parent = Background, Enabled = false, Rotation = 106, Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 229.00000154972076, 255)); ColorSequenceKeypoint.new(0.427335649728775, Color3.fromRGB(113.23794409632683, 93.11447471380234, 255)); ColorSequenceKeypoint.new(0.8235294222831726, Color3.fromRGB(164.83565658330917, 31.197222769260406, 255)); ColorSequenceKeypoint.new(1, Color3.fromRGB(185.00000417232513, 7.000000057742, 255));}),})
local UIGradient2 = add("UIGradient", { Parent = Background, Enabled = false, Rotation = 106, Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45.00000111758709, 45.00000111758709, 45.00000111758709)); ColorSequenceKeypoint.new(0.31833910942077637, Color3.fromRGB(55.1730128377676, 49.98961977660656, 52.21799500286579)); ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 148.000006377697, 194.00000363588333));}),})
local UIGradient3 = add("UIGradient", { Parent = Background, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1, 0); NumberSequenceKeypoint.new(0.25375625491142273, 0.9090909361839294, 0); NumberSequenceKeypoint.new(0.34223705530166626, 0.8181818127632141, 0); NumberSequenceKeypoint.new(0.39899832010269165, 0.7438016533851624, 0); NumberSequenceKeypoint.new(0.4974958002567291, 0.5041322708129883, 0); NumberSequenceKeypoint.new(0.6494156718254089, 0.22727274894714355, 0); NumberSequenceKeypoint.new(0.7545909881591797, 0.10743802785873413, 0); NumberSequenceKeypoint.new(0.8614357113838196, 0.04132235050201416, 0); NumberSequenceKeypoint.new(1, 0, 0);}), Rotation = 106,})
local ImageLabel = add("ImageLabel", { Parent = ProfilePicture, Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420), BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
local UICorner2 = add("UICorner", { Parent = ImageLabel, CornerRadius = UDim.new(0, 6),})
local UIStroke = add("UIStroke", { Parent = ImageLabel, Color = Color3.fromRGB(50, 50, 50),})
local UIPadding = add("UIPadding", { Parent = ProfileCard, PaddingLeft = UDim.new(0, 6),})
local UserLabel = add("TextLabel", { Parent = ProfileCard, Name = [[UserLabel]], Text = Player.DisplayName, TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd, BorderSizePixel = 0, TextYAlignment = Enum.TextYAlignment.Bottom, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Size = UDim2.new(1, -45, 0, 17), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.new(0.357798159, 0, 0.13333334, 0), TextColor3 = Color3.fromRGB(165, 165, 165), BackgroundTransparency = 1,})
local StatusLabel = add("TextLabel", { Parent = ProfileCard, Name = [[StatusLabel]], BorderSizePixel = 0, TextYAlignment = Enum.TextYAlignment.Top, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Size = UDim2.new(1, -45, 0, 17), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = [[Seller]], Font = Enum.Font.Gotham, Position = UDim2.new(0.357798159, 0, 0.466666669, 0), TextColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 1,})
local Tabs = add("Frame", { Parent = Window, Name = [[Tabs]], AnchorPoint = Vector2.new(1, 1), BorderSizePixel = 0, Size = UDim2.new(1, -116, 1, -26), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(25, 25, 25),})
local UIPadding2 = add("UIPadding", { Parent = Tabs, PaddingTop = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10),})
local DragButton = add("ImageButton", { Parent = Window, Name = [[DragBottom]], ResampleMode = Enum.ResamplerMode.Pixelated, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1), Image = [[http://www.roblox.com/asset/?id=17736105571]], BorderSizePixel = 0, Size = UDim2.new(0, 9, 0, 9), BorderColor3 = Color3.fromRGB(0, 0, 0), ImageColor3 = Color3.fromRGB(75, 75, 75), Rotation = 180, Position = UDim2.new(1, -2, 1, -2), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
local DragStroke = add("UIStroke", { Parent = Window, Name = [[DragStroke]], Transparency = 1, Color = Color3.fromRGB(255, 255, 255),})
local UIGradient4 = add("UIGradient", { Parent = DragStroke, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1, 0); NumberSequenceKeypoint.new(0.6994991302490234, 0.8801652789115906, 0); NumberSequenceKeypoint.new(0.7996661067008972, 0.7520661354064941, 0); NumberSequenceKeypoint.new(1, 0, 0);}), Rotation = 45,})

-- >> TASKS << --------------------------------------------------------------------
if getgenv().Alts and getgenv().Alts[Player.UserId] then StatusLabel.Text = 'Alt' end

-- Minimize Button
spawn(function()
	--! Variables
	local Minimized = false;
	local OldSize = nil;
	
	--! Connections
	Minimize.MouseButton1Click:Connect(function()
		Minimized = not Minimized

		if Minimized then
			OldSize = Window.Size.Y.Offset
		end

		if Minimized then
			TweenInstance({
				Object = Title,
				Data = { TextColor3 = getgenv().MAIN_COLOR }
			})

			TweenInstance({
				Object = Window,
				Data = { Size = UDim2.new(0, Window.Size.X.Offset, 0, 25) }
			})
		elseif not Minimized then
			TweenInstance({
				Object = Title,
				Data = { TextColor3 = Color3.fromRGB(150, 150, 150) }
			})

			TweenInstance({
				Object = Window,
				Data = { Size = UDim2.new(0, Window.Size.X.Offset, 0, OldSize) }
			})
		end

		task.wait(.125)

		Window.Sidebar.Visible = not Minimized
		Window.Tabs.Visible = not Minimized
	end)
end)

-- Exit Button
spawn(function()
	--! Variables
	local Closed = false;
	
	--! Connections
	Exit.MouseButton1Click:Connect(function()
		if Closed then return end
		Closed = true

		TweenInstance({
			Object = Window,
			Data = { Size = UDim2.new(0, Window.Size.X.Offset, 0, 25) }
		})

		task.wait(0.25)

		TweenInstance({
			Object = Window,
			Data = { Size = UDim2.new(0, 0, 0, 25) }
		})

		task.wait(0.25)

		Window.Parent:Destroy()
	end)
end)

-- Drag + Resize
spawn(function()
	--! Variables
	local Dragging = false
	local LastPosX;
	local LastPosY;

	local MinimumSizeX = 355
	local MinimumSizeY = 210

	--! Instances
	local Player = game:GetService('Players').LocalPlayer
	local Mouse = Player:GetMouse()

	--! Functions
	local function StartDrag()
		if Dragging then return end

		Window.Draggable = false
		Dragging = true

		TweenInstance({
			Object = DragButton,
			Data = { ImageColor3 = getgenv().MAIN_COLOR }
		})

		TweenInstance({
			Object = DragStroke,
			Data = { Transparency = 0.5, Color = getgenv().MAIN_COLOR }
		})
	end

	local function StopDrag()
		if not Dragging then return end

		Dragging = false
		Window.Draggable = true

		TweenInstance({
			Object = DragButton,
			Data = { ImageColor3 = Color3.fromRGB(75, 75, 75) }
		})

		TweenInstance({
			Object = DragStroke,
			Data = { Transparency = 1 }
		})
	end

	--! ButtonInput
	DragButton.MouseButton1Down:Connect(StartDrag)
	DragButton.MouseButton1Up:Connect(StopDrag)

	DragButton.MouseButton2Click:Connect(function()
		Window.Size = UDim2.new(
			0, 420,
			0, 250
		)
	end)

	--! MouseInput
	Mouse.Button1Up:Connect(StopDrag)

	game:GetService('UserInputService').InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
			StopDrag()
		end
	end)

	--! MouseMove
	Mouse.Move:Connect(function()
		if Dragging then
			if LastPosX and LastPosY then
				local NewPosX = Mouse.X - LastPosX
				local NewPosY = Mouse.Y - LastPosY

				--! Don't resize if minimum is reached
				if Window.Size.X.Offset + 1 * NewPosX > MinimumSizeX then
					Window.Size += UDim2.new(0, 1 * NewPosX, 0, 0)
					Window.Position += UDim2.new(0, 1 * NewPosX, 0, 0)
				end

				--! Don't resize if minimum is reached
				if Window.Size.Y.Offset + 1 * NewPosY > MinimumSizeY then
					Window.Size += UDim2.new(0, 0, 0, 1 * NewPosY)
					Window.Position += UDim2.new(0, 0, 0, 1 * NewPosY)
				end
			end
		end

		LastPosX = Mouse.X
		LastPosY = Mouse.Y
	end)
end)

-- >> METHODS << ------------------------------------------------------------------
function Library:NewTab(...)
	local Tab = {}	

	local TabFrame = add("ScrollingFrame", { Parent = Tabs, Name = [[TabFrame]], Visible = false, Active = true, BorderSizePixel = 0, CanvasSize = UDim2.new(0, 0, 0, 284), ElasticBehavior = Enum.ElasticBehavior.Never, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, 0), ScrollBarImageColor3 = Color3.fromRGB(145, 145, 145), BorderColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 3, BackgroundTransparency = 1,})
	local Title = add("TextLabel", { Parent = TabFrame, Name = [[Title]], TextWrapped = true, BorderSizePixel = 0, TextYAlignment = Enum.TextYAlignment.Bottom, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, Size = UDim2.new(1, 0, -0, 15), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = (...)['Name'], FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), TextColor3 = Color3.fromRGB(150, 150, 150), BackgroundTransparency = 1,})
	local TabButton = add("Frame", { Parent = Buttons, Name = [[TabButton]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 20), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, BackgroundTransparency = 1, BackgroundColor3 = getgenv().MAIN_COLOR,})
	local Hitbox = add("TextButton", { Parent = TabButton, Name = [[Hitbox]], ZIndex = 999, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Size = UDim2.new(1, 0, 1, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), TextTransparency = 1, Font = Enum.Font.SourceSans, TextColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1,})
	local Label = add("TextLabel", { Parent = TabButton, Name = [[Label]], BorderSizePixel = 0, RichText = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Size = UDim2.new(1, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = (...)['Name'], Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(125, 125, 125), BackgroundTransparency = 1,})
	local Icon = add("ImageLabel", { Parent = TabButton, Name = [[Icon]], AnchorPoint = Vector2.new(0, 0.5), Image = (...)['Icon'] or [[http://www.roblox.com/asset/?id=6026568198]], BorderSizePixel = 0, Size = UDim2.new(0, 12, 0, 12), BorderColor3 = Color3.fromRGB(0, 0, 0), ImageColor3 = Color3.fromRGB(125, 125, 125), Position = UDim2.new(0, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	add("UIPadding", { Parent = Label, PaddingLeft = UDim.new(0, 18),})
	add("UIPadding", { Parent = TabButton, PaddingRight = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6),})
	add("UIGradient", { Parent = TabButton, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0); NumberSequenceKeypoint.new(1, 1, 0);}),})
	add("UIPadding", { Parent = Title, PaddingLeft = UDim.new(0, 0), PaddingBottom = UDim.new(0, 1),})
	add("UIPadding", { Parent = TabFrame, PaddingRight = UDim.new(0, 7), PaddingLeft = UDim.new(0, 1),})
	add("UIListLayout", { Parent = TabFrame, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder,})

	Hitbox.MouseEnter:Connect(function()
		TweenInstance({
			Object = Label,
			Data = { TextColor3 = Color3.fromRGB(200, 200, 200) }
		}, not TabFrame.Visible)

		TweenInstance({
			Object = Icon,
			Data = { ImageColor3 = Color3.fromRGB(200, 200, 200) }
		}, not TabFrame.Visible)
	end)

	Hitbox.MouseLeave:Connect(function()
		TweenInstance({
			Object = Label,
			Data = { TextColor3 = Color3.fromRGB(125, 125, 125) }
		}, not TabFrame.Visible)

		TweenInstance({
			Object = Icon,
			Data = { ImageColor3 = Color3.fromRGB(125, 125, 125) }
		}, not TabFrame.Visible)
	end)

	Hitbox.MouseButton1Click:Connect(function()
		TweenInstance({
			Object = TabButton,
			Data = { BackgroundTransparency = 0.95 }
		})

		TweenInstance({
			Object = Label,
			Data = { TextColor3 = getgenv().MAIN_COLOR }
		})

		TweenInstance({
			Object = Icon,
			Data = { ImageColor3 = getgenv().MAIN_COLOR }
		})

		for _, Button in Buttons:GetChildren() do
			if Button:IsA('Frame') and Button ~= TabButton then
				Button.Label.Text = Button.Label.Text:gsub('<b>', '')
				Button.Label.Text = Button.Label.Text:gsub('</b>', '')

				TweenInstance({
					Object = Button,
					Data = { BackgroundTransparency = 1 }
				})

				TweenInstance({
					Object = Button.Label,
					Data = { TextColor3 = Color3.fromRGB(125, 125, 125) }
				})

				TweenInstance({
					Object = Button.Icon,
					Data = { ImageColor3 = Color3.fromRGB(125, 125, 125) }
				})
			end
		end

		for _, Tab in Tabs:GetChildren() do
			if Tab:IsA('ScrollingFrame') then Tab.Visible = false end
		end

		--Label.Text = `<b>{Label.Text}</b>`
		TabFrame.Visible = true
	end)

	function Tab:Import(...)
		local Data = ...

		if Data.Object then
			Data.Object.Parent = TabFrame
		end

		if Data.Offset then
			TabFrame.CanvasSize += UDim2.new(0,0,0,Data.Offset)
		end
	end

	return Tab
end

return Library
