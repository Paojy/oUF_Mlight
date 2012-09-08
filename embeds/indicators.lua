local ADDON_NAME, ns = ...
local cfg = ns.cfg

local x = "8"
local bigmark = 11
local smallmark = 5
local timersize = 10

-- [[ Raid Buffs ]] -- http://www.wowhead.com/guide=1100#buffs-stats

-- Effect: +5% Strength, Agility, and Intellect
oUF.Tags.Methods['mlight:SAI'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(1126)) or -- druid
	UnitAura(u, GetSpellInfo(20217)) or -- paladin
	UnitAura(u, GetSpellInfo(115921)) or -- monk
	UnitAura(u, GetSpellInfo(90363)) -- hunter
	) then return "|cffCD00CD"..x.."|r" end 
end
oUF.Tags.Events['mlight:SAI'] = "UNIT_AURA"

-- Effect: +10% Stamina
oUF.Tags.Methods['mlight:Stamina'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(21562)) or -- priest
	UnitAura(u, GetSpellInfo(103127)) or -- warlock
	UnitAura(u, GetSpellInfo(469)) or -- warrior
	UnitAura(u, GetSpellInfo(90364)) -- hunter
	) then return "|cffFFFFFF"..x.."|r" end 
end
oUF.Tags.Events['mlight:Stamina'] = "UNIT_AURA"

-- Effect: +10% melee and ranged attack power
oUF.Tags.Methods['mlight:AP'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(57330)) or -- death knight
	UnitAura(u, GetSpellInfo(6673)) or -- warrior
	UnitAura(u, GetSpellInfo(19506)) -- hunter
	) then return "|cff8B4513"..x.."|r" end 
end
oUF.Tags.Events['mlight:AP'] = "UNIT_AURA"

-- Effect: +10% spell power
oUF.Tags.Methods['mlight:SP'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(1459)) or UnitAura(u, GetSpellInfo(61316)) or -- mage
	UnitAura(u, GetSpellInfo(77747)) or -- shaman
	UnitAura(u, GetSpellInfo(109773)) or -- warlock
	UnitAura(u, GetSpellInfo(126309)) -- hunter
	) then return "|cff00FFFF"..x.."|r" end 
end
oUF.Tags.Events['mlight:SP'] = "UNIT_AURA"

-- Effect: +10% melee and ranged haste
oUF.Tags.Methods['mlight:Haste'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(55610)) or -- death knight
	UnitAura(u, GetSpellInfo(113742)) or -- rogue
	UnitAura(u, GetSpellInfo(30809)) or -- shaman
	UnitAura(u, GetSpellInfo(128432)) or UnitAura(u, GetSpellInfo(128433)) -- hunter (pet)
	) then return "|cffEEB422"..x.."|r" end
end
oUF.Tags.Events['mlight:Haste'] = "UNIT_AURA"

-- Effect: +5% spell haste
oUF.Tags.Methods['mlight:SpellHaste'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(24907)) or -- druid
	UnitAura(u, GetSpellInfo(15473)) or -- priest
	UnitAura(u, GetSpellInfo(51470)) -- shaman
	) then return "|cffFF1493"..x.."|r" end
end
oUF.Tags.Events['mlight:SpellHaste'] = "UNIT_AURA"

-- Effect: +5% ranged, melee, and spell critical chance
oUF.Tags.Methods['mlight:Crit'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(17007)) or -- druid
	UnitAura(u, GetSpellInfo(1459)) or UnitAura(u, GetSpellInfo(61316)) or -- mage
	UnitAura(u, GetSpellInfo(116781)) or -- monk
	UnitAura(u, GetSpellInfo(126373)) or UnitAura(u, GetSpellInfo(126309)) or -- hunter
	UnitAura(u, GetSpellInfo(97229)) or UnitAura(u, GetSpellInfo(90309)) -- hunter (pet)
	) then return "|cffEEEE00"..x.."|r" end
end
oUF.Tags.Events['mlight:Crit'] = "UNIT_AURA"

-- Effect: +3000 mastery
oUF.Tags.Methods['mlight:Mastery'] = function(u) 
	if not (
	UnitAura(u, GetSpellInfo(19740)) or -- paladin
	UnitAura(u, GetSpellInfo(116956)) or -- shaman
	UnitAura(u, GetSpellInfo(128997)) or -- hunter
	UnitAura(u, GetSpellInfo(93435)) -- hunter (pet)
	) then return "|cffD3D3D3"..x.."|r" end
end
oUF.Tags.Events['mlight:Mastery'] = "UNIT_AURA"

-- [[ Healers' indicators ]] -- 

-- Priest ��ʦ
local pomCount = {"i","h","g","f","Z"}
oUF.Tags.Methods['freebgrid:pom'] = function(u) -- ���ϵ���
    local name, _,_, c, _,_,_, fromwho = UnitAura(u, GetSpellInfo(41635)) 
    if fromwho == "player" then
        if c and c ~= 0 then return "|cff66FFFF"..pomCount[c].."|r" end 
    else
        if c and c ~= 0 then return "|cffFFCF7F"..pomCount[c].."|r" end 
    end
end
oUF.Tags.Events['freebgrid:pom'] = "UNIT_AURA"

oUF.Tags.Methods['freebgrid:rnw'] = function(u) -- �ָ�
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(139))
    if(fromwho == "player") then
        local spellTimer = expirationTime - GetTime()
        if spellTimer > 4 then
            return "|cff33FF33"..ns.FormatValue(spellTimer).."|r"
        elseif spellTimer > 2 then
            return "|cffFF9900"..ns.FormatValue(spellTimer).."|r"
        else
            return "|cffFF0000"..ns.FormatValue(spellTimer).."|r"
        end
    end
end
oUF.Tags.Events['freebgrid:rnw'] = "UNIT_AURA"

oUF.Tags.Methods['freebgrid:pws'] = function(u) -- ��
local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(17))
    if(fromwho == "player") then
        local spellTimer = (expirationTime-GetTime())
		local TimeLeft = ns.FormatValue(spellTimer)
        if spellTimer > 0 then
            return "|cffFFF68F"..TimeLeft.."|r"
        end
    end
end
oUF.Tags.Events['freebgrid:pws'] = "UNIT_AURA"

oUF.Tags.Methods['freebgrid:ws'] = function(u) if UnitDebuff(u, GetSpellInfo(6788)) then return "|cffFF9900"..x.."|r" end end -- �������
oUF.Tags.Events['freebgrid:ws'] = "UNIT_AURA"

-- Druid ��³��
oUF.Tags.Methods['freebgrid:lb'] = function(u) -- ��������
    local name, _,_, c,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(33763))
    if(fromwho == "player") then
		local spellTimer = (expirationTime-GetTime())
		local TimeLeft = ns.FormatValue(spellTimer)
        if c > 2 then
            return "|cffA7FD0A"..TimeLeft.."|r"
        elseif c > 1 then
            return "|cffFF9900"..TimeLeft.."|r"
        else
            return "|cffFF0000"..TimeLeft.."|r"
        end
    end
end
oUF.Tags.Events['freebgrid:lb'] = "UNIT_AURA"

oUF.Tags.Methods['freebgrid:rejuv'] = function(u) -- �ش�
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(774))
    if(fromwho == "player") then
        local spellTimer = (expirationTime-GetTime())
		local TimeLeft = ns.FormatValue(spellTimer)
        if spellTimer > 0 then
            return "|cffFF00BB"..TimeLeft.."|r"
        end
    end
end
oUF.Tags.Events['freebgrid:rejuv'] = "UNIT_AURA"

oUF.Tags.Methods['freebgrid:regrow'] = function(u) -- ����
	local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(8936))
    if(fromwho == "player") then
        local spellTimer = (expirationTime-GetTime())
		local TimeLeft = ns.FormatValue(spellTimer)
        if spellTimer > 3 then
			return "|cffFFA500?|r"
		elseif spellTimer > 0 then
            return "|cff33FF33?|r"
        end
    end
end
oUF.Tags.Events['freebgrid:regrow'] = "UNIT_AURA"

-- Shaman ����
oUF.Tags.Methods['freebgrid:ripTime'] = function(u) --����
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(61295))
    if(fromwho == "player") then
        local spellTimer = (expirationTime-GetTime())
		local TimeLeft = ns.FormatValue(spellTimer)
        if spellTimer > 0 then
            return "|cff00FFDD"..TimeLeft.."|r"
        end
    end
end
oUF.Tags.Events['freebgrid:ripTime'] = 'UNIT_AURA'

local earthCount = {"i","h","g","f","i","k","l","m","Y"}
oUF.Tags.Methods['freebgrid:earth'] = function(u) -- ���֮��
    local c = select(4, UnitAura(u, GetSpellInfo(974))) if c then return '|cffFFCF7F'..earthCount[c]..'|r' end 
end
oUF.Tags.Events['freebgrid:earth'] = 'UNIT_AURA'

-- Paladin ��ʿ
oUF.Tags.Methods['freebgrid:beacon'] = function(u) if UnitAura(u, GetSpellInfo(53563)) then return "|cffFFB90FO|r" end end --����
oUF.Tags.Events['freebgrid:beacon'] = "UNIT_AURA"

oUF.Tags.Methods['freebgrid:forbearance'] = function(u) if UnitDebuff(u, GetSpellInfo(25771)) then return "|cffFF9900"..x.."|r" end end
oUF.Tags.Events['freebgrid:forbearance'] = "UNIT_AURA" -- ����

-- Monk ��ɮ
oUF.Tags.Methods['freebgrid:zs'] = function(u) -- ������
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(124081))
    if(fromwho == "player") then
        local spellTimer = (expirationTime-GetTime())
		local TimeLeft = ns.FormatValue(spellTimer)
        if spellTimer > 0 then
            return "|cff00FBFF"..TimeLeft.."|r"
        end
    end
end
oUF.Tags.Events['freebgrid:zs'] = 'UNIT_AURA'

oUF.Tags.Methods['freebgrid:sooth'] = function(u) if UnitAura(u, GetSpellInfo(115175)) then return "|cff97FFFF"..x.."|r" end end -- ��ο֮��
oUF.Tags.Events['freebgrid:sooth'] = "UNIT_AURA"

oUF.Tags.Methods['freebgrid:remist'] = function(u) -- ����֮��
    local name, _,_,_,_,_, expirationTime, fromwho = UnitAura(u, GetSpellInfo(115151))
    if(fromwho == "player") then
        local spellTimer = (expirationTime-GetTime())
		local TimeLeft = ns.FormatValue(spellTimer)
        if spellTimer > 0 then
            return "|cff55FF00"..TimeLeft.."|r"
        end
    end
end 
oUF.Tags.Events['freebgrid:remist'] = 'UNIT_AURA'

classIndicators={
    ["DRUID"] = {
        ["TL"] = "[freebgrid:lb]",
        ["BR"] = "[mlight:SAI]",--[mlight:SpellHaste][mlight:Crit]
        ["BL"] = "[freebgrid:rejuv]",
        ["TR"] = "[freebgrid:regrow]",
        ["Cen"] = "",
    },
    ["PRIEST"] = {
        ["TL"] = "[freebgrid:rnw]",
        ["BR"] = "[mlight:Stamina]",--[mlight:SpellHaste]
        ["BL"] = "[freebgrid:pws]",
        ["TR"] = "[freebgrid:pom]",
        ["Cen"] = "[freebgrid:ws]",
    },
    ["PALADIN"] = {
        ["TL"] = "",
        ["BR"] = "[mlight:SAI]",--mlight:Mastery]
        ["BL"] = "",
        ["TR"] = "[freebgrid:beacon]",
        ["Cen"] = "[freebgrid:forbearance]",
    },
    ["WARLOCK"] = {
        ["TL"] = "",
        ["BR"] = "[mlight:Stamina][mlight:SP]",
        ["BL"] = "",
        ["TR"] = "",
        ["Cen"] = "",
    },
    ["WARRIOR"] = {
        ["TL"] = "",
        ["BR"] = "[mlight:Stamina][mlight:AP]",
        ["BL"] = "",
        ["TR"] = "",
        ["Cen"] = "",
    },
    ["DEATHKNIGHT"] = {
        ["TL"] = "",
        ["BR"] = "[mlight:AP]",--[mlight:Haste]
        ["BL"] = "",
        ["TR"] = "",
        ["Cen"] = "",
    },
    ["SHAMAN"] = {
        ["TL"] = "[freebgrid:ripTime]",
        ["BR"] = "[mlight:SP]",--[mlight:Haste][mlight:SpellHaste][mlight:Mastery]
        ["BL"] = "",
        ["TR"] = "[freebgrid:earth]",
        ["Cen"] = "",
    },
    ["HUNTER"] = {
        ["TL"] = "",
        ["BR"] = "[mlight:SAI][mlight:Stamina][mlight:AP][mlight:SP]",--[mlight:Haste][mlight:Crit][mlight:Mastery]
        ["BL"] = "",
        ["TR"] = "",
        ["Cen"] = "",
    },
    ["ROGUE"] = {
        ["TL"] = "",
        ["BR"] = "",--[mlight:Haste]
        ["BL"] = "",
        ["TR"] = "",
        ["Cen"] = "",
    },
    ["MAGE"] = {
        ["TL"] = "",
        ["BR"] = "[mlight:SP]",--[mlight:Crit]
        ["BL"] = "",
        ["TR"] = "",
        ["Cen"] = "",
    },
	["MONK"] = {
        ["TL"] = "[freebgrid:remist]",
        ["BR"] = "[mlight:SAI]",--[mlight:Crit]
        ["BL"] = "[freebgrid:zs]",
        ["TR"] = "",
        ["Cen"] = "[freebgrid:sooth]",
    },
}

local _, class = UnitClass("player")
local symbols = "Interface\\Addons\\oUF_Mlight\\media\\PIZZADUDEBULLETS.ttf"

local update = .25

local Enable = function(self)
    if(self.MlightIndicators) then
        self.AuraStatusBL = self.Health:CreateFontString(nil, "OVERLAY")
        self.AuraStatusBL:ClearAllPoints()
        self.AuraStatusBL:SetPoint("BOTTOMLEFT", 0, -2)
		self.AuraStatusBL:SetJustifyH("LEFT")
        self.AuraStatusBL:SetFont(cfg.font, timersize, "THINOUTLINE")
        self.AuraStatusBL.frequentUpdates = update
        self:Tag(self.AuraStatusBL, classIndicators[class]["BL"])	

		self.AuraStatusBR = self.Health:CreateFontString(nil, "OVERLAY")
        self.AuraStatusBR:ClearAllPoints()
        self.AuraStatusBR:SetPoint("BOTTOMRIGHT", 3, 0)
		self.AuraStatusBR:SetJustifyH("RIGHT")
        self.AuraStatusBR:SetFont(symbols, smallmark, "THINOUTLINE")
        self.AuraStatusBR.frequentUpdates = update
        self:Tag(self.AuraStatusBR, classIndicators[class]["BR"])
		
        self.AuraStatusTL = self.Health:CreateFontString(nil, "OVERLAY")
        self.AuraStatusTL:ClearAllPoints()
        self.AuraStatusTL:SetPoint("TOPLEFT", 0, 0)
		self.AuraStatusTL:SetJustifyH("LEFT")
        self.AuraStatusTL:SetFont(cfg.font, timersize, "THINOUTLINE")
        self.AuraStatusTL.frequentUpdates = update
        self:Tag(self.AuraStatusTL, classIndicators[class]["TL"])
		
        self.AuraStatusTR = self.Health:CreateFontString(nil, "OVERLAY")
        self.AuraStatusTR:ClearAllPoints()
        self.AuraStatusTR:SetPoint("CENTER", self.Health, "TOPRIGHT", -4, -4)
        self.AuraStatusTR:SetFont(symbols, bigmark, "OUTLINE")
        self.AuraStatusTR.frequentUpdates = update
        self:Tag(self.AuraStatusTR, classIndicators[class]["TR"])
		
        self.AuraStatusCen = self.Health:CreateFontString(nil, "OVERLAY")
        self.AuraStatusCen:SetPoint("LEFT", -3, 0)
        self.AuraStatusCen:SetJustifyH("LEFT")
        self.AuraStatusCen:SetFont(symbols, smallmark, cfg.fontflag)
        self.AuraStatusCen:SetWidth(0)
        self.AuraStatusCen.frequentUpdates = update
        self:Tag(self.AuraStatusCen, classIndicators[class]["Cen"])
    end
end

oUF:AddElement('MlightIndicators', nil, Enable, nil)
