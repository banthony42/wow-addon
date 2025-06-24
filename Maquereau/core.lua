local MAX_GLOBAL_MACRO = 120
local PLAYER_NAME = UnitNameUnmodified("player")
local PLAYER_CLASS, _ = UnitClassBase("player")

--- Delete all global macros
local function DeleteGlobalMacro()
   local globalMacroNumber, _ = GetNumMacros()
   for index = globalMacroNumber, 1, -1 do
      DeleteMacro(index)
   end
end

--- Delete all per character macros
local function DeleteCharacterTabMacro()
   local _, characterMacro = GetNumMacros()
   for index = MAX_GLOBAL_MACRO + characterMacro, MAX_GLOBAL_MACRO, -1 do
      DeleteMacro(index)
   end
end

--- Copy all character macro to the MacroLookupTable addon variable.
--- The MacroLookupTable will be indexed using the character class as key.
--- The SavedVariable is save on disk here:
--- E:\Games\Blizzard\World of Warcraft\_classic_era_\WTF\Account\124444335#3\SavedVariables\Maquereau.lua
local function SaveCharacaterMacro()
   local saved = 0
   local _, characterMacro = GetNumMacros()

   if characterMacro then
      for index = MAX_GLOBAL_MACRO + 1, MAX_GLOBAL_MACRO + characterMacro do -- TODO: seems the first macro is not saved
         local name, icon, body, _ = GetMacroInfo(index)

         if body then
            saved = saved + 1
            if MacroLookupTable[PLAYER_CLASS] == nil then
               MacroLookupTable[PLAYER_CLASS] = {}
            end
            table.insert(MacroLookupTable[PLAYER_CLASS], {
               name = name,
               icon = icon,
               body = body
            })
            print(string.format("Save macro id: %d ...", index))
         else
            print(string.format("Skip macro id: %d (body is empty)", index))
         end
      end
   end

   print(string.format("Maquereau: %s macro to load over %s. (Macro with empty body are ignored.)", characterMacro, saved))
end

local function DumpSavedMacroForCurrentPlayerClass()
   if MacroLookupTable[PLAYER_CLASS] == nil then
      print("No macro for this class")
   end
   for _, data in pairs(MacroLookupTable[PLAYER_CLASS]) do
      print(string.format("[%s] : icon:[%s] : %s", data.name, data.icon, data.body))
   end
end

local function LoadMacroForCurrentPlayerClass()
   local macroLoaded = 0
   if MacroLookupTable[PLAYER_CLASS] == nil then
      print("No macro for this class")
   end
   for _, data in pairs(MacroLookupTable[PLAYER_CLASS]) do
      local macroId = CreateMacro(data.name, data.icon, data.body, true)
      if macroId then
         macroLoaded = macroLoaded + 1
      end
   end

   return macroLoaded
end

if MacroLookupTable == nil then
   MacroLookupTable = {}
end

SLASH_MAQUEREAU1 = "/mq"
SlashCmdList["MAQUEREAU"] = function(msg)
   if msg == "save" then
      SaveCharacaterMacro()
      print("All character macro has been saved.")
   elseif msg == "show" then
      DumpSavedMacroForCurrentPlayerClass()
   elseif msg == "load" then
      local loadedMacro = LoadMacroForCurrentPlayerClass()
      print(string.format("%d macro for %s has been loaded in your %s macro tab.", loadedMacro, PLAYER_CLASS, PLAYER_NAME))
   elseif msg == "rm lib" then
      MacroLookupTable[PLAYER_CLASS] = nil
      print(string.format("All macros for %s has been deleted in your lib.", PLAYER_CLASS))
   elseif msg == "rm global" then
      DeleteGlobalMacro()
      print("All global macro has been deleted.")
   elseif msg == "rm char" then
      DeleteCharacterTabMacro()
      print("All character macro has been deleted.")
   elseif msg == "help" then
      print([[
Maquereau help you keeping track of you class macros:
/maquereau or /mq CMD

CMD:
help : Display this message.
save : Save all macro from this character, for the class you are playing in your lib.
load : Load all macro from your lib, in your character macro tab.
show : Show saved macros in your lib.
rm lib: Delete all saved macros in your lib.
rm global : Delete all global macros.
rm char : Delete all character macros.
]])
   end
end
