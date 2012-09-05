local _, ns = ...
local oUF = ns.oUF or oUF

local verticalgradient = {
	{ .31, .94, .99, .29, .09, .33},
	{ 1, 0, 0, .48, .28, .02},
	{ 1, .41, .05, .48, .39, .04},
	{ .92, .68, 0.31, .27, .17, .12},
}

local horizontalgradient = {
	{ .29, .09, .33, .31, .94, .99},
	{ .48, .28, .02, 1, 0, 0},
	{ .48, .39, .04, 1, .41, .05},
	{ .27, .17, .12, .92, .68, .31,},
}

local Update = function(self, event, unit)
	if unit ~= self.unit or not InCombatLockdown() then return end
	
	local threatbar = self.ThreatBar
	local ind = self.ThreatBar.indictator
	local orientation = self.ThreatBar.vertical and "VERTICAL" or "HORIZONTAL"
	local colors = self.ThreatBar.vertical and verticalgradient or horizontalgradient
	
	unit = unit or self.unit

	local isTanking, status, overtauntedprec, rawthreatprec = UnitDetailedThreatSituation("player", unit)
	
	if not overtauntedprec then
		UIFrameFadeOut(threatbar, 2, threatbar:GetAlpha(), 0)
		ind:ClearAllPoints()
		return
	else --if IsInRaid() or IsInGroup() then
		UIFrameFadeIn(threatbar, 1, threatbar:GetAlpha(), 1)
	end

	local Tankthreat
	if status <= 1 then -- unit is not tanking
		Tankthreat = overtauntedprec/rawthreatprec*100
		if rawthreatprec < 70 then -- safely threat
			threatbar:GetStatusBarTexture():SetGradient(orientation, unpack(colors[1]))
		elseif status == 1 then -- ot
			threatbar:GetStatusBarTexture():SetGradient(orientation, unpack(colors[2]))
		else -- about to ot
			threatbar:GetStatusBarTexture():SetGradient(orientation, unpack(colors[3]))
		end
	else -- unit is not tanking
		Tankthreat = overtauntedprec
		if status == 2 then -- about to lose threat
			threatbar:GetStatusBarTexture():SetGradient(orientation, unpack(colors[3]))
		else -- safely tanking
			threatbar:GetStatusBarTexture():SetGradient(orientation, unpack(colors[4]))
		end
	end

	threatbar:SetValue(overtauntedprec)
	ind:SetPoint("CENTER", threatbar, "LEFT", Tankthreat/100*(threatbar:GetWidth()), 0)
end

local Enable = function(self)
	local threatbar = self.ThreatBar
	if threatbar then
		threatbar:SetMinMaxValues(0, 100)
		threatbar:SetAlpha(0)
		threatbar.indictator = threatbar:CreateTexture(nil, "OVERLAY")
		threatbar.indictator:SetSize(15, threatbar:GetHeight()+10)
		threatbar.indictator:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
		threatbar.indictator:SetVertexColor(1, 1, 0)
		threatbar.indictator:SetBlendMode("ADD")

		threatbar:RegisterEvent("PLAYER_REGEN_ENABLED")
		threatbar:SetScript("OnEvent", function() UIFrameFadeOut(threatbar, 2, threatbar:GetAlpha(), 0) end)

		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", Update)

		return true
	end
end

local Disable = function(self)
	local threatbar = self.ThreatBar
	if threatbar then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
		threatbar:Hide()
	end
end

oUF:AddElement("ThreatBar", Update, Enable, Disable)