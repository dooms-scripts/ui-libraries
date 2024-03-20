--[[
						    __
		  ___  ____  ____________  ______  / /_   
		 / _ \/ __ \/ ___/ ___/ / / / __ \/ __/  
		/  __/ / / / /__/ /  / /_/ / /_/ / /_  
		\___/_/ /_/\___/_/   \__, / .___/\__/  
				    /____/_/             
    		---------------------------------------
    		> notification library
    		> doom#1000
]]--

local encrypt_notification_lib = {}

--> Services
local players = game:GetService('Players')
local ts = game:GetService('TweenService')
local ti = TweenInfo

--> Variables
local encrypted_name = Instance.new("ScreenGui")
local notification_container = Instance.new("Frame")
local list_layout = Instance.new("UIListLayout")
local padding = Instance.new("UIPadding")


notification_container.Parent = encrypted_name
notification_container.AnchorPoint = Vector2.new(0.5, 1)
notification_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notification_container.BackgroundTransparency = 1.000
notification_container.BorderColor3 = Color3.fromRGB(0, 0, 0)
notification_container.BorderSizePixel = 0
notification_container.Position = UDim2.new(0.5, 0, 1, 0)
notification_container.Size = UDim2.new(0, 400, 0, 200)

list_layout.Parent = notification_container
list_layout.SortOrder = Enum.SortOrder.LayoutOrder
list_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom

padding.Parent = notification_container
padding.PaddingBottom = UDim.new(0, 4)
padding.PaddingLeft = UDim.new(0, 4)

-- Functions
local _,err = pcall(function()
	encrypted_name.Parent = game.CoreGui
	encrypted_name.Name = tostring('doom_'..math.random(10000000000,99999999999))
	encrypted_name.ResetOnSpawn = false
end)

if err then 
	warn('⚠️ ENCRYPT LIBRARY ERROR: ' ..tostring(err))
	encrypted_name.Parent = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
end

function tween(instance, info, property, value)
	ts:Create(instance, info, { [property] = value }):Play()
end

function encrypt_notification_lib.notify(text, duration)
	local notification = Instance.new('TextLabel', notification_container)
	notification.Parent = notification_container
	notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	notification.BackgroundTransparency = 1.000
	notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
	notification.BorderSizePixel = 0
	notification.Size = UDim2.new(1, 0, 0, 15)
	notification.Font = Enum.Font.SourceSans
	notification.Text = text
	notification.RichText = true
	notification.TextColor3 = Color3.fromRGB(0, 0, 0)
	notification.TextSize = 16.000
	notification.TextStrokeTransparency = 0.750
	notification.TextXAlignment = Enum.TextXAlignment.Center
	
	task.wait(duration)
	tween(notification, ti.new(.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), 'TextTransparency', 1)
	task.wait(.35)
	notification:Destroy()
end

warn('✅ ENCRYPT NOTIFICATION LIBRARY: LOADED')

return encrypt_notification_lib
