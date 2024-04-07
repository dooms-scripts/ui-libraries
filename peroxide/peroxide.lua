__=[[

                                  88""Yb 888888 88""Yb  dP"Yb  Yb  dP 88 8888b.  888888 
                                  88__dP 88__   88__dP dP   Yb  YbdP  88  8I  Yb 88__   
                                  88"""  88""   88"Yb  Yb   dP  dPYb  88  8I  dY 88""   
                                  88     888888 88  Yb  YbodP  dP  Yb 88 8888Y"  888888 

	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	::                                          UI LIBRARY MADE BY doom#1000                                      ::
	::                             HOW TO USE: dooms-scripts.gitbook.io/peroxide-docs                             ::
	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

]]

getgenv = getgenv or _G --assert(getgenv, 'Your executor is not supported.')

--# CONFIG #--------------------------
peroxide = {
	version = '1.0.0'; instance = nil; start_time = tick();

	threads = { 
		dropdowns = {}, keybinds = {},
		textbox = {}, toggles = {},
		buttons = {}, sliders = {},
	};

	custom_cursor = {
		enabled = false,
		icon = 'http://www.roblox.com/asset/?id=16710247795',
	};

	customization = {
		colors = {
			accent = Color3.fromRGB(255, 255, 255);
			background = Color3.fromRGB(15, 15, 15);
			foreground = Color3.fromRGB(17, 17, 17);
			categories = Color3.fromRGB(16, 16, 16);
		};

		font = {
			primary = 'Code';
			secondary = 'Code';
			stroke_transparency = 1;
		};

		drop_shadow = false;
		outlines = true;
	};
}

warn(string.format('[>] PEROXIDE: LOADING (%s)', peroxide.version))

--# ATTRIBUTES #----------------------
local tween_service = game:GetService('TweenService')
local input_service = game:GetService('UserInputService')
local run_service = game:GetService('RunService')
local players = game:GetService('Players')
local debris = game:GetService('Debris')

local tween_info = TweenInfo
local ease_style = Enum.EasingStyle
local ease_direction = Enum.EasingDirection

local plr = players.LocalPlayer
local mouse = plr:GetMouse()

--# FUNCTIONS #-----------------------
function peroxide.new(instance, properties)
	local i = Instance.new(instance)
	for p,v in pairs(properties) do
		local s, err = pcall(function()
			i[p] = v
		end)

		if err then
			warn(string.format('[>] PEROXIDE: PROBLEM CREATING INSTANCE %s : %s', tostring(instance), err))
		end
	end

	return i
end

function peroxide.tween(instance, info, property, value)
	tween_service:Create(instance, info, {[property] = value}):Play()
end

function peroxide.serial(length)
	local str = ''

	for i=1, length do
		str = str .. string.char(math.random(65, 122))
	end

	return str
end

--# CREATE UI #----------------------
peroxide.instance = peroxide.new("ScreenGui", {
	Name = 'ENCRYPT_' .. peroxide.serial(99),
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	IgnoreGuiInset = false,
	Parent = debris
})

local cursor = peroxide.new('ImageLabel', {
	Parent = peroxide.instance,
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1.000,
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderSizePixel = 0,
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.new(0, 25, 0, 25),
	Image = peroxide.custom_cursor.icon,
	Visible = false,
	ZIndex = 99999,
})

coroutine.wrap(function()
	run_service.Stepped:Connect(function()
		input_service.MouseIconEnabled = not peroxide.custom_cursor.enabled
		cursor.Visible = peroxide.custom_cursor.enabled

		cursor.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
	end)
end)()

local _, failed = pcall(function()
	peroxide.instance.Parent = game.CoreGui
end)

if failed then 
	warn('Your executor is not supported.') 
	peroxide.instance.Parent = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
end

--# MAKE WINDOW #--------------------
function peroxide.new_window(name, size)
	local window = { tab_count = 0 }
	name = name or 'peroxide // doom#1000'
	size = size or UDim2.new(0, 450, 0, 500)

	local window_frame = Instance.new("Frame")
	window_frame.Name = "Window"
	window_frame.Parent = peroxide.instance
	window_frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	window_frame.BorderColor3 = Color3.fromRGB(50, 50, 50)
	window_frame.BorderMode = 'Inset'
	window_frame.BorderSizePixel = 1
	window_frame.Position = UDim2.new(0.588466287, 0, 0.424580991, 0.5)
	window_frame.AnchorPoint = Vector2.new(0, 0.5)
	window_frame.Size = size
	window_frame.Visible = true
	window_frame.Active = true
	window_frame.Selectable = true
	window_frame.Draggable = true

	local line = Instance.new("Frame")
	line.Name = "[1] line"
	line.Parent = window_frame
	line.AnchorPoint = Vector2.new(0.5, 0)
	line.BackgroundColor3 = peroxide.customization.colors.accent
	line.BorderColor3 = Color3.fromRGB(0, 255, 0)
	line.BorderSizePixel = 0
	line.Position = UDim2.new(0.5, 0, 0, 0)
	line.Size = UDim2.new(1, 0, 0, 1)

	local title = Instance.new("TextLabel")
	title.Name = "[2] Title"
	title.Parent = window_frame
	title.AnchorPoint = Vector2.new(0.5, 0)
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0.25111112, 0, 0.0860000029, 0)
	title.Size = UDim2.new(1, 0, 0, 20)
	title.Font = Enum.Font[peroxide.customization.font.primary]
	title.Text = name
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 14.000

	local divider = Instance.new("Frame") 
	divider.Name = "divider"
	divider.Parent = title
	divider.AnchorPoint = Vector2.new(0.5, 0)
	divider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	divider.BorderSizePixel = 0
	divider.Position = UDim2.new(0.5, 0, 1.04999995, 0)
	divider.Size = UDim2.new(0.980000019, 0, 0, 1)

	local divider_2 = Instance.new("Frame")
	divider_2.Name = "divider"
	divider_2.Parent = title
	divider_2.AnchorPoint = Vector2.new(0.5, 0)
	divider_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	divider_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	divider_2.BorderSizePixel = 0
	divider_2.Position = UDim2.new(0.49999997, 0, 2.04999995, 0)
	divider_2.Size = UDim2.new(0.980000019, 0, 0, 1)

	local close_button = Instance.new("ImageButton")
	close_button.Parent = title
	close_button.AnchorPoint = Vector2.new(0, 0.5)
	close_button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	close_button.BackgroundTransparency = 1.000
	close_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
	close_button.BorderSizePixel = 0
	close_button.Position = UDim2.new(0.963, 0, 0.5, 0)
	close_button.Size = UDim2.new(0, 12, 0, 12)
	close_button.Image = "rbxassetid://13273265457"

	local tab_buttons = Instance.new("Frame")
	tab_buttons.Name = "[3] tab_buttons"
	tab_buttons.Parent = window_frame
	tab_buttons.AnchorPoint = Vector2.new(0.5, 0)
	tab_buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tab_buttons.BackgroundTransparency = 1.000
	tab_buttons.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tab_buttons.BorderSizePixel = 0
	tab_buttons.Position = UDim2.new(0.5, 0, 0.0379999988, 0)
	tab_buttons.Size = UDim2.new(1, 0, 0, 20)

	local list_layout = Instance.new("UIListLayout") 
	list_layout.Name = "list_layout"
	list_layout.Parent = tab_buttons
	list_layout.FillDirection = Enum.FillDirection.Horizontal
	list_layout.SortOrder = Enum.SortOrder.Name
	list_layout.VerticalAlignment = Enum.VerticalAlignment.Center

	local tabs = Instance.new("Frame")
	tabs.Name = "[4] tabs"
	tabs.Parent = window_frame
	tabs.AnchorPoint = Vector2.new(0.5, 1)
	tabs.BackgroundTransparency = 1.000
	tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tabs.BorderSizePixel = 0
	tabs.Position = UDim2.new(0.5, 0, 1, 0)
	tabs.Size = UDim2.new(1, 0, 0, 450)

	local padding = Instance.new("UIPadding")
	padding.Name = "padding"
	padding.Parent = tabs
	padding.PaddingLeft = UDim.new(0, 4)
	padding.PaddingRight = UDim.new(0, 4)
	padding.PaddingTop = UDim.new(0, 4)

	local list_layout_2 = Instance.new("UIListLayout")
	list_layout_2.Name = "list_layout_2"
	list_layout_2.Parent = window_frame
	list_layout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	list_layout_2.Padding = UDim.new(0, 2)

	local label = Instance.new("TextLabel")
	label.Name = "[5] label"
	label.Parent = window_frame
	label.AnchorPoint = Vector2.new(0.5, 0)
	label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1.000
	label.BorderColor3 = Color3.fromRGB(0, 0, 0)
	label.BorderSizePixel = 0
	label.Position = UDim2.new(0.5, 0, 0, 0)
	label.Size = UDim2.new(0.980000019, 0, 0, -20)
	label.Font = Enum.Font.Gotham
	label.Text = "v1.0.0"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 14.000
	label.TextStrokeTransparency = 0.500
	label.TextTransparency = 0.750
	label.TextXAlignment = Enum.TextXAlignment.Right

	local gradient = Instance.new("UIGradient")
	-- Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.76, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 180, 180))}
	gradient.Rotation = 90
	gradient.Name = "Gradient"
	gradient.Parent = window_frame

	local outline = Instance.new("UIStroke")
	outline.Parent = window_frame
	outline.Color = Color3.fromRGB(0, 0, 0)
	outline.Thickness = 1
	outline.Enabled = peroxide.customization.outlines

	close_button.MouseButton1Click:Connect(function() peroxide.instance:Destroy() end)

	function window.new_tab(tab_name)
		local tab = {}
		window.tab_count += 1

		local tab_frame = Instance.new("Frame")
		tab_frame.Parent = tabs
		tab_frame.AnchorPoint = Vector2.new(0.5, 0.5)
		tab_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tab_frame.BackgroundTransparency = 1.000
		tab_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tab_frame.BorderSizePixel = 0
		tab_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		tab_frame.Size = UDim2.new(1, 0, 1, 0)
		tab_frame.Visible = false

		local tab_button = Instance.new("TextButton")
		tab_button.Name = string.format("[%s] tab_button", window.tab_count)
		tab_button.Parent = tab_buttons
		tab_button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tab_button.BackgroundTransparency = 1.000
		tab_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tab_button.BorderSizePixel = 0
		tab_button.Size = UDim2.new(0, 10, 0, 15)
		tab_button.Font = Enum.Font[peroxide.customization.font.primary]
		tab_button.Text = tab_name
		tab_button.TextColor3 = Color3.fromRGB(255, 255, 255)
		tab_button.TextSize = 13.000
		tab_button.TextTransparency = 0.750

		tab_button.Size = UDim2.new(0, tab_button.TextBounds.X + 10, 1, 0)

		tab_button.MouseButton1Click:Connect(function()
			for _, frame in ipairs(tabs:GetChildren()) do 
				if frame:IsA('Frame') then 
					frame.Visible = false 
				end 
			end

			for _, button in ipairs(tab_buttons:GetChildren()) do 
				if button:IsA('TextButton') then 
					button.TextTransparency = 0.750 
				end 
			end

			tab_button.TextTransparency = 0
			tab_frame.Visible = true
		end)

		function tab.new_category(category_name)
			local category = {}
			
			local category_frame = Instance.new("Frame")
			local line = Instance.new("Frame")
			local title = Instance.new("TextLabel")
			local padding = Instance.new("UIPadding")
			local list_layout = Instance.new("UIListLayout")

			category_frame.Name = "category_frame"
			category_frame.Parent = tab_frame
			category_frame.AnchorPoint = Vector2.new(0, 0)
			category_frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
			category_frame.BorderColor3 = Color3.fromRGB(45, 45, 45)
			category_frame.BorderMode = 'Inset'
			category_frame.Position = UDim2.new(0, 0, 0, 0)
			category_frame.Size = UDim2.new(0.5, -3, 0, 27)
			
			local outline = Instance.new("UIStroke")
			outline.Parent = category_frame
			outline.ApplyStrokeMode = 'Border'
			outline.Color = Color3.fromRGB(0, 0, 0)
			outline.Thickness = 1
			outline.Enabled = peroxide.customization.outlines

			line.Name = "[1] line"
			line.Parent = title
			line.AnchorPoint = Vector2.new(0.5, 0)
			line.BackgroundColor3 = peroxide.customization.colors.accent
			line.BorderSizePixel = 0
			line.Position = UDim2.new(0.5, 0, 0, 0)
			line.Size = UDim2.new(1.068, 0, 0, 1)

			title.Name = "[2] title"
			title.Parent = category_frame
			title.AnchorPoint = Vector2.new(0.5, 0)
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0.5, 0, 0, 0)
			title.Size = UDim2.new(0.99, 0, 0, 20)
			title.Font = Enum.Font[peroxide.customization.font.primary]
			title.Text = category_name
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 14.000
			title.TextStrokeTransparency = 0.500
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.TextYAlignment = Enum.TextYAlignment.Bottom

			padding.Name = "padding"
			padding.Parent = category_frame
			padding.PaddingLeft = UDim.new(0, 6)
			padding.PaddingRight = UDim.new(0, 6)

			list_layout.Name = "list_layout"
			list_layout.Parent = category_frame
			list_layout.Padding = UDim.new(0, 4)
			list_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			list_layout.SortOrder = Enum.SortOrder.LayoutOrder
			
			function category.new_toggle(properties)
				local toggle, default = { value = false }, {
					text = 'toggle',
					tooltip = nil,
					callback = function() end,
				}
				
				local properties = properties or default
				local text = properties.text or default.text
				local tooltip = properties.tooltip or default.tooltip
				local callback = properties.callback or default.callback
				
				local toggle_frame = Instance.new("Frame")
				local toggle_button = Instance.new("TextButton")
				local toggle_label = Instance.new("TextLabel")

				toggle_frame.Name = "toggle_frame"
				toggle_frame.Parent = category_frame
				toggle_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggle_frame.BackgroundTransparency = 1.000
				toggle_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				toggle_frame.BorderSizePixel = 0
				toggle_frame.Size = UDim2.new(1, 0, 0, 17)

				toggle_button.Name = "toggle_button"
				toggle_button.Parent = toggle_frame
				toggle_button.AnchorPoint = Vector2.new(0, 0.5)
				toggle_button.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
				toggle_button.BorderColor3 = Color3.fromRGB(45, 45, 45)
				toggle_button.BorderMode = 'Inset'
				toggle_button.Position = UDim2.new(0, 0, 0.5, 0)
				toggle_button.Size = UDim2.new(0, 14, 0, 14)
				toggle_button.AutoButtonColor = false
				toggle_button.Font = Enum.Font[peroxide.customization.font.primary]
				toggle_button.Text = ""
				toggle_button.TextColor3 = Color3.fromRGB(255, 255, 255)
				toggle_button.TextSize = 12.000
				toggle_button.TextStrokeTransparency = 0.500

				toggle_label.Name = "label"
				toggle_label.Parent = toggle_frame
				toggle_label.AnchorPoint = Vector2.new(0.5, 0.5)
				toggle_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggle_label.BackgroundTransparency = 1.000
				toggle_label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				toggle_label.BorderSizePixel = 0
				toggle_label.Position = UDim2.new(0.439967245, 0, 0.5, 0)
				toggle_label.Size = UDim2.new(0.699999988, 0, 1, 0)
				toggle_label.Font = Enum.Font[peroxide.customization.font.primary]
				toggle_label.Text = text
				toggle_label.TextColor3 = Color3.fromRGB(255, 255, 255)
				toggle_label.TextSize = 13.000
				toggle_label.TextXAlignment = Enum.TextXAlignment.Left
				toggle_label.TextStrokeTransparency = peroxide.customization.font.outline_amount

				local outline = Instance.new("UIStroke")
				outline.Parent = toggle_button
				outline.ApplyStrokeMode = 'Border'
				outline.Color = Color3.fromRGB(0, 0, 0)
				outline.Thickness = 1
				outline.Enabled = peroxide.customization.outlines
				
				function toggle:add_keybind(properties)
					local keybind, default = {}, {
						default_key = nil,
						callback = function() end,
					}
					
					local properties = properties or default
					local default_key = properties.default_key or default.default_key
					local callback = properties.callback or default.callback
					local editing_key = false
					
					keybind.key = default_key
					
					local keybind_button = Instance.new("TextButton")
					keybind_button.Name = "TextButton57"
					keybind_button.Parent = toggle_frame
					keybind_button.AnchorPoint = Vector2.new(1, 0.5)
					keybind_button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					keybind_button.BackgroundTransparency = 1.000
					keybind_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
					keybind_button.Position = UDim2.new(0.999999702, 0, 0.5, 0)
					keybind_button.Size = UDim2.new(0, 45, 0, 14)
					keybind_button.Font = Enum.Font[peroxide.customization.font.primary]
					keybind_button.Text = "[...]"
					keybind_button.TextColor3 = Color3.fromRGB(125, 125, 125)
					keybind_button.TextSize = 11.000
					keybind_button.TextStrokeTransparency = peroxide.customization.font.outline_amount
					keybind_button.TextXAlignment = Enum.TextXAlignment.Right
					
					if keybind.key ~= nil then keybind_button.Text = string.format("[%s]", keybind.key) end
					
					keybind_button.MouseButton1Click:Connect(function()
						editing_key = true
						keybind_button.TextColor3 = peroxide.customization.colors.accent
					end)
					
					local input = game:GetService('UserInputService')
					input.InputBegan:Connect(function(key)
						if editing_key and key.KeyCode ~= Enum.KeyCode.LeftSuper and key.KeyCode ~= Enum.KeyCode.RightSuper then 
							if key.KeyCode == Enum.KeyCode.Backspace then
									keybind.key = nil
									keybind_button.TextColor3 = Color3.fromRGB(125, 125, 125)
									keybind_button.Text = "[...]"
									editing_key = false
								return
							end
							
							keybind.key = tostring(key.KeyCode):gsub('Enum.KeyCode.', '')
							keybind_button.TextColor3 = Color3.fromRGB(125, 125, 125)
							keybind_button.Text = string.format("[%s]", keybind.key)
							editing_key = false
							return
						end
						
						if keybind.key == nil then 
							return 
						end
						
						if key.KeyCode == Enum.KeyCode[keybind.key] then
							callback(toggle.value)
						end
					end)
					
					return keybind
				end
				
				function toggle:add_colorpicker(properties)
					local color_picker, default = {}, {
						default_color = nil,
						callback = function() end,
					}
					
					local properties = properties or default
					local default_color = properties.default_color or default.default_color
					local callback = properties.callback or default.callback
					
					local color_picker_button = Instance.new("TextButton")
					local gradient = Instance.new("UIGradient")

					color_picker_button.Name = "TextButton55"
					color_picker_button.Parent = toggle_frame
					color_picker_button.AnchorPoint = Vector2.new(1, 0.5)
					color_picker_button.BackgroundColor3 = Color3.fromRGB(69, 69, 69)
					color_picker_button.BorderColor3 = Color3.fromRGB(45, 45, 45)
					color_picker_button.BorderSizePixel = 1
					color_picker_button.BorderMode = 'Inset'
					color_picker_button.Position = UDim2.new(1, 0, 0.5, 0)
					color_picker_button.Size = UDim2.new(0, 30, 0, 14)
					color_picker_button.Font = Enum.Font.Code
					color_picker_button.Text = ""
					color_picker_button.TextColor3 = Color3.fromRGB(255, 255, 255)
					color_picker_button.TextSize = 12.000
					color_picker_button.TextStrokeTransparency = 0.500

					gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(147, 147, 147))}
					gradient.Rotation = 90
					gradient.Name = "UIGradient43"
					gradient.Parent = color_picker_button
					
					local outline = Instance.new("UIStroke")
					outline.Parent = color_picker_button
					outline.ApplyStrokeMode = 'Border'
					outline.Color = Color3.fromRGB(0,0, 0)
					outline.Thickness = 1
					outline.Enabled = peroxide.customization.outlines
				end
				
				toggle_button.MouseButton1Click:Connect(function()
					toggle.value = not toggle.value

					if toggle.value then toggle_button.BackgroundColor3 = peroxide.customization.colors.accent end
					if not toggle.value then toggle_button.BackgroundColor3 = Color3.fromRGB(17, 17, 17) end
					
					callback(toggle.value)
				end)
				
				toggle_button.MouseEnter:Connect(function()
					toggle_button.BorderColor3 = peroxide.customization.colors.accent
				end)
				
				toggle_button.MouseLeave:Connect(function()
					if not toggle.value then
						toggle_button.BorderColor3 = Color3.fromRGB(45, 45, 45)
					end
				end)
				
				category_frame.Size += UDim2.new(0, 0, 0, 21)
				
				return toggle
			end
			
			function category.new_button(properties)
				local button, default = {}, {
					text = 'button',
					tooltip = nil,
					callback = function() end,
				}
				
				local properties = properties or default
				local text = properties.text or default.text
				local tooltip = properties.tooltip or default.tooltip
				local callback = properties.callback or default.callback
				
				local text_button = Instance.new("TextButton")
				text_button.Name = "button"
				text_button.Parent = category_frame
				text_button.AnchorPoint = Vector2.new(0.5, 0)
				text_button.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
				text_button.BorderColor3 = Color3.fromRGB(45, 45, 45)
				text_button.BorderMode = 'Inset'
				text_button.Position = UDim2.new(0.5, 0, 0.252000004, 0)
				text_button.Size = UDim2.new(1, 0, 0, 16)
				text_button.AutoButtonColor = true
				text_button.Font = Enum.Font[peroxide.customization.font.primary]
				text_button.Text = "button"
				text_button.TextColor3 = Color3.fromRGB(255, 255, 255)
				text_button.TextSize = 12.000
				text_button.TextStrokeTransparency = peroxide.customization.font.outline_amount

				local outline = Instance.new("UIStroke")
				outline.Parent = text_button
				outline.ApplyStrokeMode = 'Border'
				outline.Color = Color3.fromRGB(0, 0, 0)
				outline.Thickness = 1
				outline.Enabled = peroxide.customization.outlines
				
				text_button.MouseButton1Click:Connect(callback)

				category_frame.Size += UDim2.new(0, 0, 0, 21)
				
				return button
			end
			
			function category.new_label(properties)
				local label, default = {}, {
					text = 'text label',
					tooltip = nil,
				}
				
				local properties = properties or default
				local text = properties.text or default.text
				local tooltip = properties.tooltip or default.tooltip
				
				local text_label = Instance.new("TextLabel")
				text_label.Name = "TextLabel43"
				text_label.Parent = category_frame
				text_label.AnchorPoint = Vector2.new(0.5, 0)
				text_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				text_label.BackgroundTransparency = 1.000
				text_label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				text_label.BorderSizePixel = 0
				text_label.Position = UDim2.new(0.50000006, 0, 0.625499904, 0)
				text_label.Size = UDim2.new(1, 0, 0, 15)
				text_label.Font = Enum.Font[peroxide.customization.font.primary]
				text_label.Text = text
				text_label.TextColor3 = Color3.fromRGB(255, 255, 255)
				text_label.TextSize = 13.000
				text_label.TextStrokeTransparency = peroxide.customization.font.outline_amount
				text_label.TextXAlignment = Enum.TextXAlignment.Left
				
				function label.alignment(alignment_type)
					text_label.TextXAlignment = Enum.TextXAlignment[alignment_type]
				end

				category_frame.Size += UDim2.new(0, 0, 0, 17)
				
				return label 
			end
			
			return category
		end

		return tab
	end

	window_frame.MouseEnter:Connect(function() peroxide.custom_cursor.enabled = true end)
	window_frame.MouseLeave:Connect(function() peroxide.custom_cursor.enabled = false end)

	return window
end

--# INITIALIE LIBRARY #--------------
_G.PEROXIDE_LOADED = true
_G.PEROXIDE_INSTANCE = peroxide.instance
_G.PEROXIDE_ONLOAD = _G.PEROXIDE_ONLOAD or function() warn(string.format('PEROXIDE: LOADED IN %s SECONDS', tostring(tick() - peroxide.start_time):sub(1,4))) end

_G.PEROXIDE_ONLOAD()

return peroxide
