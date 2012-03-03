  -----------------------------
  -- INIT
  -----------------------------
  
  --get the addon namespace
  local addon, ns = ...
  
  --get the config values
  local cfg = ns.cfg
  
  -----------------------------
  -- TAGS
  -----------------------------
  
  local numFormat = function(v)
    if v > 1E9 then
      return (floor((v/1E9)*10)/10).."b"
    elseif v > 1E6 then
      return (floor((v/1E6)*10)/10).."m"
    elseif v > 1E3 then
      return (floor((v/1E3)*10)/10).."k"
    else
      return v
    end  
  end
  
-- calculating the ammount of latters
local function utf8sub(string, i, dots)
	if string then
	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = string:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then
			return string:sub(1, pos - 1)..(dots and '..' or '')
		else
			return string
		end
	end
	end
end

-- turn hex colors into RGB format
local function hex(r, g, b)
	if r then
		if (type(r) == 'table') then
			if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
		end
		return ('|cff%02x%02x%02x'):format(r * 255, g * 255, b * 255)
	end
end

----------------
-- name color tags
oUF.Tags['Mlight:color'] = function(u, r)
	local _, class = UnitClass(u)
	local reaction = UnitReaction(u, "player")
	if (UnitIsTapped(u) and not UnitIsTappedByPlayer(u)) then
		return hex(oUF.colors.tapped)
	elseif (UnitIsPlayer(u)) then
		return hex(oUF.colors.class[class])
	elseif reaction then
		return hex(oUF.colors.reaction[reaction])
	else
		return hex(0, 0, 0)
	end
end
oUF.TagEvents['Mlight:color'] = 'UNIT_REACTION UNIT_HEALTH UNIT_POWER'

oUF.Tags['Mlight:gridcolor'] = function(u, r)
	local _, class = UnitClass(u)
	if (UnitIsPlayer(u)) then
		return hex(oUF.colors.class[class])
	else
		return hex(1, 1, 1)
	end
end
oUF.TagEvents['Mlight:gridcolor'] = 'UNIT_HEALTH'

-- name tags

oUF.Tags["Mlight:name"] = function(u, r)
	local name = UnitName(r or u)
	return utf8sub(name, 12, true)
end
oUF.TagEvents["Mlight:name"] = "UNIT_NAME_UPDATE UNIT_CONNECTION"

oUF.Tags["Mlight:shortname"] = function(u, r)
	local name = UnitName(r or u)
	return utf8sub(name, 4, false)
end
oUF.TagEvents["Mlight:shortname"] = "UNIT_NAME_UPDATE UNIT_CONNECTION"

oUF.Tags["Mlight:gridname"] = function(u, r)
	local namelength = cfg.namelength or 4
	local name = UnitName(r or u)
	return utf8sub(name, namelength, false)
end
oUF.TagEvents["Mlight:gridname"] = "UNIT_NAME_UPDATE UNIT_CONNECTION"

-------------
oUF.Tags["Mlight:hpdefault"] = function(unit)
  if not UnitIsConnected(unit) then
    return "|cff999999Off|r"
  end  
  if(UnitIsDead(unit) or UnitIsGhost(unit)) then 
    return "|cff999999Dead|r"
  end
  local min, max = UnitHealth(unit), UnitHealthMax(unit)
  local per = 0
  if max > 0 then
    per = floor(min/max*100)
  end
  local val = numFormat(min)
  
    if min~=max then
        return val.."|cffcccccc - |r"..per.."%"
    else
        if u == "player" then
		  return ""
		else
          if cfg.showhealth then
            return val.."|cffcccccc - |r"..per.."%"
		  else
		    return ""
		  end
	    end 
	end
end
oUF.TagEvents["Mlight:hpdefault"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"

oUF.Tags["Mlight:hpperc"] = function(unit)
  if not UnitIsConnected(unit) then
    return "|cff999999Off|r"
  end  
  if(UnitIsDead(unit) or UnitIsGhost(unit)) then 
    return "|cff999999Dead|r"
  end
  local min, max = UnitHealth(unit), UnitHealthMax(unit)
  local per = 0
  if max > 0 then
    per = floor(min/max*100)
  end
  return per.."%"  
end

oUF.TagEvents["Mlight:hpperc"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"

oUF.Tags["Mlight:hpraid"] = function(unit)
  if not UnitIsConnected(unit) then
    return "|cff999999Off|r"
  end  
  if(UnitIsDead(unit) or UnitIsGhost(unit)) then 
    return "|cff999999Dead|r"
  end
  local min, max = UnitHealth(unit), UnitHealthMax(unit)
  if min == max and max > 0 then
    return oUF.Tags["Mlight:gridname"](unit)
  end
  return "-"..numFormat(max-min)
end

oUF.TagEvents["Mlight:hpraid"] = "UNIT_NAME_UPDATE UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"

oUF.Tags["Mlight:offdead"] = function(unit)
  if not UnitIsConnected(unit) then
    return "|cff999999Off|r"
  end  
  if(UnitIsDead(unit) or UnitIsGhost(unit)) then 
    return "|cff999999Dead|r"
  end
end
oUF.TagEvents["Mlight:offdead"] = "UNIT_HEALTH UNIT_CONNECTION"

-- power value tags
oUF.Tags['Mlight:pp'] = function(u)
	local _, str = UnitPowerType(u)
	local min, max = UnitPower(u), UnitPowerMax(u)
	if str then
      if min~=max then
        return hex{0/255,  90/255,  180/255}..numFormat(UnitPower(u))
      else
        if u == "player" then
		  return ""
		else
          if cfg.showpower then
            return hex{0/255,  90/255,  180/255}..numFormat(UnitPower(u))
		  else
		    return ""
		  end
		end
      end
	end
end

oUF.TagEvents['Mlight:pp'] = 'UNIT_POWER UNIT_MAXPOWER'

oUF.Tags['Mlight:druidpower'] = function(u)
	local min, max = UnitPower(u, 0), UnitPowerMax(u, 0)
	return u == 'player' and UnitPowerType(u) ~= 0 and min ~= max and ('|cff5F9BFF%d%%|r |'):format(min / max * 100)
end
oUF.TagEvents['Mlight:druidpower'] = 'UNIT_POWER UNIT_MAXPOWER UPDATE_SHAPESHIFT_FORM'

-- level
oUF.Tags['Mlight:lvl'] = function(u) 
	local level = UnitLevel(u)
	local typ = UnitClassification(u)
	local color = GetQuestDifficultyColor(level)
	if level <= 0 then
		level = "??" 
		color.r, color.g, color.b = 1, 0, 0
	end
	if typ=="rareelite" then
		return hex(color)..level..'r+'
	elseif typ=="elite" then
		return hex(color)..level..'+'
	elseif typ=="rare" then
		return hex(color)..level..'r'
	else
		if u=="player" then
		    return ""
		else
			return hex(color)..level
		end
    end
end
oUF.TagEvents['Mlight:info'] = 'UNIT_LEVEL PLAYER_LEVEL_UP UNIT_CLASSIFICATION_CHANGED'

-- AltPower value tag
oUF.Tags['Mlight:altpower'] = function(unit)
	local cur = UnitPower(unit, ALTERNATE_POWER_INDEX)
	local max = UnitPowerMax(unit, ALTERNATE_POWER_INDEX)
	if(max > 0 and not UnitIsDeadOrGhost(unit)) then
		return ("%s%%"):format(math.floor(cur/max*100+.5))
	end
end
oUF.TagEvents['Mlight:altpower'] = 'UNIT_POWER'

-- LFD role tag
oUF.Tags['Mlight:LFD'] = function(u)
	local role = UnitGroupRolesAssigned(u)
	if role == "HEALER" then
		return "|cff8AFF30H|r"
	elseif role == "TANK" then
		return "|cffFFF130T|r"
	elseif role == "DAMAGER" then
		return "|cffFF6161D|r"
	end
end
oUF.TagEvents['Mlight:LFD'] = 'PLAYER_ROLES_ASSIGNED PARTY_MEMBERS_CHANGED'

-------------[[ class specific tags ]]-------------
-- special powers
oUF.Tags['Mlight:sp'] = function(u)
	local _, class = UnitClass(u)
	local SP, spcol = 0,{}
	if class == "PALADIN" then
		SP = UnitPower("player", SPELL_POWER_HOLY_POWER )
	elseif class == "WARLOCK" then
		SP = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
	end
	if SP == 1 then
		return cfg.sp1
	elseif SP == 2 then
		return cfg.sp2
	elseif SP == 3 then
		return cfg.sp3
	end
end
oUF.TagEvents['Mlight:sp'] = 'UNIT_POWER'
-- combo points
oUF.Tags['Mlight:cp'] = function(u)
	local cp = UnitExists("vehicle") and GetComboPoints("vehicle", "target") or GetComboPoints("player", "target")
	if cp == 1 then		return cfg.combo1 
	elseif cp == 2 then	return cfg.combo2
	elseif cp == 3 then	return cfg.combo3 
	elseif cp == 4 then	return cfg.combo4 
	elseif cp == 5 then	return cfg.combo5 
	end
end
oUF.TagEvents['Mlight:cp'] = 'UNIT_COMBO_POINTS'
-- shadow orbs
oUF.Tags['Mlight:orbs'] = function(u)
	local name, _, _, count, _, duration = UnitBuff("player",GetSpellInfo(77487))
	if count == 1 then
		return cfg.orbs1
	elseif count == 2 then
		return cfg.orbs2
	elseif count == 3 then
		return cfg.orbs3
	end
end
oUF.TagEvents['Mlight:orbs'] = 'UNIT_AURA'
-- water shield
oUF.Tags['Mlight:ws'] = function(u)
	local name, _, _, count, _, duration = UnitBuff("player",GetSpellInfo(52127)) 
	if count == 1 then
		return "|cffFF61611|r"
	elseif count == 2 then
		return "|cff8AFF302|r"
	elseif count == 3 then
		return "|cff8AFF303|r"
	end
end
oUF.TagEvents['Mlight:ws'] = 'UNIT_AURA'
-- lightning shield / maelstrom weapon
oUF.Tags['Mlight:ls'] = function(u)
	local lsn, _, _, lsc = UnitBuff("player",GetSpellInfo(324))
	local mw, _, _, mwc = UnitBuff("player",GetSpellInfo(53817))
	if mw and not UnitBuff("player",GetSpellInfo(52127)) then
		if mwc == 1 then
			return "|cff8AFF301|r"
		elseif mwc == 2 then
			return "|cff8AFF302|r"
		elseif mwc == 3 then
			return "|cffFFF1303|r"
		elseif mwc == 4 then
			return "|cffFFF1304|r"
		elseif mwc == 5 then
			return "|cffFF61615|r"
		end
	else
		if lsc == 1 then
			return "|cff4343431|r"
		elseif lsc == 2 then
			return "|cff4343432|r"
		elseif lsc == 7 then
			return "|cff4343437|r"
		elseif lsc == 8 then
			return "|cff4343438|r"
		elseif lsc == 9 then
			return "|cffFF61619|r"
		elseif lsc then
			return "|cff434343бн|r"
		end
	end
end
oUF.TagEvents['Mlight:ls'] = 'UNIT_AURA'
-- earth shield
oUF.earthCount = {1,2,3,4,5,6,7,8,9}
oUF.Tags['raid:earth'] = function(u) 
	local c = select(4, UnitAura(u, GetSpellInfo(974))) 
	if c then return '|cffFFCF7F'..oUF.earthCount[c]..'|r' end end
oUF.TagEvents['raid:earth'] = 'UNIT_AURA'
-- Prayer of Mending
oUF.pomCount = {1,2,3,4,5,6}
oUF.Tags['raid:pom'] = function(u) local c = select(4, UnitAura(u, GetSpellInfo(33076))) if c then return "|cffFFCF7F"..oUF.pomCount[c].."|r" end end
oUF.TagEvents['raid:pom'] = "UNIT_AURA"
-- Lifebloom
oUF.lbCount = { 1, 2, 3 }
oUF.Tags['raid:lb'] = function(u) 
	local name, _,_, c,_,_, expirationTime, fromwho,_ = UnitAura(u, GetSpellInfo(33763))
	if not (fromwho == "player") then return end
	local spellTimer = GetTime()-expirationTime
	if spellTimer > -2 then
		return "|cffFF0000"..oUF.lbCount[c].."|r"
	elseif spellTimer > -4 then
		return "|cffFF9900"..oUF.lbCount[c].."|r"
	else
		return "|cffA7FD0A"..oUF.lbCount[c].."|r"
	end
end
oUF.TagEvents['raid:lb'] = "UNIT_AURA"
-- Wild Mushroom
if select(2, UnitClass("player")) == "DRUID" then
	for i=1,3 do
		oUF.Tags['Mlight:wm'..i] = function(u)
			_,_,_,dur = GetTotemInfo(i)
			if dur > 0 then
				return cfg.wmr
			end
		end
		oUF.TagEvents['Mlight:wm'..i] = 'PLAYER_TOTEM_UPDATE'
		oUF.UnitlessTagEvents.PLAYER_TOTEM_UPDATE = true
	end
end
-- Priest
local pomCount = {"i","h","g","f","Z","Y"}
oUF.Tags['freebgrid:pom'] = function(u) 
    local name, _,_, c, _,_,_, fromwho = UnitAura(u, GetSpellInfo(41635)) 
    if fromwho == "player" then
        if(c) then return "|cff66FFFF"..pomCount[c].."|r" end 
    else
        if(c) then return "|cffFFCF7F"..pomCount[c].."|r" end 
    end
end
oUF.TagEvents['freebgrid:pom'] = "UNIT_AURA"

oUF.Tags['freebgrid:rnw'] = function(u)
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(139))
    if(fromwho == "player") then
        local spellTimer = GetTime()-expirationTime
        if spellTimer > -2 then
            return "|cffFF0000"..x.."|r"
        elseif spellTimer > -4 then
            return "|cffFF9900"..x.."|r"
        else
            return "|cff33FF33"..x.."|r"
        end
    end
end
oUF.TagEvents['freebgrid:rnw'] = "UNIT_AURA"

oUF.Tags['freebgrid:rnwTime'] = function(u)
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(139))
    if(fromwho == "player") then return getTime(expirationTime) end 
end
oUF.TagEvents['freebgrid:rnwTime'] = "UNIT_AURA"

oUF.Tags['freebgrid:pws'] = function(u) if UnitAura(u, GetSpellInfo(17)) then return "|cff33FF33"..x.."|r" end end
oUF.TagEvents['freebgrid:pws'] = "UNIT_AURA"

oUF.Tags['freebgrid:ps'] = function(u) if UnitAura(u, GetSpellInfo(33206)) then return "|cffFF00FF"..x.."|r" end end
oUF.TagEvents['freebgrid:ps'] = "UNIT_AURA"

oUF.Tags['freebgrid:gs'] = function(u) if UnitAura(u, GetSpellInfo(47788)) then return "|cffFFFFFF"..x.."|r" end end
oUF.TagEvents['freebgrid:gs'] = "UNIT_AURA"

oUF.Tags['freebgrid:ws'] = function(u) if UnitDebuff(u, GetSpellInfo(6788)) then return "|cffFF9900"..x.."|r" end end
oUF.TagEvents['freebgrid:ws'] = "UNIT_AURA"

oUF.Tags['freebgrid:fw'] = function(u) if UnitAura(u, GetSpellInfo(6346)) then return "|cff8B4513"..x.."|r" end end
oUF.TagEvents['freebgrid:fw'] = "UNIT_AURA"

oUF.Tags['freebgrid:sp'] = function(u) if not UnitAura(u, GetSpellInfo(79107)) then return "|cff9900FF"..x.."|r" end end
oUF.TagEvents['freebgrid:sp'] = "UNIT_AURA"

oUF.Tags['freebgrid:fort'] = function(u) if not(UnitAura(u, GetSpellInfo(79105)) or UnitAura(u, GetSpellInfo(6307)) or UnitAura(u, GetSpellInfo(469))) then return "|cff00A1DE"..x.."|r" end end
oUF.TagEvents['freebgrid:fort'] = "UNIT_AURA"

oUF.Tags['freebgrid:pwb'] = function(u) if UnitAura(u, GetSpellInfo(81782)) then return "|cffEEEE00"..x.."|r" end end
oUF.TagEvents['freebgrid:pwb'] = "UNIT_AURA"

-- Druid
local lbCount = { 4, 2, 3}
oUF.Tags['freebgrid:lb'] = function(u) 
    local name, _,_, c,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(33763))
    if(fromwho == "player") then
        local spellTimer = GetTime()-expirationTime
        if spellTimer > -2 then
            return "|cffFF0000"..lbCount[c].."|r"
        elseif spellTimer > -4 then
            return "|cffFF9900"..lbCount[c].."|r"
        else
            return "|cffA7FD0A"..lbCount[c].."|r"
        end
    end
end
oUF.TagEvents['freebgrid:lb'] = "UNIT_AURA"

oUF.Tags['freebgrid:rejuv'] = function(u)
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(774))
    if(fromwho == "player") then
        local spellTimer = GetTime()-expirationTime
        if spellTimer > -2 then
            return "|cffFF0000"..x.."|r"
        elseif spellTimer > -4 then
            return "|cffFF9900"..x.."|r"
        else
            return "|cff33FF33"..x.."|r"
        end
    end
end
oUF.TagEvents['freebgrid:rejuv'] = "UNIT_AURA"

oUF.Tags['freebgrid:rejuvTime'] = function(u)
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(774))
    if(fromwho == "player") then return getTime(expirationTime) end 
end
oUF.TagEvents['freebgrid:rejuvTime'] = "UNIT_AURA"

oUF.Tags['freebgrid:regrow'] = function(u) if UnitAura(u, GetSpellInfo(8936)) then return "|cff00FF10"..x.."|r" end end
oUF.TagEvents['freebgrid:regrow'] = "UNIT_AURA"

oUF.Tags['freebgrid:wg'] = function(u) if UnitAura(u, GetSpellInfo(48438)) then return "|cff33FF33"..x.."|r" end end
oUF.TagEvents['freebgrid:wg'] = "UNIT_AURA"

oUF.Tags['freebgrid:motw'] = function(u) if not(UnitAura(u, GetSpellInfo(79060)) or UnitAura(u,GetSpellInfo(79063))) then return "|cff00A1DE"..x.."|r" end end
oUF.TagEvents['freebgrid:motw'] = "UNIT_AURA"

-- Warrior
oUF.Tags['freebgrid:stragi'] = function(u) if not(UnitAura(u, GetSpellInfo(6673)) or UnitAura(u, GetSpellInfo(57330)) or UnitAura(u, GetSpellInfo(8076))) then return "|cffFF0000"..x.."|r" end end
oUF.TagEvents['freebgrid:stragi'] = "UNIT_AURA"

oUF.Tags['freebgrid:vigil'] = function(u) if UnitAura(u, GetSpellInfo(50720)) then return "|cff8B4513"..x.."|r" end end
oUF.TagEvents['freebgrid:vigil'] = "UNIT_AURA"

-- Shaman
oUF.Tags['freebgrid:rip'] = function(u) 
    local name, _,_,_,_,_,_, fromwho = UnitAura(u, GetSpellInfo(61295))
    if(fromwho == 'player') then return "|cff00FEBF"..x.."|r" end
end
oUF.TagEvents['freebgrid:rip'] = 'UNIT_AURA'

oUF.Tags['freebgrid:ripTime'] = function(u)
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(61295))
    if(fromwho == "player") then return getTime(expirationTime) end 
end
oUF.TagEvents['freebgrid:ripTime'] = 'UNIT_AURA'

local earthCount = {'i','h','g','f','p','q','Z','Z','Y'}
oUF.Tags['freebgrid:earth'] = function(u) 
    local c = select(4, UnitAura(u, GetSpellInfo(974))) if c then return '|cffFFCF7F'..earthCount[c]..'|r' end 
end
oUF.TagEvents['freebgrid:earth'] = 'UNIT_AURA'

-- Paladin
oUF.Tags['freebgrid:might'] = function(u) if not(UnitAura(u, GetSpellInfo(53138)) or UnitAura(u, GetSpellInfo(79102))) then return "|cffFF0000"..x.."|r" end end
oUF.TagEvents['freebgrid:might'] = "UNIT_AURA"

oUF.Tags['freebgrid:beacon'] = function(u)
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(53563))
    if not name then return end
    if(fromwho == "player") then
        local spellTimer = GetTime()-expirationTime
        if spellTimer > -30 then
            return "|cffFF00004|r"
        else
            return "|cffFFCC003|r"
        end
    else
        return "|cff996600Y|r" -- other pally's beacon
    end
end
oUF.TagEvents['freebgrid:beacon'] = "UNIT_AURA"

oUF.Tags['freebgrid:forbearance'] = function(u) if UnitDebuff(u, GetSpellInfo(25771)) then return "|cffFF9900"..x.."|r" end end
oUF.TagEvents['freebgrid:forbearance'] = "UNIT_AURA"

-- Warlock
oUF.Tags['freebgrid:di'] = function(u) 
    local name, _,_,_,_,_,_, fromwho = UnitAura(u, GetSpellInfo(85767)) 
    if fromwho == "player" then
        return "|cff6600FF"..x.."|r"
    elseif name then
        return "|cffCC00FF"..x.."|r"
    end
end
oUF.TagEvents['freebgrid:di'] = "UNIT_AURA"

oUF.Tags['freebgrid:ss'] = function(u) 
    local name, _,_,_,_,_,_, fromwho = UnitAura(u, GetSpellInfo(20707)) 
    if fromwho == "player" then
        return "|cff6600FFY|r"
    elseif name then
        return "|cffCC00FFY|r"
    end
end
oUF.TagEvents['freebgrid:ss'] = "UNIT_AURA"

-- Mage
oUF.Tags['freebgrid:int'] = function(u) if not(UnitAura(u, GetSpellInfo(1459))) then return "|cff00A1DE"..x.."|r" end end
oUF.TagEvents['freebgrid:int'] = "UNIT_AURA"

oUF.Tags['freebgrid:fmagic'] = function(u) if UnitAura(u, GetSpellInfo(54648)) then return "|cffCC00FF"..x.."|r" end end
oUF.TagEvents['freebgrid:fmagic'] = "UNIT_AURA"

ns.classIndicators={
    ["DRUID"] = {
        ["TL"] = "",
        ["TR"] = "[freebgrid:motw]",
        ["BL"] = "[freebgrid:regrow][freebgrid:wg]",
        ["BR"] = "[freebgrid:lb]",
        ["Cen"] = "[freebgrid:rejuvTime]",
    },
    ["PRIEST"] = {
        ["TL"] = "[freebgrid:pws][freebgrid:ws]",
        ["TR"] = "[freebgrid:fw][freebgrid:sp][freebgrid:fort]",
        ["BL"] = "[freebgrid:rnw][freebgrid:pwb][freebgrid:ps][freebgrid:gs]",
        ["BR"] = "[freebgrid:pom]",
        ["Cen"] = "[freebgrid:rnwTime]",
    },
    ["PALADIN"] = {
        ["TL"] = "[freebgrid:forbearance]",
        ["TR"] = "[freebgrid:might][freebgrid:motw]",
        ["BL"] = "",
        ["BR"] = "[freebgrid:beacon]",
        ["Cen"] = "",
    },
    ["WARLOCK"] = {
        ["TL"] = "",
        ["TR"] = "[freebgrid:di]",
        ["BL"] = "",
        ["BR"] = "[freebgrid:ss]",
        ["Cen"] = "",
    },
    ["WARRIOR"] = {
        ["TL"] = "[freebgrid:vigil]",
        ["TR"] = "[freebgrid:stragi][freebgrid:fort]",
        ["BL"] = "",
        ["BR"] = "",
        ["Cen"] = "",
    },
    ["DEATHKNIGHT"] = {
        ["TL"] = "",
        ["TR"] = "",
        ["BL"] = "",
        ["BR"] = "",
        ["Cen"] = "",
    },
    ["SHAMAN"] = {
        ["TL"] = "[freebgrid:rip]",
        ["TR"] = "",
        ["BL"] = "",
        ["BR"] = "[freebgrid:earth]",
        ["Cen"] = "[freebgrid:ripTime]",
    },
    ["HUNTER"] = {
        ["TL"] = "",
        ["TR"] = "",
        ["BL"] = "",
        ["BR"] = "",
        ["Cen"] = "",
    },
    ["ROGUE"] = {
        ["TL"] = "",
        ["TR"] = "",
        ["BL"] = "",
        ["BR"] = "",
        ["Cen"] = "",
    },
    ["MAGE"] = {
        ["TL"] = "",
        ["TR"] = "[freebgrid:int]",
        ["BL"] = "",
        ["BR"] = "",
        ["Cen"] = "",
    }
}
