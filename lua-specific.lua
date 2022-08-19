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





-- Function template with variable number of arguments
local function FindMinimumValue(...)
    local args = {...}                  -- table containing the args
    local minimumIndex = 1
    local minimumValue = 100000000
    for index,value in ipairs(args) do  -- unpack the args & do stuff
        if value < minimumValue then
            minimumIndex = index
            minimumValue = value
        end
    end
    return minimumIndex, minimumValue
end




-- Class creation function that facilitates the creation of objects
function class(base, init)
    local c = {}
    if not init and type(base) == 'function' then
        init = base
        base = nil
    elseif type(base) == 'table' then
        for i,v in pairs(base) do c[i] = v end
        c._base = base
    end
    c.__index = c
    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj, c)
        if init then init(obj,...)
        else if base and base.init then base.init(obj, ...) end end
        return obj
    end
    c.init = init
    c.is_a = function(self, class_)
        local m = getmetatable(self)
        while m do 
            if m == class_ then return true end
            m = m._base
        end
        return false
    end
    setmetatable(c, mt)
    return c
end

-- Using this class creation function:



