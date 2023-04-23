local M = {}

M.blend = function(color1, color2, ratio)
	local r1, g1, b1 = color1:match("#(%x%x)(%x%x)(%x%x)")
	local r2, g2, b2 = color2:match("#(%x%x)(%x%x)(%x%x)")

	-- Convert hex color codes to decimal values
	r1, g1, b1 = tonumber(r1, 16), tonumber(g1, 16), tonumber(b1, 16)
	r2, g2, b2 = tonumber(r2, 16), tonumber(g2, 16), tonumber(b2, 16)

	-- Calculate the blended color
	local r = math.floor(r1 + (r2 - r1) * ratio)
	local g = math.floor(g1 + (g2 - g1) * ratio)
	local b = math.floor(b1 + (b2 - b1) * ratio)

	-- Convert decimal values back to hex color code
	return string.format("#%02x%02x%02x", r, g, b)
end

M.saturate = function(hex, percent)
	-- Remove "#" character if present
	hex = hex:gsub("#", "")

	-- Convert hex to RGB
	local r = tonumber(string.sub(hex, 1, 2), 16)
	local g = tonumber(string.sub(hex, 3, 4), 16)
	local b = tonumber(string.sub(hex, 5, 6), 16)

	-- Calculate saturation adjustment factor
	local satAdjust = (100 - percent) / 100

	-- Find the maximum color value
	local maxColor = math.max(r, g, b)

	-- If the maximum color value is 0, return black
	if maxColor == 0 then
		return "#000000"
	end

	-- Adjust each color channel
	r = math.floor(((r / maxColor) + satAdjust) * maxColor)
	g = math.floor(((g / maxColor) + satAdjust) * maxColor)
	b = math.floor(((b / maxColor) + satAdjust) * maxColor)

	-- Ensure that the RGB values are within the valid range
	r = math.max(0, math.min(r, 255))
	g = math.max(0, math.min(g, 255))
	b = math.max(0, math.min(b, 255))

	-- Convert RGB back to hex
	return string.format("#%02x%02x%02x", r, g, b)
end

-- Helper function to convert a HSL color value to RGB
-- Not to be used directly, use M.hsl2rgb instead
M.hsl2rgb_helper = function(p, q, a)
	if a < 0 then
		a = a + 6
	end
	if a >= 6 then
		a = a - 6
	end
	if a < 1 then
		return (q - p) * a + p
	elseif a < 3 then
		return q
	elseif a < 4 then
		return (q - p) * (4 - a) + p
	else
		return p
	end
end

-- Convert a HSL color value to RGB
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
-- @return r: Red (0-255)
-- @return g: Green (0-255)
-- @return b: Blue (0-255)
M.hsl2rgb = function(h, s, l)
	local t1, t2, r, g, b

	h = h / 60
	if l <= 0.5 then
		t2 = l * (s + 1)
	else
		t2 = l + s - (l * s)
	end

	t1 = l * 2 - t2
	r = M.hsl2rgb_helper(t1, t2, h + 2) * 255
	g = M.hsl2rgb_helper(t1, t2, h) * 255
	b = M.hsl2rgb_helper(t1, t2, h - 2) * 255

	return r, g, b
end

-- Convert a HSL color value to hex
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
-- @returns hex color value
M.hsl2hex = function(h, s, l)
	local r, g, b = M.hsl2rgb(h, s, l)
	return M.rgb2hex(r, g, b)
end

-- Desaturate or saturate a color by a given percentage
-- @param hex The hex color value
-- @param percent The percentage to desaturate or saturate the color.
--                Negative values desaturate the color, positive values saturate it
-- @return The hex color value
M.change_hex_saturation = function(hex, percent)
	local h, s, l = M.hex2hsl(hex)
	s = s + (percent / 100)
	if s > 1 then
		s = 1
	end
	if s < 0 then
		s = 0
	end
	return M.hsl2hex(h, s, l)
end

return M
