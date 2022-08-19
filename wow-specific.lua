----------------------------------
--                              --
--    WoW specific functions    --
--                              --
----------------------------------




-- Creates a subheading for an interface options panel
-- where 'frame' is the frame containing the panel,
-- 'title' is the text assigned to the subheading,
-- and 'x' and 'y' are the coordinate position
-- relative to the top left corner of the panel
local function Subheading(frame, title, x, y)
	local text = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	text:SetPoint("TOPLEFT", x, y)
    text:SetText(title)
	return text
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





-- On addon-load function and frame template with delay timer
local function OnLoadFunction()
   -- do something 
end
local function delay(delay, func)
    DelayFrame.func = func
    DelayFrame.delay = delay
    DelayFrame:Show()
end
local function OnEvent(self, event, addonName)
    if addonName == "<>" then       -- replace <> with addon name
        -- do stuff
        if not DelayFrame then
            DelayFrame = CreateFrame("Frame")
            DelayFrame:Hide()
        end
        DelayFrame:SetScript("OnUpdate", function(self, elapsed)
            self.delay = self.delay - elapsed
            if self.delay <= 0 then
                self:Hide()
                self.func()
            end
        end)
        delay(5, OnLoadFunction())  -- delay time, in seconds
    end
end
local LoginFrame = CreateFrame("Frame")
LoginFrame:RegisterEvent("ADDON_LOADED")
LoginFrame:SetScript("OnEvent", OnEvent)





-- Button creator with "Secure" property inheritance
local function SecureButton(name, text, movable, width, height, x, y, frameStrata, normalTexture, pushedTexture, highlightTexture)
    -- default values if not specified
    movable = movable or true
    x = x or 0; y = y or 0
    frameStrata = frameStrata or "LOW"
    normalTexture = normalTexture or "Interface/Buttons/UI-Panel-Button-Up"
    pushedTexture = pushedTexture or "Interface/Buttons/UI-Panel-Button-Down"
    highlightTexture = highlightTexture or "Interface/Buttons/UI-Panel-Button-Highlight"
    
    local button = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
    if movable then
        button:SetMovable(true)
        button:RegisterForDrag("LeftButton")
        button:SetScript("OnDragStart",function(self) self:StartMoving() end)
        button:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
        end)
    end
    button:SetWidth(width)
    button:SetHeight(height)
    button:SetFrameStrata(frameStrata)
    button:SetPoint("TOPLEFT", x, y)
    button:SetNormalTexture(normalTexture)
    button:SetPushedTexture(pushedTexture)
    button:SetHighlightTexture(highlightTexture)
    
    local buttonText = button:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    buttonText:SetText(text)
    buttonText:SetPoint("TOPLEFT", 0, 0)
    
    button:Show()
    return button
end
