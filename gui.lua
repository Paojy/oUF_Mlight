﻿local F = {}
if IsAddOnLoaded("Aurora") then 
	F = unpack(Aurora)
else
	F.Reskin = function() end
	F.ReskinCheck = function() end
	F.ReskinSlider = function() end
	F.CreateBD = function() end
	F.ReskinScroll = function() end
end

local addon, ns = ...
local L = ns.L

local function createreloadbuttons(parent)
	local bu = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	bu:SetPoint("TOPRIGHT", -16, -20)
	bu:SetSize(150, 25)
	bu:SetText(APPLY)
	bu:SetScript("OnClick", ReloadUI)
	F.Reskin(bu)
	return bu
end

local function createcheckbutton(parent, index, name, value, tip)
	local bu = CreateFrame("CheckButton", "oUF_Mlight GUI"..name.."Button", parent, "InterfaceOptionsCheckButtonTemplate")
	bu.value = value
	bu:SetPoint("TOPLEFT", 16, 10-index*30)
	bu.text = bu:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	bu.text:SetPoint("LEFT", bu, "RIGHT", 1, 1)
	bu.text:SetText(name)
	F.ReskinCheck(bu)
	bu:SetScript("OnShow", function(self)
		self:SetChecked(oUF_MlightDB[self.value] == true)
	end)
	bu:SetScript("OnEnter", function(self) 
		GameTooltip:SetOwner(bu, "ANCHOR_RIGHT", 10, 10)
		GameTooltip:AddLine(tip)
		GameTooltip:Show() 
	end)
	bu:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	bu:SetScript("OnClick", function()
		if bu:GetChecked() then
			oUF_MlightDB[bu.value] = true
		else
			oUF_MlightDB[bu.value] = false
		end
	end)
	return bu
end

local function createeditbox(parent, index, name, value, tip)
	local box = CreateFrame("EditBox", "oUF_Mlight GUI"..name.."EditBox", parent)
	box.value = value
	box:SetSize(150, 20)
	box:SetPoint("TOPLEFT", 16, 10-index*30)
	box.name = box:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	box.name:SetPoint("LEFT", box, "RIGHT", 10, 1)
	box.name:SetText(name)
	box:SetFont(GameFontHighlight:GetFont(), 12, "OUTLINE")
	box:SetAutoFocus(false)
	box:SetTextInsets(3, 0, 0, 0)
	F.CreateBD(box)
	box:SetScript("OnShow", function(self) self:SetText(oUF_MlightDB[self.value]) end)
	box:SetScript("OnEscapePressed", function(self) self:SetText(oUF_MlightDB[self.value]) self:ClearFocus() end)
	box:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
		oUF_MlightDB[self.value] = self:GetText()
	end)
	if tip then
		box:SetScript("OnEnter", function(self) 
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:AddLine(tip)
			GameTooltip:Show() 
		end)
		box:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	end
	return box
end

local function createslider(parent, index, name, value, divisor, min, max, step, tip)
	local slider = CreateFrame("Slider", "oUF_Mlight"..name.."Slider", parent, "OptionsSliderTemplate")
	slider.value = value
	slider:SetWidth(150)
	slider:SetPoint("TOPLEFT", 16, 10-index*30)
	slider.name = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	slider.name:SetPoint("LEFT", slider, "RIGHT", 35, 1)
	slider.name:SetText(name)
	slider.text = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	slider.text:SetPoint("LEFT", slider, "RIGHT", 10, 1)
	BlizzardOptionsPanel_Slider_Enable(slider)
	slider:SetMinMaxValues(min, max)
	slider:SetValueStep(step)
	F.ReskinSlider(slider)
	slider:SetScript("OnShow", function(self)
		self:SetValue(oUF_MlightDB[self.value]*divisor)
		self.text:SetText(oUF_MlightDB[self.value])
	end)	
	slider:SetScript("OnValueChanged", function(self, getvalue)
		oUF_MlightDB[self.value] = getvalue/divisor
		self.text:SetText(oUF_MlightDB[self.value])
	end)
	if tip then
		slider:SetScript("OnEnter", function(self) 
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:AddLine(tip)
			GameTooltip:Show() 
		end)
		slider:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	end
	return slider
end

local function createanchorbox(parent, index, name, value)
	local ab = CreateFrame("Button", "oUF_Mlight"..name.."AnchorButton", parent, "UIPanelButtonTemplate")
	ab.value = value
	ab:SetPoint("TOPLEFT", 16, 10-index*30)
	ab:SetSize(150, 20)
	ab.name = ab:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	ab.name:SetPoint("LEFT", ab, "RIGHT", 10, 1)
	ab.name:SetText(name)
	F.Reskin(ab)
	ab:SetScript("OnShow", function(self)
		self:SetText(oUF_MlightDB[self.value])
	end)
	ab:SetScript("OnClick", function()
		if ab:GetText() == "LEFT" then
			oUF_MlightDB[ab.value] = "TOP"
		else
			oUF_MlightDB[ab.value] = "LEFT"
		end
		ab:SetText(oUF_MlightDB[ab.value])
	end)
	return ab
end

local function createraidsizebox(parent, index, name, value)
	local rsb = CreateFrame("Button", "oUF_Mlight"..name.."RaidSizeButton", parent, "UIPanelButtonTemplate")
	rsb.value = value
	rsb:SetPoint("TOPLEFT", 16, 10-index*30)
	rsb:SetSize(150, 20)
	rsb.name = rsb:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	rsb.name:SetPoint("LEFT", rsb, "RIGHT", 10, 1)
	rsb.name:SetText(name)
	F.Reskin(rsb)
	rsb:SetScript("OnShow", function(self)
		self:SetText(oUF_MlightDB[self.value] == "1,2,3,4,5" and "25-man" or "40-man")
	end)
	rsb:SetScript("OnClick", function(self)
		if oUF_MlightDB[self.value] == "1,2,3,4,5" then
			oUF_MlightDB[self.value] = "1,2,3,4,5,6,7,8"
			self:SetText("40-man")
		else
			oUF_MlightDB[self.value] = "1,2,3,4,5"
			self:SetText("25-man")
		end
	end)
	return rsb
end

local function creatfontflagbu(parent, index, name, value)
	local ffb = CreateFrame("Button", "oUF_Mlight"..name.."FontFlagButton", parent, "UIPanelButtonTemplate")
	ffb.value = value
	ffb:SetPoint("TOPLEFT", 16, 10-index*30)
	ffb:SetSize(150, 20)
	ffb.name = ffb:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	ffb.name:SetPoint("LEFT", ffb, "RIGHT", 10, 1)
	ffb.name:SetText(name)
	F.Reskin(ffb)
	ffb:SetScript("OnShow", function(self)
		self:SetText(oUF_MlightDB[self.value])
	end)
	ffb:SetScript("OnClick", function(self)
		if oUF_MlightDB[self.value] == "OUTLINE" then
			oUF_MlightDB[self.value] = "MONOCHROME"
		elseif oUF_MlightDB[self.value] == "MONOCHROME" then
			oUF_MlightDB[self.value] = "NONE"
		elseif oUF_MlightDB[self.value] == "NONE" then
			oUF_MlightDB[self.value] = "OUTLINE"
		end
		self:SetText(oUF_MlightDB[self.value])
	end)
	return ffb
end

local function createcolorpickerbu(parent, index, name, value, tip)
	local cpb = CreateFrame("Button", "oUF_Mlight"..name.."ColorPickerButton", parent, "UIPanelButtonTemplate")
	cpb.value = value
	cpb:SetPoint("TOPLEFT", 16, 10-index*30)
	cpb:SetSize(150, 20)
	
	cpb.colortexture = cpb:CreateTexture(nil, "OVERLAY")
	cpb.colortexture:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	cpb.colortexture:SetPoint"CENTER"
	cpb.colortexture:SetSize(120, 12)

	cpb.name = cpb:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	cpb.name:SetPoint("LEFT", cpb, "RIGHT", 10, 1)
	cpb.name:SetText(name)
	
	F.Reskin(cpb)
	
	cpb:SetScript("OnShow", function(self)
		self.colortexture:SetVertexColor(oUF_MlightDB[self.value].r, oUF_MlightDB[self.value].g, oUF_MlightDB[self.value].b)	
	end)
	
	cpb:SetScript("OnClick", function(self)
		local r, g, b, a = oUF_MlightDB[value].r, oUF_MlightDB[value].g, oUF_MlightDB[value].b, oUF_MlightDB[value].a
		ColorPickerFrame:ClearAllPoints()
		ColorPickerFrame:SetPoint("TOPLEFT", self, "TOPRIGHT", 20, 0)
		
		ColorPickerFrame.hasOpacity = oUF_MlightDB.transparentmode -- Opacity slider only available for reverse filling
		ColorPickerFrame.func = function() 
			oUF_MlightDB[value].r, oUF_MlightDB[value].g, oUF_MlightDB[value].b = ColorPickerFrame:GetColorRGB()
			self.colortexture:SetVertexColor(ColorPickerFrame:GetColorRGB())
		end
		ColorPickerFrame.opacityFunc = function()
			oUF_MlightDB[value].a = OpacitySliderFrame:GetValue()
		end
		ColorPickerFrame.previousValues = {r = r, g = g, b = b, opacity = a}
		ColorPickerFrame.opacity = oUF_MlightDB[value].a
		ColorPickerFrame.cancelFunc = function()
			oUF_MlightDB[value].r, oUF_MlightDB[value].g, oUF_MlightDB[value].b, oUF_MlightDB[value].a = r, g, b, a
			self.colortexture:SetVertexColor(oUF_MlightDB[value].r, oUF_MlightDB[value].g, oUF_MlightDB[value].b)
		end
		ColorPickerFrame:SetColorRGB(r, g, b)
		ColorPickerFrame:Hide()
		ColorPickerFrame:Show()
	end)
	if tip then
		cpb:SetScript("OnEnter", function(self) 
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:AddLine(tip)
			GameTooltip:Show() 
		end)
		cpb:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	end
	return cpb
end


-- dependency relationship
local function createDR(parent, ...)
    for i=1, select("#", ...) do
		local object = select(i, ...)
		if object:GetObjectType() == "Slider" then
			parent:HookScript("OnShow", function(self)
				if self:GetChecked() then
					BlizzardOptionsPanel_Slider_Enable(object)
				else
					BlizzardOptionsPanel_Slider_Disable(object)
				end
			end)
			parent:HookScript("OnClick", function(self)
				if self:GetChecked() then
					BlizzardOptionsPanel_Slider_Enable(object)
				else
					BlizzardOptionsPanel_Slider_Disable(object)
				end
			end)	
		else
			parent:HookScript("OnShow", function(self)
				if self:GetChecked() then
					object:Enable()
				else
					object:Disable()
				end
			end)
			parent:HookScript("OnClick", function(self)
				if self:GetChecked() then
					object:Enable()
				else
					object:Disable()
				end
			end)
		end
    end
end
--====================================================--
--[[                   -- GUI --                    ]]--
--====================================================--
local gui = CreateFrame("Frame", "oUF_Mlight GUI", UIParent)
gui.name = ("oUF_Mlight")
InterfaceOptions_AddCategory(gui)

gui.title = gui:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
gui.title:SetPoint("TOPLEFT", 15, -20)
gui.title:SetText("oUF_Mlight v."..GetAddOnMetadata("oUF_Mlight", "Version"))

gui.line = gui:CreateTexture(nil, "ARTWORK")
gui.line:SetSize(600, 1)
gui.line:SetPoint("TOP", 0, -50)
gui.line:SetTexture(1, 1, 1, .2)

gui.intro = gui:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftGrey")
gui.intro:SetText(L["apply"])
gui.intro:SetPoint("TOPLEFT", 20, -60)

reloadbutton1 = createreloadbuttons(gui)

local resetbu = CreateFrame("Button", nil, gui, "UIPanelButtonTemplate")
resetbu:SetPoint("RIGHT", reloadbutton1,"LEFT", -5, 0)
resetbu:SetSize(150, 25)
resetbu:SetText(NEWBIE_TOOLTIP_STOPWATCH_RESETBUTTON)
F.Reskin(resetbu)	
resetbu:SetScript("OnClick", function()
	ns.ResetVariables()
	ns.LoadVariables()
	ReloadUI()
end)

local scrollFrame = CreateFrame("ScrollFrame", "oUF_Mlight GUI Frame_ScrollFrame", gui, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", gui, "TOPLEFT", 10, -80)
scrollFrame:SetPoint("BOTTOMRIGHT", gui, "BOTTOMRIGHT", -35, 0)
scrollFrame:SetFrameLevel(gui:GetFrameLevel()+1)

scrollFrame.Anchor = CreateFrame("Frame", "oUF_Mlight GUI Frame_ScrollAnchor", scrollFrame)
scrollFrame.Anchor:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, -3)
scrollFrame.Anchor:SetWidth(scrollFrame:GetWidth()-30)
scrollFrame.Anchor:SetHeight(scrollFrame:GetHeight()+200)
scrollFrame.Anchor:SetFrameLevel(scrollFrame:GetFrameLevel()+1)
scrollFrame:SetScrollChild(scrollFrame.Anchor)
F.ReskinScroll(_G["oUF_Mlight GUI Frame_ScrollFrameScrollBar"])
	
local fadetext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
fadetext:SetPoint("TOPLEFT", 16, 3-1*30)
fadetext:SetText(L["fade"])

local enablefadebu = createcheckbutton(scrollFrame.Anchor, 2, L["enablefade"], "enablefade", L["enablefade2"])
local fadingalphaslider = createslider(scrollFrame.Anchor, 3, L["fadingalpha"], "fadingalpha", 100, 0, 80, 5, L["fadingalpha2"])
createDR(enablefadebu, fadingalphaslider)

local fonttext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
fonttext:SetPoint("TOPLEFT", 16, 3-4*30)
fonttext:SetText(L["font"])

local fontfilebox = createeditbox(scrollFrame.Anchor, 5, L["fontfile"], "fontfile", L["fontfile2"])
fontfilebox:SetWidth(300)
local fontsizebox = createeditbox(scrollFrame.Anchor, 6, L["fontsize"], "fontsize", L["fontsize2"])
local fontflagbu = creatfontflagbu(scrollFrame.Anchor, 7, L["fontflag"], "fontflag")
local tenthousandbu = createcheckbutton(scrollFrame.Anchor, 8, L["tenthousand"], "tenthousand")
local alwayshpbu = createcheckbutton(scrollFrame.Anchor, 9, L["alwayshp"], "alwayshp", L["alwayshp2"])
local alwaysppbu = createcheckbutton(scrollFrame.Anchor, 10, L["alwayspp"], "alwayspp", L["alwayspp2"])

local colormodtext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
colormodtext:SetPoint("TOPLEFT", 16, 3-11*30)
colormodtext:SetText(L["colormode"])
local classcolormodebu = createcheckbutton(scrollFrame.Anchor, 12, L["classcolormode"], "classcolormode", L["classcolormode2"])
local transparentmodebu = createcheckbutton(scrollFrame.Anchor, 13, L["transparentmode"], "transparentmode", L["transparentmode2"])
local startcolorpicker = createcolorpickerbu(scrollFrame.Anchor, 14, L["startcolor"], "startcolor", L["onlywhentransparent"])
local endcolorpicker = createcolorpickerbu(scrollFrame.Anchor, 15, L["endcolor"], "endcolor", L["onlywhentransparent"])
local nameclasscolormodebu = createcheckbutton(scrollFrame.Anchor, 16, L["nameclasscolormode"], "nameclasscolormode", L["nameclasscolormode2"])

local portraittext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
portraittext:SetPoint("TOPLEFT", 14, 3-17*30)
portraittext:SetText(L["portrait"])

local portraitbu = createcheckbutton(scrollFrame.Anchor, 18, L["enableportrait"], "portrait")
local portraitalphaslider = createslider(scrollFrame.Anchor, 19, L["portraitalpha"], "portraitalpha", 100, 10, 100, 5, L["portraitalpha2"])
createDR(portraitbu, portraitalphaslider)

local sizetext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
sizetext:SetPoint("TOPLEFT", 14, 3-20*30)
sizetext:SetText(L["framesize"])

local heightbox = createeditbox(scrollFrame.Anchor, 21, L["height"], "height", L["height2"])
local widthbox = createeditbox(scrollFrame.Anchor, 22, L["width"], "width", L["width2"])
local widthpetbox = createeditbox(scrollFrame.Anchor, 23, L["widthpet"], "widthpet", L["widthpet2"])
local widthbossbox = createeditbox(scrollFrame.Anchor, 24, L["widthboss"], "widthboss", L["widthboss2"])
local scaleslider = createslider(scrollFrame.Anchor, 25, L["scale"], "scale", 100, 50, 300, 5, L["scale2"])
local hpheightslider = createslider(scrollFrame.Anchor, 26, L["hpheight"], "hpheight", 100, 20, 95, 5, L["hpheight2"])

local castbartext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
castbartext:SetPoint("TOPLEFT", 16, 3-27*30)
castbartext:SetText(L["castbar"])

local castbarsbu = createcheckbutton(scrollFrame.Anchor, 28, L["enablecastbars"], "castbars", L["enablecastbars2"])
local cbIconsizebox = createslider(scrollFrame.Anchor, 29, L["cbIconsize"], "cbIconsize", 1, 10, 50, 1)
local independentcbbu = createcheckbutton(scrollFrame.Anchor, 30, L["Independent Player Castbar"], "independentcb")
local cbheightslider = createslider(scrollFrame.Anchor, 31, L["cbheight"],  "cbheight", 1, 5, 30, 1)
local cbwidthslider = createslider(scrollFrame.Anchor, 32, L["cbwidth"],  "cbwidth", 1, 50, 500, 5)
local cbxslider = createslider(scrollFrame.Anchor, 33, L["xoffset"],  "cbx", 1, -500, 500, 5)
local cbyslider = createslider(scrollFrame.Anchor, 34, L["yoffset"],  "cby", 1, -500, 500, 5)
createDR(independentcbbu, cbheightslider, cbwidthslider, cbxslider, cbyslider)
local channelticksbu = createcheckbutton(scrollFrame.Anchor, 35, L["Show every tick in a channel spell"],  "channelticks")
local tickscolorpicker = createcolorpickerbu(scrollFrame.Anchor, 36, L["tickcolor"], "tickcolor")
createDR(channelticksbu, tickscolorpicker)
createDR(castbarsbu, cbIconsizebox, independentcbbu, cbheightslider, cbwidthslider, cbxslider, cbyslider, channelticksbu, tickscolorpicker)

local auratext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
auratext:SetPoint("TOPLEFT", 16, 3-37*30)
auratext:SetText(L["aura"])

local aurasbu = createcheckbutton(scrollFrame.Anchor, 38, L["enableauras"], "auras", L["enableauras2"])
local aurabordersbu = createcheckbutton(scrollFrame.Anchor, 39, L["auraborders"], "auraborders", L["auraborders2"])
local auraperrowslider = createslider(scrollFrame.Anchor, 40, L["aurasperrow"], "auraperrow", 1, 4, 20, 1, L["aurasperrow2"])
local playerdebuffbu = createcheckbutton(scrollFrame.Anchor, 41, L["enableplayerdebuff"], "playerdebuffenable", L["enableplayerdebuff2"])
local playerdebuffperrowslider = createslider(scrollFrame.Anchor, 42, L["playerdebuffsperrow"], "playerdebuffnum", 1, 4, 20, 1, L["playerdebuffsperrow2"])
local AuraFilterignoreBuffbu = createcheckbutton(scrollFrame.Anchor, 43, L["AuraFilterignoreBuff"], "AuraFilterignoreBuff", L["AuraFilterignoreBuff2"])
local AuraFilterignoreDebuffbu = createcheckbutton(scrollFrame.Anchor, 44, L["AuraFilterignoreDebuff"], "AuraFilterignoreDebuff", L["AuraFilterignoreDebuff2"])
local AuraFiltertext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftYellow")
AuraFiltertext:SetPoint("TOPLEFT", 16, 3-45*30)
AuraFiltertext:SetText(L["aurafilterinfo"])
createDR(aurasbu, auraperrowslider, aurabordersbu, playerdebuffbu, playerdebuffperrowslider, AuraFilterignoreBuffbu, AuraFilterignoreDebuffbu)
createDR(playerdebuffbu, playerdebuffperrowslider)

local threatbartext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
threatbartext:SetPoint("TOPLEFT", 16, 3-46*30)
threatbartext:SetText(L["threatbar"])

local showthreatbarbu = createcheckbutton(scrollFrame.Anchor, 47, L["showthreatbar"], "showthreatbar", L["showthreatbar2"])
local tbvergradientbu = createcheckbutton(scrollFrame.Anchor, 48, L["tbvergradient"], "tbvergradient", L["tbvergradient2"])
createDR(showthreatbarbu, tbvergradientbu)

local pvpiconbu = createcheckbutton(scrollFrame.Anchor, 49, L["pvpicon"], "pvpicon", L["pvpicon2"])

local bosstext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
bosstext:SetPoint("TOPLEFT", 16, 3-50*30)
bosstext:SetText(L["bossframe"])

local bossframesbu = createcheckbutton(scrollFrame.Anchor, 51, L["bossframes"], "bossframes", L["bossframes2"])

local arenatext = scrollFrame.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
arenatext:SetPoint("TOPLEFT", 16, 3-52*30)
arenatext:SetText(L["arenaframe"])

local arenaframesbu = createcheckbutton(scrollFrame.Anchor, 53, L["arenaframes"], "arenaframes", L["arenaframes2"])
--====================================================--
--[[                 -- Raid --                     ]]--
--====================================================--
local raidgui = CreateFrame("Frame", "oUF_Mlight Raid", UIParent)
raidgui.name = ("oUF_Mlight Raid")
raidgui.parent = ("oUF_Mlight")
InterfaceOptions_AddCategory(raidgui)

raidgui.title = raidgui:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
raidgui.title:SetPoint("TOPLEFT", 15, -20)
raidgui.title:SetText("oUF_Mlight Raid Frames")

raidgui.line = raidgui:CreateTexture(nil, "ARTWORK")
raidgui.line:SetSize(600, 1)
raidgui.line:SetPoint("TOP", 0, -50)
raidgui.line:SetTexture(1, 1, 1, .2)

raidgui.intro = raidgui:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftGrey")
raidgui.intro:SetText(L["apply"])
raidgui.intro:SetPoint("TOPLEFT", 20, -60)

reloadbutton2 = createreloadbuttons(raidgui)

local scrollFrame2 = CreateFrame("ScrollFrame", "oUF_Mlight Raid GUI Frame_ScrollFrame", raidgui, "UIPanelScrollFrameTemplate")
scrollFrame2:SetPoint("TOPLEFT", raidgui, "TOPLEFT", 10, -80)
scrollFrame2:SetPoint("BOTTOMRIGHT", raidgui, "BOTTOMRIGHT", -35, 0)
scrollFrame2:SetFrameLevel(raidgui:GetFrameLevel()+1)
	
scrollFrame2.Anchor = CreateFrame("Frame", "oUF_Mlight Raid GUI Frame_ScrollAnchor", scrollFrame2)
scrollFrame2.Anchor:SetPoint("TOPLEFT", scrollFrame2, "TOPLEFT", 0, -3)
scrollFrame2.Anchor:SetWidth(scrollFrame2:GetWidth()-30)
scrollFrame2.Anchor:SetHeight(scrollFrame2:GetHeight()+200)
scrollFrame2.Anchor:SetFrameLevel(scrollFrame2:GetFrameLevel()+1)
scrollFrame2:SetScrollChild(scrollFrame2.Anchor)
F.ReskinScroll(_G["oUF_Mlight Raid GUI Frame_ScrollFrameScrollBar"])

local sharetext = scrollFrame2.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
sharetext:SetPoint("TOPLEFT", 16, 3-1*30)
sharetext:SetText(L["raidshare"])

local enableraidbu = createcheckbutton(scrollFrame2.Anchor, 2, L["enableraid"], "enableraid", L["enableraid2"])
local showraidpetbu = createcheckbutton(scrollFrame2.Anchor, 3, L["showraidpet"], "showraidpet", L["showraidpet2"])
local raidfontsizebox = createeditbox(scrollFrame2.Anchor, 4, L["raidfontsize"], "raidfontsize", L["raidfontsize2"])
local namelengthslider = createslider(scrollFrame2.Anchor, 5, L["namelength"], "namelength", 1, 2, 10, 1, L["namelength2"])
local showsolobu = createcheckbutton(scrollFrame2.Anchor, 6, L["showsolo"], "showsolo", L["showsolo2"])
local autoswitchbu = createcheckbutton(scrollFrame2.Anchor, 7, L["autoswitch"], "autoswitch", L["autoswitch2"])
local raidonlyhealerbu = createcheckbutton(scrollFrame2.Anchor, 8, L["raidonlyhealer"], "raidonlyhealer", L["raidonlyhealer2"])
local raidonlydpsbu = createcheckbutton(scrollFrame2.Anchor, 9, L["raidonlydps"], "raidonlydps", L["raidonlydps2"])
createDR(autoswitchbu, raidonlyhealerbu, raidonlydpsbu)
local raidtoggletext = scrollFrame2.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftYellow")
raidtoggletext:SetPoint("TOPLEFT", 16, 3-10*30)
raidtoggletext:SetText(L["toggleinfo"])

local enablearrowbu = createcheckbutton(scrollFrame2.Anchor, 12, L["enablearrow"], "enablearrow", L["enablearrow2"])
local arrowsacleslider = createslider(scrollFrame2.Anchor, 13, L["arrowsacle"], "arrowsacle", 100, 50, 200, 5, L["arrowsacle2"])
createDR(enablearrowbu, arrowsacleslider)

local healerraidtext = scrollFrame2.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
healerraidtext:SetPoint("TOPLEFT", 16, 3-14*30)
healerraidtext:SetText(L["healerraidtext"])

local healergroupfilterbox = createraidsizebox(scrollFrame2.Anchor, 15, L["groupsize"], "healergroupfilter")
local healerraidheightbox = createeditbox(scrollFrame2.Anchor, 16, L["healerraidheight"], "healerraidheight", L["healerraidheight2"])
local healerraidwidthbox = createeditbox(scrollFrame2.Anchor, 17, L["healerraidwidth"], "healerraidwidth", L["healerraidwidth2"])
local raidmanabarsbox = createcheckbutton(scrollFrame2.Anchor, 18, L["raidmanabars"], "raidmanabars", L["raidmanabars2"])
local raidhpheightslider = createslider(scrollFrame2.Anchor, 19, L["hpheight"], "raidhpheight", 100, 20, 95, 5, L["hpheight2"])
createDR(raidmanabarsbox, raidhpheightslider)
local healerraidanchorddm = createanchorbox(scrollFrame2.Anchor, 20, L["anchor"], "anchor")
local healerraidpartyanchorddm = createanchorbox(scrollFrame2.Anchor, 21, L["partyanchor"], "partyanchor")
local showgcdbu = createcheckbutton(scrollFrame2.Anchor, 22, L["showgcd"], "showgcd", L["showgcd2"])
local showmisshpbu = createcheckbutton(scrollFrame2.Anchor, 23, L["showmisshp"], "showmisshp", L["showmisshp2"])
local healpredictionbu = createcheckbutton(scrollFrame2.Anchor, 24, L["healprediction"], "healprediction", L["healprediction2"])

local dpstankraidtext = scrollFrame2.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
dpstankraidtext:SetPoint("TOPLEFT", 18, 3-25*30)
dpstankraidtext:SetText(L["dpstankraidtext"])

local dpsgroupfilterbox = createraidsizebox(scrollFrame2.Anchor, 26, L["groupsize"], "dpsgroupfilter")
local dpsraidheightbox = createeditbox(scrollFrame2.Anchor, 27, L["dpsraidheight"], "dpsraidheight", L["dpsraidheight2"])
local dpsraidwidthbox = createeditbox(scrollFrame2.Anchor, 28, L["dpsraidwidth"], "dpsraidwidth", L["dpsraidwidth2"])
local dpsraidgroupbyclassbu = createcheckbutton(scrollFrame2.Anchor, 29, L["dpsraidgroupbyclass"], "dpsraidgroupbyclass", L["dpsraidgroupbyclass2"])
local unitnumperlinebox = createeditbox(scrollFrame2.Anchor, 30, L["unitnumperline"], "unitnumperline", L["unitnumperline2"])

--====================================================--
--[[           -- Aura White List --                ]]--
--====================================================--
local whitelist = CreateFrame("Frame", "oUF_Mlight WhiteList", UIParent)
whitelist.name = ("Aura Fliter WhiteList")
whitelist.parent = ("oUF_Mlight")
InterfaceOptions_AddCategory(whitelist)

whitelist.title = whitelist:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
whitelist.title:SetPoint("TOPLEFT", 15, -20)
whitelist.title:SetText("oUF_Mlight Aura Fliter WhiteList")

whitelist.line = whitelist:CreateTexture(nil, "ARTWORK")
whitelist.line:SetSize(600, 1)
whitelist.line:SetPoint("TOP", 0, -50)
whitelist.line:SetTexture(1, 1, 1, .2)

whitelist.intro = whitelist:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftGrey")
whitelist.intro:SetText(L["don't have to rl"])
whitelist.intro:SetPoint("TOPLEFT", 20, -60)

local scrollFrame3 = CreateFrame("ScrollFrame", "oUF_Mlight WhiteList Frame_ScrollFrame", whitelist, "UIPanelScrollFrameTemplate")
scrollFrame3:SetPoint("TOPLEFT", whitelist, "TOPLEFT", 10, -130)
scrollFrame3:SetPoint("BOTTOMRIGHT", whitelist, "BOTTOMRIGHT", -35, 0)
scrollFrame3:SetFrameLevel(whitelist:GetFrameLevel()+1)
	
scrollFrame3.Anchor = CreateFrame("Frame", "oUF_Mlight WhiteList Frame_ScrollAnchor", scrollFrame3)
scrollFrame3.Anchor:SetPoint("TOPLEFT", scrollFrame3, "TOPLEFT", 0, -3)
scrollFrame3.Anchor:SetWidth(scrollFrame3:GetWidth()-30)
scrollFrame3.Anchor:SetHeight(scrollFrame3:GetHeight()+200)
scrollFrame3.Anchor:SetFrameLevel(scrollFrame3:GetFrameLevel()+1)
scrollFrame3:SetScrollChild(scrollFrame3.Anchor)
F.ReskinScroll(_G["oUF_Mlight WhiteList Frame_ScrollFrameScrollBar"])

local function updateanchors()
	sort(oUF_MlightDB.AuraFilterwhitelist)
	local index = 1
	for spellID, name in pairs(oUF_MlightDB.AuraFilterwhitelist) do
		if not spellID then return end
		_G["oUF_Mlight WhiteList Button"..spellID]:SetPoint("TOPLEFT", scrollFrame3.Anchor, "TOPLEFT", 10, 20-index*30)
		index = index + 1
	end
end

local function CreateWhiteListButton(name, icon, spellID)
	local wb = CreateFrame("Frame", "oUF_Mlight WhiteList Button"..spellID, scrollFrame3.Anchor)
	wb:SetSize(350, 20)

	wb.icon = CreateFrame("Button", nil, wb)
	wb.icon:SetSize(18, 18)
	wb.icon:SetNormalTexture(icon)
	wb.icon:GetNormalTexture():SetTexCoord(0.1,0.9,0.1,0.9)
	wb.icon:SetPoint"LEFT"
	
	wb.iconbg = wb:CreateTexture(nil, "BACKGROUND")
	wb.iconbg:SetPoint("TOPLEFT", -1, 1)
	wb.iconbg:SetPoint("BOTTOMRIGHT", 1, -1)
	wb.iconbg:SetTexture("Interface\\Buttons\\WHITE8x8")
	wb.iconbg:SetVertexColor(0, 0, 0, 0.5)
	
	wb.spellid = wb:CreateFontString(nil, "OVERLAY")
	wb.spellid:SetFont(GameFontHighlight:GetFont(), 12, "OUTLINE")
	wb.spellid:SetPoint("LEFT", 40, 0)
	wb.spellid:SetTextColor(1, .2, .6)
    wb.spellid:SetJustifyH("LEFT")
	wb.spellid:SetText(spellID)
	
	wb.spellname = wb:CreateFontString(nil, "OVERLAY")
	wb.spellname:SetFont(GameFontHighlight:GetFont(), 12, "OUTLINE")
	wb.spellname:SetPoint("LEFT", 140, 0)
	wb.spellname:SetTextColor(1, 1, 0)
    wb.spellname:SetJustifyH("LEFT")
	wb.spellname:SetText(name)
	
	wb.close = CreateFrame("Button", nil, wb, "UIPanelButtonTemplate")
	wb.close:SetSize(18,18)
	wb.close:SetPoint("RIGHT")
	F.Reskin(wb.close)
	wb.close:SetText("x")
	wb.close:SetScript("OnClick", function() 
	wb:Hide()
	oUF_MlightDB.AuraFilterwhitelist[spellID] = nil
	print("|cffFF0000"..name.." |r"..L["remove frome white list"])
	updateanchors()
	end)
	
	return wb
end

local function CreateWhiteListButtonList()
	for spellID, name in pairs(oUF_MlightDB.AuraFilterwhitelist) do
		if spellID then
			local icon = select(3, GetSpellInfo(spellID))
			CreateWhiteListButton(name, icon, spellID)
		end
	end
	updateanchors()
end

local wlbox = CreateFrame("EditBox", "oUF_Mlight WhiteList Input", whitelist)
wlbox:SetSize(250, 20)
wlbox:SetPoint("TOPLEFT", 16, -80)
wlbox:SetFont(GameFontHighlight:GetFont(), 12, "OUTLINE")
wlbox:SetAutoFocus(false)
wlbox:SetTextInsets(3, 0, 0, 0)
F.CreateBD(wlbox)
wlbox:SetScript("OnShow", function(self) self:SetText(L["input spellID"]) end)
wlbox:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
wlbox:SetScript("OnEscapePressed", function(self)
	self:ClearFocus()
	wlbox:SetText(L["input spellID"])
end)
wlbox:SetScript("OnEnterPressed", function(self)
	local spellID = self:GetText()
	self:ClearFocus()
	local name, _, icon = GetSpellInfo(spellID)
	if name then
		CreateWhiteListButton(name, icon, spellID)
		oUF_MlightDB.AuraFilterwhitelist[spellID] = name
		print("|cff7FFF00"..name.." |r"..L["add to white list"])
		updateanchors()
	else
		print("|cff7FFF00"..spellID.." |r"..L["not a corret Spell ID"])
	end
end)

--====================================================--
--[[         -- Click Cast Settings --              ]]--
--====================================================--

local clickcastgui = CreateFrame("Frame", "oUF_Mlight ClickCast GUI", UIParent)
clickcastgui.name = ("Click Cast")
clickcastgui.parent = ("oUF_Mlight")
InterfaceOptions_AddCategory(clickcastgui)

clickcastgui.title = clickcastgui:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
clickcastgui.title:SetPoint("TOPLEFT", 15, -20)
clickcastgui.title:SetText("oUF_Mlight Click Cast Settings")

clickcastgui.line = clickcastgui:CreateTexture(nil, "ARTWORK")
clickcastgui.line:SetSize(600, 1)
clickcastgui.line:SetPoint("TOP", 0, -50)
clickcastgui.line:SetTexture(1, 1, 1, .2)

clickcastgui.intro = clickcastgui:CreateFontString(nil, "ARTWORK", "GameFontNormalLeft")
clickcastgui.intro:SetText(L["clickcastinro"])
clickcastgui.intro:SetPoint("TOPLEFT", 20, -85)

reloadbutton3 = createreloadbuttons(clickcastgui)

local enableClickCastbu = createcheckbutton(clickcastgui, 2, L["enableClickCast"], "enableClickCast")

local scrollFrame4 = CreateFrame("ScrollFrame", "oUF_Mlight ClickCast Frame_ScrollFrame", clickcastgui, "UIPanelScrollFrameTemplate")
scrollFrame4:SetPoint("TOPLEFT", clickcastgui, "TOPLEFT", 10, -180)
scrollFrame4:SetPoint("BOTTOMRIGHT", clickcastgui, "BOTTOMRIGHT", -35, 0)
scrollFrame4:SetFrameLevel(clickcastgui:GetFrameLevel()+1)

scrollFrame4.Anchor = CreateFrame("Frame", "oUF_Mlight ClickCast Frame_ScrollAnchor", scrollFrame4)
scrollFrame4.Anchor:SetPoint("TOPLEFT", scrollFrame4, "TOPLEFT", 0, -3)
scrollFrame4.Anchor:SetWidth(scrollFrame4:GetWidth()-30)
scrollFrame4.Anchor:SetHeight(scrollFrame4:GetHeight()+200)
scrollFrame4.Anchor:SetFrameLevel(scrollFrame4:GetFrameLevel()+1)
scrollFrame4:SetScrollChild(scrollFrame4.Anchor)
F.ReskinScroll(_G["oUF_Mlight ClickCast Frame_ScrollFrameScrollBar"])

local mouse_buttons = {
	["1"] = {"Click", "shift-", "ctrl-", "alt-"},
	["2"] = {"Click", "shift-", "ctrl-", "alt-"},
	["3"] = {"Click", "shift-", "ctrl-", "alt-"},
	["4"] = {"Click", "shift-", "ctrl-", "alt-"},
	["5"] = {"Click", "shift-", "ctrl-", "alt-"},
}

StaticPopupDialogs["oUF_Mlight incorrect spell"] = {
	text = L["incorrect spell name"],
	button1 = ACCEPT, 
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
}

StaticPopupDialogs["oUF_Mlight give macro"] = {
	text = L["enter a macro"],
	button1 = ACCEPT, 
	button2 = CANCEL,
	hasEditBox = 1,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
}

local selectid, selectv1
StaticPopupDialogs["oUF_Mlight give macro"].OnAccept = function(self)
	local m = _G[self:GetName().."EditBox"]:GetText()
	oUF_MlightDB.ClickCast[selectid][selectv1]["macro"] = m
end

StaticPopupDialogs["oUF_Mlight give macro"].OnShow = function(self)
	_G[self:GetName().."EditBox"]:SetAutoFocus(true)
	if not oUF_MlightDB.ClickCast[selectid][selectv1]["macro"] or oUF_MlightDB.ClickCast[selectid][selectv1]["macro"] == "" then
		_G[self:GetName().."EditBox"]:SetText(L["enter a macro"])
		_G[self:GetName().."EditBox"]:HighlightText()
	else
		_G[self:GetName().."EditBox"]:SetText(oUF_MlightDB.ClickCast[selectid][selectv1]["macro"])
	end
end

for id, v in pairs(mouse_buttons) do
	local mousebutton = scrollFrame4.Anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	mousebutton:SetPoint("TOPLEFT", 16, -5-((id-1)*5)*30)
	mousebutton:SetText(L[id])
	for k1, v1 in pairs(mouse_buttons[id]) do
		local inputbox = CreateFrame("EditBox", "oUF_Mlight ClickCast"..v1.."EditBox", scrollFrame4.Anchor)
		inputbox:SetSize(150, 20)
		inputbox:SetPoint("TOPLEFT", 16, -5-((id-1)*5)*30-k1*30)
		
		inputbox.name = inputbox:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftYellow")
		inputbox.name:SetPoint("LEFT", inputbox, "RIGHT", 10, 1)
		inputbox.name:SetText(L[v1])
		
		inputbox:SetFont(GameFontHighlight:GetFont(), 12, "OUTLINE")
		inputbox:SetAutoFocus(false)
		inputbox:SetTextInsets(3, 0, 0, 0)
		
		F.CreateBD(inputbox)
		
		inputbox:SetScript("OnShow", function(self) self:SetText(oUF_MlightDB.ClickCast[id][v1]["action"]) end)
		inputbox:SetScript("OnEscapePressed", function(self) self:SetText(oUF_MlightDB.ClickCast[id][v1]["action"]) self:ClearFocus() end)
		inputbox:SetScript("OnEnterPressed", function(self)
			local var = self:GetText()
				if (var == "target" or var == "tot" or var == "follow" or var == "macro") then
					oUF_MlightDB.ClickCast[id][v1]["action"] = var
					if var == "macro" then
						selectid, selectv1 = id, v1
						StaticPopup_Show("oUF_Mlight give macro")
					end
				elseif GetSpellInfo(var) or var == "NONE" then -- 法术已学会
					oUF_MlightDB.ClickCast[id][v1]["action"] = var
				else
					StaticPopupDialogs["oUF_Mlight incorrect spell"].text = "法术名称不正确: "..var
					StaticPopup_Show("oUF_Mlight incorrect spell")
					self:SetText(oUF_MlightDB.ClickCast[id][v1]["action"])
				end
			self:ClearFocus()
		end)
		
		createDR(enableClickCastbu, inputbox)
	end
end

--====================================================--
--[[                -- Init --                      ]]--
--====================================================--
local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("ADDON_LOADED")
eventframe:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function eventframe:ADDON_LOADED(arg1)
	if arg1 ~= "oUF_Mlight" then return end
	if oUF_MlightDB == nil then
		ns.ResetVariables()
	end
	ns.LoadVariables()
	
	sort(oUF_MlightDB.AuraFilterwhitelist)
	CreateWhiteListButtonList()
end

--[[ CPU and Memroy testing
local interval = 0
cfg:SetScript("OnUpdate", function(self, elapsed)
 	interval = interval - elapsed
	if interval <= 0 then
		UpdateAddOnMemoryUsage()
			print("----------------------")
			print("|cffBF3EFFoUF_Mlight|r CPU  "..GetAddOnCPUUsage("oUF_Mlight").." Memory "..format("%.1f kb", floor(GetAddOnMemoryUsage("oUF_Mlight"))))
			print("|cffFFFF00oUF|r CPU  "..GetAddOnCPUUsage("oUF").."  Memory  "..format("%.1f kb", floor(GetAddOnMemoryUsage("oUF"))))
			print("----------------------")
		interval = 4
	end
end)
]]--