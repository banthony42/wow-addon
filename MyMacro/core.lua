

local globalMacroLimit = 120
local characaterMacroLimit = 18

local _, unitPlayerRealm = UnitFullName("player")
local unitPlayer = UnitNameUnmodified("player")
-- TODO fixme: attempt to index local 'unitPlayerRealm' (a nil value)
local playerUniqId = unitPlayer:sub(1, 7) .. unitPlayerRealm:sub(1, 7)

--- Copy all character macro to the global macro tab.
local function DumpCharacaterMacroToGlobal()
   local globalMacro, characterMacro = GetNumMacros()
   local globalMacroFreeSlot = globalMacroLimit - globalMacro

   if globalMacroFreeSlot < characterMacro then
      print(string.format("Can't dump character macro to globals: %d free global slot, but try to dump %d.",globalMacroFreeSlot, characterMacro))
      return
   end

   if characterMacro then
      for index = globalMacroLimit + 1, globalMacroLimit + characterMacro do
         local name, icon, body, _ = GetMacroInfo(index)
         if body then
            local charIndex = index - globalMacroLimit
            CreateMacro(playerUniqId..charIndex, icon, body, false)
         end
      end
   end
end

--- Delete all global macros
local function DeleteGlobalMacro()
   local globalMacroNumber, _ = GetNumMacros()
   for index = globalMacroNumber, 1, -1 do
      DeleteMacro(index)
   end
end

--- Delete all per character macros
local function DeletePerCharMacro()
   local _, perCharMacro = GetNumMacros()
   for index = globalMacroLimit + perCharMacro, 1, -1 do
      DeleteMacro(index)
   end
end

--- Load the 18 first macro from global tab to character tab.
--- 18 is a maximum, the function start to load from the first global
--- macro, and stop when a limit is reached. (global or per character)
---@param start number The offset where the load should start in global macro
---@return number loadedMacro
local function LoadGlobalMacroToCharacter(start)
   local globalMacro, characterMacro = GetNumMacros()
   local characterFreeSlot = characaterMacroLimit - characterMacro
   local macroLoaded = 0
   start = start and start or 0

   for index = 1 + start, characterFreeSlot do
      local _, icon, body, _ = GetMacroInfo(index)
      local macroId = CreateMacro(" ", icon, body, true)

      if macroId then
         macroLoaded = macroLoaded + 1
      end
   end
   return macroLoaded
end

SLASH_MYMACRO1 = "/mymacro"
SlashCmdList["MYMACRO"] = function(msg)
   if msg == "dump" then
      DumpCharacaterMacroToGlobal()
      print("All character macro has been dump into global macro.")

   elseif msg == "load" then
      local loadedMacro = LoadGlobalMacroToCharacter()
      print(string.format("First %d globals macro has been loaded in %s macro tab.", loadedMacro, unitPlayer))

   elseif msg == "rmglob" then
      DeleteGlobalMacro()
      print("All global macro has been deleted.")

   elseif msg == "rmperchar" then
      DeletePerCharMacro()
      print("All character macro has been deleted.")

   elseif msg == "help" then
      print([[
mymacro help you to easily copy character macro into your global macros
then you could load global into another character macro.

/mymacro   dump
Copy all character macro into the globals macro.

/mymacro   load
Load the first 18 global macro into your character macro tab.

/mymacro   rmglob
Delete all your global macros.

/mymacro   rmperchar
Delete all your character macros.
]])
   end
end 

