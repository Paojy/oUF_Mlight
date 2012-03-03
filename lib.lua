
  local addon, ns = ...
  local cfg = ns.cfg
  local lib = CreateFrame("Frame")  
    
  -----------------------------
  -- FUNCTIONS
  -----------------------------
  
  --backdrop table
  local backdrop_tab = { 
    bgFile = cfg.backdrop_texture, 
    edgeFile = cfg.backdrop_edge_texture,
    tile = false,
    tileSize = 0, 
    edgeSize = 5, 
    insets = { left = 5, right = 5, top = 5, bottom = 5, },
  }
  
  --backdrop func
  lib.gen_backdrop = function(f)
    f:SetBackdrop(backdrop_tab);
    f:SetBackdropColor(0,0,0,0.35)
    f:SetBackdropBorderColor(0,0,0,1)
  end

  --fontstring func
  lib.gen_fontstring = function(f, name, size, outline)
    local fs = f:CreateFontString(nil, "OVERLAY")
    fs:SetFont(name, size, outline)
    fs:SetShadowColor(0,0,0,0.5)
    fs:SetShadowOffset(0,-0)
    return fs
  end  
  
  local dropdown = CreateFrame("Frame", addon.."DropDown", UIParent, "UIDropDownMenuTemplate")
  
  UIDropDownMenu_Initialize(dropdown, function(self)
    local unit = self:GetParent().unit
    if not unit then return end  
    local menu, name, id
    if UnitIsUnit(unit, "player") then
      menu = "SELF"
    elseif UnitIsUnit(unit, "vehicle") then
      menu = "VEHICLE"
    elseif UnitIsUnit(unit, "pet") then
      menu = "PET"
    elseif UnitIsPlayer(unit) then
      id = UnitInRaid(unit)
      if id then
        menu = "RAID_PLAYER"
        name = GetRaidRosterInfo(id)
      elseif UnitInParty(unit) then
        menu = "PARTY"
      else
        menu = "PLAYER"
      end
    else
      menu = "TARGET"
      name = RAID_TARGET_ICON
    end
    if menu then
      UnitPopup_ShowMenu(self, menu, unit, name, id)
    end
  end, "MENU")
  
  lib.menu = function(self)
    dropdown:SetParent(self)
    ToggleDropDownMenu(1, nil, dropdown, "cursor", 0, 0)
  end
  
  --remove focus from menu list
  do 
    for k,v in pairs(UnitPopupMenus) do
      for x,y in pairs(UnitPopupMenus[k]) do
        if y == "SET_FOCUS" then
          table.remove(UnitPopupMenus[k],x)
        elseif y == "CLEAR_FOCUS" then
          table.remove(UnitPopupMenus[k],x)
        end
      end
    end
  end
  
  --gen healthbar func
  lib.gen_hpbar = function(f)
    --statusbar
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetHeight(f.height)
    s:SetWidth(f.width)
    s:SetPoint("CENTER",0,0)
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)
    --bg
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    b:SetAlpha(0)
	
    --debuff highlight
    local dbh = s:CreateTexture(nil, "OVERLAY")
    dbh:SetAllPoints(f)
    dbh:SetTexture("Interface\\AddOns\\oUF_Mlight\\media\\debuff_highlight")
    dbh:SetBlendMode("ADD")
    dbh:SetVertexColor(0,0,0,0)
    f.DebuffHighlightAlpha = 1
    f.DebuffHighlightFilter = false
	
    f.DebuffHighlight = dbh
    f.Health = s
    f.Health.bg = b
    f.Health:SetReverseFill(true)
	f.Health.PostUpdate = function(Health, unit, min, max)   
	f.Health:SetValue(max - Health:GetValue())end
    
  end
  
  --gen hp strings func
  lib.gen_hpstrings = function(f)
    local hpval, pp
    --health
    hpval = lib.gen_fontstring(f.Health, cfg.font, cfg.fontsize, "THINOUTLINE")
    pp = lib.gen_fontstring(f.Health, cfg.font, cfg.fontsize, "THINOUTLINE")
	
    if f.mystyle == "player" or f.mystyle == "target" or f.mystyle == "focus" then
	hpval:SetPoint("RIGHT", f.Health, "RIGHT", -2, 0)
    pp:SetPoint("LEFT", f.Health, "LEFT",2,0)
	elseif f.mystyle == "boss" or f.mystyle == "party" then
	hpval:SetPoint("RIGHT", f.Health, "RIGHT", -2, 0)
	pp:Hide()
    else
	hpval:Hide()
    pp:Hide()
    end
	
	if f.mystyle == "party" then
	f:Tag(hpval, "[Mlight:offdead]")
	else
    f:Tag(hpval, "[Mlight:hpdefault]")
	end
    if class == "DRUID" then
    f:Tag(pp, '[Mlight:druidpower] [Mlight:pp]')
    else
    f:Tag(pp, '[Mlight:pp]')
    end
	
    end

  
  --gen power func
  lib.gen_ppbar = function(f)
    --statusbar
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetHeight(f.height/6)
    s:SetWidth(f.width)
    s:SetPoint("TOP",f,"BOTTOM",0,-5)
	if f.mystyle == "party" then
	s:SetPoint("TOP",f,"BOTTOM",0,1)
	end
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)
    --bg
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    f.Power = s
    f.Power.bg = b
  end
  
  lib.gen_ppstrings = function(f)
    
    local name, lvl
    --name
    name = lib.gen_fontstring(f.Power, cfg.font, cfg.namefontsize, "THINOUTLINE")
	lvl = lib.gen_fontstring(f.Power, cfg.font, cfg.namefontsize, "THINOUTLINE")
	if f.mystyle == "player" then
    name:Hide()
	lvl:Hide()
    elseif f.mystyle == "target" then
    name:SetPoint("TOPLEFT", f.Power, "BOTTOMLEFT", 14, -3)
	lvl:SetPoint("TOPRIGHT", f.Power, "BOTTOMLEFT", 14, -3)
	elseif f.mystyle == "boss" then
	name:SetPoint("LEFT", f.Power, "LEFT", 2, 0)
	else
	name:SetPoint("TOPLEFT", f.Power, "BOTTOMLEFT", 0, -3)
	end
	if f.mystyle == "party" or f.mystyle == "raid" then
	f:Tag(name, "[Mlight:gridcolor][Mlight:name]")
	else
    f:Tag(name, "[Mlight:color][Mlight:name]")
	end
	f:Tag(lvl, "[Mlight:lvl]")
	
    --resting indicator for player frame
	if f.mystyle == "player" then
	local ri = lib.gen_fontstring(f.Power, cfg.font, 11, "THINOUTLINE")
	ri:SetPoint("CENTER", f.Power, "CENTER",0,12)
	ri:SetText("|cff8AFF30Zzz|r")
	f.Resting = ri
	end
	
    end
---------------------------
--Casting bar
---------------------------  

  --moveme func
  lib.moveme = function(f)
    if not cfg.movablecb then return end
    f:SetMovable(true)
    f:SetUserPlaced(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton","RightButton")
    --f:SetScript("OnDragStart", function(self) if IsAltKeyDown() and IsShiftKeyDown() then self:StartMoving() end end)
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  end 
  
  --gen castbar
  lib.gen_castbar = function(f)
  if not cfg.cbenabled then return end
    local s = CreateFrame("StatusBar", "oUF_MlightCastbar"..f.mystyle, f)
    if f.mystyle == "player" then
	  s:SetHeight(cfg.playercbheight)
      s:SetWidth(cfg.playercbwidth)
      lib.moveme(s)
      s:SetPoint(unpack(cfg.playercbposition))
    elseif f.mystyle == "target" then
	  s:SetHeight(cfg.targetcbheight)
      s:SetWidth(cfg.targetcbwidth)
      lib.moveme(s)
      s:SetPoint(unpack(cfg.targetcbposition))
	elseif f.mystyle == "focus" then
	  s:SetHeight(cfg.focuscbheight)
      s:SetWidth(cfg.focuscbwidth)
      lib.moveme(s)
      s:SetPoint(unpack(cfg.focuscbposition))
    else
	  s:SetHeight(f.height/2)
      s:SetWidth(f.width-20)
      s:SetPoint("BOTTOMLEFT",f,"TOPLEFT",19,-f.height/2+17)
    end
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetStatusBarColor(cfg.cbcolor[1], cfg.cbcolor[2], cfg.cbcolor[3],1)
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)
    
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    b:SetVertexColor(0.8*0.3,0.8*0.3,0.8*0.3,0.7)  
    
    local txt = lib.gen_fontstring(s, cfg.font, 16, "THINOUTLINE")
    txt:SetPoint("LEFT", 2, 5)
    txt:SetJustifyH("LEFT")
    --time
    local t = lib.gen_fontstring(s, cfg.font, 16, "THINOUTLINE")
    t:SetPoint("RIGHT", -2, 5)
    txt:SetPoint("RIGHT", t, "LEFT", -5, 0)
    
    --icon
    local i = s:CreateTexture(nil, "ARTWORK")
    i:SetWidth(f.height)
    i:SetHeight(f.height)
    i:SetPoint("RIGHT", s, "LEFT", -5, 5)
    i:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    
    --helper2 for icon
    local h2 = CreateFrame("Frame", nil, s)
    h2:SetFrameLevel(0)
    h2:SetPoint("TOPLEFT",i,"TOPLEFT",-5,5)
    h2:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h2)
    
    if f.mystyle == "player" then
      --latency only for player unit
      local z = s:CreateTexture(nil,"OVERLAY")
      z:SetTexture(cfg.statusbar_texture)
      z:SetVertexColor(0.6,0,0,0.6)
      z:SetPoint("TOPRIGHT")
      z:SetPoint("BOTTOMRIGHT")
      s.SafeZone = z
    end
    
    f.Castbar = s
    f.Castbar.Text = txt
    f.Castbar.Time = t
    f.Castbar.Icon = i
  end
  
   lib.gen_mirrorcb = function(f)
    for _, bar in pairs({'MirrorTimer1','MirrorTimer2','MirrorTimer3',}) do   
      for i, region in pairs({_G[bar]:GetRegions()}) do
        if (region.GetTexture and region:GetTexture() == 'SolidTexture') then
          region:Hide()
        end
      end
      _G[bar..'Border']:Hide()
      _G[bar]:SetParent(UIParent)
      _G[bar]:SetScale(1)
      _G[bar]:SetHeight(16)
      _G[bar]:SetBackdropColor(.1,.1,.1)
      _G[bar..'Background'] = _G[bar]:CreateTexture(bar..'Background', 'BACKGROUND', _G[bar])
      _G[bar..'Background']:SetTexture(cfg.statusbar_texture)
      _G[bar..'Background']:SetAllPoints(bar)
      _G[bar..'Background']:SetVertexColor(.15,.15,.15,1)
      _G[bar..'Text']:SetFont(cfg.font, 14)
      _G[bar..'Text']:ClearAllPoints()
      _G[bar..'Text']:SetPoint('CENTER', _G[bar..'StatusBar'], 0, 0)
	  _G[bar..'StatusBar']:SetAllPoints(_G[bar])
      --glowing borders
      local h = CreateFrame("Frame", nil, _G[bar])
      h:SetFrameLevel(0)
      h:SetPoint("TOPLEFT",-5,5)
      h:SetPoint("BOTTOMRIGHT",5,-5)
      lib.gen_backdrop(h)
    end
  end

---------------------------
--3D portrait
---------------------------  
-- worgen male portrait fix
  lib.PortraitPostUpdate = function(self, unit) 
	if self:GetModel() and self:GetModel().find and self:GetModel():find("worgenmale") then
		self:SetCamera(1)
	end	
  end
  
  lib.gen_portrait = function(f)
    if not cfg.Enable3DPortrait then return end
    s = f.Health
	local p = CreateFrame("PlayerModel", nil, f)
	p:SetFrameLevel(s:GetFrameLevel()-1)
    p:SetWidth(f.width-2)
    p:SetHeight(f.height-2)
    p:SetPoint("TOP", s, "TOP", 0, -2)
	p:SetAlpha(.25)
	p.PostUpdate = lib.PortraitPostUpdate	
    f.Portrait = p
  end
  
 -------------------
 --aura and timer 
 -------------------
-- Creating our own timers with blackjack and hookers!
  lib.FormatTime = function(s)
    local day, hour, minute = 86400, 3600, 60
    if s >= day then
      return format("%dd", floor(s/day + 0.5)), s % day
    elseif s >= hour then
      return format("%dh", floor(s/hour + 0.5)), s % hour
    elseif s >= minute then
      if s <= minute * 5 then
        return format('%d:%02d', floor(s/60), s % minute), s - floor(s)
      end
      return format("%dm", floor(s/minute + 0.5)), s % minute
    elseif s >= minute / 12 then
      return floor(s + 0.5), (s * 100 - floor(s * 100))/100
    end
    return format("%.1f", s), (s * 100 - floor(s * 100))/100
  end
  lib.CreateAuraTimer = function(self,elapsed)
    if self.timeLeft then
      self.elapsed = (self.elapsed or 0) + elapsed
      local w = self:GetWidth()
      if self.elapsed >= 0.1 then
        if not self.first then
          self.timeLeft = self.timeLeft - self.elapsed
        else
          self.timeLeft = self.timeLeft - GetTime()
          self.first = false
        end
        if self.timeLeft > 0 and w > cfg.ATIconSizeThreshold then
          local time = lib.FormatTime(self.timeLeft)
          self.remaining:SetText(time)
          if self.timeLeft < 5 then
            self.remaining:SetTextColor(1, .3, .2)
          else
            self.remaining:SetTextColor(.9, .7, .2)
          end
        else
          self.remaining:Hide()
          self:SetScript("OnUpdate", nil)
        end
        self.elapsed = 0
      end
    end
  end
  lib.PostUpdateIcon = function(self, unit, icon, index, offset)
  local _, _, _, _, _, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, icon.filter)
    -- Debuff desaturation
    if unitCaster ~= 'player' and unitCaster ~= 'vehicle' and not UnitIsFriend('player', unit) and icon.debuff then
      icon.icon:SetDesaturated(true)
    else
      icon.icon:SetDesaturated(false)
    end
    -- Creating aura timers
    if duration and duration > 0 and cfg.auratimers then
      if cfg.PlayerTimersOnly and unitCaster ~= 'player' then 
		if unit=='player' and icon.debuff then icon.remaining:Show() else icon.remaining:Hide() end
	  else 
		icon.remaining:Show() 
	  end
    else
      icon.remaining:Hide()
    end
    if unit == 'player' or unit == 'target' or (unit:match'(boss)%d?$' == 'boss') then
      icon.duration = duration
      icon.timeLeft = expirationTime
      icon.first = true
      icon:SetScript("OnUpdate", lib.CreateAuraTimer)
    end
  end
  -- creating aura icons
  lib.PostCreateIcon = function(self, button)
    button.cd:SetReverse()
    button.cd.noOCC = true
    button.cd.noCooldownCount = true
    button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    button.icon:SetDrawLayer("BACKGROUND")
    --count
    button.count:ClearAllPoints()
    button.count:SetJustifyH("RIGHT")
    button.count:SetPoint("BOTTOMRIGHT", 2, -2)
    button.count:SetTextColor(1,1,1)
    --helper
    local h = CreateFrame("Frame", nil, button)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-4,4)
    h:SetPoint("BOTTOMRIGHT",4,-4)
    lib.gen_backdrop(h)
    --another helper frame for our fontstring to overlap the cd frame
    local h2 = CreateFrame("Frame", nil, button)
    h2:SetAllPoints(button)
    h2:SetFrameLevel(10)
    button.remaining = lib.gen_fontstring(h2, cfg.font, cfg.ATSize, "THINOUTLINE")
	--button.remaining:SetShadowColor(0, 0, 0)--button.remaining:SetShadowOffset(2, -1)
    button.remaining:SetPoint("TOPLEFT", 0, -0.5)
    --overlay texture for debuff types display
    button.overlay:SetTexture(cfg.auratex)
    button.overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 2)
    button.overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
    button.overlay:SetTexCoord(0.04, 0.96, 0.04, 0.96)
    button.overlay.Hide = function(self) self:SetVertexColor(0, 0, 0) end
  end
  
    --aura
    lib.createAuras = function(f)
    a = CreateFrame('Frame', nil, f)
    a:SetPoint('BOTTOMLEFT', f, 'TOPLEFT', 1.5, 7)
    a['growth-x'] = 'RIGHT'
    a['growth-y'] = 'UP' 
    a.initialAnchor = 'BOTTOMLEFT'
    a.gap = true
    a.spacing = 7
    a.size = 17
    a.showDebuffType = cfg.showDebuffType
	
    a:SetHeight((a.size+a.spacing)*2)
    a:SetWidth((a.size+a.spacing)*8)
    a.numBuffs = 15 
    a.numDebuffs = 15
	
    a.PostCreateIcon = lib.PostCreateIcon
    a.PostUpdateIcon = lib.PostUpdateIcon
	f.Auras = a
  end
    -- buffs
  lib.createBuffs = function(f)
    b = CreateFrame("Frame", nil, f)
    b.initialAnchor = "TOPLEFT"
    b['growth-x'] = 'RIGHT'
    b['growth-y'] = 'UP' 
    b.initialAnchor = 'BOTTOMLEFT'
    b.gap = true
    b.spacing = 7
    b.size = 17
    b.showDebuffType = cfg.showDebuffType
	
    b:SetHeight((b.size+b.spacing)*2)
    b:SetWidth((b.size+b.spacing)*8)
    b.numBuffs = 15 
    b.numDebuffs = 15
    b.PostCreateIcon = lib.PostCreateIcon
    b.PostUpdateIcon = lib.PostUpdateIcon
    f.Buffs = b
  end
  -- debuffs
  lib.createDebuffs = function(f)
    d = CreateFrame("Frame", nil, f)
    d.initialAnchor = "TOPRIGHT"
    d["growth-y"] = "DOWN"
    d.num = 4
    d.size = 18
    d.spacing = 6
    d:SetHeight((d.size+d.spacing)*2)
    d:SetWidth((d.size+d.spacing)*5)
    d.showDebuffType = cfg.showDebuffType
    if f.mystyle=="pet" then
      d:SetPoint("TOPRIGHT", f, "TOPLEFT", -d.spacing, -2)
      d["growth-x"] = "LEFT"
	elseif f.mystyle=="player" then
	  d['growth-x'] = 'LEFT'
      d['growth-y'] = 'UP' 
      d.initialAnchor = 'BOTTOMRIGHT'
	  d.num = 15
	  d.size = 25
      d:SetHeight((d.size+d.spacing)*2)
      d:SetWidth((d.size+d.spacing)*6)
	  d:SetPoint('BOTTOMRIGHT', f, 'TOPRIGHT', -1.5, 12)
    end
    d.PostCreateIcon = lib.PostCreateIcon
    d.PostUpdateIcon = lib.PostUpdateIcon
    f.Debuffs = d
  end
------------------------------
-- gen class specific function
------------------------------
  --DK runes
  lib.gen_Runes = function(f)
    if class ~= "DEATHKNIGHT" then return
    else
      local runeloadcolors = {
      [1] = {0.59, 0.31, 0.31},
      [2] = {0.59, 0.31, 0.31},
      [3] = {0.33, 0.51, 0.33},
      [4] = {0.33, 0.51, 0.33},
      [5] = {0.31, 0.45, 0.53},
      [6] = {0.31, 0.45, 0.53},}
      f.Runes = CreateFrame("Frame", nil, f)
      for i = 1, 6 do
        r = CreateFrame("StatusBar", f:GetName().."_Runes"..i, f)
        r:SetSize(f.width/6, f.height/3)
        if (i == 1) then
          r:SetPoint(unpack(cfg.runesp))
        else
          r:SetPoint("TOPLEFT", f.Runes[i-1], "TOPRIGHT", 2, 0)
        end
        r:SetStatusBarTexture(cfg.statusbar_texture)
        r:GetStatusBarTexture():SetHorizTile(false)
        r:SetStatusBarColor(unpack(runeloadcolors[i]))
        r.bd = r:CreateTexture(nil, "BORDER")
        r.bd:SetAllPoints()
        r.bd:SetTexture(cfg.statusbar_texture)
        r.bd:SetVertexColor(0.15, 0.15, 0.15)
        f.b = CreateFrame("Frame", nil, r)
        f.b:SetPoint("TOPLEFT", r, "TOPLEFT", -4, 4)
        f.b:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", 4, -5)
        f.b:SetBackdrop(backdrop_tab)
        f.b:SetBackdropColor(0, 0, 0, 0)
        f.b:SetBackdropBorderColor(0,0,0,1)
        f.Runes[i] = r
      end
    end
  end
  -- eclipse bar
  lib.gen_EclipseBar = function(f)
	if class ~= "DRUID" then return end
	local eb = CreateFrame('Frame', nil, f)
	eb:SetPoint(unpack(cfg.ebp))
	eb:SetSize(cfg.ebw, cfg.ebh)
	lib.gen_backdrop(eb)
	local lb = CreateFrame('StatusBar', nil, eb)
	lb:SetPoint('LEFT', eb, 'LEFT', 5, 0)
	lb:SetSize(cfg.ebw-9, 10)
	lb:SetStatusBarTexture(cfg.statusbar_texture)
	lb:SetStatusBarColor(0.27, 0.47, 0.74,0.5)
	eb.LunarBar = lb
	local sb = CreateFrame('StatusBar', nil, eb)
	sb:SetPoint('LEFT', lb:GetStatusBarTexture(), 'RIGHT', 0, 0)
	sb:SetSize(cfg.ebw-9, 10)
	sb:SetStatusBarTexture(cfg.statusbar_texture)
	sb:SetStatusBarColor(0.9, 0.6, 0.3,0.5)
	eb.SolarBar = sb
  	local h = CreateFrame("Frame", nil, eb)
	h:SetAllPoints(eb)
	h:SetFrameLevel(30)
	f.EclipseBar = eb
	local ebInd = lib.gen_fontstring(h, cfg.font, 16, "THINOUTLINE")
	ebInd:SetPoint('CENTER', eb, 'CENTER', 0, 0)
	f.EclipseBar.PostDirectionChange = function(element, unit)
		local dir = GetEclipseDirection()
		if dir=="sun" then
			ebInd:SetText("|cff4478BC>|r")
		elseif dir=="moon" then
			ebInd:SetText("|cffE5994C<|r")
		end
	end
  end
  -- TotemBar for shamans
  lib.gen_TotemBar = function(f)
    if class ~= "SHAMAN" then return
    elseif IsAddOnLoaded("oUF_boring_TotemBar") then
		local width = f.width/4
		local height = f.height/3
		local TotemBar = CreateFrame("Frame", nil, f)
		TotemBar:SetSize(width,height)
		TotemBar:SetPoint("LEFT",UIParent,"BOTTOM",-f.width/2,280)
		TotemBar.Destroy = true
		TotemBar.UpdateColors = true
		TotemBar.AbbreviateNames = true
		for i = 1, 4 do
			local t = CreateFrame("Frame", nil, TotemBar)
			t:SetPoint("LEFT", (i - 1) * (width + 3.5), 0)
			t:SetWidth(width)
			t:SetHeight(height)
			local bar = CreateFrame("StatusBar", nil, t)
			bar:SetWidth(width)
			bar:SetPoint"BOTTOM"
			bar:SetHeight(8)
			t.StatusBar = bar
			local h = CreateFrame("Frame",nil,t)
			h:SetFrameLevel(10)
			local time = lib.gen_fontstring(h, cfg.font, 11, "THINOUTLINE")
			time:SetPoint("BOTTOMRIGHT",t,"TOPRIGHT", 0, -1)
			time:SetFontObject"GameFontNormal"
			t.Time = time
			local text = lib.gen_fontstring(h, cfg.font, 11, "THINOUTLINE")
			text:Hide()
			--text:SetPoint("BOTTOMLEFT", t, "TOPLEFT", 0, -1)
			--text:SetFontObject"GameFontNormal"
			t.Text = text
	        t.bg = CreateFrame("Frame", nil, t)
			t.bg:SetPoint("TOPLEFT", t, "TOPLEFT", -4, 5)
			t.bg:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 4, -5)
			t.bg:SetBackdrop(backdrop_tab)
			t.bg:SetBackdropColor(0,0,0,0)
			t.bg:SetBackdropBorderColor(0,0,0,1)
			t.bg = t:CreateTexture(nil, "BACKGROUND")
			t.bg:SetAllPoints()
			t.bg:SetTexture(1, 1, 1)
			t.bg.multiplier = 0.2
			TotemBar[i] = t
		end
		f.TotemBar = TotemBar
    end
  end
  -- class specific power display
  lib.gen_specificpower = function(f, unit)
    local h = CreateFrame("Frame", nil, f)
    h:SetAllPoints(f.Health)
    h:SetFrameLevel(10)
	if f.mystyle == "player" then
		local sp = lib.gen_fontstring(h, cfg.font, cfg.specialpowerfont, "OUTLINE")
		sp:SetPoint(unpack(cfg.specialpowerp))
		if class == "DRUID" then
			f:Tag(sp, '[Mlight:wm1][Mlight:wm2][Mlight:wm3]')
		elseif class == "PRIEST" then
			f:Tag(sp, '[Mlight:orbs]')
		elseif class == "PALADIN" or class == "WARLOCK" then
			f:Tag(sp, '[Mlight:sp]')
		elseif class == "SHAMAN" then
			f:Tag(sp, '[Mlight:ws][Mlight:ls]')
		end
	end
  end
    --gen combo points
  lib.gen_cp = function(f)
    local h = CreateFrame("Frame", nil, f)
    h:SetAllPoints(f.Health)
    h:SetFrameLevel(10)
    local cp = lib.gen_fontstring(h, cfg.font, cfg.combofont, "THINOUTLINE")
    cp:SetPoint(unpack(cfg.combop))
    f:Tag(cp, '[Mlight:cp]')
  end
  -----------------------------
  -- litte marks
  -----------------------------
   --gen LFD role indicator
  lib.gen_LFDindicator = function(f)
    local lfdi = lib.gen_fontstring(f.Health, cfg.font, 11, "THINOUTLINE")
    lfdi:SetPoint("LEFT", f.Health, "LEFT",1,0)
    f:Tag(lfdi, '[Mlight:LFD]')
  end
   --gen combat icons
    lib.gen_combatIcon = function(f)
    local h = CreateFrame("Frame",nil,f)
    h:SetAllPoints(f.Health)
    h:SetFrameLevel(10)
    --combat icon
    if f.mystyle == 'player' then
		f.Combat = h:CreateTexture(nil, 'OVERLAY')
		f.Combat:SetSize(20,20)
		f.Combat:SetPoint('BOTTOMRIGHT', 2, -30)
    end
	end
  --gen leader icons
  lib.gen_InfoIcons = function(f)
    local h = CreateFrame("Frame",nil,f)
    h:SetAllPoints(f.Health)
    h:SetFrameLevel(10)
    --Leader icon
    li = h:CreateTexture(nil, "OVERLAY")
	if f.mystyle == 'party' then
    li:SetPoint("BOTTOMRIGHT", f, -10, -8)
	else
	li:SetPoint("BOTTOMRIGHT", f, 0, -4)
	end
    li:SetSize(12,12)
    f.Leader = li
    --Assist icon
    ai = h:CreateTexture(nil, "OVERLAY")
	if f.mystyle == 'party' then
    ai:SetPoint("BOTTOMRIGHT", f, -10, -8)
	else
	ai:SetPoint("BOTTOMRIGHT", f, 0, -4)
	end
    ai:SetSize(12,12)
    f.Assistant = ai
    --ML icon
    local ml = h:CreateTexture(nil, 'OVERLAY')
    ml:SetSize(12,12)
    ml:SetPoint('RIGHT', f.Leader, 'LEFT')
    f.MasterLooter = ml
  end
    -- raid mark icons
  lib.gen_RaidMark = function(f)
    local h = CreateFrame("Frame", nil, f)
    h:SetAllPoints(f)
    h:SetFrameLevel(20)
    h:SetAlpha(cfg.RMalpha)
    local ri = h:CreateTexture(nil,'OVERLAY',h)
    ri:SetPoint("CENTER", f, "CENTER", 0, 0)
    ri:SetSize(cfg.RMsize, cfg.RMsize)
    f.RaidIcon = ri
  end
  -- hilight texture
  lib.gen_highlight = function(f)
    local OnEnter = function(f)
      UnitFrame_OnEnter(f)
      f.Highlight:Show()
    end
    local OnLeave = function(f)
      UnitFrame_OnLeave(f)
      f.Highlight:Hide()
    end
    f:SetScript("OnEnter", OnEnter)
    f:SetScript("OnLeave", OnLeave)
    local hl = f.Health:CreateTexture(nil, "OVERLAY")
    hl:SetAllPoints(f.Health)
    hl:SetTexture(cfg.backdrop_texture)
    hl:SetVertexColor(.5,.5,.5,.1)
    hl:SetBlendMode("ADD")
    hl:Hide()
    f.Highlight = hl
  end
  -- alt power bar
  lib.gen_alt_powerbar = function(f)
	local apb = CreateFrame("StatusBar", nil, f)
	apb:SetFrameLevel(f.Health:GetFrameLevel() + 2)
	apb:SetSize(f.width/2.2, f.height/3)
	apb:SetStatusBarTexture(cfg.statusbar_texture)
	apb:GetStatusBarTexture():SetHorizTile(false)
	apb:SetStatusBarColor(1, 0, 0)
	apb:SetPoint("BOTTOM", f, "TOP", 0, -f.height/6)

	apb.bg = apb:CreateTexture(nil, "BORDER")
	apb.bg:SetAllPoints(apb)
	apb.bg:SetTexture(cfg.statusbar_texture)
	apb.bg:SetVertexColor(.18, .18, .18, 1)
	f.AltPowerBar = apb
	
	apb.b = CreateFrame("Frame", nil, apb)
	apb.b:SetFrameLevel(f.Health:GetFrameLevel() + 1)
	apb.b:SetPoint("TOPLEFT", apb, "TOPLEFT", -4, 4)
	apb.b:SetPoint("BOTTOMRIGHT", apb, "BOTTOMRIGHT", 4, -5)
	apb.b:SetBackdrop(backdrop_tab)
	apb.b:SetBackdropColor(0, 0, 0, 0)
	apb.b:SetBackdropBorderColor(0,0,0,1)
	
	apb.v = lib.gen_fontstring(apb, cfg.font, 10, "THINOUTLINE")
	apb.v:SetPoint("CENTER", apb, "CENTER", 0, 0)
	f:Tag(apb.v, '[Mlight:altpower]')
  end
  -----------------------------
  lib.gen_raidhpbar = function(f)
    --statusbar
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetHeight(f.height)
    s:SetWidth(f.width)
    s:SetPoint("CENTER",0,0)
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)
    --bg
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    b:SetAlpha(0)
	
    --debuff highlight
    local dbh = s:CreateTexture(nil, "OVERLAY")
    dbh:SetAllPoints(f)
    dbh:SetTexture("Interface\\AddOns\\oUF_Mlight\\media\\debuff_highlight")
    dbh:SetBlendMode("ADD")
    dbh:SetVertexColor(0,0,0,0)
    f.DebuffHighlightAlpha = 1
    f.DebuffHighlightFilter = false
	
    f.DebuffHighlight = dbh
    f.Health = s
    f.Health.bg = b
    f.Health:SetReverseFill(true)
	f.Health.PostUpdate = function(Health, unit, min, max)   
	f.Health:SetValue(max - Health:GetValue())end
    
  end
  
  --gen hp strings func
  lib.gen_raidhpstrings = function(f)
    local hpval
    --health
    hpval = lib.gen_fontstring(f.Health, cfg.font, cfg.gridfontsize, "THINOUTLINE")

	hpval:SetPoint("BOTTOMRIGHT", f.Health, "BOTTOMRIGHT", -2, 1)

    f:Tag(hpval, "[Mlight:gridcolor][Mlight:hpraid]")
	
    end

  --gen power func
  lib.gen_raidppbar = function(f)
    --statusbar
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetHeight(f.height/9)
    s:SetWidth(f.width)
    s:SetPoint("TOP",f,"BOTTOM",0,-4)
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)
    --bg
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    f.Power = s
    f.Power.bg = b
  end
  function lib.CreateTargetBorder(self)
	local glowBorder = {edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1}
	self.TargetBorder = CreateFrame("Frame", nil, self)
	self.TargetBorder:SetPoint("TOPLEFT", self, "TOPLEFT", -1, 1)
	self.TargetBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 1, -1)
	self.TargetBorder:SetBackdrop(glowBorder)
	self.TargetBorder:SetFrameLevel(2)
	self.TargetBorder:SetBackdropBorderColor(.7,.7,.7,1)
	self.TargetBorder:Hide()
end
----------------------------------
-- target and threat
----------------------------------
function lib.ChangedTarget(self, event, unit)
	if UnitIsUnit('target', self.unit) then
		self.TargetBorder:Show()
	else
		self.TargetBorder:Hide()
	end
end
function lib.CreateThreatBorder(self)
	local glowBorder = {edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2}
	self.Thtborder = CreateFrame("Frame", nil, self)
	self.Thtborder:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 2)
	self.Thtborder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 2, -2)
	self.Thtborder:SetBackdrop(glowBorder)
	self.Thtborder:SetFrameLevel(1)
	self.Thtborder:Hide()	
end
function lib.UpdateThreat(self, event, unit)
	if (self.unit ~= unit) then return end
		local status = UnitThreatSituation(unit)
		unit = unit or self.unit
	if status and status > 1 then
		local r, g, b = GetThreatStatusColor(status)
		self.Thtborder:Show()
		self.Thtborder:SetBackdropBorderColor(r, g, b, 1)
	else
		self.Thtborder:SetBackdropBorderColor(r, g, b, 0)
		self.Thtborder:Hide()
	end
end
----------------------------------
-- heal in coming
----------------------------------
lib.healcomm = function(self, unit)
if cfg.HealMode then
		local mhpb = CreateFrame('StatusBar', nil, self.Health)
		mhpb:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPLEFT', 0, 0)
		mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMLEFT', 0, 0)
		mhpb:SetWidth(65)
		mhpb:SetStatusBarTexture(cfg.statusbar_texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

		local ohpb = CreateFrame('StatusBar', nil, self.Health)
		ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPLEFT', 0, 0)
		ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMLEFT', 0, 0)
		ohpb:SetWidth(65)
		ohpb:SetStatusBarTexture(cfg.statusbar_texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 2,
		}
	end
end
----------------------------------
-- ReadyCheck
----------------------------------
lib.ReadyCheck = function(self)
	if cfg.RCheckIcon then
		rCheck = self.Health:CreateTexture(nil, "OVERLAY")
		rCheck:SetSize(14, 14)
		rCheck:SetPoint("TOP", self.Health)
		rCheck.finishedTimer = 10
		rCheck.fadeTimer = 3
		self.ReadyCheck = rCheck
	end
end
----------------------------------
-- Raid Debuffs
----------------------------------
lib.raidDebuffs = function(f)
	if cfg.showRaidDebuffs then
		local raid_debuffs = {
			debuffs = {
			[GetSpellInfo(47476)] = 3, --strangulate
		-- Druid
			[GetSpellInfo(33786)] = 3, --Cyclone
			[GetSpellInfo(2637)] = 3, --Hibernate
			[GetSpellInfo(339)] = 3, --Entangling Roots
			[GetSpellInfo(80964)] = 3, --Skull Bash
			[GetSpellInfo(78675)] = 3, --Solar Beam
		-- Hunter
			[GetSpellInfo(3355)] = 3, --Freezing Trap Effect
			--[GetSpellInfo(60210)] = 3, --Freezing Arrow Effect
			[GetSpellInfo(1513)] = 3, --scare beast
			[GetSpellInfo(19503)] = 3, --scatter shot
			[GetSpellInfo(34490)] = 3, --silence shot
		-- Mage
			[GetSpellInfo(31661)] = 3, --Dragon's Breath
			[GetSpellInfo(61305)] = 3, --Polymorph
			[GetSpellInfo(18469)] = 3, --Silenced - Improved Counterspell
			[GetSpellInfo(122)] = 3, --Frost Nova
			[GetSpellInfo(55080)] = 3, --Shattered Barrier
		-- Paladin
			[GetSpellInfo(20066)] = 3, --Repentance
			[GetSpellInfo(10326)] = 3, --Turn Evil
			[GetSpellInfo(853)] = 3, --Hammer of Justice
		-- Priest
			[GetSpellInfo(605)] = 3, --Mind Control
			[GetSpellInfo(64044)] = 3, --Psychic Horror
			[GetSpellInfo(8122)] = 3, --Psychic Scream
			[GetSpellInfo(9484)] = 3, --Shackle Undead
			[GetSpellInfo(15487)] = 3, --Silence
		-- Rogue
			[GetSpellInfo(2094)] = 3, --Blind
			[GetSpellInfo(1776)] = 3, --Gouge
			[GetSpellInfo(6770)] = 3, --Sap
			[GetSpellInfo(18425)] = 3, --Silenced - Improved Kick
		-- Shaman
			[GetSpellInfo(51514)] = 3, --Hex
			[GetSpellInfo(3600)] = 3, --Earthbind
			[GetSpellInfo(8056)] = 3, --Frost Shock
			[GetSpellInfo(63685)] = 3, --Freeze
			[GetSpellInfo(39796)] = 3, --Stoneclaw Stun
		-- Warlock
			[GetSpellInfo(710)] = 3, --Banish
			[GetSpellInfo(6789)] = 3, --Death Coil
			[GetSpellInfo(5782)] = 3, --Fear
			[GetSpellInfo(5484)] = 3, --Howl of Terror
			[GetSpellInfo(6358)] = 3, --Seduction
			[GetSpellInfo(30283)] = 3, --Shadowfury
			[GetSpellInfo(89605)] = 3, --Aura of Foreboding
		-- Warrior
			[GetSpellInfo(20511)] = 3, --Intimidating Shout
		-- Racial
			[GetSpellInfo(25046)] = 3, --Arcane Torrent
			[GetSpellInfo(20549)] = 3, --War Stomp
		
		--Magmaw
			[GetSpellInfo(78941)] = 6, -- Parasitic Infection
			[GetSpellInfo(89773)] = 7, -- Mangle
		--Omnitron Defense System
			[GetSpellInfo(79888)] = 6, -- Lightning Conductor
            [GetSpellInfo(79505)] = 8, -- Flamethrower
            [GetSpellInfo(80161)] = 7, -- Chemical Cloud
            [GetSpellInfo(79501)] = 8, -- Acquiring Target
            [GetSpellInfo(80011)] = 7, -- Soaked in Poison
            [GetSpellInfo(80094)] = 7, -- Fixate
            [GetSpellInfo(92023)] = 9, -- Encasing Shadows
            [GetSpellInfo(92048)] = 9, -- Shadow Infusion
            [GetSpellInfo(92053)] = 9, -- Shadow Conductor
            --Maloriak
            [GetSpellInfo(92973)] = 8, -- Consuming Flames
            [GetSpellInfo(92978)] = 8, -- Flash Freeze
            [GetSpellInfo(92976)] = 7, -- Biting Chill
            [GetSpellInfo(91829)] = 7, -- Fixate
            [GetSpellInfo(92787)] = 9, -- Engulfing Darkness
            --Atramedes
            [GetSpellInfo(78092)] = 7, -- Tracking
            [GetSpellInfo(78897)] = 8, -- Noisy
            [GetSpellInfo(78023)] = 7, -- Roaring Flame
            --Chimaeron
            [GetSpellInfo(89084)] = 8, -- Low Health
            [GetSpellInfo(82881)] = 7, -- Break
            [GetSpellInfo(82890)] = 9, -- Mortality
            --Nefarian
            [GetSpellInfo(94128)] = 7, -- Tail Lash
            --[GetSpellInfo(94075)] = 8, -- Magma
            [GetSpellInfo(79339)] = 9, -- Explosive Cinders
            [GetSpellInfo(79318)] = 9, -- Dominion
			
			 --Halfus
            [GetSpellInfo(39171)] = 7, -- Malevolent Strikes
            [GetSpellInfo(86169)] = 8, -- Furious Roar
            --Valiona & Theralion
            [GetSpellInfo(86788)] = 6, -- Blackout
            [GetSpellInfo(86622)] = 7, -- Engulfing Magic
            --[GetSpellInfo(86202)] = 7, -- Twilight Shift
            --Council
            [GetSpellInfo(82665)] = 7, -- Heart of Ice
            [GetSpellInfo(82660)] = 7, -- Burning Blood
            [GetSpellInfo(82762)] = 7, -- Waterlogged
            [GetSpellInfo(83099)] = 7, -- Lightning Rod
            [GetSpellInfo(82285)] = 7, -- Elemental Stasis
            [GetSpellInfo(92488)] = 8, -- Gravity Well
            --Cho'gall
            [GetSpellInfo(86028)] = 6, -- Cho's Blast
            [GetSpellInfo(86029)] = 6, -- Gall's Blast
            [GetSpellInfo(93189)] = 7, -- Corrupted Blood
            [GetSpellInfo(93133)] = 7, -- Debilitating Beam
            [GetSpellInfo(81836)] = 8, -- Corruption: Accelerated
            [GetSpellInfo(81831)] = 8, -- Corruption: Sickness
            [GetSpellInfo(82125)] = 8, -- Corruption: Malformation
            [GetSpellInfo(82170)] = 8, -- Corruption: Absolute 
			
			--Conclave
            [GetSpellInfo(85576)] = 9, -- Withering Winds
            [GetSpellInfo(85573)] = 9, -- Deafening Winds
            [GetSpellInfo(93057)] = 7, -- Slicing Gale
            [GetSpellInfo(86481)] = 8, -- Hurricane
            [GetSpellInfo(93123)] = 7, -- Wind Chill
            [GetSpellInfo(93121)] = 8, -- Toxic Spores
            --Al'Akir
            --[GetSpellInfo(93281)] = 7, -- Acid Rain
            [GetSpellInfo(87873)] = 7, -- Static Shock
            [GetSpellInfo(88427)] = 7, -- Electrocute
            [GetSpellInfo(93294)] = 8, -- Lightning Rod
            [GetSpellInfo(93284)] = 9, -- Squall Line
			
			
			--Beth'tilac(÷©÷Î)
			[GetSpellInfo(97202)] = 7, -- Fiery Web Spin(üÎ—◊÷ÎæW—£ïû)
            [GetSpellInfo(49026)] = 8, -- Fixate(ƒ˝“ï)
			[GetSpellInfo(99506)] = 9, -- The Widow's Kiss(π—ãD÷ÆŒ«)
			
			--Lord Rhyolith(◊Û”“ƒ_)
			[GetSpellInfo(98492)] = 7, -- Eruption(±¨∞l)
			
			--Alysrazor(ª¯B)
			[GetSpellInfo(101729)] = 7, -- Blazing Claw(üÎ—◊◊¶ìÙ)
			[GetSpellInfo(100094)] = 7, -- Fieroblast(√Õª–nìÙ)
			[GetSpellInfo(99389)] = 8, -- Imprinted(”°øÃ)
			
			--Shannox(´C»À)
			[GetSpellInfo(100415)] = 8, -- Rage(≈≠ª)
			[GetSpellInfo(99947)] = 7, -- Face Rage(≈≠ö‚±¨∞l)
			
			--Baleroc, the Gatekeeper( ÿÈT»À)
			[GetSpellInfo(99403)] = 8, -- Tormented( ‹µΩ’€ƒ•)
			[GetSpellInfo(99256)] = 7, -- Torment(’€ƒ•)
			
			--Majordomo Staghelm(¬πø¯)
			[GetSpellInfo(98450)] = 7, -- Searing Seeds(◊∆ü·∑N◊”)
			[GetSpellInfo(98443)] = 8, -- Fiery Cyclone(üÎ—◊ÔZÔL)
			
			--Ragnaros(¥Û¬›Ωz)
			[GetSpellInfo(100460)] = 7, --Blazing Heat(üÎü·∏ﬂúÿ)
			[GetSpellInfo(99399)] = 8, -- Burning Wound(»ºü˝Ç˚ø⁄)
			

			---- Dragon Soul
			-- Morchok
			[GetSpellInfo(103687)] = 7,  -- Crush Armor(ìÙÀÈ◊oº◊)
			
			-- Zon'ozz
			[GetSpellInfo(103434)] = 7, -- Disrupting Shadows(±¿Ω‚÷Æ”∞)
			
			-- Yor'sahj
			[GetSpellInfo(105171)] = 7, -- Deep Corruption(…Ó∂»∏ØªØ)
			--[GetSpellInfo(103628)] = 7, -- Deep Corruption(…Ó∂»∏ØªØ)
			[GetSpellInfo(104849)] = 8,  -- Void Bolt(Ãìüoº˝)
			
			-- Hagara
			[GetSpellInfo(104451)] = 7,  -- Ice Tomb(∫Æ±˘÷Æƒπ)
			
			-- Ultraxion
			[GetSpellInfo(110073)] = 7, -- Fading Light(µÚ¡„÷Æπ‚)
			
			-- Blackhorn
			[GetSpellInfo(109209)] = 7,  -- Brutal Strike(–UôM¥ÚìÙ)
			[GetSpellInfo(108043)] = 8,  -- Sunder Armor(∆∆º◊π•ìÙ)
			[GetSpellInfo(108861)] = 9,  -- Degeneration(À•Õˆ)
			
			-- Spine
			[GetSpellInfo(105479)] = 7, -- »ºü˝—™ù{
			--[GetSpellInfo(109379)] = 7, -- Searing Plasma(»ºü˝—™ù{)
			--[GetSpellInfo(109457)] = 8,  -- Fiery Grip(üÎü·÷ÆŒ’)
			[GetSpellInfo(105490)] = 8,  -- Fiery Grip(üÎü·÷ÆŒ’)
			
			-- Madness 
			[GetSpellInfo(105841)] = 7,  -- Degenerative Bite(ÕÀªØ“ßìÙ)
			[GetSpellInfo(105445)] = 8,  -- Blistering Heat(òOüÎ∏ﬂü·)
			[GetSpellInfo(106444)] = 9,  -- Impale(¥Ã¥©)
			
			--≤‚ ‘
			[GetSpellInfo(95223)] = 8, -- »∫ÃÂ∏¥ªÓ
			[GetSpellInfo(6788)] = 7, -- Ãì»ıÏ`ªÍ
			},
		}

		local instDebuffs = {}
		local instances = raid_debuffs.instances
		local getzone = function()
			local zone = GetInstanceInfo()
			if instances[zone] then
				instDebuffs = instances[zone]
			else
				instDebuffs = {}
			end
		end

		local debuffs = raid_debuffs.debuffs
		local CustomFilter = function(icons, ...)
			local _, icon, name, _, _, _, dtype = ...
			if instDebuffs[name] then
				icon.priority = instDebuffs[name]
				return true
			elseif debuffs[name] then
				icon.priority = debuffs[name]
				return true
			else
				icon.priority = 0
			end
		end

		local dbsize = 18
		local debuffs = CreateFrame("Frame", nil, f)
		debuffs:SetWidth(dbsize) debuffs:SetHeight(dbsize)
		debuffs:SetPoint("CENTER", 0, 0)
		debuffs.size = dbsize
		
		debuffs.CustomFilter = CustomFilter
		f.raidDebuffs = debuffs
	end
end

  -----------------------------
  -- HANDOVER
  -----------------------------
  
  --hand the lib to the namespace for further usage...this is awesome because you can reuse functions in any of your layout files
  ns.lib = lib