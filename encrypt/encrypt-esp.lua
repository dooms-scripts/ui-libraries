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
local encrypt_esp = { version = 'e1.0.3' }
-- warn(__, encrypt_esp.version)

-- [ SERVICES ] ------------------------------------------------------------------------------------
local run = game:GetService('RunService')
local players = game:GetService('Players')
local camera = game:GetService('Workspace').CurrentCamera

-- [ FUNCTIONS ] -----------------------------------------------------------------------------------
function encrypt_esp.new_highlight(player, properties)
	local highlight, default = {}, {
		color = Color3.fromRGB(255, 255, 255),
		outline_color = Color3.fromRGB(0, 0, 0),
		outline_transparency = 0,
		fill_transparency = 0,
		outline = false,
	}

	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end

	local properties    = properties or default
	local color         = properties.color or default.color
	local outline	    = properties.outline or default.outline
	local outline_color = properties.outline_color or default.outline_color
	local outline_transparency = properties.outline_transparency or default.outline_transparency
	local fill_transparency = properties.fill_transparency or default.fill_transparency
	
	local char = player.Character or player.CharacterAdded:Wait()
	
	local highlight = nil
	local highlight_connection = nil

	function highlight.destroy()
		if highlight then highlight:Destroy()
		if highlight_connection then highlight_connection:Disconnect() end
	end

	function create_highlight()
		highlight = Instance.new('Highlight')
		highlight.Parent = char
		highlight.DepthMode = 'AlwaysOnTop'
		highlight.Adornee = char
		highlight.Enabled = true
		highlight.FillColor = color
		highlight.OutlineColor = outline_color
		highlight.OutlineTransparency = 1
		highlight.FillTransparency = fill_transparency
		
		if outline then
			highlight.OutlineTransparency = outline_transparency
		end
	end
	
	highlight_connection = player.CharacterAdded:Connect(create_highlight)

	return highlight
end

function encrypt_esp.new_box(player, properties)
	local box, default = {}, {
		color = Color3.fromRGB(255, 255, 255),
		outline_color = Color3.fromRGB(0, 0, 0),
		thickness = 1,
		update_speed = 0,
		outline = false,
	}

	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end

	local properties    = properties or default
	local color         = properties.color or default.color
	local thickness     = properties.thickness or default.thickness
	local update_speed  = properties.update_speed or default.update_speed
	local outline		= properties.outline or default.outline
	local outline_color = properties.outline_color or default.outline_color

	local bound1_outline = Drawing.new('Line')
	bound1_outline.Color = outline_color
	bound1_outline.Thickness = 3
	bound1_outline.Visible = outline
	local bound1 = Drawing.new('Line')
	bound1.Color = color
	bound1.Thickness = thickness

	local bound2_outline = Drawing.new('Line')
	bound2_outline.Color = outline_color
	bound2_outline.Thickness = 3
	bound2_outline.Visible = outline
	local bound2 = Drawing.new('Line')
	bound2.Color = color
	bound2.Thickness = thickness

	local bound3_outline = Drawing.new('Line')
	bound3_outline.Color = outline_color
	bound3_outline.Thickness = 3
	bound3_outline.Visible = outline
	local bound3 = Drawing.new('Line')
	bound3.Color = color
	bound3.Thickness = thickness

	local bound4_outline = Drawing.new('Line')
	bound4_outline.Color = outline_color
	bound4_outline.Thickness = 3
	bound4_outline.Visible = outline
	local bound4 = Drawing.new('Line')
	bound4.Color = color
	bound4.Thickness = thickness

	function box.visibility(bool)
		if outline then bound1_outline.Visible = bool end
		if outline then bound2_outline.Visible = bool end
		if outline then bound3_outline.Visible = bool end
		if outline then bound4_outline.Visible = bool end

		bound1.Visible = bool
		bound2.Visible = bool
		bound3.Visible = bool
		bound4.Visible = bool
	end

	function box.destroy()
		bound1_outline:Remove()
		bound2_outline:Remove()
		bound3_outline:Remove()
		bound4_outline:Remove()
		bound1:Remove()
		bound2:Remove()
		bound3:Remove()
		bound4:Remove()
	end

	function box.update(new_properties)
		local properties    = new_properties or default
		local color         = new_properties.color or default.color
		local thickness     = new_properties.thickness or default.thickness

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

			bound1_outline.From = Vector2.new(bound_positions[1].X, bound_positions[1].Y)
			bound1_outline.To = Vector2.new(bound_positions[2].X, bound_positions[2].Y)
			bound1.From = Vector2.new(bound_positions[1].X, bound_positions[1].Y)
			bound1.To = Vector2.new(bound_positions[2].X, bound_positions[2].Y)

			bound2_outline.From = Vector2.new(bound_positions[2].X, bound_positions[2].Y)
			bound2_outline.To = Vector2.new(bound_positions[3].X, bound_positions[3].Y)
			bound2.From = Vector2.new(bound_positions[2].X, bound_positions[2].Y)
			bound2.To = Vector2.new(bound_positions[3].X, bound_positions[3].Y)

			bound3_outline.From = Vector2.new(bound_positions[3].X, bound_positions[3].Y)
			bound3_outline.To = Vector2.new(bound_positions[4].X, bound_positions[4].Y)
			bound3.From = Vector2.new(bound_positions[3].X, bound_positions[3].Y)
			bound3.To = Vector2.new(bound_positions[4].X, bound_positions[4].Y)

			bound4_outline.From = Vector2.new(bound_positions[4].X, bound_positions[4].Y)
			bound4_outline.To = Vector2.new(bound_positions[1].X, bound_positions[1].Y)
			bound4.From = Vector2.new(bound_positions[4].X, bound_positions[4].Y)
			bound4.To = Vector2.new(bound_positions[1].X, bound_positions[1].Y)
		elseif char == nil then
			box.destroy()
			-- warn('[-] ENCRYPT ESP > Character is nil; Removed bounding box') 
		end

		task.wait(properties.update_speed)
	end)

	local drawings = { bound1, bound2, bound3, bound4 }
	
	return box --, drawings
	--return drawings
end

function encrypt_esp.new_text(player, properties)
	local text, default = {}, {
		color = Color3.fromRGB(255, 255, 255),
		outline_color = Color3.fromRGB(0, 0, 0),
		thickness = 1,
		outline = false,
		update_speed = 0,
	}

	local properties		 = properties or default
	local color				 = properties.color or default.color_picker
	local outline  			 = properties.outline or default.outline
	local outline_color		 = properties.outline_color or default.outline_color
	local update_speed		 = properties.update_speed or default.update_speed

	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end

	local text_drawing = Drawing.new('Text')
	text_drawing.Text = player.DisplayName or player.Name
	text_drawing.Color = color
	text_drawing.Visible = true

	if outline then
		text_drawing.Outline = outline
		text_drawing.OutlineColor = outline_color
	end

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

			text_drawing.Position = Vector2.new(vector.X + 10, vector.Y - 10)
		elseif char == nil then
			text.destroy()
			-- warn('[-] ENCRYPT ESP > Character is nil; Removed text') 
		end

		task.wait(properties.update_speed)
	end)

	return text --, text_drawing
	--return text_drawing
end

function encrypt_esp.new_tracer(player, properties)
	local tracer, default = {}, {
		color = Color3.fromRGB(255, 255, 255),
		outline_color = Color3.fromRGB(0, 0, 0),
		thickness = 1,
		update_speed = 0,
		outline = false,
	}

	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end

	local properties    = properties or default
	local thickness     = properties.thickness or default.thickness
	local color         = properties.color or default.color
	local outline		= properties.outline or default.outline
	local outline_color = properties.outline_color or default.outline_color
	local update_speed  = properties.update_speed or default.update_speed

	local outline_drawing = Drawing.new('Line')
	outline_drawing.Thickness = 3
	outline_drawing.Color = outline_color
	outline_drawing.Visible = outline

	local line = Drawing.new('Line')
	line.Color = color
	line.Thickness = thickness
	line.Visible = true

	function tracer.visibility(bool)
		if outline then outline_drawing.Visible = bool end
		line.Visible = bool
	end

	function tracer.destroy()
		line:Remove()
		outline_drawing:Remove()
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

			outline_drawing.From = center
			outline_drawing.To = Vector2.new(vector.X, vector.Y)

			line.From = center
			line.To = Vector2.new(vector.X, vector.Y)
		elseif char == nil then
			tracer.destroy()
		end

		task.wait(update_speed)
	end)

	return tracer --, line
	--return line
end

function encrypt_esp.draw_skeleton(player, properties)
	local skeleton, default = {}, {
		color = Color3.fromRGB(255, 255, 255),
		outline_color = Color3.fromRGB(0, 0, 0),
		thickness = 1,
		update_speed = 0,
		outline = false,
	}
	
	if player == nil then return warn('[!] ENCRYPT ESP > Player is nil.') end
	if player.Character == nil then return warn('[!] ENCRYPT ESP > Character is nil.') end
	
	local properties    = properties or default
	local color         = properties.color or default.color
	local thickness     = properties.thickness or default.thickness
	local update_speed  = properties.update_speed or default.update_speed
	local outline       = properties.outline or default.outline
	local outline_color = properties.outline_color or default.outline_color

	function attachment_to_vector(attachment)
		local camera = workspace.CurrentCamera
		local vector, _ = camera:WorldToViewportPoint(attachment.WorldPosition)
		return Vector2.new(vector.X, vector.Y)
	end

	function new_line()
		local drawing = Drawing.new('Line')
		drawing.Visible = true
		drawing.Color = color
	
		return drawing
	end

    	head = new_line()
    	waist = new_line()
    	left_hand = new_line()
    	left_shoulder = new_line()
    	right_hand = new_line()
    	right_shoulder = new_line()
    	left_arm_joint = new_line()
    	right_arm_joint = new_line()
    	left_foot = new_line()
    	left_hip = new_line()
    	right_foot = new_line()
    	right_hip = new_line()
    	right_waist_joint = new_line()
    	left_waist_joint = new_line()

	function skeleton.visibility(bool)
		head.Visible = bool
		waist.Visible = bool
		left_hand.Visible = bool
		left_shoulder.Visible = bool
		right_hand.Visible = bool
		right_shoulder.Visible = bool
		left_arm_joint.Visible = bool
		right_arm_joint.Visible = bool
		left_foot.Visible = bool
		left_hip.Visible = bool
		right_foot.Visible = bool
		right_hip.Visible = bool
		right_waist_joint.Visible = bool
		left_waist_joint.Visible = bool
	end

	function skeleton.destroy()
		head:Remove()
		waist:Remove()
		left_hand:Remove()
		left_shoulder:Remove()
		right_hand:Remove()
		right_shoulder:Remove()
		left_arm_joint:Remove()
		right_arm_joint:Remove()
		left_foot:Remove()
		left_hip:Remove()
		right_foot:Remove()
		right_hip:Remove()
		right_waist_joint:Remove()
		left_waist_joint:Remove()
	end

	--> draw adornment
	local line_adornment = Instance.new('LineHandleAdornment')
	line_adornment.Length = 2
	line_adornment.Thickness = 2
	line_adornment.ZIndex = 999
	line_adornment.Color3 = color
	line_adornment.AlwaysOnTop = true

	run.Stepped:Connect(function()
		local char = player.Character

		if char then
			pcall(function()
			line_adornment.Parent = char.UpperTorso
			line_adornment.Adornee = char.UpperTorso
					
			local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')
			local _, on_screen = camera:WorldToViewportPoint(root.Position)
			
			skeleton.visibility(on_screen)
			
			--> get attachments
			local attachments = {
				--> Head
				Head = char["Head"]["HatAttachment"],
				Neck = char["Head"]["NeckRigAttachment"],
				
				--> Hip
				Waist = char["LowerTorso"]["WaistRigAttachment"],
				
				-- Left Arm
				LeftHand = char["LeftHand"]["LeftGripAttachment"],
				LeftElbow = char["LeftUpperArm"]["LeftElbowRigAttachment"],
				LeftShoulder = char["LeftUpperArm"]["LeftShoulderAttachment"],
				
				-- Right Arm
				RightHand = char["RightHand"]["RightGripAttachment"],
				RightElbow = char["RightUpperArm"]["RightElbowRigAttachment"],
				RightShoulder = char["RightUpperArm"]["RightShoulderAttachment"],
				
				--> Left Leg
				LeftFoot = char["LeftFoot"]["LeftFootAttachment"],
				LeftKnee = char["LeftLowerLeg"]["LeftKneeRigAttachment"],
				LeftHip = char["LowerTorso"]["LeftHipRigAttachment"],
				
				--> Right Leg
				RightFoot = char["RightFoot"]["RightFootAttachment"],
				RightKnee = char["RightLowerLeg"]["RightKneeRigAttachment"],
				RightHip = char["RightUpperLeg"]["RightHipRigAttachment"],
			}
	
			if on_screen then
				head.From = attachment_to_vector(attachments.Neck)
				head.To = attachment_to_vector(attachments.Head)
				
				waist.From = attachment_to_vector(attachments.Neck)
				waist.To = attachment_to_vector(attachments.Waist)
				
				left_hand.From = attachment_to_vector(attachments.LeftHand)
				left_hand.To = attachment_to_vector(attachments.LeftElbow)
				
				left_shoulder.From = attachment_to_vector(attachments.LeftElbow)
				left_shoulder.To = attachment_to_vector(attachments.LeftShoulder)
				
				right_hand.From = attachment_to_vector(attachments.RightHand)
				right_hand.To = attachment_to_vector(attachments.RightElbow)
				
				right_shoulder.From = attachment_to_vector(attachments.RightElbow)
				right_shoulder.To = attachment_to_vector(attachments.RightShoulder)
				
				left_arm_joint.From = attachment_to_vector(attachments.LeftShoulder)
				left_arm_joint.To = attachment_to_vector(attachments.Neck)
				
				right_arm_joint.From = attachment_to_vector(attachments.RightShoulder)
				right_arm_joint.To = attachment_to_vector(attachments.Neck)
				
				left_foot.From = attachment_to_vector(attachments.LeftFoot)
				left_foot.To = attachment_to_vector(attachments.LeftKnee)
				    
				left_hip.From = attachment_to_vector(attachments.LeftKnee)
				left_hip.To = attachment_to_vector(attachments.LeftHip)
				
				right_foot.From = attachment_to_vector(attachments.RightFoot)
				right_foot.To = attachment_to_vector(attachments.RightKnee)
				
				right_hip.From = attachment_to_vector(attachments.RightKnee)
				right_hip.To = attachment_to_vector(attachments.RightHip)
				
				right_waist_joint.From = attachment_to_vector(attachments.RightHip)
				right_waist_joint.To = attachment_to_vector(attachments.Waist)
				
				left_waist_joint.From = attachment_to_vector(attachments.LeftHip)
				left_waist_joint.To = attachment_to_vector(attachments.Waist)
			end
			end)
		elseif char == nil then
			skeleton.destroy()
		end
	end)
	
	return skeleton
end

return encrypt_esp
