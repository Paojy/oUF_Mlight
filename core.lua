
  --get the addon namespace
  local addon, ns = ...
  --get the config values
  local cfg = ns.cfg
  --get the library
  local lib = ns.lib
  
  local uw5 = ((cfg.width)*2/5*1.5) -- calculating unit width for 8 goups raid
  local uw8 = ((cfg.width)/4*2) -- calculating unit width for 8 goups raid
  -----------------------------
  -- STYLE FUNCTIONS
  -----------------------------
  
  --init func
  local initHeader = function(self)
    self.menu = lib.menu
    self:RegisterForClicks("AnyUp")
    self:SetAttribute("*type2", "menu")
    self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)
    lib.gen_hpbar(self)
    lib.gen_hpstrings(self)
    lib.gen_ppbar(self)
	lib.gen_ppstrings(self)
	self.colors.smooth = {cfg.colorsmooth[1], cfg.colorsmooth[2], cfg.colorsmooth[3], cfg.colorsmooth[4], cfg.colorsmooth[5], cfg.colorsmooth[6], cfg.colorsmooth[7], cfg.colorsmooth[8], cfg.colorsmooth[9]}
    self.Health.colorSmooth = true
	lib.gen_RaidMark(self)
	lib.gen_highlight(self)
  end  
  

  --init func
  local init = function(self)
    self:SetSize(self.width, self.height)
    initHeader(self)
  end

  --the player style
  local function CreatePlayerStyle(self)
    --style specific stuff
    self.width = cfg.Pwidth
    self.height = cfg.Pheight
    self.mystyle = "player"
    init(self)
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
    self.Power.bg.multiplier = 0.3
    lib.gen_castbar(self)
    lib.gen_portrait(self)
	lib.gen_mirrorcb(self)
	lib.gen_Runes(self)
	lib.gen_EclipseBar(self)
    lib.gen_TotemBar(self)
    lib.gen_specificpower(self)
    lib.gen_combatIcon(self)
	lib.gen_alt_powerbar(self)
  end  
  
  --the target style
  local function CreateTargetStyle(self)
    --style specific stuff
    self.width = cfg.Twidth
    self.height = cfg.Theight
    self.mystyle = "target"
    init(self)
    self.Health.colorTapping = true
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
	self.Power.colorReaction = true
    self.Power.bg.multiplier = 0.3
	lib.gen_cp(self)
    lib.gen_castbar(self)
    lib.gen_portrait(self)
    lib.createAuras(self)
  end  
  
  --the tot style
  local function CreateToTStyle(self)
    --style specific stuff
    self.width = cfg.PTTwidth
    self.height = cfg.PTTheight
    self.mystyle = "tot"
    self.hptag = "[simple:hpperc]"
    init(self)
    self.Health.colorTapping = true
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
	self.Power.colorReaction = true
    self.Power.bg.multiplier = 0.3
  end 

  --the focus style
  local function CreateFocusStyle(self)
    --style specific stuff
    self.width = cfg.Fwidth
    self.height = cfg.Fheight
    self.mystyle = "focus"
    init(self)
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
	self.Power.colorReaction = true
	self.Power.colorReaction = true
    self.Power.bg.multiplier = 0.3
    lib.gen_castbar(self)
    lib.createAuras(self)
  end  
  
  --the pet style
  local function CreatePetStyle(self)
    --style specific stuff
    self.width = cfg.PTTwidth
    self.height = cfg.PTTheight
    self.mystyle = "pet"
    --init
    init(self)
    --stuff
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
	self.Power.colorReaction = true
	self.Power.colorReaction = true
    self.Power.bg.multiplier = 0.3
    lib.gen_castbar(self)
    lib.gen_portrait(self)
    lib.createDebuffs(self)
  end
  
  --boss frames
  local function CreateBossStyle(self, unit)
    self.width = cfg.PBwidth
    self.height = cfg.PBheight
    self.mystyle = "boss"
    --init
    init(self)
	self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
    self.Power.bg.multiplier = 0.3
    lib.createDebuffs(self)
    lib.gen_castbar(self)
  end    
  --now header units, examples for party, raid10, raid25, raid40
  
  --party frames
  local function CreatePartyStyle(self)
    --style specific stuff
    self.width = cfg.PBwidth
    self.height = cfg.PBheight
    self.mystyle = "party"
    --init
    initHeader(self)
    --stuff
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
    self.Power.bg.multiplier = 0.3
	lib.gen_LFDindicator(self)
	lib.gen_InfoIcons(self)
    lib.createDebuffs(self)
  end  

  local raidinit = function(self)
    self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)
    lib.gen_raidhpbar(self)
    lib.gen_raidhpstrings(self)
    lib.gen_raidppbar(self)
	self.colors.smooth = {cfg.colorsmooth[1], cfg.colorsmooth[2], cfg.colorsmooth[3], cfg.colorsmooth[4], cfg.colorsmooth[5], cfg.colorsmooth[6], cfg.colorsmooth[7], cfg.colorsmooth[8], cfg.colorsmooth[9]}
    self.Health.colorSmooth = true
	lib.gen_RaidMark(self)
	lib.gen_highlight(self)
	self:SetSize(self.width, self.height)
    --stuff
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorClass = true
	self.Power.colorReaction = true
    self.Power.bg.multiplier = 0.3
	lib.gen_LFDindicator(self)
	lib.gen_InfoIcons(self)
	self.freebIndicators = true
	-- Range
    range = 
	{ insideAlpha = 1,
      outsideAlpha = 0.4,}
	self.freebRange = range
    self.Range = range
	
	lib.raidDebuffs(self)
	lib.ReadyCheck(self)
    lib.CreateTargetBorder(self)
	lib.CreateThreatBorder(self)
	lib.healcomm(self, unit)
	
	self:RegisterEvent('PLAYER_TARGET_CHANGED', lib.ChangedTarget)
	self:RegisterEvent('RAID_ROSTER_UPDATE', lib.ChangedTarget)
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", lib.UpdateThreat)
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", lib.UpdateThreat)
  end
  
  --raid frames
  local function CreateRaidStyle10(self)
    --style specific stuff
    self.width = cfg.width
    self.height = cfg.height
    self.mystyle = "raid"
    --init
    raidinit(self)
  end 
  
  local function CreateRaidStyle25(self)
    --style specific stuff
    self.width = uw5
    self.height = cfg.height
    self.mystyle = "raid"
    --init
    raidinit(self)
  end 
  
    local function CreateRaidStyle40(self)
    --style specific stuff
    self.width = uw8
    self.height = cfg.height
    self.mystyle = "raid"
    --init
    raidinit(self)
  end 
  -----------------------------
  -- SPAWN UNITS
  -----------------------------

  if cfg.showplayer then
    oUF:RegisterStyle("oUF_SimplePlayer", CreatePlayerStyle)
    oUF:SetActiveStyle("oUF_SimplePlayer")
    local player = oUF:Spawn("player", "oUF_SimplePlayer")
    player:SetPoint(unpack(cfg.Ppos))
  end
  
  if cfg.showtarget then
    oUF:RegisterStyle("oUF_SimpleTarget", CreateTargetStyle)
    oUF:SetActiveStyle("oUF_SimpleTarget")
    local target = oUF:Spawn("target", "oUF_SimpleTarget")
    target:SetPoint(unpack(cfg.Tpos))
  end

  if cfg.showtot then
    oUF:RegisterStyle("oUF_SimpleToT", CreateToTStyle)
    oUF:SetActiveStyle("oUF_SimpleToT")
    local tot = oUF:Spawn("targettarget", "oUF_Simple_ToT")
	tot:SetPoint(unpack(cfg.TTpos))  
  end
  
  if cfg.showfocus then
    oUF:RegisterStyle("oUF_SimpleFocus", CreateFocusStyle)
	oUF:RegisterStyle("oUF_SimpleFocusTarget", CreateFocusStyle)
    oUF:SetActiveStyle("oUF_SimpleFocus")
    local focus = oUF:Spawn("focus", "oUF_SimpleFocus")
	focus:SetPoint(unpack(cfg.Fpos))
	oUF:SetActiveStyle("oUF_SimpleToT")
	local focust = oUF:Spawn("focustarget", "oUF_SimpleFocusTarget")
	focust:SetPoint(unpack(cfg.FTpos))
  end
  
  if cfg.showpet then
    oUF:RegisterStyle("oUF_SimplePet", CreatePetStyle)
    oUF:SetActiveStyle("oUF_SimplePet")
    local pet = oUF:Spawn("pet", "oUF_SimplePet")
	pet:SetPoint(unpack(cfg.PEpos))
  end
  
--Boss frames
if cfg.showboss then
	oUF:RegisterStyle("oUF_SimpleBoss", CreateBossStyle)
    oUF:SetActiveStyle("oUF_SimpleBoss")
	local bossFrames = {}
	for i = 1, MAX_BOSS_FRAMES do
			local unit = oUF:Spawn("boss"..i, "oUF_Boss"..i)
			if i > 1 then
				unit:SetPoint('BOTTOMLEFT', bossFrames[i - 1], 'TOPLEFT', 0, 40)
			else
				unit:SetPoint('RIGHT', UIparent, 'RIGHT', -5, 90) 
			end
		bossFrames[i] = unit
	end
end
	
  if cfg.showparty then
    oUF:RegisterStyle("oUF_SimpleParty", CreatePartyStyle)
    oUF:SetActiveStyle("oUF_SimpleParty")
    
    local party = oUF:SpawnHeader(
      "oUF_SimpleParty", 
      nil, 
      "custom [@raid1,exists] hide; [group:party,nogroup:raid] show; hide",
      "showPlayer",         true,
      "showSolo",           false,
      "showParty",          true,
      "showRaid",           false,
      "point",              "TOP",
      "yOffset",            -25,
      "xoffset",            0,
      "oUF-initialConfigFunction", [[
        self:SetHeight(25)
        self:SetWidth(180)
      ]]
    )
    party:SetPoint("LEFT",UIParent,"LEFT",30,90)    
        
  end
  

  if cfg.showraid then
    
    --die raid panel, die
    CompactRaidFrameManager:UnregisterAllEvents()
    CompactRaidFrameManager.Show = CompactRaidFrameManager.Hide
    CompactRaidFrameManager:Hide()
    
    CompactRaidFrameContainer:UnregisterAllEvents()
    CompactRaidFrameContainer.Show = CompactRaidFrameContainer.Hide
    CompactRaidFrameContainer:Hide()
    
    --setup for 10 man raid    
    oUF:RegisterStyle("oUF_SimpleRaid10", CreateRaidStyle10)
    oUF:SetActiveStyle("oUF_SimpleRaid10")
    
    local raid10 = oUF:SpawnHeader(
      "oUF_SimpleRaid10", 
      nil, 
      "custom [@raid11,exists] hide; [@raid1,exists] show; hide",  
      "showPlayer",         true,
      "showSolo",           true,
      "showParty",          true,
      "showRaid",           true,
      "point",              cfg.point,
      "yOffset",            -11,
      "xoffset",            0,
      "columnSpacing",      cfg.colspacing,
      "columnAnchorPoint",  cfg.columnAnchorPoint,
      "groupFilter",        "1,2,3,4,5,6,7,8",
      "groupBy",            "GROUP",
      "groupingOrder",      "1,2,3,4,5,6,7,8",
      "sortMethod",         "NAME",
      "maxColumns",         8,
      "unitsPerColumn",     5,
      "oUF-initialConfigFunction",([[
		self:SetWidth(%d)
		self:SetHeight(%d)
	]]):format(cfg.width, cfg.height)
    )
    raid10:SetPoint("CENTER",UIParent,"CENTER",0,-230)
    
    --setup for 25 man raid
    
    oUF:RegisterStyle("oUF_SimpleRaid25", CreateRaidStyle25)
    oUF:SetActiveStyle("oUF_SimpleRaid25")
    
    local raid25 = oUF:SpawnHeader(
      "oUF_SimpleRaid25", 
      nil, 
      "custom [@raid26,exists] hide; [@raid11,exists] show; hide",  
      "showPlayer",         true,
      "showSolo",           true,
      "showParty",          true,
      "showRaid",           true,
      "point",              cfg.point,
      "yOffset",            -11,
      "xoffset",            0,
      "columnSpacing",      cfg.colspacing,
      "columnAnchorPoint",  cfg.columnAnchorPoint,
      "groupFilter",        "1,2,3,4,5,6,7,8",
      "groupBy",            "GROUP",
      "groupingOrder",      "1,2,3,4,5,6,7,8",
      "sortMethod",         "NAME",
      "maxColumns",         8,
      "unitsPerColumn",     5,
      "oUF-initialConfigFunction", ([[
		self:SetWidth(%d)
		self:SetHeight(%d)
	]]):format(uw5, cfg.height)
    )
    raid25:SetPoint("CENTER",UIParent,"CENTER",0,-230)
    
    --setup for 40 man raid
    
    oUF:RegisterStyle("oUF_SimpleRaid40", CreateRaidStyle40)
    oUF:SetActiveStyle("oUF_SimpleRaid40")
    
    local raid40 = oUF:SpawnHeader(
      "oUF_SimpleRaid40", 
      nil, 
      "custom [@raid26,exists] show; hide",  
      "showPlayer",         true,
      "showSolo",           true,
      "showParty",          true,
      "showRaid",           true,
      "point",              cfg.point,
      "yOffset",            -11,
      "xoffset",            0,
      "columnSpacing",      cfg.colspacing,
      "columnAnchorPoint",  cfg.columnAnchorPoint,
      "groupFilter",        "1,2,3,4,5,6,7,8",
      "groupBy",            "GROUP",
      "groupingOrder",      "1,2,3,4,5,6,7,8",
      "sortMethod",         "NAME",
      "maxColumns",         8,
      "unitsPerColumn",     5,
      "oUF-initialConfigFunction", ([[
		self:SetWidth(%d)
		self:SetHeight(%d)
	]]):format(uw8, cfg.height)
    )
    raid40:SetPoint("CENTER",UIParent,"CENTER",0,-230)
        
  end
  
  SlashCmdList["SHOW_BOSS"] = function()
    oUF_Boss1:Show(); oUF_Boss1.Hide = function() end oUF_Boss1.unit = "player"
    oUF_Boss2:Show(); oUF_Boss2.Hide = function() end oUF_Boss2.unit = "player"
    oUF_Boss3:Show(); oUF_Boss3.Hide = function() end oUF_Boss3.unit = "player"
    oUF_Boss4:Show(); oUF_Boss4.Hide = function() end oUF_Boss4.unit = "player"
end
SLASH_SHOW_BOSS1 = "/tboss" 