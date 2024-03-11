local library = {}

warn('dooms anti lib loaded : v1.0.0')

function library.newWindow(title_text, main_color)
	local window = {}
	
	local antilib = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Topbar = Instance.new("Frame")
	local label = Instance.new("TextLabel")
	local divider = Instance.new("Frame")
	local close = Instance.new("TextButton")
	local UIListLayout = Instance.new("UIListLayout")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local stroke = Instance.new('UIStroke')
	
	UIListLayout.SortOrder = 'Name'
	
	stroke.Color = main_color
	stroke.Thickness = 1
	stroke.Parent = Main

	antilib.Name = "anti-lib"
	antilib.Parent = game.Players.LocalPlayer.PlayerGui
	antilib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = antilib
	Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Main.BorderColor3 = Color3.fromRGB(50, 50, 50)
	Main.BorderMode = 'Inset'
	Main.Position = UDim2.new(0.729705751, 0, 0.700501263, 0)
	Main.Size = UDim2.new(0, 250, 0, 37)
	
	Main.Selectable = true
	Main.Active = true
	Main.Draggable = true
	
	Topbar.Name = "1Topbar"
	Topbar.Parent = Main
	Topbar.AnchorPoint = Vector2.new(0.5, 0)
	Topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Topbar.BackgroundTransparency = 0.975
	Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Topbar.BorderSizePixel = 0
	Topbar.Position = UDim2.new(0.5, 0, 0, 0)
	Topbar.Size = UDim2.new(0, 250, 0, 30)

	label.Name = "label"
	label.Parent = Topbar
	label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1.000
	label.BorderColor3 = Color3.fromRGB(0, 0, 0)
	label.BorderSizePixel = 0
	label.Position = UDim2.new(0.0280000009, 0, 0, 0)
	label.Size = UDim2.new(0, 210, 0, 30)
	label.Font = Enum.Font.Gotham
	label.Text = title_text
	label.TextColor3 = Color3.fromRGB(75, 75, 75)
	label.TextSize = 14.000
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.RichText = true

	divider.Name = "divider"
	divider.Parent = Topbar
	divider.AnchorPoint = Vector2.new(0.5, 0)
	divider.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	divider.BorderSizePixel = 0
	divider.Position = UDim2.new(0.497999996, 0, 1, 0)
	divider.Size = UDim2.new(0, 248, 0, 1)
	
	divider.Visible = false

	close.Name = "close"
	close.Parent = Topbar
	close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	close.BackgroundTransparency = 1.000
	close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	close.BorderSizePixel = 0
	close.Position = UDim2.new(0.875968277, 0, 0.13333334, 0)
	close.Size = UDim2.new(0, 27, 0, 21)
	close.Font = Enum.Font.Gotham
	close.Text = "-"
	close.TextColor3 = Color3.fromRGB(75, 75, 75)
	close.TextSize = 18.000
	
	close.MouseButton1Click:Connect(function()
		Main:Destroy()
	end)
	
	wait(1)

	local ContentHolder = Instance.new("Frame")


	ContentHolder.Name = "ContentHolder"
	ContentHolder.Parent = Main
	ContentHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ContentHolder.BackgroundTransparency = 1.000
	ContentHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ContentHolder.BorderSizePixel = 0
	ContentHolder.Position = UDim2.new(0.00400000019, 0, 0.184210524, 0)
	ContentHolder.Size = UDim2.new(0, 249, 0, 4)

	UIListLayout.Parent = ContentHolder
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UIListLayout_2.Parent = Main
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 4)
	
	local plr = game.Players.LocalPlayer
	local cursor = plr:GetMouse()


	ContentHolder.MouseEnter:Connect(function() cursor.Icon = 'http://www.roblox.com/asset/?id=16710247795' end)
	ContentHolder.MouseLeave:Connect(function() cursor.Icon = '' end)
	
	Main.MouseEnter:Connect(function() cursor.Icon = 'http://www.roblox.com/asset/?id=16710247795' end)
	Main.MouseLeave:Connect(function() cursor.Icon = '' end)


	function window.newToggle(text, callback, value)
		local toggle_ = {}
		local toggled = false
		
		local toggle = Instance.new("Frame")
		local label = Instance.new("TextLabel")
		local toggle_2 = Instance.new("TextButton")

		ContentHolder.Size += UDim2.new(0,0,0,30)
		Main.Size += UDim2.new(0,0,0,30)

		toggle.Name = "toggle"
		toggle.Parent = ContentHolder
		toggle.AnchorPoint = Vector2.new(0.5, 0)
		toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		toggle.BackgroundTransparency = 1.000
		toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		toggle.BorderSizePixel = 0
		toggle.Position = UDim2.new(-7.35363301e-07, 0, 0, 0)
		toggle.Size = UDim2.new(1, 0, 0, 30)

		label.Name = "label"
		label.Parent = toggle
		label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		label.BackgroundTransparency = 1.000
		label.BorderColor3 = Color3.fromRGB(0, 0, 0)
		label.BorderSizePixel = 0
		label.Position = UDim2.new(0.0281124506, 0, 0, 0)
		label.Size = UDim2.new(0, 240, 0, 30)
		label.Font = Enum.Font.Gotham
		label.Text = text
		label.TextColor3 = Color3.fromRGB(100, 100, 100)
		label.TextSize = 14.000
		label.TextXAlignment = Enum.TextXAlignment.Left

		toggle_2.Name = "toggle"
		toggle_2.Parent = toggle
		toggle_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		toggle_2.BorderColor3 = Color3.fromRGB(30, 30, 30)
		toggle_2.BorderMode = 'Inset'
		toggle_2.Position = UDim2.new(0.887550473, 0, 0.166666672, 0)
		toggle_2.Size = UDim2.new(0, 20, 0, 20)
		toggle_2.AutoButtonColor = false
		toggle_2.Font = Enum.Font.Gotham
		toggle_2.Text = ""
		toggle_2.TextColor3 = Color3.fromRGB(179, 128, 255)
		toggle_2.TextSize = 16.000

		toggle_2.MouseButton1Click:Connect(function()
			callback()
			toggled = not toggled
			if toggled then
				toggle_2.BackgroundColor3 = main_color
				toggle_2.BorderColor3 = main_color
			elseif not toggled then
				toggle_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				toggle_2.BorderColor3 = Color3.fromRGB(30, 30, 30)
			end
		end)
		
		return toggle_
	end
	
	return window
end

return library
