--[[ LIBRARY DATA ]]-------------------------------------------------
local library = {
	use_custom_cursor = true,
	threads = {}, connections = {},
	custom_cursor = {
		enabled = false
	},
	colors = {
		accent = Color3.fromRGB(255, 0, 0),
		foreground = Color3.fromRGB(),
		background = Color3.fromRGB(),
	}
}

--[[ DEPENDENCIES ]]-------------------------------------------------
cloneref = cloneref or nil
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

--[[ FUNCTIONS ]]----------------------------------------------------
local function encrypt_name()
	local characters = [[]]
	local str = ''
	for i=1, 99 do
		str = str .. characters:sub(math.random(1,7), math.random(1,7))
	end

	return str
end

--// SAFELOAD FUNCTION
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

--// CREATE FUNCTION
local function create(instance, properties)
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

local function GetChildrenOfClass(instance, class)
	local children = {}

	for _,__ in ipairs(instance:GetChildren()) do
		if __:IsA(class) then
			children[#children+1] = __
		end
	end

	return children
end

--// CREATE UI
library.GUI = create("ScreenGui", {Name = [[null lib]];Parent = nil;ZIndexBehavior = Enum.ZIndexBehavior.Sibling;})

local custom_cursor = create('ImageLabel', {
	Parent = library.GUI,
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1.000,
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderSizePixel = 0,
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.new(0, 25, 0, 25),
	Image = 'http://www.roblox.com/asset/?id=16710247795',
	Visible = false,
	ZIndex = 99999,
})

library.threads['update_cursor_pos'] = coroutine.create(function()
	repeat task.wait()
		if library.use_custom_cursor then
			input_service.MouseIconEnabled = not library.custom_cursor.enabled
			custom_cursor.Visible = library.custom_cursor.enabled

			custom_cursor.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
		else
			input_service.MouseIconEnabled = true
			custom_cursor.Visible = false
		end
	until nil
end)

if not pcall(function() safe_load(library.GUI, false) end) then
	warn('Failed to load to an elevated state. Returning to PlrGui')
	library.GUI.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')
	coroutine.resume(library.threads['update_cursor_pos'])
end

function library:new_window(window_data)
	local window, defaults = {}, {
		title = 'cranberry sprite // ui library<font color="rgb(185,185,185)"> | doom#1000</font>',
		bg_img = 'rbxassetid://15688752899',
		bg_img_transparency = 0.95,
		size = UDim2.new(0, 450, 0, 550),
		pos = UDim2.new(0, 500, 0, 200),
		draggable = true,
	}
	
	local window_data = override(defaults, window_data or {})
	
	local window_frame = create("Frame", {Parent = library.GUI;Draggable = window_data.draggable;BorderSizePixel = 0;Size = UDim2.new(0, 450, 0, 550);BorderColor3 = Color3.fromRGB(45, 45, 45);BorderMode = Enum.BorderMode.Inset;Name = [[window_frame]];Position = window_data.pos;BackgroundColor3 = Color3.fromRGB(40, 40, 40);Active=true;Selectable=true;})
	local tab_holder = create("Frame", {Parent = window_frame;AnchorPoint = Vector2.new(0.5, 1);ZIndex = 2;BorderSizePixel = 0;Size = UDim2.new(1, 0, 1, -45);BorderColor3 = Color3.fromRGB(0, 0, 0);LayoutOrder = 2;Name = [[tab_holder]];Position = UDim2.new(0.5, 0, 1, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
	local top_bar = create("Frame", {Parent = window_frame;Size = UDim2.new(1, 0, 0, 25);BorderColor3 = Color3.fromRGB(58, 58, 58);BorderMode = Enum.BorderMode.Inset;Name = [[top_bar]];BackgroundColor3 = Color3.fromRGB(40, 40, 40);})
	local label = create("TextLabel", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;RichText = true;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = top_bar;AnchorPoint = Vector2.new(0.5, 0);TextSize = 14;Size = UDim2.new(1, 0, 1, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = string.format(window_data.title);TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[label]];Position = UDim2.new(0.5, 0, 0, 0);TextColor3 = library.colors.accent;BackgroundTransparency = 1;})
	local line = create("Frame", {Parent = top_bar;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 1);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[line]];BackgroundColor3 = library.colors.accent;})
	local tab_buttons = create("Frame", {Parent = window_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 20);BorderColor3 = Color3.fromRGB(0, 0, 0);LayoutOrder = 1;Name = [[tab_buttons]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
	local background_image = create("ImageLabel", {Parent = window_frame;LayoutOrder = 99;AnchorPoint = Vector2.new(0.5, 0.5);Image = window_data.bg_img;BorderSizePixel = 0;Size = UDim2.new(1, 0, -1, 45);ScaleType = Enum.ScaleType.Stretch;BorderColor3 = Color3.fromRGB(0, 0, 0);ImageTransparency = window_data.bg_img_transparency;Name = [[background_image]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
	local text_padding = create("UIPadding", {Name = [[text_padding]];Parent = label;PaddingLeft = UDim.new(0, 6);})
	local outline = create("UIStroke", {Name = [[outline]];Parent = window_frame;Color = Color3.fromRGB(29, 29, 29);})
	local gradient = create("UIGradient", {Name = [[gradient]];Parent = top_bar;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200));});})
	local gradient2 = create("UIGradient", {Name = [[gradient]];Parent = window_frame;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 176));});})
	local padding = create("UIPadding", {PaddingTop = UDim.new(0, 6);Name = [[padding]];Parent = tab_holder;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);PaddingBottom = UDim.new(0, 6);})
	local padding2 = create("UIPadding", {Name = [[padding]];Parent = tab_buttons;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);})
	local list_layout = create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal;Name = [[list_layout]];Parent = tab_buttons;Padding = UDim.new(0, 10);SortOrder = Enum.SortOrder.LayoutOrder;})
	local list_layout2 = create("UIListLayout", {Name = [[list_layout]];Parent = window_frame;SortOrder = Enum.SortOrder.LayoutOrder;})
	
	function window:toggle()
		window_frame.Visible = not window_frame.Visible
	end

	function window:close()
		window_frame:Destroy()
	end

	function window:update(data)
		local data = override(defaults, data or {})

		label.Text = data.title
		window_frame.Size = data.size
		window_frame.Position = data.position
		window_frame.Draggable = data.draggable
		background_image.Image = data.bg_img
		background_image.ImageTransparency = data.ImageTransparency
	end

	window_frame.MouseEnter:Connect(function()
		library.custom_cursor.enabled = true
	end)

	window_frame.MouseLeave:Connect(function()
		library.custom_cursor.enabled = false
	end)
	
	function window:add_tab(tab_data)
		local tab, defaults = {}, {
			name = 'tab',
		}
		
		local tab_data = override(defaults, tab_data or {})
		
		local tab_frame = create("Frame", {Parent = tab_holder;Size = UDim2.new(1, 0, 1, 0);Visible=false;ClipsDescendants = false;BorderColor3 = Color3.fromRGB(255, 255, 255);BorderMode = Enum.BorderMode.Inset;Name = [[tab_frame]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(35, 35, 35);})
		local tab_button = create("TextButton", {TextStrokeTransparency = 0;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = tab_buttons;TextSize = 13;Size = UDim2.new(0, 75, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Text = tab_data.name;TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[tab_button]];TextColor3 = Color3.fromRGB(255, 255, 255);BackgroundTransparency = 1;})
		local line = create("Frame", {Visible = false;Parent = tab_button;AnchorPoint = Vector2.new(0, 1);Size = UDim2.new(1, 0, 0, 1);BorderColor3 = Color3.fromRGB(28, 28, 28);Name = [[line]];Position = UDim2.new(0, 0, 1, 0);BackgroundColor3 = library.colors.accent;})
		local outline = create("UIStroke", {Name = [[outline]];Parent = tab_frame;Enabled = false;Color = Color3.fromRGB(20, 20, 20);})
		local gradient = create("UIGradient", {Name = [[gradient]];Parent = tab_frame;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(0.8287197351455688, Color3.fromRGB(253, 253, 253));ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200));});})
		local padding = create("UIPadding", {Name = [[padding]];Parent = tab_frame;})
		
		tab_button.Size = UDim2.new(0, tab_button.TextBounds.X, 1, 0)
		tab_button.MouseButton1Click:Connect(function()
			for _, button in ipairs(tab_buttons:GetChildren()) do 
				if button:IsA('TextButton') then
					button.TextColor3 = Color3.fromRGB(255, 255, 255)
					button.line.Visible = false
				end
			end
			
			for _, tab in ipairs(tab_holder:GetChildren()) do
				if tab:IsA('Frame') then tab.Visible = false end
			end
			
			tab_button.TextColor3 = library.colors.accent
			line.Visible = true
			tab_frame.Visible = true
		end)
		
		function tab:add_category(category_data)
			local category, defaults = { elements = 0 }, {
				name = 'category'
			}
			
			local category_data = override(defaults, category_data or {})
			
			local category_frame = create("Frame", {Parent = tab_frame;Size = UDim2.new(0.5, -5, 0, 18);BorderColor3 = Color3.fromRGB(50, 50, 50);BorderMode = Enum.BorderMode.Inset;Name = [[category_frame]];BackgroundTransparency = 0.15000000596046448;BackgroundColor3 = Color3.fromRGB(30, 30, 30);})
			local top_bar = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 10);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[top_bar]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
			local line = create("Frame", {Parent = top_bar;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 1);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[line]];BackgroundColor3 = library.colors.accent;})
			local label = create("TextLabel", {TextStrokeTransparency = 0;BorderSizePixel = 0;RichText = true;BackgroundColor3 = Color3.fromRGB(30, 30, 30);Parent = top_bar;TextSize = 13;Size = UDim2.new(0, 66, 0, 10);BorderColor3 = Color3.fromRGB(0, 0, 0);Text = category_data.name;TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[label]];Position = UDim2.new(0.05, 0, 0, -2);TextColor3 = Color3.fromRGB(255, 255, 255);})
			local outline = create("UIStroke", {Name = [[outline]];Parent = category_frame;Color = Color3.fromRGB(20, 20, 20);})
			local list_layout = create("UIListLayout", {Name = [[list_layout]];Parent = category_frame;SortOrder = Enum.SortOrder.LayoutOrder;})
			local text_padding = create("UIPadding", {Name = [[text_padding]];Parent = label;PaddingBottom = UDim.new(0, 7);})
			
			label.Size = UDim2.new(0, label.TextBounds.X + 10, 0, 10)
			
			function category.new_label(data)
				local label, defaults = {}, {
					text = 'text label',
					alignment = 'Left',
				}
				
				local data = override(defaults, data or {})
				
				local label_frame = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 20);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[label_frame]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
				local label_text = create("TextLabel", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = label_frame;AnchorPoint = Vector2.new(0, 0.5);TextSize = 13;Size = UDim2.new(0.75, 0, 1, 0);TextXAlignment = Enum.TextXAlignment[data.alignment];BorderColor3 = Color3.fromRGB(0, 0, 0);Text = data.text;TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[label_text]];Position = UDim2.new(0, 0, 0.5, 0);TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local padding = create("UIPadding", {Name = [[padding]];Parent = label_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);})
				
				category_frame.Size += UDim2.new(0, 0, 0, 20)
				return label
			end
			
			function category.new_button(data)
				category.elements += 1
				local button, defaults = {}, {
					text = 'button',
					callback = function ()
						warn('No callback has been set to button')
					end
				}
				
				local data = override(defaults, data or {})

				local button_frame = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 22);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[button_frame]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
				local text_button = create("TextButton", {TextStrokeTransparency = 0.5;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(29, 29, 29);BorderMode = Enum.BorderMode.Inset;Parent = button_frame;AnchorPoint = Vector2.new(0, 0.5);TextSize = 13;Size = UDim2.new(1, 0, 0, 18);BorderColor3 = Color3.fromRGB(50, 50, 50);Text = [[button]];TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Position = UDim2.new(0, 0, 0.5, 0);TextColor3 = Color3.fromRGB(150, 150, 150);})
				local button_highlight = create("Frame", {Visible = false;Parent = text_button;AnchorPoint = Vector2.new(0.5, 0.5);BorderSizePixel = 0;Size = UDim2.new(1, 0, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Position = UDim2.new(0.5, 0, 0.5, 0);BackgroundTransparency = 0.85;BackgroundColor3 = library.colors.accent;})
				local UIStroke = create("UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Border;Parent = text_button;Color = Color3.fromRGB(21, 21, 21);})
				local UIGradient = create("UIGradient", {Parent = text_button;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200));});})
				local UIPadding = create("UIPadding", {Parent = button_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);})
				
				text_button.MouseEnter:Connect(function() button_highlight.Visible = true end)
				text_button.MouseLeave:Connect(function() button_highlight.Visible = false end)
				text_button.MouseButton1Down:Connect(function() button_highlight.BackgroundTransparency = 0.875 end)
				text_button.MouseButton1Up:Connect(function() button_highlight.BackgroundTransparency = 0.85 end)
				text_button.MouseButton1Click:Connect(function() data.callback() button_highlight.BackgroundTransparency = 0.85 end)

				category_frame.Size += UDim2.new(0, 0, 0, 22)
				return button
			end
			
			function category.new_toggle(data)
				category.elements += 1
				local toggle, defaults = { value = false }, {
					text = 'toggle',
					callback = function()
						warn('No callback has been set to toggle')
					end,
				}
				
				local data = override(defaults, data or {})
				
				local toggle_frame = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 20);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[toggle_frame]];Position = UDim2.new(-1.41860461, 0, 0.309090912, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
				local toggle_text = create("TextLabel", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = toggle_frame;AnchorPoint = Vector2.new(1, 0.5);TextSize = 13;Size = UDim2.new(1, -20, 1, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = data.text;TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[toggle_text]];Position = UDim2.new(1, 0, 0.5, 0);TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local toggle_button = create("TextButton", {AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(29, 29, 29);BorderMode = Enum.BorderMode.Inset;Parent = toggle_frame;AnchorPoint = Vector2.new(0, 0.5);TextSize = 14;Size = UDim2.new(0, 15, 0, 15);BorderColor3 = Color3.fromRGB(50, 50, 50);Text = [[]];Font = Enum.Font.SourceSans;Name = [[toggle_button]];Position = UDim2.new(0, 0, 0.5, 0);TextColor3 = Color3.fromRGB(0, 0, 0);})
				local outline = create("UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Border;Parent = toggle_button;Color = Color3.fromRGB(21, 21, 21);})
				local UIGradient = create("UIGradient", {Enabled = false;Parent = toggle_button;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200));});})
				local UIPadding = create("UIPadding", {Parent = toggle_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);})
				
				toggle_button.MouseEnter:Connect(function()
					outline.Color = library.colors.accent
				end)
				
				toggle_button.MouseLeave:Connect(function()
					outline.Color = Color3.fromRGB(21, 21, 21)
				end)
				
				toggle_button.MouseButton1Click:Connect(function()
					toggle.value = not toggle.value
					
					if toggle.value then
						toggle_button.BackgroundColor3 = library.colors.accent
						--> toggle_button.BorderColor3 = library.colors.accent
					end
					
					if not toggle.value then
						toggle_button.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
						--> toggle_button.BorderColor3 = Color3.fromRGB(50, 50, 50)
					end
					
					if not pcall(function() data.callback() end) then 
						warn('Callback failed. Check your code bud')
					end
				end)
				
				function toggle:add_keybind(data)
					local keybind, defaults = { key = nil, editing = false, clicked = false }, {
						text = 'keybind',
						input_mode = 'click',
						key = nil,
						callback = function()
							warn("No callback set to keybind")
						end,
					}

					local data = override(defaults, data or {})

					local keybind_button = create("TextButton", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = toggle_frame;AnchorPoint = Vector2.new(1, 0.5);TextSize = 13;Size = UDim2.new(0, 30, 0, 15);TextXAlignment = Enum.TextXAlignment.Right;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = '[...]';TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[keybind_button]];Position = UDim2.new(1, 0, 0.5, 0);TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
					
					if data.key then
						keybind_button.Text = string.format('[%s]', keybind.key)
						keybind.key = data.key
					end

					local blacklisted_keys = {
						'RightSuper',
						'LeftSuper',
						'BackSlash',
						'Backspace',
						'Unknown',
						'Return',
						'Escape',
					}

					keybind_button.MouseEnter:Connect(function()
						keybind_button.TextColor3 = library.colors.accent
					end)

					keybind_button.MouseLeave:Connect(function()
						keybind_button.TextColor3 = Color3.fromRGB(150, 150, 150)
					end)

					library.connections['click_connection_' .. tostring(category.elements)] = keybind_button.MouseButton1Click:Connect(function()
						keybind_button.TextColor3 = library.colors.accent
						keybind_button.Text = '[...]'
						keybind.editing = true
					end)

					library.connections['input_connection_' .. tostring(category.elements)] = input_service.InputBegan:Connect(function(key)
						if keybind.editing then
							keybind_button.TextColor3 = Color3.new(150, 150, 150)

							if table.find(blacklisted_keys, tostring(key.KeyCode):gsub('Enum.KeyCode.', '')) then
								keybind.key = nil
								keybind_button.Text = '...'
								keybind_button.Size = UDim2.new(0, 30, 1, 0)	
								keybind.editing = false
								return
							end

							keybind.key = tostring(key.KeyCode):gsub('Enum.KeyCode.', '')
							keybind_button.Text = string.format('[%s]', keybind.key)

							if keybind_button.TextBounds.X > 30 then
								keybind_button.Size = UDim2.new(0, keybind_button.TextBounds.X + 6, 1, 0)	
							end

							if keybind_button.TextBounds.X < 30 then
								keybind_button.Size = UDim2.new(0, 30, 1, 0)	
							end

							keybind.editing = false 
							return
						end

						if keybind.key == nil then return end

						if key.KeyCode == Enum.KeyCode[keybind.key] then
							if data.input_mode == 'hold' then
								keybind.clicked = true
								while keybind.clicked do task.wait()
									data.callback(toggle.value)
								end
							elseif data.input_mode == 'toggle' then
								keybind.clicked = not keybind.clicked
								while keybind.clicked do task.wait()
									data.callback(toggle.value)
								end
							elseif data.input_mode == 'click' then
								data.callback(toggle.value)
							end
						end
					end)

					library.connections['hold_connection_' .. tostring(category.element_count)] = input_service.InputEnded:Connect(function(key)
						if keybind.key == nil then return end

						if key.KeyCode == Enum.KeyCode[keybind.key] and data.input_mode == 'hold' then
							keybind.clicked = false
						end
					end)

					category_frame.Size += UDim2.new(0, 0, 0, 20)
					return keybind
				end

				category_frame.Size += UDim2.new(0, 0, 0, 20)
				return toggle
			end
			
			function category.new_textbox(data)
				category.elements += 1
				local textbox, defaults = { value = '' }, {
					text = 'textbox',
					text_prefix = '',
					placeholder_text = '...',
					callback = function()
						warn('No callback set to textbox.')
					end,
				}
				
				local data = override(defaults, data or {})
				
				local textbox_frame = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 36);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[textbox_frame]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
				local textbox_label = create("TextLabel", {TextStrokeTransparency = 0.5;Position = UDim2.new(0,0,0,0);BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = textbox_frame;TextSize = 14;Size = UDim2.new(1, 0, 0.5, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = data.text;TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[textbox_label]];TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local textbox_text = create("TextBox", {CursorPosition = -1;TextStrokeTransparency = 0.5;PlaceholderColor3 = Color3.fromRGB(178, 178, 178);BackgroundColor3 = Color3.fromRGB(25, 25, 25);BorderMode = Enum.BorderMode.Inset;Parent = textbox_frame;AnchorPoint = Vector2.new(0, 1);TextXAlignment = Enum.TextXAlignment.Left;TextSize = 13;Size = UDim2.new(1, 0, 0, 18);TextStrokeColor3 = Color3.fromRGB(18, 18, 18);TextColor3 = Color3.fromRGB(150, 150, 150);BorderColor3 = Color3.fromRGB(50, 50, 50);Text = data.text_prefix .. data.placeholder_text;Font = Enum.Font.Code;Name = [[textbox_text]];Position = UDim2.new(0, 0, 1, 0);})
				local outline = create("UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Border;Parent = textbox_text;Color = Color3.fromRGB(21, 21, 21);})
				local UIGradient = create("UIGradient", {Parent = textbox_text;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 191, 191));});})
				local UIPadding = create("UIPadding", {Parent = textbox_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);PaddingBottom = UDim.new(0, 1);})
				local UIPadding2 = create("UIPadding", {Parent = textbox_text;PaddingLeft = UDim.new(0, 4);})
				
				textbox_text.MouseEnter:Connect(function()
					outline.Color = library.colors.accent
				end)

				textbox_text.MouseLeave:Connect(function()
					outline.Color = Color3.fromRGB(21, 21, 21)
				end)
				
				function textbox:get_value()
					return textbox.value
				end
				
				textbox_text.FocusLost:Connect(function()
					if textbox_text.Text == '' then textbox_text.Text = '...' else textbox_text.Text = data.text_prefix .. textbox_text.Text end 
					if not pcall(function() data.callback(textbox.value) end) then
						warn('Callback failed. Check your code bud')
					end
				end)

				category_frame.Size += UDim2.new(0, 0, 0, 36)
				return textbox
			end
			
			function category.new_slider(data)
				category.elements += 1
				local slider, defaults = { value = 0 }, {
					text = 'slider',
					allow_decimals = false,
					min = 0,
					max = 100,
					value = 0,
					callback = function()
						warn('No callback set to slider.')
					end,
				}
				
				local data = override(defaults, data or {})
				slider.value = data.value
				
				local slider_frame = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 36);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[slider_frame]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
				local slider_button = create("TextButton", {AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(29, 29, 29);BorderMode = Enum.BorderMode.Inset;Parent = slider_frame;AnchorPoint = Vector2.new(0, 1);TextSize = 14;Size = UDim2.new(1, 0, 0, 18);BorderColor3 = Color3.fromRGB(50, 50, 50);Text = [[]];Font = Enum.Font.SourceSans;Name = [[slider_button]];Position = UDim2.new(0, 0, 1, 0);TextColor3 = Color3.fromRGB(0, 0, 0);})
				local slider_label = create("TextLabel", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = slider_frame;TextSize = 14;Size = UDim2.new(1, 0, 0.5, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = data.text;TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[slider_label]];TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local value_label = create("TextLabel", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = slider_frame;AnchorPoint = Vector2.new(1, 0);TextSize = 14;Size = UDim2.new(0.25, 0, 0.5, 0);TextXAlignment = Enum.TextXAlignment.Right;BorderColor3 = Color3.fromRGB(0, 0, 0);	Text = slider.value;TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[value_label]];	Position = UDim2.new(1, 0, 0, 0);TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local outline = create("UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Border;Parent = slider_button;Color = Color3.fromRGB(21, 21, 21);})
				local fill = create("Frame", {Parent = slider_button;BorderSizePixel = 0;Size = UDim2.new(0.25, 0, 1, 0);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[fill]];BackgroundColor3 = library.colors.accent;})
				local UIPadding = create("UIPadding", {Parent = slider_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);PaddingBottom = UDim.new(0, 2);})
				local UIGradient = create("UIGradient", {Parent = slider_button;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200));});})
				
				slider_button.MouseEnter:Connect(function()
					outline.Color = library.colors.accent
				end)

				slider_button.MouseLeave:Connect(function()
					outline.Color = Color3.fromRGB(21, 21, 21)
				end)
				
				local min = data.min
				local max = data.max
				local mouse_down = false
				local mouse_on = false

				slider.value = data.value
				fill.Size = UDim2.new((slider.value - min) / (max - min), 0, 1, 0)
				value_label.Text = tostring(slider.value):sub(1,4)

				local function update_value()
					local mouse_x = math.clamp(mouse.X - slider_button.AbsolutePosition.X, min, slider_button.AbsoluteSize.X)

					if data.allow_decimals then
						slider.value = (math.clamp((mouse_x / slider_button.AbsoluteSize.X) * (max - min) + min, min, max))
						value_label.Text = tostring(slider.value):sub(1,4)
					elseif not data.allow_decimals then
						slider.value = math.floor(math.clamp((mouse_x / slider_button.AbsoluteSize.X) * (max - min) + min, min, max))
						value_label.Text = tostring(slider.value)
					end

					fill.Size = UDim2.new((slider.value - min) / (max - min), 0, 1, 0)

					data.callback(slider.value)
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
				
				category_frame.Size += UDim2.new(0, 0, 0, 36)
				return slider	
			end
			
			function category.new_keybind(data)
				category.elements += 1
				local keybind, defaults = { key = nil, editing = false, clicked = false }, {
					text = 'keybind',
					input_mode = 'click',
					key = nil,
					callback = function()
						warn("No callback set to keybind")
					end,
				}
				
				local data = override(defaults, data or {})
				
				local keybind_frame = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 20);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[keybind_frame]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
				local keybind_label = create("TextLabel", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = keybind_frame;AnchorPoint = Vector2.new(0, 0.5);TextSize = 13;Size = UDim2.new(0.75, 0, 1, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[keybind]];TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[keybind_label]];Position = UDim2.new(0, 0, 0.5, 0);TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local keybind_button = create("TextButton", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = keybind_frame;AnchorPoint = Vector2.new(1, 0.5);TextSize = 13;Size = UDim2.new(0, 30, 0, 15);TextXAlignment = Enum.TextXAlignment.Right;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = '[...]';TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[keybind_button]];Position = UDim2.new(1, 0, 0.5, 0);TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local UIPadding = create("UIPadding", {Parent = keybind_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);})

				if data.key then
					keybind_button.Text = string.format('[%s]', keybind.key)
					keybind.key = data.key
				end
				
				local blacklisted_keys = {
					'RightSuper',
					'LeftSuper',
					'BackSlash',
					'Backspace',
					'Unknown',
					'Return',
					'Escape',
				}
				
				keybind_button.MouseEnter:Connect(function()
					keybind_button.TextColor3 = library.colors.accent
				end)
				
				keybind_button.MouseLeave:Connect(function()
					keybind_button.TextColor3 = Color3.fromRGB(150, 150, 150)
				end)
				
				library.connections['click_connection_' .. tostring(category.elements)] = keybind_button.MouseButton1Click:Connect(function()
					keybind_button.TextColor3 = library.colors.accent
					keybind_button.Text = '[...]'
					keybind.editing = true
				end)

				library.connections['input_connection_' .. tostring(category.elements)] = input_service.InputBegan:Connect(function(key)
					if keybind.editing then
						keybind_button.TextColor3 = Color3.new(150, 150, 150)
						
						if table.find(blacklisted_keys, tostring(key.KeyCode):gsub('Enum.KeyCode.', '')) then
							keybind.key = nil
							keybind_button.Text = '...'
							keybind_button.Size = UDim2.new(0, 30, 1, 0)	
							keybind.editing = false
							return
						end

						keybind.key = tostring(key.KeyCode):gsub('Enum.KeyCode.', '')
						keybind_button.Text = string.format('[%s]', keybind.key)

						if keybind_button.TextBounds.X > 30 then
							keybind_button.Size = UDim2.new(0, keybind_button.TextBounds.X + 6, 1, 0)	
						end

						if keybind_button.TextBounds.X < 30 then
							keybind_button.Size = UDim2.new(0, 30, 1, 0)	
						end

						keybind.editing = false 
						return
					end

					if keybind.key == nil then return end

					if key.KeyCode == Enum.KeyCode[keybind.key] then
						if data.input_mode == 'hold' then
							keybind.clicked = true
							while keybind.clicked do task.wait()
								data.callback()
							end
						elseif data.input_mode == 'toggle' then
							keybind.clicked = not keybind.clicked
							while keybind.clicked do task.wait()
								data.callback()
							end
						elseif data.input_mode == 'click' then
							data.callback()
						end
					end
				end)

				library.connections['hold_connection_' .. tostring(category.element_count)] = input_service.InputEnded:Connect(function(key)
					if keybind.key == nil then return end

					if key.KeyCode == Enum.KeyCode[keybind.key] and data.input_mode == 'hold' then
						keybind.clicked = false
					end
				end)

				category_frame.Size += UDim2.new(0, 0, 0, 20)
				return keybind
			end
			
			function category.new_colorpicker(data)
				category.elements += 1
				local color_picker, defaults = {}, {
					text = 'color picker',
					callback = function()
						warn('')
					end,
				}
				
				local color_picker_data = override(defaults, data or {})
				
				local color_picker_frame = create("Frame", {Parent = category_frame;BorderSizePixel = 0;Size = UDim2.new(1, 0, 0, 20);BorderColor3 = Color3.fromRGB(0, 0, 0);Name = [[keybind_frame]];BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
				local color_picker_label = create("TextLabel", {TextStrokeTransparency = 0.5;BorderSizePixel = 0;BackgroundColor3 = Color3.fromRGB(255, 255, 255);Parent = color_picker_frame;AnchorPoint = Vector2.new(0, 0.5);TextSize = 13;Size = UDim2.new(0.75, 0, 1, 0);TextXAlignment = Enum.TextXAlignment.Left;BorderColor3 = Color3.fromRGB(0, 0, 0);Text = [[keybind]];TextStrokeColor3 = Color3.fromRGB(18, 18, 18);Font = Enum.Font.Code;Name = [[keybind_label]];Position = UDim2.new(0, 0, 0.5, 0);TextColor3 = Color3.fromRGB(150, 150, 150);BackgroundTransparency = 1;})
				local color_picker_button = create("TextButton", {AutoButtonColor = false;BackgroundColor3 = Color3.fromRGB(255, 0, 0);BorderMode = Enum.BorderMode.Inset;Parent = color_picker_frame;AnchorPoint = Vector2.new(1, 0.5);TextSize = 14;Size = UDim2.new(0, 30, 0, 15);BorderColor3 = Color3.fromRGB(50, 50, 50);Text = [[]];Font = Enum.Font.SourceSans;Position = UDim2.new(1, 0, 0.5, 0);TextColor3 = Color3.fromRGB(0, 0, 0);})
				local UIPadding = create("UIPadding", {Parent = color_picker_frame;PaddingRight = UDim.new(0, 6);PaddingLeft = UDim.new(0, 6);})
				local UIStroke = create("UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Border;Parent = color_picker_button;Color = Color3.fromRGB(44, 44, 44);})
				local UIGradient = create("UIGradient", {Parent = color_picker_button;Rotation = 90;Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255));ColorSequenceKeypoint.new(0.6712803244590759, Color3.fromRGB(140, 140, 140));ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 86, 86));});})
				
			end
			
			return category
		end
		
		
		--// auto sort categories
		coroutine.wrap(function()
			local function GetCategoryFrames()
				local frames = {}
				for _, child in ipairs(tab_frame:GetChildren()) do
					if child:IsA("Frame") and child.Name == "category_frame" then
						table.insert(frames, child)
					end
				end
				return frames
			end

			local function PositionCategoryFrames(frames)
				local count = 0
				local sizeY = 0
				local anchor = 0
				local padding = 10
				local switched = false
				
				for index, category in ipairs(frames) do
					count = count + 1

					if count > 1 then
						local lastFrame = frames[index - 1]
						
						if sizeY + category.Size.Y.Offset + padding > tab_frame.AbsoluteSize.Y then
							--> warn("Switched")
							switched = not switched
							sizeY = 0
							anchor = 1
							
							category.Position = UDim2.new(
								anchor, 
								0, 
								0, 
								0
							)
						else
							sizeY = sizeY + category.Size.Y.Offset + padding

							category.Position = UDim2.new(
								anchor, 
								0, 0, 
								lastFrame.Position.Y.Offset + lastFrame.Size.Y.Offset + padding
							)
						end

						if sizeY > tab_frame.AbsoluteSize.Y then
							--> warn("Switched")
							switched = not switched
							sizeY = 0
							anchor = 1
						end
						
						category.AnchorPoint = Vector2.new(anchor, 0)
					else
						sizeY = sizeY + category.Size.Y.Offset
					end
				end
			end
			task.wait()

			local frames = GetCategoryFrames()
			PositionCategoryFrames(frames)
			PositionCategoryFrames(frames)
		end)()
		
		return tab
	end
	
	return window
end

function library:exit_threads()
	if pcall(function() 
			for _, thread in pairs(library.threads) do
				pcall(function() task.cancel(thread) end)
				pcall(function() coroutine.close(thread) end)
			end
		end) then 
		warn('Successfully exited threads.')
	end
end

function library:exit_connections()
	if pcall(function() 
			for _, connection in pairs(library.connections) do
				if typeof(connection) == 'RBXScriptConnection' then
					connection:Disconnect()
				end
			end
		end) then
		warn('Successfully exited connections.')
	end
end

function library:exit()
	library.GUI:Destroy()
	
	if not pcall(function() library:exit_threads() end) then warn('Failed to exit lib threads') end
	if not pcall(function() library:exit_connections() end) then warn('Failed to exit lib connections') end
	
	warn('> Library exit')
end

return library
