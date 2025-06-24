SLASH_TEST1 = "/test1"
SLASH_TEST2 = "/addontest1"
SlashCmdList["TEST"] = function(msg)
   print("Hello World!")
   print(GetMacroSpell())
end 

-- local tick = 2

-- local elapsed = GetTime()
-- print("Hello")
-- print(tostring(GetBuildInfo()))

-- local menu = {
--     { text = "Select an Option", isTitle = true},
--     { text = "Option 1", func = function() print("You've chosen option 1"); end },
--     { text = "Option 2", func = function() print("You've chosen option 2"); end },
--     { text = "More Options", hasArrow = true,
--         menuList = {
--             { text = "Option 3", func = function() print("You've chosen option 3"); end }
--         } 
--     }
-- }
-- -- Note that this frame must be named for the dropdowns to work.
-- local menuFrame = CreateFrame("Frame", "ExampleMenuFrame", UIParent, "UIDropDownMenuTemplate")

-- -- Make the menu appear at the cursor: 
-- EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU", 2);

-- local function frameTest()
-- local f = CreateFrame("Frame",nil,UIParent)
-- f:SetFrameStrata("BACKGROUND")
-- f:SetWidth(128) -- Set these to whatever height/width is needed 
-- f:SetHeight(64) -- for your Texture

-- local t = f:CreateTexture(nil,"BACKGROUND")
-- t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions.blp")
-- t:SetAllPoints(f)
-- f.texture = t

-- f:SetPoint("CENTER",0,0)
-- f:Show()
-- end

-- local function Update()
--     if (GetTime() - elapsed > 6) then
--         local type, data, subType, subData = GetCursorInfo()
--         print(string.format("CursorInfo: type[%s] data[%s] subtype[%s]", tostring(type), tostring(data), tostring(subType)))
--         PlaySound(SOUNDKIT.UI_80_AZERITEARMOR_BUFFAVAILABLE )
--         print("FPS:" .. tostring(GetFramerate()))
--         elapsed = GetTime()
--         frameTest()
--     end
--     C_Timer.After(tick, Update)
-- end

--Update()