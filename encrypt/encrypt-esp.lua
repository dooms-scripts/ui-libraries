__=[[
		        ###########  #####       #####  ##########  ##############  #####  #####  ##############  ################
           #####        ########    #####  #####       #####    #####  #####  #####  #####    #####        #####      
          ###########  #####  ###  #####  #####       ############    ############  ##############        #####       
         #####        #####    ########  #####       #####    #####         #####  #####                 #####        
        ###########  #####       #####  ##########  #####    #####  ############  #####                 #####         
        
 		::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		> ESP LIBRARY
		> MADE BY doom#1000
]]

-- [ + ] -------------------------------------------------------------------------------------------
Drawing = Drawing or assert(Drawing, 'Your executor is not supported.') 

-- [ ATTRIBUTES ] ----------------------------------------------------------------------------------
local encrypt_esp = { version = 'e1.0.0' }
warn(__, encrypt_esp.version)

-- [ SERVICES ] ------------------------------------------------------------------------------------
local run = game:GetService('RunService')
local players = game:GetService('Players')
local camera = game:GetService('Workspace').CurrentCamera

-- [ FUNCTIONS ] -----------------------------------------------------------------------------------
function encrypt_esp.new_box(player, properties)
	local box, default_properties = {}, {
		color = Color3.fromRGB(255, 255, 255),
		outline_color = Color3.fromRGB(0, 0, 0),
		thickness = 1,
		update_speed = 0,
	}

	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end

	local properties    = properties or default_properties
	local color         = properties.color or default_properties.color
	local thickness     = properties.thickness or default_properties.thickness
	local update_speed  = properties.update_speed or default_properties.update_speed

	local bound1 = Drawing.new('Line')
	bound1.Color = color
	bound1.Thickness = thickness
	bound1.OutlineThickness = outline_thickness
	bound1.OutlineColor = outline_color
	
	local bound2 = Drawing.new('Line')
	bound2.Color = color
	bound2.Thickness = thickness

	local bound3 = Drawing.new('Line')
	bound3.Color = color
	bound3.Thickness = thickness
	
	local bound4 = Drawing.new('Line')
	bound4.Color = color
	bound4.Thickness = thickness

	function box.visibility(bool)
		bool = bool or false
		bound1.Visible = bool
		bound2.Visible = bool
		bound3.Visible = bool
		bound4.Visible = bool
	end
	
	function box.destroy()
		bound1:Remove()
		bound2:Remove()
		bound3:Remove()
		bound4:Remove()
	end
	
	function box.update(new_properties)
		local properties    = new_properties or default_properties
		local color         = new_properties.color or default_properties.color
		local thickness     = new_properties.thickness or default_properties.thickness
		
		bound1.Color = color
		bound1.Thickness = thickness

		bound2.Color = color
		bound2.Thickness = thickness

		bound3.Color = color
		bound3.Thickness = thickness

		bound4.Color = color
		bound4.Thickness = thickness
	end
	
	run.Stepped:Connect(function()
		local char = player.character
		if char then
			local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')
			local _, on_screen = camera:WorldToViewportPoint(root.Position)
			
			if on_screen then
				box.visibility(true)
			elseif not on_screen then
				box.visibility(false)
			end
			
			local vectors = {
				look_vector = root.CFrame.LookVector,
				right_vector = root.CFrame.RightVector,
				up_vector = root.CFrame.UpVector,
			}

			local bound_positions = {}
			bound_positions[1], _ = camera:WorldToViewportPoint(root.Position + vectors.look_vector * 0.25 + vectors.right_vector * -2 + vectors.up_vector * -2)
			bound_positions[2], _ = camera:WorldToViewportPoint(root.Position + vectors.look_vector * 0.25 + vectors.right_vector * -2 + vectors.up_vector * 2)
			bound_positions[3], _ = camera:WorldToViewportPoint(root.Position + vectors.look_vector * 0.25 + vectors.right_vector * 2 + vectors.up_vector * 2)
			bound_positions[4], _ = camera:WorldToViewportPoint(root.Position + vectors.look_vector * 0.25 + vectors.right_vector * 2 + vectors.up_vector * -2)
			
			bound1.From = Vector2.new(bound_positions[1].X, bound_positions[1].Y)
			bound1.To = Vector2.new(bound_positions[2].X, bound_positions[2].Y)

			bound2.From = Vector2.new(bound_positions[2].X, bound_positions[2].Y)
			bound2.To = Vector2.new(bound_positions[3].X, bound_positions[3].Y)

			bound3.From = Vector2.new(bound_positions[3].X, bound_positions[3].Y)
			bound3.To = Vector2.new(bound_positions[4].X, bound_positions[4].Y)

			bound4.From = Vector2.new(bound_positions[4].X, bound_positions[4].Y)
			bound4.To = Vector2.new(bound_positions[1].X, bound_positions[1].Y)
		elseif char == nil then
			box.destroy()
			warn('[-] ENCRYPT ESP > Character is nil; Removed bounding box') 
		end
		
		task.wait(properties.update_speed)
	end)

	local drawings = { bound1, bound2, bound3, bound4 }
	return box, drawings
end

function encrypt_esp.new_text(player, properties)
	local text, default = {}, {
		color = Color3.fromRGB(255, 255, 255),
		outline_color = Color3.fromRGB(0, 0, 0),
		thickness = 1,
		outline_thickness = 0,
		update_speed = 0,
	}

	local properties = properties or default
	local color = properties.color or default.color
	local outline_color = properties.outline_color or default.outline_color
	local outline_thickness = properties.outline_thickness or default.outline_thickness
	-- local thickness = properties.thickness or default.thickness
	local update_speed = properties.update_speed or default.update_speed

	local text_drawing = Drawing.new('Text')
    text_drawing.Text = player.Name
	text_drawing.Color = color
	text_drawing.Visible = true
	text_drawing.Outline = outline_thickness
	text_drawing.OutlineColor = outline_color

	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end

	function text.visibility(bool)
		text_drawing.Visible = bool
	end

	function text.destroy()
		text_drawing:Remove()
	end

	run.Stepped:Connect(function()
		local char = player.character

		if char then
			local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')
			local vector, on_screen = camera:WorldToViewportPoint(root.Position)
			
			if on_screen then
				text.visibility(true)
			elseif not on_screen then
				text.visibility(false)
			end
	
			text_drawing.Position = Vector2.new(vector.X + 3, vector.Y)
		elseif char == nil then
			text.destroy()
			warn('[-] ENCRYPT ESP > Character is nil; Removed text') 
		end
		
		task.wait(properties.update_speed)
	end)

    return text, text_drawing
end

function encrypt_esp.new_tracer(player, properties)
	local tracer, default = {}, {
		color = Color3.fromRGB(255, 255, 255),
		thickness = 1,
		update_speed = 0,
	}

	local properties = properties or default
	local color = properties.color or default.color
	local thickness = properties.thickness or default.thickness
	local update_speed = properties.update_speed or default.update_speed 

	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end

	local line = Drawing.new('Line')
	line.Color = color
	line.Thickness = thickness
	line.Visible = true

	function tracer.visibility(bool)
		line.Visible = bool
	end

	function tracer.destroy()
		line:Remove()
	end

	run.Stepped:Connect(function()
		local char = player.Character

		if char then
			local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')
			local vector, on_screen = camera:WorldToViewportPoint(root.Position)
			local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)

			if on_screen then
				tracer.visibility(true)
			elseif not on_screen then
				tracer.visibility(false)
			end

			tracer.From = center
			tracer.To = Vector2.new(vector.X, vector.Y)
		elseif char == nil then
			tracer.destroy()
			warn('[-] ENCRYPT ESP > Character is nil; Removed tracer') 
		end

		task.wait(update_speed)
	end)

	return tracer, line
end

return encrypt_esp
