--// LIBRARY DATA ###################################################
local encrypt = {
	data = {
		load_time = tick(),

		labels = {},
		sliders = {},
		buttons = {},
		keybinds = {},
		textboxes = {},
		colorpickers = {},
	},

	customize = {
		colors = {
			accent = Color3.fromRGB(255, 255, 255),
			background = Color3.fromRGB(20, 20, 20),
			foreground = Color3.fromRGB(17, 17, 17),
			dropdowns = Color3.fromRGB(42, 42, 42),
			buttons = Color3.fromRGB(24, 24, 24),
			text = Color3.fromRGB(65, 65, 65)
		},

		fonts = {
			primary = Enum.Font.Gotham,
			secondary = Enum.Font.GothamMedium,
			keybinds = Enum.Font.Gotham,
			text_size = 11,
			alt_text_size = 11,
		},

		bg_image = nil,
		drop_shadow = false,
		draggable = true,
	},
}

--// DEPENDENCIES ###################################################
local cloneref = cloneref or function(...) return ... end
local services = setmetatable({},{__index = function(self,name)
	local serv = cloneref(game:GetService(name))
	self[name] = serv
	return serv
end})

local run_service = services.RunService
local input_service = services.UserInputService
local tween_service = services.TweenService
local players = services.Players

local tween_info = TweenInfo
local easing_style = Enum.EasingStyle
local easing_direction = Enum.EasingDirection
local ease_style = Enum.EasingStyle.Linear
local ease_direction = Enum.EasingDirection.InOut

local plr = players.LocalPlayer
local mouse = plr:GetMouse()

--// FUNCTIONS ######################################################
local function encrypt_name()
	local characters = [[]]
	local str = ''
	for i=1, 99 do
		str = str .. characters:sub(math.random(1,7), math.random(1,7))
	end

	return str
end

local function safe_load(instance, encrypt_names)
	local cloneref = cloneref or function(...) return ... end
	local elevated_state = pcall(function() local a = cloneref(game:GetService("CoreGui")):GetFullName() end)

	if encrypt_names then
		for _,__ in ipairs(instance:GetDescendants()) do
			__.Name = encrypt_name()
		end
	end

	local service = setmetatable({},{__index = function(self,name)
		local serv = cloneref(game:GetService(name))
		self[name] = serv
		return serv
	end})

	instance.Parent = elevated_state and service.CoreGui
end

local function GetChildrenOfClass(instance, class)
	local children = {}

	for _,__ in ipairs(instance:GetChildren()) do
		if __:IsA(class) then
			children[#children+1] = __
		end
	end

	return children
end

local function GetDescendantsOfClass(instance, class)
	local descendants = {}

	for _,__ in ipairs(instance:GetDescendants()) do
		if __:IsA(class) then
			descendants[#descendants+1] = __
		end
	end

	return descendants
end

local function override(to_override, override_with)
	for i, v in pairs(override_with) do
		if type(v) == 'table' then
			to_override[i] = override(to_override[i] or {}, v)
		else
			to_override[i] = v
		end
	end

	return to_override
end

local function tween(tween_data)
	local defaults = {
		time = 0.15,
		instance = nil,
		data = nil,
		ease_data = {
			ease_style = Enum.EasingStyle.Quad,
			ease_direction = Enum.EasingDirection.InOut,
		},
	}

	local tween_data = override(defaults, tween_data or {})
	tween_data.ease_data = override(defaults.ease_data, tween_data.ease_data or {})

	if tween_data.instance == nil then return warn('plz give an instance') end
	if tween_data.data == nil then return warn('plz give property data') end

	tween_service:Create(
		tween_data.instance, 
		TweenInfo.new(tween_data.time, tween_data.ease_data.ease_style, tween_data.ease_data.ease_direction),
		tween_data.data
	):Play()
end

local function get_value(data_table, default_table, value_name)
	local value = data_table[value_name] or default_table[value_name]
	return value
end

local function append(to_append, append_with)
	table.insert(to_append, append_with)
end

function encrypt:new(instance, properties)
	local i = Instance.new(instance)
	for p,v in pairs(properties) do
		local s, err = pcall(function()
			i[p] = v
		end)

		if err then 
			warn('[!] PROBLEM CREATING INSTANCE "'..instance..'": '..err) 
		end
	end

	return i
end

--// LOAD GUI #######################################################
local gui, window

gui = encrypt:new("ScreenGui", {Parent = nil;ZIndexBehavior = Enum.ZIndexBehavior.Sibling;})
safe_load(gui, false)

--// CREATE UI ######################################################
function encrypt.new_window(name)
	local window = { tab_count = 0 }
	
	local window_frame = encrypt:new("Frame", {Active = true;Parent = gui;BorderSizePixel = 0;Size = UDim2.new(0, 400, 0, 475);Draggable = true;BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[window]];Position = UDim2.new(0.75, -683, 0.494415849, -137);Selectable = true;BackgroundColor3 = Color3.fromRGB(20, 20, 20);})
	local tab_buttons = encrypt:new("Frame", {Parent = window_frame;AnchorPoint = Vector2.new(0.5, 0);ZIndex = 2;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 20);BorderColor3 = Color3.fromRGB(0, 0, 0);LayoutOrder = 2;Name = [[tab_buttons]];Position = UDim2.new(0.5, 0, 0, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(20, 20, 20);})
	local tab_holder = encrypt:new("Frame", {Parent = window_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 1, -45);BorderColor3 = Color3.fromRGB(0, 0, 0);LayoutOrder = 3;Name = [[tabs]];Position = UDim2.new(0, 0, 0, 30);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
	local top_bar = encrypt:new("Frame", {Parent = window_frame;AnchorPoint = Vector2.new(0.5, 0);ZIndex = 2;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 25);BorderColor3 = Color3.fromRGB(0, 0, 0);LayoutOrder = 1;Name = [[top_bar]];Position = UDim2.new(0.5, 0, 0, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(20, 20, 20);})
	local title = encrypt:new("TextLabel", {BorderSizePixel = 0;RichText = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = top_bar;TextSize = 12;Size = UDim2.new(1, 0, 1, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[<font color="rgb(255, 51, 54)">encrypt v2</font><font color="rgb(150,150,150)"> | doom#1000 </font>]];Font = Enum.Font.Gotham;Name = [[title]];TextColor3 = Color3.fromRGB(225, 225, 225);BackgroundTransparency = 1;})
	local fade = encrypt:new("ImageLabel", {Parent = tab_holder;AnchorPoint = Vector2.new(0.5, 1);Image = [[rbxassetid://1679440786]];BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 100);BorderColor3 = Color3.fromRGB(0, 0, 0);ImageColor3 = Color3.fromRGB(20, 20, 20);Name = [[fade]];Position = UDim2.new(0.5, 0, 1, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
	local divider = encrypt:new("Frame", {Visible = false;Parent = top_bar;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 1);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[Divider]];Position = UDim2.new(0, 0, 1, 0);BackgroundColor3 = Color3.fromRGB(36, 36, 36);})
	local background_image = encrypt:new("Frame", {Visible = false;Parent = window_frame;BorderSizePixel = 0;BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[background_image]];BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
	local ImageLabel = encrypt:new("ImageLabel", {Parent = background_image;Image = [[rbxassetid://15931665651]];BorderSizePixel = 0;Size = UDim2.new(0, 400, 0, 475);BorderColor3 = Color3.fromRGB(0, 0, 0);ImageTransparency = 0.949999988079071;Position = UDim2.new(-162, 0, 0, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
	local padding = encrypt:new("UIPadding", {Parent = tab_buttons;PaddingRight = UDim.new(0, 8);PaddingLeft = UDim.new(0, 8);})
	local padding_2 = encrypt:new("UIPadding", {Parent = title;PaddingLeft = UDim.new(0, 8);})
	local list_layout = encrypt:new("UIListLayout", {Parent = window_frame;SortOrder = Enum.SortOrder.LayoutOrder;})
	local list_layout_2 = encrypt:new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal;Parent = tab_buttons;Padding = UDim.new(0, 8);SortOrder = Enum.SortOrder.LayoutOrder;})

	if name then title.Text = name end

	function window.new_tab(tab_data)
		window.tab_count += 1

		local tab, defaults = { group_count = 0 }, { 
			name = 'tab',
			groups = {},
		}

		local tab_data = override(defaults, tab_data or {})
		
		local tab_frame = encrypt:new("Frame", {Visible = false;Parent = tab_holder;AnchorPoint = Vector2.new(0.5, 0.5);ZIndex = 2;BorderSizePixel = 0;Size = UDim2.new(1, 0, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[tab]];Position = UDim2.new(0.5, 0, 0.5, 0);BackgroundTransparency = 1;Selectable = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
		local tab_button = encrypt:new("TextButton", { BorderSizePixel = 0; RichText = true;	BackgroundColor3 = Color3.fromRGB(255, 255, 255); Parent = tab_buttons; TextSize = 12; Size = UDim2.new(0, 44, 1, 0); TextXAlignment = Enum.TextXAlignment.Left;	BorderColor3 = Color3.fromRGB(0, 0, 0);	Text = tab_data.name; Font = Enum.Font.Gotham; Name = [[tab_button]];	TextColor3 = Color3.fromRGB(150, 150, 150);	BackgroundTransparency = 1;})
		local list_layout = encrypt:new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal;Name = [[list_layout]];Parent = tab_frame;SortOrder = Enum.SortOrder.LayoutOrder;})
		local padding = encrypt:new("UIPadding", {Name = [[padding]];Parent = tab_frame;PaddingRight = UDim.new(0, 4);PaddingLeft = UDim.new(0, 4);PaddingBottom = UDim.new(0, 4);}) 
		
		tab_button.Size = UDim2.new(0, tab_button.TextBounds.X, 1, 0)
		tab_button.MouseButton1Click:Connect(function()
			for _, tab in ipairs(GetChildrenOfClass(tab_holder, 'Frame')) do
				tab.Visible = false
			end

			for _, t_button in ipairs(GetChildrenOfClass(tab_buttons, 'TextButton')) do
				tween({ instance = t_button, data = { TextColor3 = Color3.fromRGB(150, 150, 150) } })
			end

			tab_frame.Visible = true
			tween({ instance = tab_button, data = { TextColor3 = encrypt.customize.colors.accent } })
		end)
		
		function tab.new_group(group_data)
			tab.group_count += 1

			local group, defaults = { category_count = 0 }, {
				name = 'group',
				categories = {},
			}

			local group_data = override(defaults, group_data or {})

			local group_frame = encrypt:new("ScrollingFrame", {Active = true;BorderSizePixel = 0;CanvasSize = UDim2.new(0, 0, 0, 22);BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = tab_frame;BorderColor3 = Color3.fromRGB(0, 0, 0);ScrollBarThickness = 0;Name = group_data.Name;BackgroundTransparency = 1;})
			local UIPadding = encrypt:new("UIPadding", {Parent = group_frame;PaddingRight = UDim.new(0, 2);PaddingLeft = UDim.new(0, 2);PaddingBottom = UDim.new(0, 4);})
			local UIListLayout = encrypt:new("UIListLayout", {Parent = group_frame;Padding = UDim.new(0, 4);SortOrder = Enum.SortOrder.LayoutOrder;})

			coroutine.wrap(function()
				task.wait(0.1)
				group_frame.Size = UDim2.new(1 / tab.group_count, 0, 1, 0)
			end)()

			function group.new_category(category_data)
				group.category_count += 1
				local category, defaults = {
					label_count = 0,
					button_count = 0,
					toggle_count = 0,
					slider_count = 0,
					keybind_count = 0,
					dropdown_count = 0,
					colorpicker_count = 0,	
				}, {
					elements = {},
					name = 'category',
					title_alignment = 'Left',
				}

				local category_data = override(defaults, category_data or {})

				local category_frame = encrypt:new("Frame", {Name = category_data.name; BackgroundTransparency = 1; Parent = group_frame;BackgroundColor3 = encrypt.customize.colors.foreground;Size = UDim2.new(1, 0, 0, 22);BorderColor3 = Color3.fromRGB(35, 35, 35);Selectable = true;LayoutOrder = group.category_count;})
				local UICorner = encrypt:new("UICorner", {Parent = category_frame;CornerRadius = UDim.new(0, 3);})
				local UIListLayout = encrypt:new("UIListLayout", {Parent = category_frame;Padding = UDim.new(0, 4);SortOrder = Enum.SortOrder.LayoutOrder;})
				local title = encrypt:new("TextLabel", {Parent = category_frame; Text = category_data.name;Font = encrypt.customize.fonts.secondary;BorderSizePixel = 0;TextXAlignment = Enum.TextXAlignment[category_data.title_alignment]; TextYAlignment = Enum.TextYAlignment.Bottom;BackgroundColor3 = Color3.fromRGB(255, 255, 255);TextSize = 12;Size = UDim2.new(1, 0, 0, 16);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[title]];TextColor3 = Color3.fromRGB(180, 180, 180);Selectable = true;BackgroundTransparency = 1;})
				local padding = encrypt:new("UIPadding", {Parent = category_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);})
				-- local UIPadding = encrypt:new("UIPadding", {Parent = title;PaddingLeft = UDim.new(0, 1);})

				function category.new_label(label_data)
					local label, defaults = {}, {
						text = 'text label',
						alignment = 'Left',
						visible = true,
					}

					local label_data = override(defaults, label_data or {})
					local title = encrypt:new("TextLabel", {BorderSizePixel = 0;TextSize = encrypt.customize.fonts.text_size;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = category_frame;Size = UDim2.new(1, 0, 0, 12);TextXAlignment = Enum.TextXAlignment[label_data.alignment];BorderColor3 = Color3.fromRGB(0, 0, 0);Text = label_data.text;Font = encrypt.customize.fonts.primary;Name = [[label]];TextColor3 = encrypt.customize.colors.text;Selectable = true;BackgroundTransparency = 1;})

					function label:hide() 
						title.Visible = false 
					end

					function label:show() 
						title.Visible = true 
					end

					function label:remove()
						title:Destroy()
						category_frame.Size -= UDim2.new(0, 0, 0, 16)
					end

					function label:update(new_data)
						local new_data = override(defaults, new_data or {})
						title.Visible = new_data.visible
						title.Text = new_data.text
						title.TextXAlignment = Enum.TextXAlignment[new_data.alignment]
					end

					category_frame.Size += UDim2.new(0, 0, 0, 16)
					group_frame.CanvasSize += UDim2.new(0, 0, 0, 16)
					return label
				end

				function category.new_button(button_data) 
					local button, defaults = {}, {
						text = 'button',
						visible = true,
						callback = function() warn('NO CALLBACK SET') end,
					}

					local button_data = override(defaults, button_data or {})
					local text_button = encrypt:new("TextButton", {Parent = category_frame;BackgroundColor3 = encrypt.customize.colors.buttons;Font = encrypt.customize.fonts.primary;Text = button_data.text;TextSize = encrypt.customize.fonts.text_size;TextStrokeTransparency = 0.949999988079071;BorderSizePixel = 0;AutoButtonColor = false;AnchorPoint = Vector2.new(0, 0.5);Size = UDim2.new(1, 0, 0, 18);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[text_button]];Position = UDim2.new(0, 0, 0.5, 0);TextColor3 = Color3.fromRGB(85, 85, 85);})
					local round = encrypt:new("UICorner", {Parent = text_button;CornerRadius = UDim.new(0, 3);})

					text_button.MouseEnter:Connect(function() tween({ instance = text_button, data = { BackgroundColor3 = Color3.fromRGB(37, 37, 37) }}) end)
					text_button.MouseLeave:Connect(function() tween({ instance = text_button, data = { BackgroundColor3 = encrypt.customize.colors.buttons }}) end)
					text_button.MouseButton1Down:Connect(function() tween({ instance = text_button, data = { BackgroundColor3 = Color3.fromRGB(42, 42, 42) }, time = 0.1, }) end)
					text_button.MouseButton1Up:Connect(function() tween({ instance = text_button, data = { BackgroundColor3 = encrypt.customize.colors.buttons }, time = 0.1, }) end)

					local callback = text_button.MouseButton1Click:Connect(button_data.callback)

					function button:hide() 
						text_button.Visible = false 
					end

					function button:show() 
						text_button.Visible = true 
					end

					function button:remove()
						text_button:Destroy()
						category_frame.Size -= UDim2.new(0, 0, 0, 22)
					end

					function button:update(new_data)
						local new_data = override(defaults, new_data or {})
						text_button.Visible = new_data.visible
						text_button.Text = new_data.text
						callback:Disconnect()
						callback = text_button.MouseButton1Click:Connect(new_data.callback)
					end

					category_frame.Size += UDim2.new(0, 0, 0, 22)
					group_frame.CanvasSize += UDim2.new(0, 0, 0, 22)
					return button
				end

				function category.new_toggle(toggle_data)
					local toggle, defaults = { value = false }, {
						text = 'toggle',
						visible = true,
						callback = function() warn('NO CALLBACK SET') end,
					}

					local toggle_data = override(defaults, toggle_data or {})

					local toggle_frame = encrypt:new("Frame", {Parent = category_frame; Visible = toggle_data.visible; BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 16);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[toggle_frame]];Position = UDim2.new(0, 0, 0.239999995, 0);BackgroundTransparency = 1;Selectable = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
					local toggle_label = encrypt:new("TextLabel", {Parent = toggle_frame; Font = encrypt.customize.fonts.primary; TextSize = encrypt.customize.fonts.text_size; Text = toggle_data.text; TextColor3 = encrypt.customize.colors.text; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Size = UDim2.new(1, 0, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[toggle_label]];BackgroundTransparency = 1;})
					local toggle_button = encrypt:new("ImageButton", {Parent = toggle_frame;AnchorPoint = Vector2.new(0, 0.5);Image = [[http://www.roblox.com/asset/?id=17084749971]];BorderSizePixel = 0;Size = UDim2.new(0, 16, 0, 16);ImageTransparency = 1;BorderColor3 = Color3.fromRGB(0, 0, 0);AutoButtonColor = false;Name = [[toggle_button]];Position = UDim2.new(0, 0, 0.5, 0);BackgroundColor3 = Color3.fromRGB(27, 27, 27);})
					local text_padding = encrypt:new("UIPadding", {Parent = toggle_label;PaddingLeft = UDim.new(0, 22);})
					local round = encrypt:new("UICorner", {Parent = toggle_button;CornerRadius = UDim.new(0, 3);})

					function toggle:hide()
						toggle_frame.Visible = false
					end

					function toggle:show()
						toggle_frame.Visible = true
					end

					function toggle:remove()
						toggle_frame:Destroy()
						category_frame.Size -= UDim2.new(0, 0, 0, 24)
					end

					function toggle:update(new_data)
						local new_data = override(defaults, new_data or {})
						toggle_frame.Visible = new_data.visible
						toggle_label.Text = new_data.text
					end

					function toggle:add_keybind(keybind_data)
						local keybind, defaults = {}, {
							text = 'keybind',
							default_key = nil,
							input_mode = 'click',
							callback = function() warn('NO CALLBACK SET') end,
						}

						local keybind_data = override(defaults, keybind_data or {})
						keybind.key = keybind_data.default_key

						local input_connection
						local hold_connection
						local clicked = false
						local editing = false

						local keybind_button = encrypt:new("TextButton", {Parent = toggle_frame;Font = encrypt.customize.fonts.keybinds; TextSize = encrypt.customize.fonts.alt_text_size;TextStrokeTransparency = 1.850000023841858;BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(27, 27, 27);AnchorPoint = Vector2.new(1, 0.5);Size = UDim2.new(0, 30, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[...]];Name = [[keybind_button]];Position = UDim2.new(1, 0, 0.5, 0);TextColor3 = Color3.fromRGB(75, 75, 75);})
						local round = encrypt:new("UICorner", {Parent = keybind_button;Name = [[round]];CornerRadius = UDim.new(0, 3);})
						-- keybind_button.TextStrokeTransparency = 0.850

						if keybind.key then keybind_button.Text = keybind.key end

						function keybind:hide()
							keybind_button.Visible = false
							category_frame.Size -= UDim2.new(0, 0, 0, 20)
							group_frame.CanvasSize -= UDim2.new(0, 0, 0, 20)
						end

						function keybind:show()
							keybind_button.Visible = true
							category_frame.Size += UDim2.new(0, 0, 0, 20)
							group_frame.CanvasSize += UDim2.new(0, 0, 0, 20)
						end

						function keybind:remove()
							keybind_button:Destroy()
							input_connection:Disconnect()
							hold_connection:Disconnect()
						end

						function keybind:update(new_data)
							local new_data = override(keybind_data, new_data or {})
							keybind_data.input_mode = new_data.input_mode
							keybind_data.callback = new_data.callback
							keybind.key = new_data.default_key

							if keybind.key then keybind_button.Text = keybind.key end
						end

						local blacklisted_keys = {
							'Backspace',
							'LeftSuper',
							'RightSuper',
							'Return',
							'Escape',
							'Unknown',
						}

						keybind_button.MouseButton1Click:Connect(function()
							editing = true

							coroutine.wrap(function()
								while editing == true do
									if editing then keybind_button.Text = '.' end
									task.wait(0.5)
									if editing then keybind_button.Text = '..' end
									task.wait(0.5)
									if editing then keybind_button.Text = '...' end
									task.wait(0.5)
								end
							end)()
						end)

						input_connection = input_service.InputBegan:Connect(function(key)
							if editing then
								if table.find(blacklisted_keys, tostring(key.KeyCode):gsub('Enum.KeyCode.', '')) then
									keybind.key = nil
									keybind_button.Text = '...'
									keybind_button.Size = UDim2.new(0, 30, 1, 0)	
									editing = false
									return
								end

								keybind.key = tostring(key.KeyCode):gsub('Enum.KeyCode.', '')
								keybind_button.Text = keybind.key

								if keybind_button.TextBounds.X > 30 then
									keybind_button.Size = UDim2.new(0, keybind_button.TextBounds.X + 6, 1, 0)	
								end

								if keybind_button.TextBounds.X < 30 then
									keybind_button.Size = UDim2.new(0, 30, 1, 0)	
								end

								editing = false return
							end

							if keybind.key == nil then return end

							if key.KeyCode == Enum.KeyCode[keybind.key] then
								if keybind_data.input_mode == 'hold' then
									clicked = true
									while clicked do task.wait()
										keybind_data.callback(toggle.value)
									end
								elseif keybind_data.input_mode == 'toggle' then
									clicked = not clicked
									while clicked do task.wait()
										keybind_data.callback(toggle.value)
									end
								elseif keybind_data.input_mode == 'click' then
									keybind_data.callback(toggle.value)
								end
							end
						end)

						hold_connection = input_service.InputEnded:Connect(function(key)
							if keybind.key == nil then return end

							if key.KeyCode == Enum.KeyCode[keybind.key] and keybind_data.input_mode == 'hold' then
								clicked = false
							end
						end)

						return keybind
					end

					toggle_button.MouseButton1Click:Connect(function()
						toggle.value = not toggle.value

						if toggle.value then
							tween({ 
								instance = toggle_button, 
								data = { BackgroundColor3 = encrypt.customize.colors.accent } 
							})
						elseif not toggle.value then
							tween({ 
								instance = toggle_button, 
								data = { BackgroundColor3 = Color3.fromRGB(27, 27, 27) } 
							})
						end

						toggle_data.callback(toggle.value)
					end)

					category_frame.Size += UDim2.new(0, 0, 0, 20)
					group_frame.CanvasSize += UDim2.new(0, 0, 0, 20)
					return toggle
				end

				function category.new_keybind(keybind_data)
					local keybind, defaults = {}, {
						default_key = nil,
						input_mode = 'click',
						callback = function() warn('NO CALLBACK SET') end,
					}

					local keybind_data = override(defaults, keybind_data or {})
					keybind.key = keybind_data.default_key
					keybind.threads = {}

					keybind.threads.input_connection = nil
					keybind.threads.hold_connection = nil
					local editing = false
					local clicked = false

					local keybind_frame = encrypt:new("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 16);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[keybind_frame]];Position = UDim2.new(0, 0, 0.239999995, 0);BackgroundTransparency = 1;Selectable = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
					local keybind_label = encrypt:new("TextLabel", {Font = encrypt.customize.fonts.primary;Text = keybind_data.text;TextColor3 = encrypt.customize.colors.text;TextSize = encrypt.customize.fonts.text_size;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = keybind_frame;Size = UDim2.new(1, 0, 1, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);BackgroundTransparency = 1;})
					local keybind_button = encrypt:new("TextButton", {Parent = keybind_frame;Font = encrypt.customize.fonts.keybinds; TextSize = encrypt.customize.fonts.alt_text_size;TextStrokeTransparency = 1.850000023841858;BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(27, 27, 27);AnchorPoint = Vector2.new(1, 0.5);Size = UDim2.new(0, 30, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[...]];Name = [[keybind_button]];Position = UDim2.new(1, 0, 0.5, 0);TextColor3 = Color3.fromRGB(75, 75, 75);})
					local round = encrypt:new("UICorner", {Parent = keybind_button;Name = [[round]];CornerRadius = UDim.new(0, 3);})

					if keybind.key then keybind_button.Text = keybind.key end

					UICorner.CornerRadius = UDim.new(0, 3)
					UICorner.Parent = keybind_button

					function keybind:hide()
						keybind_button.Visible = false
						category_frame.Size -= UDim2.new(0, 0, 0, 20)
						group_frame.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					function keybind:show()
						keybind_button.Visible = true
						category_frame.Size += UDim2.new(0, 0, 0, 20)
						group_frame.CanvasSize += UDim2.new(0, 0, 0, 20)
					end

					function keybind:remove()
						keybind_button:Destroy()
						keybind.threads.input_connection:Disconnect()
						keybind.threads.hold_connection:Disconnect()
					end

					function keybind:update(new_data)
						local new_data = override(keybind_data, new_data or {})
						keybind_data.input_mode = new_data.input_mode
						keybind_data.callback = new_data.callback
						keybind.key = new_data.default_key

						if keybind.key then keybind_button.Text = keybind.key end
					end

					local blacklisted_keys = {
						'Backspace',
						'LeftSuper',
						'RightSuper',
						'Return',
						'Escape',
						'Unknown',
					}

					keybind_button.MouseButton1Click:Connect(function()
						editing = true

						coroutine.wrap(function()
							while editing == true do
								if editing then keybind_button.Text = '.' end
								task.wait(0.5)
								if editing then keybind_button.Text = '..' end
								task.wait(0.5)
								if editing then keybind_button.Text = '...' end
								task.wait(0.5)
							end
						end)()
					end)

					keybind.threads.input_connection = input_service.InputBegan:Connect(function(key)
						if editing then
							if table.find(blacklisted_keys, tostring(key.KeyCode):gsub('Enum.KeyCode.', '')) then
								keybind.key = nil
								keybind_button.Text = '...'
								keybind_button.Size = UDim2.new(0, 30, 1, 0)	
								editing = false
								return
							end

							keybind.key = tostring(key.KeyCode):gsub('Enum.KeyCode.', '')
							keybind_button.Text = keybind.key

							if keybind_button.TextBounds.X > 30 then
								keybind_button.Size = UDim2.new(0, keybind_button.TextBounds.X + 6, 1, 0)	
							end

							if keybind_button.TextBounds.X < 30 then
								keybind_button.Size = UDim2.new(0, 30, 1, 0)	
							end

							editing = false return
						end

						if keybind.key == nil then return end

						if key.KeyCode == Enum.KeyCode[keybind.key] then
							if keybind_data.input_mode == 'hold' then
								clicked = true
								while clicked do task.wait()
									keybind_data.callback()
								end
							elseif keybind_data.input_mode == 'toggle' then
								clicked = not clicked
								while clicked do task.wait()
									keybind_data.callback()
								end
							elseif keybind_data.input_mode == 'click' then
								keybind_data.callback()
							end
						end
					end)

					keybind.threads.hold_connection = input_service.InputEnded:Connect(function(key)
						if keybind.key == nil then return end

						if key.KeyCode == Enum.KeyCode[keybind.key] and keybind_data.input_mode == 'hold' then
							clicked = false
						end
					end)

					category.keybind_count += 1
					encrypt.data.keybinds[category.keybind_count] = keybind
					category_frame.Size += UDim2.new(0, 0, 0, 20)
					group_frame.CanvasSize += UDim2.new(0, 0, 0, 20)
					return keybind
				end

				function category.new_dropdown(dropdown_data)
					local dropdown, defaults = { 
						selection = nil,
						option_count = 0,
						options = {},
					}, {
						text = 'dropdown',
						options = {},
						default_selection = nil,
						multi_option = false,
						visible = false,
						callback = function() warn('NO CALLBACK SET') end,
					}

					local dropdown_data = override(defaults, dropdown_data or {})
					dropdown.options = dropdown_data.options

					if dropdown_data.multi_option then dropdown.selection = {} end

					local dropdown_frame = encrypt:new("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 30);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = 'dropdown_frame';BackgroundTransparency = 1;Selectable = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
					local option_frame = encrypt:new("Frame", {Parent = dropdown_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[option_frame]];Position = UDim2.new(0, 0, 1, 0);BackgroundColor3 = Color3.fromRGB(42, 42, 42);})
					local dropdown_label = encrypt:new("TextLabel", {BorderSizePixel = 0;TextYAlignment = Enum.TextYAlignment.Top;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = dropdown_frame;TextSize = encrypt.customize.fonts.text_size;Size = UDim2.new(0.75, 0, 0, 12);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = dropdown_data.text;Font = encrypt.customize.fonts.primary;Name = [[dropdown_label]];TextColor3 = encrypt.customize.colors.text;BackgroundTransparency = 1;})
					local dropdown_button = encrypt:new("TextButton", {TextStrokeTransparency = 0.8999999761581421;BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(42, 42, 42);Parent = dropdown_frame;AnchorPoint = Vector2.new(0, 1);TextSize = encrypt.customize.fonts.text_size;Size = UDim2.new(1, 0, 0, 18);BorderColor3 = Color3.fromRGB(0, 0, 0);Text = dropdown_data.text;Font = encrypt.customize.fonts.primary;Name = [[dropdown_button]];Position = UDim2.new(0, 0, 1, 0);TextColor3 = Color3.fromRGB(145, 145, 145);})
					local arrow = encrypt:new("ImageLabel", {Parent = dropdown_button;AnchorPoint = Vector2.new(0, 0.449999988);Image = [[rbxassetid://13273265041]];BorderSizePixel = 0;Size = UDim2.new(0, 12, 0, 12);BorderColor3 = Color3.fromRGB(0, 0, 0);ImageColor3 = Color3.fromRGB(125, 125, 125);Name = [[arrow]];Position = UDim2.new(0.884000003, 0, 0.5, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
					local list_layout = encrypt:new("UIListLayout", {Parent = option_frame;SortOrder = Enum.SortOrder.LayoutOrder;})
					local round = encrypt:new("UICorner", {Parent = option_frame;CornerRadius = UDim.new(0, 3);})
					local round2 = encrypt:new("UICorner", {Parent = dropdown_button;CornerRadius = UDim.new(0, 3);})
					-- local padding = encrypt:new("UIPadding", {Parent = dropdown_label;PaddingLeft = UDim.new(0, 1);})

					function dropdown:hide()
						dropdown_frame.Visible = false
						category_frame.Size -= UDim2.new(0, 0, 0, 34)
						group_frame.CanvasSize -= UDim2.new(0, 0, 0, 34)
					end

					function dropdown:show()
						dropdown_frame.Visible = true
						category_frame.Size += UDim2.new(0, 0, 0, 34)
						group_frame.CanvasSize += UDim2.new(0, 0, 0, 34)
					end

					function dropdown:remove()
						dropdown_frame:Destroy()
						category_frame.Size -= UDim2.new(0, 0, 0, 34)
						group_frame.CanvasSize -= UDim2.new(0, 0, 0, 34)
					end

					if type(dropdown.selection) == 'string' then dropdown_button.Text = dropdown.selection end

					dropdown_button.MouseEnter:Connect(function()
						tween({ 
							time = 0.15,
							instance = dropdown_button, 
							data = { BackgroundColor3 = Color3.fromRGB(37, 37, 37) }
						})
					end)

					dropdown_button.MouseLeave:Connect(function()
						tween({ 
							time = 0.15,
							instance = dropdown_button, 
							data = { BackgroundColor3 = Color3.fromRGB(42, 42, 42) }
						})
					end)

					dropdown_button.MouseButton1Down:Connect(function()
						tween({ 
							time = 0.1,
							instance = dropdown_button, 
							data = { BackgroundColor3 = Color3.fromRGB(52, 52, 52) }
						})
					end)

					dropdown_button.MouseButton1Up:Connect(function()
						tween({ 
							time = 0.1,
							instance = dropdown_button, 
							data = { BackgroundColor3 = Color3.fromRGB(42, 42, 42) }
						})
					end)

					if dropdown_data.default_selection then
						dropdown.selection = dropdown_data.default_selection
						dropdown_button.Text = dropdown_data.default_selection
					end

					for _, option in dropdown_data.options do
						if type(option) == 'string' then
							local option_selected = false
							dropdown.option_count += 1

							local option_button = encrypt:new("TextButton", {BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = encrypt.customize.colors.accent;Parent = option_frame;AnchorPoint = Vector2.new(0, 0.5);TextSize = encrypt.customize.fonts.text_size;Size = UDim2.new(1, 0, 0.333333343, 0);LayoutOrder = dropdown.option_count;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = option ;TextTransparency = 1;Font = encrypt.customize.fonts.primary;Name = [[option_button]];Position = UDim2.new(0, 0, 0.5, 0);TextColor3 = Color3.fromRGB(100, 100, 100);BackgroundTransparency = 1;})
							local UICorner = encrypt:new("UICorner", {Parent = option_button;CornerRadius = UDim.new(0, 3);})

							option_button.MouseButton1Click:Connect(function()
								if not dropdown_data.multi_option then
									for _, t_button in ipairs(GetChildrenOfClass(option_frame, 'TextButton')) do
										tween({
											instance = t_button, 
											data = { 
												TextColor3 = Color3.fromRGB(100, 100, 100), 
												BackgroundTransparency = 1 
											}
										})
									end

									tween({
										instance = option_button, 
										data = { 
											TextColor3 = Color3.fromRGB(255, 255, 255), 
											BackgroundTransparency = 0.75 
										}
									})

									dropdown.selection = option
									dropdown_button.Text = dropdown.selection
								end

								if dropdown_data.multi_option then
									dropdown_button.Text = ''

									if option_selected then
										option_selected = false

										tween({
											instance = option_button,
											data = {
												TextColor3 = Color3.fromRGB(100, 100, 100),
												BackgroundTransparency = 1,
											}
										})

										for index, selection in pairs(dropdown.selection) do
											if selection == option then table.remove(dropdown.selection, index) end
										end
										-- table.remove(dropdown.selection, option_button[#dropdown.selection+1])
									elseif not option_selected then
										option_selected = true

										tween({
											instance = option_button,
											data = {
												TextColor3 = Color3.fromRGB(255, 255, 255),
												BackgroundTransparency = 0.75,
											}
										})

										append(dropdown.selection, option)
									end

									dropdown_button.Text = table.concat(dropdown.selection, ', ')
									if #dropdown.selection == 0 then dropdown_button.Text = dropdown_data.text end
								end

								dropdown_data.callback(dropdown.selection)
							end)

							coroutine.wrap(function()
								task.wait(0.1)
								option_button.Size = UDim2.new(1, 0, 1/dropdown.option_count, 0)
							end)()
						end
					end

					local category = category_frame

					local button = dropdown_button
					local option_frame = option_frame
					local opened = false

					local tween_service = game:GetService('TweenService')
					local info = TweenInfo
					local es = Enum.EasingStyle
					local ed = Enum.EasingDirection

					local function tween()
						if opened then
							tween_service:Create(option_frame, info.new(0.15, es.Quad, ed.InOut), { Size = UDim2.new(1, 0, 0, 20 * dropdown.option_count)}):Play()
							tween_service:Create(button.arrow, info.new(0.15, es.Quad, ed.InOut), { Rotation = 180 }):Play()

							for _, option in ipairs(GetChildrenOfClass(option_frame, 'TextButton')) do
								tween_service:Create(option, info.new(0.15, es.Quad, ed.InOut), { TextTransparency = 0}):Play()
							end
						elseif not opened then
							tween_service:Create(option_frame, info.new(0.15, es.Quad, ed.InOut), { Size = UDim2.new(1, 0, 0, 0)}):Play()
							tween_service:Create(button.arrow, info.new(0.15, es.Quad, ed.InOut), { Rotation = 0 }):Play()

							for _, option in ipairs(GetChildrenOfClass(option_frame, 'TextButton')) do
								tween_service:Create(option, info.new(0.15, es.Quad, ed.InOut), { TextTransparency = 1}):Play()
							end
						end
					end

					button.MouseButton1Click:Connect(function()
						opened = not opened

						if opened then
							button.Parent.ZIndex = 99

							for _, dropdown in ipairs(GetDescendantsOfClass(category, 'Frame')) do
								if dropdown.Name == 'dropdown_frame' and dropdown ~= button.Parent then dropdown.ZIndex = 1 end
							end
						end

						tween()
					end)

					category_frame.Size += UDim2.new(0, 0, 0, 34)
					group_frame.CanvasSize += UDim2.new(0, 0, 0, 34)
					return dropdown
				end

				function category.new_slider(slider_data)
					local slider, defaults = {}, {
						text = 'slider',
						allow_decimals = false,
						min = 0,
						max = 100,
						value = 0,
						callback = function() warn('NO CALLBACK SET') end,
					}

					local slider_data = override(defaults, slider_data or {})

					local slider_frame = encrypt:new("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 30);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[slider_frame]];BackgroundTransparency = 1;Selectable = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
					local slider_button = encrypt:new("TextButton", {TextStrokeTransparency = 0.8999999761581421;BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(24, 24, 24);Parent = slider_frame;AnchorPoint = Vector2.new(0, 1);TextSize = 11;Size = UDim2.new(1, 0, 0, 18);BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[]];Font = Enum.Font.Gotham;Name = [[slider_button]];Position = UDim2.new(0, 0, 1, 0);TextColor3 = Color3.fromRGB(145, 145, 145);})
					local slider_label = encrypt:new("TextLabel", {BorderSizePixel = 0;TextYAlignment = Enum.TextYAlignment.Top;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = slider_frame;TextSize = 11;Size = UDim2.new(0.75, 0, 0, 12);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[slider]];Font = Enum.Font.Gotham;Name = [[slider_button]];TextColor3 = Color3.fromRGB(65, 65, 65);BackgroundTransparency = 1;})
					local value_label = encrypt:new("TextLabel", {BorderSizePixel = 0;TextYAlignment = Enum.TextYAlignment.Top;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = slider_frame;AnchorPoint = Vector2.new(1, 0);TextSize = 11;Size = UDim2.new(0.25, 0, 0, 12);TextXAlignment = Enum.TextXAlignment.Right;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[0]];Font = Enum.Font.Gotham;Name = [[value_label]];Position = UDim2.new(1, 0, 0, 0);TextColor3 = Color3.fromRGB(65, 65, 65);BackgroundTransparency = 1;})
					local fill = encrypt:new("Frame", {Parent = slider_button;BorderSizePixel = 0;Size = UDim2.new(0, 0, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[fill]];BackgroundColor3 = Color3.fromRGB(255, 51, 54);})
					local round = encrypt:new("UICorner", {Parent = fill;Name = [[round]];CornerRadius = UDim.new(0, 3);})
					local round2 = encrypt:new("UICorner", {Parent = slider_button;Name = [[round]];CornerRadius = UDim.new(0, 3);})

					function slider:hide()
						slider_frame.Visible = false
						category_frame.Size -= UDim2.new(0, 0, 0, 34)
						group_frame.CanvasSize -= UDim2.new(0, 0, 0, 34)
					end

					function slider:show()
						slider_frame.Visible = true
						category_frame.Size += UDim2.new(0, 0, 0, 34)
						group_frame.CanvasSize += UDim2.new(0, 0, 0, 34)
					end

					function slider:update(new_data)
						local new_data = override(slider_data, new_data or {})
						slider_label.Text = new_data.text
						slider.value = new_data.value
						slider_data.min = new_data.min
						slider_data.max = new_data.max
						slider_data.allow_decimals = new_data.allow_decimals

						slider.value = slider_data.value
						fill.Size = UDim2.new((slider.value - slider_data.min) / (slider_data.max - slider_data.min), 0, 1, 0)
						value_label.Text = tostring(slider.value):sub(1,4)
					end

					function slider:remove()
						slider_frame:Destroy()
						category_frame.Size -= UDim2.new(0, 0, 0, 34)
						group_frame.CanvasSize -= UDim2.new(0, 0, 0, 34)
					end

					--> values
					local min = slider_data.min
					local max = slider_data.max
					local mouse_down = false
					local mouse_on = false

					slider.value = slider_data.value
					fill.Size = UDim2.new((slider.value - min) / (max - min), 0, 1, 0)
					value_label.Text = tostring(slider.value):sub(1,4)

					local function update_value()
						local mouse_x = math.clamp(mouse.X - slider_button.AbsolutePosition.X, min, slider_button.AbsoluteSize.X)

						if slider_data.allow_decimals then
							slider.value = (math.clamp((mouse_x / slider_button.AbsoluteSize.X) * (max - min) + min, min, max))
							value_label.Text = tostring(slider.value):sub(1,4)
						elseif not slider_data.allow_decimals then
							slider.value = math.floor(math.clamp((mouse_x / slider_button.AbsoluteSize.X) * (max - min) + min, min, max))
							value_label.Text = tostring(slider.value)
						end

						fill.Size = UDim2.new((slider.value - min) / (max - min), 0, 1, 0)

						slider_data.callback(slider.value)
					end

					mouse.Move:Connect(function() if mouse_down then update_value() end end)
					slider_button.MouseButton1Down:Connect(function() mouse_down = true update_value() end)
					slider_button.MouseButton1Up:Connect(function() mouse_down = false end)
					slider_button.MouseEnter:Connect(function() mouse_on = true end)
					slider_button.MouseLeave:Connect(function() mouse_on = false end)

					input_service.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							mouse_down = false
						end
					end)

					category_frame.Size += UDim2.new(0, 0, 0, 34)
					group_frame.CanvasSize += UDim2.new(0, 0, 0, 34)
					return slider
				end

				function category.new_colorpicker(colorpicker_data)
					local color_picker, defaults = { color = Color3.fromRGB(255, 255, 255) }, {
						text = 'color picker',
						color = Color3.fromRGB(255, 255, 255),
						callback = function() end,
					}

					local colorpicker_data = override(defaults, colorpicker_data or {})
					color_picker.color = colorpicker_data.color

					local colorpicker_frame = encrypt:new("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 16);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[colorpicker_frame]];Position = UDim2.new(0, 0, 0.239999995, 0);BackgroundTransparency = 1;Selectable = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
					local colorpicker_button = encrypt:new("TextButton", {TextStrokeTransparency = 1.850000023841858;BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = colorpicker_frame;AnchorPoint = Vector2.new(1, 0.5);TextSize = 12;Size = UDim2.new(0, 30, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[]];Font = Enum.Font.RobotoMono;Name = [[colorpicker_button]];Position = UDim2.new(1, 0, 0.5, 0);TextColor3 = Color3.fromRGB(75, 75, 75);})
					local colorpicker_label = encrypt:new("TextLabel", {BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = colorpicker_frame;TextSize = 11;Size = UDim2.new(1, 0, 1, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[color picker]];Font = Enum.Font.Gotham;Name = [[colorpicker_label]];TextColor3 = Color3.fromRGB(65, 65, 65);BackgroundTransparency = 1;})
					local round = encrypt:new("UICorner", {Parent = colorpicker_button;CornerRadius = UDim.new(0, 3);})

					function color_picker:show()
						colorpicker_frame.Visible = true
					end

					function color_picker:hide()
						colorpicker_frame.Visible = false
					end

					function color_picker:update(new_data)
						new_data = override(colorpicker_data, new_data or {})
						colorpicker_label.Text = new_data.text
					end

					function color_picker:remove()
						colorpicker_frame:Destroy()
						category_frame.Size -= UDim2.new(0, 0, 0, 20)
						group_frame.CanvasSize -= UDim2.new(0, 0, 0, 20)
					end

					category_frame.Size += UDim2.new(0, 0, 0, 20)
					group_frame.CanvasSize += UDim2.new(0, 0, 0, 20)
					return color_picker
				end

				return category
			end

			for _, category in group_data.categories do
				if type(category) == 'table' then
					group:new_category(category)
				end
			end

			return group
		end
		
		return tab
	end

	return window
end

return encrypt
