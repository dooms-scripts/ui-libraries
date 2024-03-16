local encrypt = {}
encrypt.color = Color3.fromRGB(255,255,255)
encrypt.ui_object = nil

local ts = game:GetService('TweenService')
local ti = TweenInfo

local EncryptedName = Instance.new("ScreenGui")
local _,err = pcall(function()
	EncryptedName.Parent = game.CoreGui
end)

warn('ENCRYPT v1.0.0')

if err then 
	warn('⚠️ ENCRYPT LIBRARY ERROR: ' ..tostring(err))
	EncryptedName.Parent = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
end

EncryptedName.Name = tostring('doom_'..math.random(10000000000,99999999999))
EncryptedName.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function encrypt.new_window(title_text)
	local window = {}
	
	-- Creating UI
	local ButtonHolder = Instance.new("Frame")
	local WindowFrame = Instance.new("Frame")
	local Divider = Instance.new("Frame")
	local Tabs = Instance.new("Frame")
	local Topbar = Instance.new("Frame")
	local TitleText = Instance.new("TextLabel")
	local Gradient = Instance.new("ImageLabel")

	WindowFrame.Name = "WindowFrame"
	WindowFrame.Parent = EncryptedName
	WindowFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	WindowFrame.BorderColor3 = Color3.fromRGB(35, 35, 35)
	WindowFrame.Position = UDim2.new(0.711538434, 0, 0.436090231, 0)
	WindowFrame.Size = UDim2.new(0, 380, 0, 425)
	WindowFrame.Active = true
	WindowFrame.Selectable = true
	WindowFrame.Draggable = true

	Gradient.Parent = WindowFrame
	Gradient.AnchorPoint = Vector2.new(0, 1)
	Gradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Gradient.BackgroundTransparency = 1.000
	Gradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Gradient.BorderSizePixel = 0
	Gradient.Position = UDim2.new(0, 0, 0.99, 0)
	Gradient.Size = UDim2.new(1, 0, 0, 25)
	Gradient.Image = "rbxassetid://277037193"
	Gradient.ImageColor3 = Color3.fromRGB(20, 20, 20)
	Gradient.ZIndex = 99
	
	Topbar.Name = "Topbar"
	Topbar.Parent = WindowFrame
	Topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Topbar.BackgroundTransparency = 1.000
	Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Topbar.BorderSizePixel = 0
	Topbar.Size = UDim2.new(1, 0, 0, 25)

	ButtonHolder.Name = "ButtonHolder"
	ButtonHolder.Parent = Topbar
	ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ButtonHolder.BackgroundTransparency = 1.000
	ButtonHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ButtonHolder.BorderSizePixel = 0
	ButtonHolder.Size = UDim2.new(1, 0, 1, 0)

	local UIListLayout = Instance.new("UIListLayout", ButtonHolder)
	UIListLayout.Parent = ButtonHolder
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	TitleText.Name = "TitleText"
	TitleText.Parent = ButtonHolder
	TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleText.BackgroundTransparency = 1.000
	TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleText.BorderSizePixel = 0
	TitleText.Size = UDim2.new(0, 111, 0, 25)
	TitleText.Font = Enum.Font.Gotham
	TitleText.Text = "  "..tostring(title_text)
	TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleText.TextSize = 14.000
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.Size = UDim2.new(0, TitleText.TextBounds.X + 10, 1, 0)

	Divider.Name = "Divider"
	Divider.Parent = Topbar
	Divider.AnchorPoint = Vector2.new(0.5, 0)
	Divider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Divider.BorderSizePixel = 0
	Divider.Position = UDim2.new(0.5, 0, 1, 0)
	Divider.Size = UDim2.new(1, 0, 0, 1)

	Tabs.Name = "Tabs"
	Tabs.Parent = WindowFrame
	Tabs.AnchorPoint = Vector2.new(0.5, 0)
	Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tabs.BackgroundTransparency = 1.000
	Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tabs.BorderSizePixel = 0
	Tabs.Position = UDim2.new(0.5, 0, 0.075000003, 0)
	Tabs.Size = UDim2.new(0, 366, 0, 385)
	
	-- Functions
	function window.new_tab(tab_name)
		local tab = {}
		local TabFrame = Instance.new("Frame")
			
		TabFrame.Name = tab_name
		TabFrame.Parent = Tabs
		TabFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabFrame.BackgroundTransparency = 1.000
		TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabFrame.BorderSizePixel = 0
		TabFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabFrame.Visible = false
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		
		local UIListLayout = Instance.new("UIListLayout", ButtonHolder)
		UIListLayout.Parent = TabFrame
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 8)

		local TabButton = Instance.new("TextButton")
		TabButton.Parent = ButtonHolder
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Position = UDim2.new(0.293650806, 0, 0, 0)
		TabButton.Size = UDim2.new(0.213506043, 0, 1, 0)
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = tab_name
		TabButton.TextColor3 = Color3.fromRGB(100, 100, 100)
		TabButton.TextSize = 14.000
		TabButton.TextWrapped = true
		TabButton.Size = UDim2.new(0, TabButton.TextBounds.X + 10, 1, 0)
		TabButton.MouseButton1Click:Connect(function()
			for _,t in ipairs(Tabs:GetChildren()) do
				if t:IsA('Frame') then t.Visible = false end
				Tabs[tab_name].Visible = true
			end
			for _,b in ipairs(ButtonHolder:GetChildren()) do
				if b:IsA('TextButton') then b.TextColor3 = Color3.fromRGB(100, 100, 100) end
				TabButton.TextColor3 = encrypt.color
			end
		end)

		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.Parent = Tab
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 8)

		function tab.new_group(group_name)
			local group = {}
			
			-- Creating UI
			local ContentHolder = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			ContentHolder.Parent = TabFrame
			
			ContentHolder.Name = group_name
			ContentHolder.Size = UDim2.new(0, 179, 0, 387)
			ContentHolder.Position = UDim2.new(0, 0, 0, 0)
			ContentHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
			ContentHolder.Active = true
			ContentHolder.ScrollBarThickness = 4
			ContentHolder.BorderSizePixel = 0
			ContentHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ContentHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			ContentHolder.ScrollBarImageColor3 = encrypt.color
			ContentHolder.BackgroundTransparency = 1.000
			ContentHolder.TopImage = "http://www.roblox.com/asset/?id=16747999837"
			ContentHolder.BottomImage = "http://www.roblox.com/asset/?id=16748002234"
			ContentHolder.MidImage = "rbxassetid://1510273450"
	
			UIListLayout.Parent = ContentHolder
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 4)
			
			-- Functions
			function group.new_category(title_text)
				local category = {}
				
				-- Creating UI
				local CategoryFrame = Instance.new("Frame")
				local TitleText = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
	
				CategoryFrame.Parent = ContentHolder
				CategoryFrame.Name = "CategoryFrame"
				CategoryFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				CategoryFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				CategoryFrame.BorderSizePixel = 0
				CategoryFrame.Size = UDim2.new(0, 170, 0, 24)
				ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 24)
	
				TitleText.Name = "TitleText"
				TitleText.Parent = CategoryFrame
				TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.BackgroundTransparency = 1.000
				TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleText.BorderSizePixel = 0
				TitleText.Position = UDim2.new(0.0411764719, 0, 0, 0)
				TitleText.Size = UDim2.new(1, 0, 0, 20)
				TitleText.Font = Enum.Font.Gotham
				TitleText.Text = tostring(title_text)
				TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.TextSize = 14.000
	
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = CategoryFrame
	
				UIListLayout.Parent = CategoryFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				
				ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 4)
				
				-- Functions
				function category.new_text(text_input)
					local text_divider = {}
					
					-- Creating UI
					local TextDivider = Instance.new("Frame")
					local text = Instance.new("TextLabel")
	
					TextDivider.Name = "TextDivider"
					TextDivider.Parent = CategoryFrame
					TextDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextDivider.BackgroundTransparency = 1.000
					TextDivider.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextDivider.BorderSizePixel = 0
					TextDivider.Position = UDim2.new(0, 0, 0.13333334, 0)
					TextDivider.Size = UDim2.new(0, 170, 0, 20)
	
					text.Name = "text"
					text.Parent = TextDivider
					text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					text.BackgroundTransparency = 1.000
					text.BorderColor3 = Color3.fromRGB(0, 0, 0)
					text.BorderSizePixel = 0
					text.Position = UDim2.new(0.0294117648, 0, 0, 0)
					text.Size = UDim2.new(0, 165, 0, 20)
					text.Font = Enum.Font.Gotham
					text.Text = text_input
					text.TextColor3 = encrypt.color
					text.TextSize = 12.000
					text.TextXAlignment = Enum.TextXAlignment.Left
					
					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)
					
					-- Functions
					function text_divider.update_text(new_text)
						text.Text = new_text
					end
					
					function text_divider:delete() 
						TextDivider:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end
					
					return text_divider
				end
				
				function category.new_toggle(text_input, callback)
					local toggle = {}
					toggle.value = false
					
					-- Creating UI
					local Toggle = Instance.new("Frame")
					local text = Instance.new("TextLabel")
					local button = Instance.new("TextButton")
					local UICorner = Instance.new("UICorner")
	
					Toggle.Name = "Toggle"
					Toggle.Parent = CategoryFrame
					Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Toggle.BackgroundTransparency = 1.000
					Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Toggle.BorderSizePixel = 0
					Toggle.Position = UDim2.new(0, 0, 0.13333334, 0)
					Toggle.Size = UDim2.new(0, 170, 0, 20)
	
					text.Name = "text"
					text.Parent = Toggle
					text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					text.BackgroundTransparency = 1.000
					text.BorderColor3 = Color3.fromRGB(0, 0, 0)
					text.BorderSizePixel = 0
					text.Position = UDim2.new(0.0294117648, 0, 0, 0)
					text.Size = UDim2.new(0, 165, 0, 20)
					text.Font = Enum.Font.Gotham
					text.Text = text_input
					text.TextColor3 = Color3.fromRGB(255, 255, 255)
					text.TextSize = 12.000
					text.TextXAlignment = Enum.TextXAlignment.Left
	
					button.Name = "button"
					button.Parent = Toggle
					button.AnchorPoint = Vector2.new(0, 0.5)
					button.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
					button.BorderColor3 = Color3.fromRGB(0, 0, 0)
					button.BorderSizePixel = 0
					button.Position = UDim2.new(0.89, 0, 0.5, 0)
					button.Size = UDim2.new(0, 14, 0, 14)
					button.AutoButtonColor = false
					button.Font = Enum.Font.SourceSans
					button.Text = ""
					button.TextColor3 = Color3.fromRGB(0, 0, 0)
					button.TextSize = 14.000
	
					UICorner.CornerRadius = UDim.new(0, 2)
					UICorner.Parent = button
					
					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)
					
					-- Functions
					button.MouseButton1Click:Connect(function()
						callback()
						toggle.value = not toggle.value
						if toggle.value then
							ts:Create(button, ti.new(.15), { BackgroundColor3 = encrypt.color }):Play()
						elseif not toggle.value then 
							ts:Create(button, ti.new(.15), { BackgroundColor3 = Color3.fromRGB(23, 23, 23) }):Play()
						end
					end)
					
					function toggle:delete()
						Toggle:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end
					
					return toggle
				end
				
				function category.new_button(text_input, callback)
					local text_button = {}
					
					-- Creating UI
					local TextButton = Instance.new("Frame")
					local button = Instance.new("TextButton")
					local UICorner = Instance.new("UICorner")
	
					TextButton.Name = "TextButton"
					TextButton.Parent = CategoryFrame
					TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.BackgroundTransparency = 1.000
					TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextButton.BorderSizePixel = 0
					TextButton.Position = UDim2.new(0, 0, 0.13333334, 0)
					TextButton.Size = UDim2.new(0, 170, 0, 20)
	
					button.Name = "button"
					button.Parent = TextButton
					button.AnchorPoint = Vector2.new(0.5, 0.5)
					button.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
					button.BorderColor3 = Color3.fromRGB(0, 0, 0)
					button.BorderSizePixel = 0
					button.Position = UDim2.new(0.5, 0, 0.5, 0)
					button.Size = UDim2.new(0, 160, 0, 16)
					button.AutoButtonColor = true
					button.Font = Enum.Font.Gotham
					button.Text = text_input
					button.TextColor3 = Color3.fromRGB(255, 255, 255)
					button.TextSize = 12.000
	
					UICorner.CornerRadius = UDim.new(0, 2)
					UICorner.Parent = button
					
					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)
					
					-- Functions
					button.MouseButton1Click:Connect(callback)
					
					function text_button:delete()
						TextButton:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end
					
					return text_button
				end
				
				function category.new_textbox(text_input, placeholder_text, callback)
					local text_box = {}
					
					-- Creating UI
					local TextBox = Instance.new("Frame")
					local text = Instance.new("TextLabel")
					local input = Instance.new("TextBox")
					local UICorner = Instance.new("UICorner")
	
					TextBox.Name = "TextBox"
					TextBox.Parent = CategoryFrame
					TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.BackgroundTransparency = 1.000
					TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextBox.BorderSizePixel = 0
					TextBox.Position = UDim2.new(0, 0, 0.13333334, 0)
					TextBox.Size = UDim2.new(0, 170, 0, 20)
	
					text.Name = "text"
					text.Parent = TextBox
					text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					text.BackgroundTransparency = 1.000
					text.BorderColor3 = Color3.fromRGB(0, 0, 0)
					text.BorderSizePixel = 0
					text.Position = UDim2.new(0.0294117648, 0, 0, 0)
					text.Size = UDim2.new(0, 93, 0, 20)
					text.Font = Enum.Font.Gotham
					text.Text = text_input
					text.TextColor3 = Color3.fromRGB(255, 255, 255)
					text.TextSize = 12.000
					text.TextXAlignment = Enum.TextXAlignment.Left
	
					input.Name = "input"
					input.Parent = TextBox
					input.AnchorPoint = Vector2.new(0, 0.5)
					input.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
					input.BorderColor3 = Color3.fromRGB(0, 0, 0)
					input.BorderSizePixel = 0
					input.Position = UDim2.new(0.616176486, 0, 0.5, 0)
					input.Size = UDim2.new(0, 60, 0, 16)
					input.Font = Enum.Font.Gotham
					input.PlaceholderText = placeholder_text
					input.Text = ''
					input.TextColor3 = Color3.fromRGB(255, 255, 255)
					input.TextSize = 12.000
					input.TextWrapped = true
	
					UICorner.CornerRadius = UDim.new(0, 2)
					UICorner.Parent = input
					
					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)
					
					-- Functions
					input.Changed:Connect(function(property)
						if property == 'Text' then
							text_box.text = input.text
							callback()
						end
					end)
					
					function text_box:delete()
						TextBox:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end
	
					return text_box
				end
				
				return category
			end
			
			return group
		end

		return tab
	end

	
	
	
	return window
end

warn('ENCRYPT UI LIBRARY: LOADED')

function encrypt:exit()
	EncryptedName:Destroy()
	warn('ENCRYPT UI; CLOSED')
end

encrypt.ui_object = EncryptedName

return encrypt
