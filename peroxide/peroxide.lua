--[[

                                  88""Yb 888888 88""Yb  dP"Yb  Yb  dP 88 8888b.  888888 
                                  88__dP 88__   88__dP dP   Yb  YbdP  88  8I  Yb 88__   
                                  88"""  88""   88"Yb  Yb   dP  dPYb  88  8I  dY 88""   
                                  88     888888 88  Yb  YbodP  dP  Yb 88 8888Y"  888888 

	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	::                                          UI LIBRARY MADE BY doom#1000                                      ::
	::                             HOW TO USE: dooms-scripts.gitbook.io/peroxide-docs                             ::
	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

]]--

getgenv = getgenv or assert(getgenv, 'Your executor is not supported.')

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

        fonts = {
            primary = 'Code';
            secondary = 'Code';
        };

        drop_shadow = false;
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
	IgnoreGuiInset = true,
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
    window_frame.Position = UDim2.new(0.588466287, 0, 0.424580991, 0)
    window_frame.Size = size

    local line = Instance.new("Frame")
    line.Name = "Line"
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
    title.Font = Enum.Font.Code
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
        tab_button.Size = UDim2.new(0, 45, 0, 15)
        tab_button.Font = Enum.Font.Code
        tab_button.Text = tab_name
        tab_button.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab_button.TextSize = 13.000
        tab_button.TextTransparency = 0.750

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
            local category_frame = Instance.new("Frame")
            local line = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local padding = Instance.new("UIPadding")
            local list_layout = Instance.new("UIListLayout")

            category_frame.Name = "category_frame"
            category_frame.Parent = tabs
            category_frame.AnchorPoint = Vector2.new(1, 0)
            category_frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
            category_frame.BorderColor3 = Color3.fromRGB(45, 45, 45)
            category_frame.Position = UDim2.new(0.999999583, 0, 0.457777768, 156)
            category_frame.Size = UDim2.new(0.494999975, 0, 0.00222222647, 21)

            line.Name = "line"
            line.Parent = category_frame
            line.AnchorPoint = Vector2.new(0.5, 0)
            line.BackgroundColor3 = peroxide.customization.colors.accent
            line.BorderSizePixel = 0
            line.Position = UDim2.new(0.5, 0, -0.00999999978, 0)
            line.Size = UDim2.new(1.05900002, 0, 0, 1)

            Title.Name = "Title"
            Title.Parent = category_frame
            Title.AnchorPoint = Vector2.new(0.5, 0)
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0.5, 0, 0.0909090862, 0)
            Title.Size = UDim2.new(0.99000001, 0, 0, 16)
            Title.Font = Enum.Font.Code
            Title.Text = category_name
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 14.000
            Title.TextStrokeTransparency = 0.500
            Title.TextXAlignment = Enum.TextXAlignment.Left

            padding.Name = "padding"
            padding.Parent = category_frame
            padding.PaddingLeft = UDim.new(0, 6)
            padding.PaddingRight = UDim.new(0, 6)

            list_layout.Name = "list_layout"
            list_layout.Parent = category_frame
            list_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            list_layout.SortOrder = Enum.SortOrder.LayoutOrder
        end

        return tab
    end
    
    window_frame.MouseEnter:Connect(function() peroxide.custom_cursor.enabled = true end)
    window_frame.MouseLeave:Connect(function() peroxide.custom_cursor.enabled = false end)

    return window
end

--# INITIALIE LIBRARY #--------------
getgenv().PEROXIDE_LOADED = true
getgenv().PEROXIDE_INSTANCE = peroxide.instance
getgenv().PEROXIDE_ONLOAD = getgenv().PEROXIDE_ONLOAD() or function() warn(string.format('PEROXIDE: LOADED IN %s SECONDS', tostring(tick() - peroxide.start_time):sub(1,4))) end

getgenv().PEROXIDE_ONLOAD()

return peroxide
