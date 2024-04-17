# CRANBERRY SPRITE UI LIBRARY

# SHOWCASE

# HOW TO USE
> Initializing the library
```lua
local sprite = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/ui-libraries/main/cranberry-sprite/sprite.lua')()
```
	
> Library settings
```lua
-- ↓↓↓ these are optional settings, if you dont wish to edit a specific thing, simply take it out.
sprite.use_custom_cursor = true
sprite.colors = {
	accent = Color3.fromRGB(255, 0, 0) -- the main GUI color
	foreground = Color3.fromRGB(),
	background = Color3.fromRGB(),
}
```
	
> Creating a window
```lua
-- ↓↓↓ these are optional settings, if you dont wish to edit a specific thing, simply take it out.
local window = sprite:new_window({
	title = 'cranberry sprite // ui library<font color="rgb(185,185,185)"> | doom#1000</font>',
	bg_img = 'rbxassetid://15688752899',
	bg_img_transparency = 0.95,
	size = UDim2.new(0, 450, 0, 550),
	pos = UDim2.new(0, 500, 0, 200),
	draggable = true,
})
```
	
> Creating a tab
```lua
local tab = window:add_tab({
	name = 'tab'
})
```
\n
> Creating a category
```lua
local category = tab:add_category({
	name = 'category'
})
```
