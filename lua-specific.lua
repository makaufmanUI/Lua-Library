----------------------------------
--                              --
--    Lua specific functions    --
--                              --
----------------------------------




-- Takes a string as input and returns a copy of the string
-- with the first letter of each word replaced with capitals
local function Capitalize(str)
	local capitalized = str:gsub("^%l", string.upper)     --  %l = lower case letters
	capitalized = capitalized:gsub("%s%l", string.upper)  --  %s = whitespace characters
	return capitalized
end

