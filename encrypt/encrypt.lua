--[[

	    ###########  #####       #####  ##########  ##############  #####  #####  ##############  ################
	   #####        ########    #####  #####       #####    #####  #####  #####  #####    #####        #####      
	  ###########  #####  ###  #####  #####       ############    ############  ##############        #####       
	 #####        #####    ########  #####       #####    #####         #####  #####                 #####        
	###########  #####       #####  ##########  #####    #####  ############  #####                 #####         

	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ui library
	# doom#1000

]]--

--> CONFIG <------------------------------------------------
local encrypt = {
	version = 'e1.4.8',
	font = 'Gotham',
	ui_object = nil,

	threads = { 
		dropdowns = {},
		keybinds = {},
		textbox = {},
		toggles = {},
		buttons = {},
		sliders = {},
	},

	colors = {
		main_color = Color3.fromRGB(255, 255, 255),
		foreground = Color3.fromRGB(23, 23, 23),
		background = Color3.fromRGB(10, 10, 10),
		categories = Color3.fromRGB(10, 10, 10),
		topbar = Color3.fromRGB(10, 10, 10),
	},
}

warn(string.format('[🔃] ENCRYPT (%s): LOADING', encrypt.version))

--> SERVICES & ATTRIBUTES <---------------------------------
local tween_service = game:GetService('TweenService')
local input_service = game:GetService('UserInputService')
local tween_info = TweenInfo
local easing_style = Enum.EasingStyle
local easing_direction = Enum.EasingDirection

--> FUNCTIONS <---------------------------------------------
function encrypt.create(instance, properties)
	local i = Instance.new(instance)
	for p,v in pairs(properties) do
		local s, err = pcall(function()
			i[p] = v
		end)

		if err then warn('[⚠️] ENCRYPT > PROBLEM CREATING INSTANCE "'..tostring(instance)..'": '..err) end
	end

	return i
end

function encrypt.tween(instance, info, property, value)
	tween_service:Create(instance, info, {[property] = value}):Play()
end

--> CONFIG <------------------------------------------------
local EncryptedName = encrypt.create("ScreenGui", {
	Name = tostring('doom_'..math.random(10000000000,99999999999)), 
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
})

encrypt.ui_object = EncryptedName

local _,err = pcall(function() EncryptedName.Parent = game.CoreGui end)
if err then  warn('[⚠️] ENCRYPT > LIBRARY ERROR: ' ..tostring(err)) end

--> CREATE UI <---------------------------------------------
function encrypt.new_window(options)
	local default = {
		title_text = 'encrypt // '..encrypt.version,
		size = UDim2.new(0, 380, 0, 425),
	}

	local options = options or default
	local title_text = options.title_text or default.title_text
	local size = options.size or default.size

	local window = {}

	-- Creating UI
	local WindowFrame = encrypt.create('Frame', {
		Name = "WindowFrame",
		Parent = EncryptedName,
		BackgroundColor3 = encrypt.colors.background,
		BorderColor3 = Color3.fromRGB(35, 35, 35),
		Position = UDim2.new(0.711538434, 0, 0.436090231, 0),
		Size = size,
		Active = true,
		Selectable = true,
		Draggable = true,
	})

	local Topbar = encrypt.create('Frame', {
		Name = "1Topbar1",
		Parent = WindowFrame,
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = encrypt.colors.topbar,
		BackgroundTransparency = 0,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0, 0),
		Size = UDim2.new(1, 0, 0, 25),
	})

	local Tabs = encrypt.create("Frame", {
		Name = "Tabs",
		Parent = WindowFrame,
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 1, 0),
		Size = UDim2.new(1, 0, 1, -25),
	})

	local ButtonHolder = encrypt.create('Frame', {
		Name = "ButtonHolder",
		Parent = Topbar,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0, 
		Size = UDim2.new(1, 0, 1, 0)
	})

	local Divider = encrypt.create('Frame', {
		Name = "Divider",
		Parent = Topbar,
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 1),
	})

	local TitleText = encrypt.create('TextLabel', {
		Name = "TitleText",
		Parent = ButtonHolder,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 111, 0, 25),
		Font = Enum.Font.Gotham,
		Text = "  "..tostring(title_text),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 12.000,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	encrypt.create('ImageLabel', {
		Parent = WindowFrame,
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = encrypt.colors.background,
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.99, 0),
		Size = UDim2.new(1, 0, 0, 25),
		Image = "rbxassetid://277037193",
		ImageColor3 = Color3.fromRGB(10, 10, 10),
		ZIndex = 99,
	})

	encrypt.create('UIListLayout', {
		Parent = ButtonHolder,
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	encrypt.create('UIPadding', {
		Parent = Tabs,
		PaddingBottom = UDim.new(0, 7),
		PaddingRight = UDim.new(0, 7),
		PaddingLeft = UDim.new(0, 7),
		PaddingTop = UDim.new(0, 7),
	})

	TitleText.Size = UDim2.new(0, TitleText.TextBounds.X + 10, 1, 0)

	-- Functions
	function window.new_tab(tab_name)
		local tab = {}

		local TabFrame = encrypt.create('Frame', {
			Name = tab_name,
			Parent = Tabs,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Visible = false,
			Size = UDim2.new(1, 0, 1, 0),
		})

		local TabButton = encrypt.create('TextButton', {
			Parent = ButtonHolder,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0.293650806, 0, 0, 0),
			Size = UDim2.new(0.213506043, 0, 1, 0),
			Font = Enum.Font.Gotham,
			Text = tab_name,
			TextColor3 = Color3.fromRGB(100, 100, 100),
			TextSize = 12.000,
			TextWrapped = true,
		})

		local UIListLayout = encrypt.create('UIListLayout', {
			Parent = TabFrame,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		})

		TabButton.Size = UDim2.new(0, TabButton.TextBounds.X + 10, 1, 0)
		TabButton.MouseButton1Click:Connect(function()
			for _,t in ipairs(Tabs:GetChildren()) do
				if t:IsA('Frame') then t.Visible = false end
				Tabs[tab_name].Visible = true
			end
			for _,b in ipairs(ButtonHolder:GetChildren()) do
				if b:IsA('TextButton') then b.TextColor3 = Color3.fromRGB(100, 100, 100) end
				TabButton.TextColor3 = encrypt.colors.main_color
			end
		end)

		function tab.new_group(group_name)
			local group = {}

			-- Creating UI
			local ContentHolder = encrypt.create('ScrollingFrame', {
				Parent = TabFrame,
				Name = group_name,
				Size = UDim2.new(0.5, -4, 1, 0),
				Position = UDim2.new(0, 0, 0, 0),
				CanvasSize = UDim2.new(0, 0, 0, 0),
				Active = true,
				ScrollBarThickness = 4,
				BorderSizePixel = 0,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundColor3 = Color3.fromRGB(15, 15, 15),
				ScrollBarImageColor3 = encrypt.color,
				BackgroundTransparency = 1.000,
				TopImage = "http://www.roblox.com/asset/?id=16747999837",
				BottomImage = "http://www.roblox.com/asset/?id=16748002234",
				MidImage = "rbxassetid://1510273450",
			})

			encrypt.create('UIListLayout', {
				Parent = ContentHolder, 
				SortOrder = Enum.SortOrder.Name, 
				Padding = UDim.new(0, 4)
			})

			encrypt.create('UIPadding', {
				Parent = ContentHolder,
				PaddingRight = UDim.new(0, 8)
			})

			-- Functions
			group.categoryCount = 0

			function group.new_category(title_text)
				local category = {}

				group.categoryCount += 1
				category.label_count = 0
				category.button_count = 0
				category.toggle_count = 0
				category.slider_count = 0
				category.keybind_count = 0
				category.textbox_count = 0
				category.dropdown_count = 0

				-- Creating UI
				local CategoryFrame = encrypt.create('Frame', {
					Parent = ContentHolder,
					Name = tostring(group.categoryCount) .."CategoryFrame" ..tostring(group.categoryCount),
					BackgroundColor3 = encrypt.colors.categories,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 44),
				})

				local TitleText = encrypt.create('TextLabel', {
					Name = "TitleText",
					Parent = CategoryFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0411764719, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 20),
					Font = Enum.Font.GothamMedium,
					Text = tostring(title_text),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14.000,
				})

				encrypt.create('UICorner', {
					CornerRadius = UDim.new(0, 4),
					Parent = CategoryFrame,
				})

				encrypt.create('UIListLayout', {
					Parent = CategoryFrame,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})
				
				encrypt.create('UIPadding', {
					Parent = CategoryFrame,
					PaddingLeft = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
				})

				ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 28)

				-- Functions
				function category.new_label(options)
					category.label_count += 1

					local default = {
						text = 'label'
					}

					local options = options or default
					local text = options.text or default.text

					local text_label = {}

					--> Creating UI
					local container = encrypt.create('Frame', {
						Name = "Label",
						Parent = CategoryFrame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.13333334, 0),
						Size = UDim2.new(0, 170, 0, 20),
					})

					local label = encrypt.create('TextLabel', {
						Name = "TextLabel",
						Parent = container,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0.0294117648, 0, 0, 0),
						Size = UDim2.new(1, 0, 0, 20),
						Font = Enum.Font.Gotham,
						Text = text,
						TextColor3 = encrypt.colors.main_color,
						TextSize = 12.000,
						TextXAlignment = Enum.TextXAlignment.Left,
						RichText = true,
					})

					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)

					--> Functions
					function text_label.update_text(new_text)
						label.Text = new_text
					end

					function text_label.alignment(option)
						local first_character = string.upper(option:sub(1,1))
						local rest = string.lower(option:sub(2,99))
						label.TextXAlignment = Enum.TextXAlignment[first_character .. rest]
					end

					function text_label:get_text()
						return label.Text
					end

					function text_label:delete() 
						container:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					return text_label
				end

				function category.new_toggle(options)
					category.toggle_count += 1

					local default = {
						text = 'toggle',
						yield = false,
						callback = function()
							warn(string.format('[❗] Toggle %d > no callback set.', category.toggle_count))
						end,
					}

					local options    = options or default
					local text       = options.text or default.text
					local yield      = options.yield or default.yield
					local callback   = options.callback or default.callback

					local toggle = { value = false }

					-- Creating UI
					local container = encrypt.create('Frame', {
						Name = "Toggle",
						Parent = CategoryFrame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.13333334, 0),
						Size = UDim2.new(1, 0, 0, 20),
					})

					local label = encrypt.create('TextLabel', {
						Name = "text",
						Parent = container,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, 0, 0.5, 0),
						Size = UDim2.new(1, 0, 0, 20),
						Font = Enum.Font.Gotham,
						Text = text,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					local button = encrypt.create('TextButton', {
						Name = "button",
						Parent = container,
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = encrypt.colors.foreground,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(1, 0, 0.5, 0),
						Size = UDim2.new(0, 16, 0, 16),
						AutoButtonColor = false,
						Font = Enum.Font.SourceSans,
						Text = "",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 14.000,
					})

					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = button,
					})

					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)

					-- Functions
					local call = nil
					
					encrypt.threads.toggles[category.toggle_count] = button.MouseButton1Click:Connect(function()
						if yield then
							toggle.value = true
							encrypt.tween(button, tween_info.new(.15), 'BackgroundColor3', encrypt.colors.main_color)
							call = coroutine.create(function()
								callback(toggle.value)
							end)
							
							coroutine.resume(call)
						
							encrypt.tween(button, tween_info.new(.15), 'BackgroundColor3', encrypt.colors.foreground)
							toggle.value = false
						elseif not yield then
							--encrypt.threads.toggles[category.toggle_count] = task.spawn(function()
								toggle.value = not toggle.value
								if toggle.value then encrypt.tween(button, tween_info.new(.15), 'BackgroundColor3', encrypt.colors.main_color)
								callback(toggle.value)
							elseif not toggle.value then 
								encrypt.tween(button, tween_info.new(.15), 'BackgroundColor3', encrypt.colors.foreground)
								callback(toggle.value)
							end
						end
					end)

					function toggle:get_value()
						return toggle.value
					end

					function toggle:update_value(bool)
						toggle.value = bool
						if toggle.value then
							tween_service:Create(button, tween_info.new(.15), { BackgroundColor3 = encrypt.colors.main_color }):Play()
						elseif not toggle.value then 
							tween_service:Create(button, tween_info.new(.15), { BackgroundColor3 = encrypt.colors.foreground }):Play()
						end
					end

					function toggle:delete()
						container:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					return toggle
				end

				function category.new_button(options)
					category.button_count += 1

					local default = {
						text = 'button',
						callback = function()
							warn(string.format('[❗] Button %d > no callback set.', category.button_count))
						end,
					}

					local options = options or default
					local text		 = options.text or default.text
					local callback	 = options.callback or default.callback

					local text_button = {}

					-- Creating UI
					local container = encrypt.create('Frame', {
						Name = "TextButton",
						Parent = CategoryFrame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.13333334, 0),
						Size = UDim2.new(1, 0, 0, 20),
					})

					local button = encrypt.create('TextButton', {
						Name = "button",
						Parent = container,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = encrypt.colors.foreground,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.5, 0),
						Size = UDim2.new(1, 0, 0, 16),
						AutoButtonColor = true,
						Font = Enum.Font.Gotham,
						Text = text,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12.000,
					})

					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = button,
					})

					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)

					-- Functions
					button.MouseButton1Click:Connect(callback)

					function text_button:delete()
						container:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					return text_button
				end

				function category.new_textbox(options)
					category.textbox_count += 1

					local default = {
						text = 'button',
						placeholder_text = '...',
						callback = function()
							warn(string.format('[❗] Textbox %d > no callback set.', category.textbox_count))
						end,
					}

					local options		   = options or default
					local text	           = options.text
					local placeholder_text     = options.placeholder_text or default.placeholder_text
					local callback		   = options.callback or default.callback

					local text_box = { text = text }

					local container = encrypt.create('Frame', {
						Name = "TextBox",
						Parent = CategoryFrame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.13333334, 0),
						Size = UDim2.new(1, 0, 0, 20),
					})

					local label = encrypt.create('TextLabel', {
						Name = "text",
						Parent = container,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(0, 93, 0, 20),
						Font = Enum.Font.Gotham,
						Text = text,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					local textbox = encrypt.create('TextBox', {
						Name = "input",
						Parent = container,
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = encrypt.colors.foreground,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(1, 0, 0.5, 0),
						Size = UDim2.new(0, 60, 0, 16),
						Font = Enum.Font.Gotham,
						PlaceholderText = placeholder_text,
						Text = '',
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12.000,
						TextWrapped = true,
					})

					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = textbox,
					})

					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)

					-- Functions
					textbox.FocusLost:Connect(function()
						text_box.text = textbox.Text
						callback(textbox.Text)
					end)

					function text_box:delete()
						container:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					return text_box
				end

				function category.new_keybind(options)
					category.keybind_count += 1

					local default = {
						text = 'keybind',
						keybind = '...',
						callback = function()
							warn(string.format('[❗] Keybind %d > no callback set.', category.keybind_count))
						end,
					}
					

					local options  = options or default
					local text	   = options.text or default.text
					local key	   = options.keybind or default.keybind
					local callback = options.callback or default.callback

					local keybind = { text = text, key = key, editing = false }

					local container = encrypt.create('Frame', {
						Name = "keybind",
						Parent = CategoryFrame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.13333334, 0),
						Size = UDim2.new(1, 0, 0, 20),
					})

					local label = encrypt.create('TextLabel', {
						Name = "text",
						Parent = container,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(0, 140, 0, 20),
						Font = Enum.Font.Gotham,
						Text = text,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					local button = encrypt.create('TextButton', {
						Name = "button",
						Parent = container,
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = encrypt.colors.foreground,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(1, 0, 0.5, 0),
						Size = UDim2.new(0, 16, 0,16),
						ZIndex = 2,
						AutoButtonColor = false,
						Font = Enum.Font.SourceSans,
						Text = key,
						TextColor3 = Color3.fromRGB(150, 150, 150),
						TextSize = 15.000,
						TextWrapped = true,
					})

					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = button,
					})

					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)

					--> Functions
					button.MouseButton1Click:Connect(function()
						keybind.editing = true
						button.Text = '...'
						print('editing...')
					end)
					
					local thread = nil
					coroutine.wrap(function()	
						encrypt.threads.keybinds[category.keybind_count] = input_service.InputBegan:Connect(function(input)
							local focused = input_service:GetFocusedTextBox()
							if focused then return end

							if keybind.editing then
								keybind.key = tostring(input.KeyCode):gsub('Enum.KeyCode.', '')
								button.Text = keybind.key

								keybind.editing = false
							elseif keybind.key ~= '...' and input.KeyCode == Enum.KeyCode[string.upper(keybind.key)] then
								callback()
							end
						end)
					end)()

					function keybind:get_value()
						return keybind.key
					end

					function keybind:delete()
						container:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end
					
					function keybind:close_thread()
						thread:Disconnect()
					end

					return keybind
				end

				function category.new_slider(options)
					category.slider_count += 1
					local default = {
						text = 'slider',
						default_value = 0,
						min_value = 1,
						max_value = 100,
						allow_decimals = false,
						callback = function()
							warn(string.format('[❗] Slider %d > no callback set.', category.slider_count))
						end,
					}

					local options		 = options or default
					local text			 = options.text or default.text
					local default_value	 = options.default_value or default.default_value
					local min_value		 = options.min_value or default.min_value
					local max_value		 = options.max_value or default.max_value
					local allow_decimals = options.allow_decimals or default.allow_decimals
					local callback		 = options.callback or default.callback

					local slider = { value = default_value }

					local container = encrypt.create('Frame', {
						Name = "slider",
						Parent = CategoryFrame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.13333334, 0),
						Size = UDim2.new(1, 0, 0, 20),
					})

					local button = encrypt.create('TextButton', {
						Name = "button",
						Parent = container,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = encrypt.colors.foreground,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.5, 0),
						Size = UDim2.new(1, 0, 0, 16),
						AutoButtonColor = false,
						Font = Enum.Font.Gotham,
						Text = "",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12.000,
					})

					local fill = encrypt.create('Frame', {
						Name = "fill",
						Parent = button,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 0.750,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Size = UDim2.new(0, 0, 1, 0),
						ZIndex = 2,
					})

					local label = encrypt.create('TextLabel', {
						Name = "label",
						Parent = button,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.5, 0),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 3,
						Font = Enum.Font.Gotham,
						Text = text,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 11.000,
						TextStrokeTransparency = 0.500,
						TextWrapped = true,
					})

					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = button,
					})

					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = fill,
					})

					--encrypt.create('UIPadding', {
					--	PaddingLeft = UDim.new(0, 5),
					--	PaddingRight = UDim.new(0, 5),
					--	Parent = container
					--})
					
					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)

					--> Values
					local min = min_value
					local max = max_value
					slider.value = default_value

					--> Variables
					local plr = game.Players.LocalPlayer
					local mouse = plr:GetMouse()

					local fill = button.fill
					fill.Size = UDim2.new((slider.value - min) / (max - min), 0, 1, 0)

					local text = 'slider'
					local label = button.label

					local mouse_down = false
					local mouse_on = false

					--> Connections
					button.MouseButton1Up:Connect(function() mouse_down = false label.Text = text end)
					button.MouseEnter:Connect(function() mouse_on = true end)
					button.MouseLeave:Connect(function() mouse_on = false end)

					button.MouseButton1Down:Connect(function()
						mouse_down = true
						encrypt.tween(fill, tween_info.new(.25, easing_style.Linear, easing_direction.InOut), 'BackgroundTransparency', 0)
						local mouse_x = math.clamp(mouse.X - button.AbsolutePosition.X, min, button.AbsoluteSize.X)
						if allow_decimals then
							slider.value = (math.clamp((mouse_x / button.AbsoluteSize.X) * (max - min) + min, min, max))
						elseif not allow_decimals then
							slider.value = math.floor(math.clamp((mouse_x / button.AbsoluteSize.X) * (max - min) + min, min, max))
						end

						-- tween(fill, ti.new(.25, es.Quad, easing_direction.InOut), 'Size', UDim2.new((slider.value - min) / (max - min), 0, 1, 0))
						fill.Size = UDim2.new((slider.value - min) / (max - min), 0, 1, 0)
						label.Text = tostring(slider.value):sub(1,4)
						local s, err = pcall(function()
							callback(slider.value)
						end)

						if err then warn('err') end
					end)

					mouse.Move:Connect(function()
						if mouse_down then	
							local mouse_x = math.clamp(mouse.X - button.AbsolutePosition.X, min, button.AbsoluteSize.X)
							if allow_decimals then
								slider.value = (math.clamp((mouse_x / button.AbsoluteSize.X) * (max - min) + min, min, max))
							elseif not allow_decimals then
								slider.value = math.floor(math.clamp((mouse_x / button.AbsoluteSize.X) * (max - min) + min, min, max))
							end

							-- tween(fill, ti.new(.25, es.Quad, easing_direction.InOut), 'Size', UDim2.new((slider.value - min) / (max - min), 0, 1, 0))
							fill.Size = UDim2.new((slider.value - min) / (max - min), 0, 1, 0)
							label.Text = tostring(slider.value):sub(1,4)
							local s, err = pcall(function()
								callback(slider.value)
							end)

							if err then warn('err') end
						end
					end)

					input_service.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							mouse_down = false
							label.Text = text
							encrypt.tween(fill, tween_info.new(.25, easing_style.Linear, easing_direction.InOut), 'BackgroundTransparency', .75)
						end
					end)

					function slider:delete()
						container:destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					return slider
				end
				
				function category.new_dropdown(properties)
					category.dropdown_count += 1
					local default = {
						text = 'dropdown',
						options = {},
						default_selection = nil,
						callback = function()
							warn(string.format('[❗] Toggle %d > no callback set.', category.dropdown_count))
						end,
					}

					local showing_options = false
					local properties = properties or default 
					local options = properties.options or default.options
					local callback = properties.callback or default.callback
					local selection = properties.default_selection or default.default_selection
					local text = properties.text or default.text
					local dropdown = { selection = selection, options = {} }

					function encrypt.create(instance, properties)
						local i = Instance.new(instance)
						for p,v in pairs(properties) do
							local s, err = pcall(function()
								i[p] = v
							end)

							if err then warn('[⚠️] ENCRYPT > PROBLEM CREATING INSTANCE "'..tostring(instance)..'": '..err) end
						end

						return i
					end

					local container = encrypt.create('Frame', {
						Name = "dropdown",
						Parent = CategoryFrame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.13333334, 0),
						Size = UDim2.new(1, 0, 0, 20),
					})

					local button = encrypt.create('TextButton', {
						Name = "1button",
						Parent = container,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(23, 23, 23),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0, 0),
						Size = UDim2.new(1, 0, 0, 16),
						Font = Enum.Font.Gotham,
						Text = text,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12.000,
					})

					local arrow = encrypt.create('ImageLabel', {
						Parent = button,
						AnchorPoint = Vector2.new(1, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(1, 0, 0.125, 0),
						Size = UDim2.new(0, 20, 0, 12),
						Image = "rbxassetid://13273265041",
						ScaleType = Enum.ScaleType.Fit,
					})

					local options_frame = encrypt.create('Frame', {
						Parent = container,
						BackgroundColor3 = Color3.fromRGB(23, 23, 23),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 0, 0),
						Visible = false,
					})

					encrypt.create('UIListLayout', {
						Parent = container,
						SortOrder = Enum.SortOrder.Name,
					})

					encrypt.create('UIPadding', {
						PaddingTop = UDim.new(0, 2),
						PaddingBottom = UDim.new(0, 2),
						Parent = container,
					})


					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = button,
					})

					encrypt.create('UICorner', {
						CornerRadius = UDim.new(0, 2),
						Parent = options_frame,
					})

					encrypt.create('UIListLayout', {
						Parent = options_frame,
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					CategoryFrame.Size += UDim2.new(0, 0, 0, 20)
					ContentHolder.CanvasSize += UDim2.new(0, 0, 0, 20)

					button.MouseButton1Click:Connect(function()
						showing_options = not showing_options
						options_frame.Visible = showing_options

						if showing_options then
							container.Size += UDim2.new(0, 0, 0, options_frame.Size.Y.Offset)
							CategoryFrame.Size += UDim2.new(0, 0, 0, options_frame.Size.Y.Offset)
							ContentHolder.CanvasSize += UDim2.new(0, 0, 0, options_frame.Size.Y.Offset)
							
							arrow.Rotation = 180
						elseif not showing_options then
							container.Size -= UDim2.new(0, 0, 0, options_frame.Size.Y.Offset)
							CategoryFrame.Size -= UDim2.new(0, 0, 0, options_frame.Size.Y.Offset)
							ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, options_frame.Size.Y.Offset)

							arrow.Rotation = 0	
						end
					end)

					function dropdown.add_option(option)
						table.insert(dropdown.options, option)

						local option_button = encrypt.create('TextButton', {
							Parent = options_frame,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1.000,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 0, 20),
							Font = Enum.Font.Gotham,
							Name = option,
							Text = option,
							TextColor3 = Color3.fromRGB(125, 125, 125),
							TextSize = 12.000,
						})
						
						if option == dropdown.selection then
							option_button.BackgroundTransparency = .95
							option_button.TextColor3 = Color3.fromRGB(125, 125, 125)
						end
						
						option_button.MouseButton1Click:Connect(function()
							for _, b in ipairs(options_frame:GetChildren()) do
								if b:IsA('TextButton') then
									b.TextColor3 = Color3.fromRGB(125, 125, 125)
									b.BackgroundTransparency = 1
								end
							end
							
							option_button.TextColor3 = Color3.fromRGB(255, 255, 255)
							option_button.BackgroundTransparency = .95
							dropdown.selection = option
							
							callback(dropdown.selection)
						end)

						options_frame.Size += UDim2.new(0, 0, 0, 20)
					end

					function dropdown.remove_option(option)
						if not table.find(option) then return warn("[⚠️] ENCRYPT > Could not remove option because it doesn't exist") end

						table.remove(dropdown.options, option)
						options_frame[option]:Destroy()

						options_frame.Size -= UDim2.new(0, 0, 0, 20)
					end
					
					function dropdown:get_selection()
						return dropdown.selection
					end

					function dropdown:delete()
						container:Destroy()
						CategoryFrame.Size -= UDim2.new(0, 0, 0, 20)
						ContentHolder.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					return dropdown
				end
				
				return category
			end

			return group
		end

		return tab
	end

	return window
end

function encrypt:exit()
	EncryptedName:Destroy()

	for _, thread_table in pairs(encrypt.threads) do
		for _n, thread in pairs(thread_table) do
			pcall(function()
				task.cancel(thread_table[_n])
				print('Closed thread: '.. thread)
			end)

			pcall(function()
				thread:Disconnect()
				print('Closed thread: '.. thread)
			end)
		end
	end

	warn('[❌] ENCRYPT UI; CLOSED')
end

function encrypt:toggle() 
	EncryptedName.Enabled = not EncryptedName.Enabled 
end

warn('[✔️] ENCRYPT UI LIBRARY: LOADED')

return encrypt
