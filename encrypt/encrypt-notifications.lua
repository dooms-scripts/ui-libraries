--[[

	    ###########  #####       #####  ##########  ##############  #####  #####  ##############  ################
	   #####        ########    #####  #####       #####    #####  #####  #####  #####    #####        #####      
	  ###########  #####  ###  #####  #####       ############    ############  ##############        #####       
	 #####        #####    ########  #####       #####    #####         #####  #####                 #####        
	###########  #####       #####  ##########  #####    #####  ############  #####                 #####         

	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# notification library
	# doom#1000
	
]]--

local encrypt_notification_lib = { 
	loaded = true, 
	padding = 0
}

--> Services
local players = game:GetService('Players')
local ts = game:GetService('TweenService')
local ti = TweenInfo

--> Variables
local encrypted_name = nil
local notification_container = nil

function encrypt_notification_lib.initialize()
	local _,err = pcall(function()
		if game.CoreGui:FindFirstChild('encrypt_notifications') then
			encrypted_name = game.CoreGui['encrypt_notifications']
			notification_container = game.CoreGui['encrypt_notifications']['Frame']
		else
			encrypted_name = Instance.new("ScreenGui")
			notification_container = Instance.new("Frame")

			local list_layout = Instance.new("UIListLayout")
			local padding = Instance.new("UIPadding")

			notification_container.Parent = encrypted_name
			notification_container.AnchorPoint = Vector2.new(0.5, 0.5)
			notification_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			notification_container.BackgroundTransparency = 1.000
			notification_container.BorderColor3 = Color3.fromRGB(0, 0, 0)
			notification_container.BorderSizePixel = 0
			notification_container.Position = UDim2.new(0.5, 0, 0.5, 0)
			notification_container.Size = UDim2.new(1, 0, 1, 0)

			list_layout.Parent = notification_container
			list_layout.SortOrder = Enum.SortOrder.LayoutOrder
			list_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom

			padding.Parent = notification_container
			padding.PaddingBottom = UDim.new(0, 4)
			padding.PaddingLeft = UDim.new(0, 4)
			padding.PaddingTop = UDim.new(0, encrypt_notification_lib.padding)
			padding.PaddingBottom = UDim.new(0, encrypt_notification_lib.padding)

			encrypted_name.Parent = game.CoreGui
			encrypted_name.Name = 'encrypt_notifications'
			encrypted_name.ResetOnSpawn = false
		end
	end)
	
	if err then
		encrypted_name = Instance.new("ScreenGui")
		notification_container = Instance.new("Frame")

		local list_layout = Instance.new("UIListLayout")
		local padding = Instance.new("UIPadding")

		notification_container.Parent = encrypted_name
		notification_container.AnchorPoint = Vector2.new(0.5, 0.5)
		notification_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		notification_container.BackgroundTransparency = 1.000
		notification_container.BorderColor3 = Color3.fromRGB(0, 0, 0)
		notification_container.BorderSizePixel = 0
		notification_container.Position = UDim2.new(0.5, 0, 0.5, 0)
		notification_container.Size = UDim2.new(1, 0, 1, 0)

		list_layout.Parent = notification_container
		list_layout.SortOrder = Enum.SortOrder.LayoutOrder
		list_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom

		padding.Parent = notification_container
		padding.PaddingBottom = UDim.new(0, 4)
		padding.PaddingLeft = UDim.new(0, 4)
		padding.PaddingTop = UDim.new(0, encrypt_notification_lib.padding)
		padding.PaddingBottom = UDim.new(0, encrypt_notification_lib.padding)

		encrypted_name.Parent = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
		encrypted_name.Name = 'encrypt_notifications'
		encrypted_name.ResetOnSpawn = false

		warn('[⚠️] ENCRYPT LIBRARY ERROR: ' ..tostring(err))
		encrypted_name.Parent = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
	end
end

-- Functions
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

	coroutine.wrap(function()
		task.wait(duration)
		--tween(notification, ti.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 'TextSize', 0)
		tween(notification, ti.new(.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), 'TextTransparency', 1)
		task.wait(.35)
		notification:Destroy()
	end)()
end

warn('[✅] ENCRYPT NOTIFICATION LIBRARY: LOADED V1.0.1')
encrypt_notification_lib.loaded = true

return encrypt_notification_lib
