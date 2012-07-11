 
  --get the addon namespace
  local addon, ns = ...
  
  --generate a holder for the config data
  local cfg = CreateFrame("Frame")
  
  -----------------------------
  -- CONFIG
  -----------------------------
  
  --config variables
  cfg.showplayer = true
  cfg.showtarget = true
  cfg.showtot = true
  cfg.showpet = true
  cfg.showfocus = true
  cfg.showboss = true
  cfg.showparty = true
  cfg.showraid = true
  
  cfg.statusbar_texture = "Interface\\Buttons\\WHITE8x8"
  cfg.backdrop_texture = "Interface\\AddOns\\oUF_Mlight\\media\\backdrop"
  cfg.backdrop_edge_texture = "Interface\\AddOns\\oUF_Mlight\\media\\backdrop_edge"
  cfg.font = "Fonts\\ZYKai_T.TTF"
  cfg.auratex = "Interface\\AddOns\\oUF_Mlight\\media\\iconborder"
  -----------------------------
  -- Frame Size
  -----------------------------
  
  cfg.Pwidth = 210 		-- Player frame玩家
  cfg.Pheight = 15
  
  cfg.Twidth = 210 		-- Target frame目标
  cfg.Theight = 15
  
  cfg.PTTwidth = 80 	-- Pet and ToT frames宠物 目标的目标
  cfg.PTTheight = 15
  
  cfg.Fwidth = 210 		-- Focus frame焦点
  cfg.Fheight = 15
  
  cfg.PBwidth = 160 	-- Party (+partypet) and Boss frames小队 BOSS
  cfg.PBheight = 15
  
  -----------------------------
  -- Frames position
  -----------------------------

  cfg.Ppos = {"TOP","UIParent","BOTTOM", -270, 280} 						-- Player玩家
  cfg.Tpos = {"TOP","UIParent","BOTTOM", 270, 280} 							-- Target目标
  cfg.PEpos = {"TOP","UIParent","BOTTOM", -425, 280} 		-- Pet宠物
  cfg.TTpos = {"TOP","UIParent","BOTTOM", 425, 280} 		-- ToT目标的目标
  cfg.Fpos = {"TOP","UIParent","BOTTOM", 270, 380}		-- Focus焦点
  cfg.FTpos = {"LEFT", "oUF_SimpleFocus", "RIGHT", 8, 0}		-- Focus target焦点目标
  
  -----------------------------
  cfg.colorsmooth = {1,0,0, .9,.6,0, .9,.7,0} -- varying color base on health血量渐变色 
  cfg.namefontsize = 16
  cfg.fontsize = 16 
  cfg.showpower = false
  cfg.showhealth = false
  cfg.Enable3DPortrait = false
  cfg.RMalpha = 0.8 				-- raid mark alpha团队标记透明度
  cfg.RMsize = 15 					-- raid mark size团队标记大小
  
  cfg.showDebuffType = true
  cfg.auratimers = true 			-- aura timers光环计时
  cfg.ATIconSizeThreshold = 15 	-- how big some icon should be to display the custom timer显示光环的最小图标大小
  cfg.ATSize = 13  				-- aura timer font size数字大小
  cfg.PlayerTimersOnly = false  	-- show timers only for auras cast by player?只为我的施加的光环计时
  
  cfg.cbenabled = true --enable all the castbars	
  cfg.movablecb = true
  cfg.cbcolor = {1,1,1}		-- castbar color
  cfg.playercbheight = 5
  cfg.playercbwidth = 250
  cfg.playercbposition = {"CENTER",UIParent,"CENTER",0,-120}
  cfg.targetcbheight = 5
  cfg.targetcbwidth = 220
  cfg.targetcbposition = {"CENTER",UIParent,"CENTER",0,-95}
  cfg.focuscbheight = 5
  cfg.focuscbwidth = 250
  cfg.focuscbposition = {"CENTER",UIParent,"CENTER",0,120}
  
  --Raid

  cfg.point = "TOP"                                 -- direction "TOP"/"LEFT"排列方向"TOP"从上到下"LEFT"从左到右
  cfg.columnAnchorPoint = "LEFT"                    -- group direction "TOP"/"LEFT"小队排列方向"TOP"从上到下"LEFT"从左到右
  cfg.width = 100 									-- raid unit width宽
  cfg.height = 26 									-- raid unit height高
  cfg.spacing = 5 									-- spacing between units间隙
  cfg.colspacing = 5                               -- spacing between partys间隙
  cfg.namelength = 4 								-- number of letters to display名字长度
  cfg.gridfontsize = 12								-- font size字号
  cfg.showRaidDebuffs = true
  cfg.HealMode = true
  cfg.showAuraWatch = true 				-- buffs timer on raid frames(hots, shields etc)
  cfg.RCheckIcon = true 					-- show raid check icon
  ------------------------
  --  各职业指示器编辑  --
  ------------------------
  
  --符文runebar
  cfg.runesp = {"LEFT",UIParent,"BOTTOM",-cfg.Pwidth/2,280}--position of the first rune.cfg.Pwidth is the width of runes bar.
  --这是第一个符文的坐标，cfg.Pwidth是6个符文的总长度。
  --往左调整的范例{"LEFT",UIParent,"BOTTOM",-cfg.Pwidth/2 -200,280}--E.G
  --往上调整的范例{"LEFT",UIParent,"BOTTOM",-cfg.Pwidth/2,350}--E.G
  
  -----------------------
  
--日食月食eclipse bar
  cfg.ebp = {"CENTER",UIParent,"BOTTOM",0,280}
  cfg.ebw = 195--宽
  cfg.ebh = 20 --高

  -----------------------
  
--蘑菇,暗影宝珠,水盾+闪电之盾/漩涡武器--mushroom,shadow orbs,water shield +（lightning shield OR maelstrom weapon）
  cfg.specialpowerp = {"CENTER",UIParent,"BOTTOM",0,300}--position
  cfg.specialpowerfont = 25 --大小（字号）--fontsize
  
  --蘑菇--mushroom 
  cfg.wmr = "|cffFF6161MR|r"
  --暗影宝珠--shadow orbs
  cfg.orbs1 = "|cffFF61611|r"
  cfg.orbs2 = "|cffFFF1302|r"
  cfg.orbs3 = "|cff8AFF303|r"
  --圣能或者灵魂碎片--holy power or soul shards
  cfg.sp1 = "|cff0d87d5A|r"
  cfg.sp2 = "|cfff20269A B|r"
  cfg.sp3 = "|cff85419cA B C|r"
  -----------------------
  
--连击点--combo points --checked
    cfg.combop = {"CENTER",UIParent,"BOTTOM",10,280}--position
    cfg.combofont = 25 --大小（字号）fontsize
	
	cfg.combo1 = "|cff8AFF30A|r" 
	cfg.combo2 = "|cff8AFF30A B|r"
	cfg.combo3 = "|cff8AFF30A B|r |cffFFF130C|r" 
	cfg.combo4 = "|cff8AFF30A B|r |cffFFF130C D|r" 
	cfg.combo5 = "|cff8AFF30A B|r |cffFFF130C D|r |cffFFF130E|r" 
	
  -----------------------

  -- my config 
  if GetUnitName("player") == "伤心蓝" then
    cfg.cbenabled = false --enable all the castbars
  end
  -----------------------------
  -- HANDOVER
  -----------------------------
  
  --hand the config to the namespace for usage in other lua files (remember: those lua files must be called after the cfg.lua)
  ns.cfg = cfg
