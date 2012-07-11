 
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
  
  cfg.Pwidth = 210 		-- Player frame���
  cfg.Pheight = 15
  
  cfg.Twidth = 210 		-- Target frameĿ��
  cfg.Theight = 15
  
  cfg.PTTwidth = 80 	-- Pet and ToT frames���� Ŀ���Ŀ��
  cfg.PTTheight = 15
  
  cfg.Fwidth = 210 		-- Focus frame����
  cfg.Fheight = 15
  
  cfg.PBwidth = 160 	-- Party (+partypet) and Boss framesС�� BOSS
  cfg.PBheight = 15
  
  -----------------------------
  -- Frames position
  -----------------------------

  cfg.Ppos = {"TOP","UIParent","BOTTOM", -270, 280} 						-- Player���
  cfg.Tpos = {"TOP","UIParent","BOTTOM", 270, 280} 							-- TargetĿ��
  cfg.PEpos = {"TOP","UIParent","BOTTOM", -425, 280} 		-- Pet����
  cfg.TTpos = {"TOP","UIParent","BOTTOM", 425, 280} 		-- ToTĿ���Ŀ��
  cfg.Fpos = {"TOP","UIParent","BOTTOM", 270, 380}		-- Focus����
  cfg.FTpos = {"LEFT", "oUF_SimpleFocus", "RIGHT", 8, 0}		-- Focus target����Ŀ��
  
  -----------------------------
  cfg.colorsmooth = {1,0,0, .9,.6,0, .9,.7,0} -- varying color base on healthѪ������ɫ 
  cfg.namefontsize = 16
  cfg.fontsize = 16 
  cfg.showpower = false
  cfg.showhealth = false
  cfg.Enable3DPortrait = false
  cfg.RMalpha = 0.8 				-- raid mark alpha�Ŷӱ��͸����
  cfg.RMsize = 15 					-- raid mark size�Ŷӱ�Ǵ�С
  
  cfg.showDebuffType = true
  cfg.auratimers = true 			-- aura timers�⻷��ʱ
  cfg.ATIconSizeThreshold = 15 	-- how big some icon should be to display the custom timer��ʾ�⻷����Сͼ���С
  cfg.ATSize = 13  				-- aura timer font size���ִ�С
  cfg.PlayerTimersOnly = false  	-- show timers only for auras cast by player?ֻΪ�ҵ�ʩ�ӵĹ⻷��ʱ
  
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

  cfg.point = "TOP"                                 -- direction "TOP"/"LEFT"���з���"TOP"���ϵ���"LEFT"������
  cfg.columnAnchorPoint = "LEFT"                    -- group direction "TOP"/"LEFT"С�����з���"TOP"���ϵ���"LEFT"������
  cfg.width = 100 									-- raid unit width��
  cfg.height = 26 									-- raid unit height��
  cfg.spacing = 5 									-- spacing between units��϶
  cfg.colspacing = 5                               -- spacing between partys��϶
  cfg.namelength = 4 								-- number of letters to display���ֳ���
  cfg.gridfontsize = 12								-- font size�ֺ�
  cfg.showRaidDebuffs = true
  cfg.HealMode = true
  cfg.showAuraWatch = true 				-- buffs timer on raid frames(hots, shields etc)
  cfg.RCheckIcon = true 					-- show raid check icon
  ------------------------
  --  ��ְҵָʾ���༭  --
  ------------------------
  
  --����runebar
  cfg.runesp = {"LEFT",UIParent,"BOTTOM",-cfg.Pwidth/2,280}--position of the first rune.cfg.Pwidth is the width of runes bar.
  --���ǵ�һ�����ĵ����꣬cfg.Pwidth��6�����ĵ��ܳ��ȡ�
  --��������ķ���{"LEFT",UIParent,"BOTTOM",-cfg.Pwidth/2 -200,280}--E.G
  --���ϵ����ķ���{"LEFT",UIParent,"BOTTOM",-cfg.Pwidth/2,350}--E.G
  
  -----------------------
  
--��ʳ��ʳeclipse bar
  cfg.ebp = {"CENTER",UIParent,"BOTTOM",0,280}
  cfg.ebw = 195--��
  cfg.ebh = 20 --��

  -----------------------
  
--Ģ��,��Ӱ����,ˮ��+����֮��/��������--mushroom,shadow orbs,water shield +��lightning shield OR maelstrom weapon��
  cfg.specialpowerp = {"CENTER",UIParent,"BOTTOM",0,300}--position
  cfg.specialpowerfont = 25 --��С���ֺţ�--fontsize
  
  --Ģ��--mushroom 
  cfg.wmr = "|cffFF6161MR|r"
  --��Ӱ����--shadow orbs
  cfg.orbs1 = "|cffFF61611|r"
  cfg.orbs2 = "|cffFFF1302|r"
  cfg.orbs3 = "|cff8AFF303|r"
  --ʥ�ܻ��������Ƭ--holy power or soul shards
  cfg.sp1 = "|cff0d87d5A|r"
  cfg.sp2 = "|cfff20269A B|r"
  cfg.sp3 = "|cff85419cA B C|r"
  -----------------------
  
--������--combo points --checked
    cfg.combop = {"CENTER",UIParent,"BOTTOM",10,280}--position
    cfg.combofont = 25 --��С���ֺţ�fontsize
	
	cfg.combo1 = "|cff8AFF30A|r" 
	cfg.combo2 = "|cff8AFF30A B|r"
	cfg.combo3 = "|cff8AFF30A B|r |cffFFF130C|r" 
	cfg.combo4 = "|cff8AFF30A B|r |cffFFF130C D|r" 
	cfg.combo5 = "|cff8AFF30A B|r |cffFFF130C D|r |cffFFF130E|r" 
	
  -----------------------

  -- my config 
  if GetUnitName("player") == "������" then
    cfg.cbenabled = false --enable all the castbars
  end
  -----------------------------
  -- HANDOVER
  -----------------------------
  
  --hand the config to the namespace for usage in other lua files (remember: those lua files must be called after the cfg.lua)
  ns.cfg = cfg
