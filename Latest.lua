--[[

---//==================================================\\---
--|| > About Script										||--
---\===================================================//---

	Script:			GodChat - The In-Game Translator
	Version:		1.00
	Script Date:	
	Author:			Devn

---//==================================================\\---
--|| > Changelog										||--
---\===================================================//---

	Version 1.00:
		- Initial script release.

--]]

-- Temporary Anti-AFK (Please remove before release)
function OnTick()
	if (not _ANTI_AFK or (_ANTI_AFK <= GetGameTimer())) then
		_ANTI_AFK = GetGameTimer() + 40
		local position = myHero + (Vector(mousePos) - myHero):normalized() * 250
		myHero:MoveTo(position.x, position.z)
	end
end

---//==================================================\\---
--|| > User Variables									||--
---\===================================================//---

-- Public user variables.
_G.GodLib_EnableDebugMode 	= false
_G.GodLib_LogTranslations	= false

---//==================================================\\---
--|| > Initialization									||--
---\===================================================//---

-- Script variables.
_G.GodLib_ScriptTitle		= "GodChat - The In-Game Translator"
_G.GodLib_ScriptName 		= "GodChat"
_G.GodLib_ScriptVersion		= "1.00"

-- Required libraries.
_G.GodLib_RequiredLibraries	= {
	["JSON"]				= { "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua", false },
}

-- Load GodLib.
assert(load(Base64Decode("LS0tLy89PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PVxcLS0tDQotLXx8ID4gSW5pdGlhbGl6YXRpb24JCQkJCQkJCQl8fC0tDQotLS1cPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ly8tLS0NCg0KbG9jYWwgTGlicmFyeVBhdGgJPSBMSUJfUEFUSC4uIkdvZExpYi5sdWEiDQpsb2NhbCBEb3dubG9hZFBhdGgJPSAiaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0dvZFNjcmlwdHMvR29kTGliL21hc3Rlci9MYXRlc3QubHVhIg0KDQotLS0vLz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09XFwtLS0NCi0tfHwgPiBMb2FkIEZ1bmN0aW9ucwkJCQkJCQkJCXx8LS0NCi0tLVw9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0vLy0tLQ0KDQpsb2NhbCBmdW5jdGlvbiBSZWFkRmlsZShwYXRoKQ0KDQoJbG9jYWwgZmlsZQkJPSBpby5vcGVuKHBhdGgsICJyIikNCglsb2NhbCBjb250ZW50CT0gZmlsZTpyZWFkKCIqYWxsIikNCgkNCglmaWxlOmNsb3NlKCkNCglyZXR1cm4gY29udGVudA0KDQplbmQNCg0KbG9jYWwgZnVuY3Rpb24gU2FmZUxpbmsodXJsKQ0KDQoJcmV0dXJuIHVybC4uIj9yYW5kPSIuLm1hdGgucmFuZG9tKDEsIDEwMDAwKQ0KDQplbmQNCg0KbG9jYWwgZnVuY3Rpb24gUHJpbnRMb2NhbChtZXNzYWdlKQ0KDQoJUHJpbnRDaGF0KCI8Zm9udCBjb2xvcj1cIiNmNzgxYmVcIj5Hb2RMaWI6PC9mb250PiA8Zm9udCBjb2xvcj1cIiNiZWY3ODFcIj4iLi5tZXNzYWdlLi4iPC9mb250PiIpDQoNCmVuZA0KDQpsb2NhbCBmdW5jdGlvbiBMb2FkTGlicmFyeSgpDQoNCglpZiAoRmlsZUV4aXN0KExpYnJhcnlQYXRoKSkgdGhlbg0KCQlhc3NlcnQobG9hZChSZWFkRmlsZShMaWJyYXJ5UGF0aCksIG5pbCwgInQiLCBfRU5WKSkoKQ0KCQlfRy5Hb2RMaWJfTG9hZGVkID0gdHJ1ZQ0KICAgIGVsc2UNCgkJUHJpbnRMb2NhbCgiRG93bmxvYWRpbmcsIHBsZWFzZSB3YWl0Li4uIikNCiAgICAgICAgRG93bmxvYWRGaWxlKFNhZmVMaW5rKERvd25sb2FkUGF0aCksIExpYnJhcnlQYXRoLCBmdW5jdGlvbigpDQoJCQlQcmludExvY2FsKCJEb3dubG9hZGVkIHN1Y2Nlc3NmdWxseSEgUGxlYXNlIHJlbG9hZCBzY3JpcHQgKGRvdWJsZSBGOSkuIikNCgkJZW5kKQ0KICAgIGVuZA0KICAgIA0KZW5kDQoNCi0tLS8vPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT1cXC0tLQ0KLS18fCA+IExvYWQgTGlicmFyeVBhdGgJCQkJCQkJCQl8fC0tDQotLS1cPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ly8tLS0NCg0KTG9hZExpYnJhcnkoKQ=="), nil, "bt", _ENV))()
if (not _G.GodLib_Loaded) then return end

-- Setup JSON.
JSON = assert(loadfile(Format("{1}JSON.lua", LIB_PATH)))()

---//==================================================\\---
--|| > Callback Handlers								||--
---\===================================================//---

Callbacks:Bind("Initialize", function()

	SetupVariables()
	SetupConfig()

end)

Callbacks:Bind("Unload", function()

	if (_G.GodLib_LogTranslations) then
		LOG_FILE:close()
	end

end)

Callbacks:Bind("SendChat", function(text)

	if (IsPrinting) then
		IsPrinting = false
		return
	end
	
	if (not Config.Outgoing.Enabled) then
		return
	end
	
	local all = false
	local from = ToArray[Config.Outgoing.From]
	local to = ToArray[Config.Outgoing.To]
	
	if (from == to) then
		return
	end
	
	if ((text[1] == "/") and not text:lower():starts("/all")) then
		return
	end
	
	if (text:lower():starts("/all")) then
		all = true
		text = text:gsub("/all ", "")
	end
	
	BlockChat()
	
	Translate(text, from, to, false, function(result)
		if (result) then
			if (all) then
				result = Format("/all {1}", { result })
			end
			DelayAction(function()
				IsPrinting = true
				SendChat(result)
			end)
		else
			DelayAction(function()
				IsPrinting = true
				SendChat(text)
			end)
		end
	end)

end)

Callbacks:Bind("RecieveChat", function(username, text)

	if (not Config.Incoming.Self and (username == myHero.name)) then
		return
	end

	if (not Config.Incoming.Enabled) then
		return
	end
	
	local from = FromArray[Config.Incoming.From]
	local to = ToArray[Config.Incoming.To]
	
	if (from == to) then
		return
	end
	
	Translate(text, from, to, true, function(result, source, to)
		if (result and not (source == to)) then
			PrintLocal(result)
		end
	end)
	
end)

---//==================================================\\---
--|| > Script Setup										||--
---\===================================================//---

function SetupVariables()
	
	if (_G.GodLib_LogTranslations) then
		LOG_FILE = io.open(Format("{1}GodChat - Log.txt", SCRIPT_PATH), "a+")
	end
	
	IsPrinting	= false
	Config		= MenuConfig(ScriptName, ScriptTitle)
	
	FromArray	= { "auto", "en", "de", "es", "fr", "pl", "hu", "sq", "sv", "cs", "ro", "da", "bg", "pt", "sr", "fi", "lv", "sk", "sl", "tr", "el", "ms", "zh-CN", "zh-TW", "mk", "ru", "ko", "it", "be", "vi", "uk" }
	ToArray		= { "en", "de", "es", "fr", "pl", "hu", "sq", "sv", "cs", "ro", "da", "bg", "pt", "sr", "fi", "lv", "sk", "sl", "tr", "el", "ms", "zh-CN", "zh-TW", "mk", "ru", "ko", "it", "be", "vi", "uk" }
	
	Accents		= {
		["a"]	= { "%E0", "%E1", "%E2", "%E3", "%E4", "%E5" },
		["c"]	= { "%E7" },
		["e"]	= { "%E8", "%E9", "%EA", "%EB" },
		["i"]	= { "%EC", "%ED", "%EE", "%EF" },
		["n"]	= { "%F1" },
		["o"]	= { "%F2", "%F3", "%F4", "%F5", "%F6" },
		["u"]	= { "%F9", "%FA", "%FB", "%FC" },
		["y"]	= { "%FD", "%FF" },
		["A"]	= { "%C0", "%C1", "%C2", "%C3", "%C4", "%C5" },
		["C"]	= { "%C7" },
		["E"]	= { "%C8", "%C9", "%CA", "%CB" },
		["I"]	= { "%CC", "%CD", "%CE", "%CF" },
		["N"]	= { "%D1" },
		["O"]	= { "%D2", "%D3", "%D4", "%D5", "%D6" },
		["U"]	= { "%D9", "%DA", "%DB", "%DC" },
		["Y"]	= { "%DD" },
	}
	
end

function SetupConfig()

	-- Advanced Settings
	Config:Menu("Incoming", "Settings: Incoming Text")
	Config:Menu("Outgoing", "Settings: Outgoing Text")
	
	-- Advanced Settings > Incoming Text
	Config.Incoming:Toggle("Enabled", "Enabled", true)
	Config.Incoming:Toggle("Self", "Translate my Text (Debug)", false)
	Config.Incoming:Separator()
	Config.Incoming:DropDown("From", "Translate From:", 1, FromArray)
	Config.Incoming:DropDown("To", "Translate To:", 1, ToArray)
	
	-- Advanced Settings > Outgoing Text
	Config.Outgoing:Toggle("Enabled", "Enabled", true)
	Config.Outgoing:Separator()
	Config.Outgoing:DropDown("From", "Translate From:", 1, ToArray)
	Config.Outgoing:DropDown("To", "Translate To:", 1, ToArray)
	
	-- Settings
	Config:Separator()
	Config:Title("Settings")
	Config:Toggle("ChineseServer", "Use Chinese Trans. Server", false)
	Config:Toggle("RemoveAccents", "Remove Accents from Translations", false)
	
	-- About
	Config:Separator()
	Config:Info("Version", ScriptVersion)
	Config:Info("Build Date", ScriptDate)
	Config:Info("Author", "Devn")

end

---//==================================================\\---
--|| > Misc Functions									||--
---\===================================================//---

function Translate(text, from, to, langs, func)

	local host = Format("translate.google.{1}", Config.ChineseServer and "cn" or "com")
	local path = Format("/translate_a/t?client=j&text={1}&hl=en&sl={2}&tl={3}", text:gsub(" ", "+"), from, to)
	
	GetAsyncWebResult(host, path, function(result)
		if (result) then
			if (result:lower():find("captcha")) then
				DelayAction(function()
					Translate(text, from, to, langs, func)
				end)
				return
			end
			local results = JSON:decode(result)
			local translation = ""
			for _, sentence in ipairs(results.sentences) do
				local trans = sentence.trans
				local safe = ""
				if (Config.RemoveAccents) then
					for i = 1, #trans do
						local character = trans:sub(i, i)
						local urlChar = string.urlencode(character)
						local isAccent = false
						for output, input in pairs(Accents) do
							if (table.contains(input, urlChar)) then
								isAccent = true
								safe = safe..output
								break
							end
						end
						if (not isAccent)then
							safe = safe..character
						end
					end
				else
					safe = trans
				end
				translation = translation..safe
			end
			local source = results.src
			if (not source) then
				source = from
			end
			if (_G.GodLib_LogTranslations) then
				LOG_FILE:write(Format("Input = {1} || Output = {2} || Result = {3} || From = {4} || To = {5} || Source = {6}\n", text, result, translation, from, to, source))
				LOG_FILE:flush()
			end
			if (langs) then
				translation = Format("({1} => {2}) {3}", source, to, translation)
			end
			func(translation, source, to)
		end
	end)

end
