﻿local addon, ns = ...
ns.Client = GetLocale()
ns.L = {}
 -- \n is for add a newline, plese save it when translating. :)
 
ns.L["apply"] = "Use /OMF to move. Reload UI to apply settings."
ns.L["don't have to rl"] = "These settings become effective immediately"
ns.L["fade"] = "Fading"
ns.L["enablefade"] = "Enable Fading"
ns.L["enablefade2"] = "Enable Unit Frames Fading when you are not casting, not in combat, \ndon't have a target and got max health or max/min power, etc."
ns.L["fadingalpha"] = "Fading Alpha"
ns.L["fadingalpha2"] = "Fade-out minimum alpha"
ns.L["font"] = "Font"
ns.L["fontfile"] = "Fontfile"
ns.L["fontfile2"] = "Please close the game program before you add/replace xxx.TTF file."
ns.L["fontsize"] = "Font Szie"
ns.L["fontsize2"] = "Font Size for hp text, power text, name adn castbar, etc"
ns.L["fontflag"] = "Font Flag"
ns.L["colormode"] = "Color Mode"
ns.L["classcolormode"] = "Class Color Mode"
ns.L["classcolormode2"] = "enable: health colored based on class, power colored based on powertype \ndisable : health colored based on health percentage, power colored based on class"
ns.L["transparentmode"] = "Reverse Fill Mode"
ns.L["transparentmode2"] = "Reverse Fill heath bar"
ns.L["onlywhentransparent"] = "Opacity slider only available for reverse filling"
ns.L["startcolor"] = "Gradient Start Color"
ns.L["endcolor"] = "Gradient End Color"
ns.L["nameclasscolormode"] = "Class Colored Name"
ns.L["nameclasscolormode2"] = "enable: classcolored \ndisable: white"
ns.L["portrait"] = "Portrait"
ns.L["enableportrait"] = "Show Portrait"
ns.L["portraitalpha"] = "Portrait Alpha"
ns.L["portraitalpha2"] = "If you disable Reverse Fill Mode, \nplease decrease Portrait Alpha to make the health bar more clear."
ns.L["framesize"] = "Frame Size"
ns.L["height"] = "Frame Height"
ns.L["height2"] = "Frame Height"
ns.L["width"] = "Frame Width"
ns.L["width2"] = "The width for player, target and focus frame"
ns.L["widthpet"] = "Pet Frame Width"
ns.L["widthpet2"] = "The width for pet frame"
ns.L["widthboss"] = "Boss Frame Width"
ns.L["widthboss2"] = "The width for boss frames"
ns.L["scale"] = "Frame Scale"
ns.L["scale2"] = "Frame Scale"
ns.L["hpheight"] = "Heathbar Height Ratio"
ns.L["hpheight2"] = "The ratio of heathbar height to frame height"
ns.L["castbar"] = "Castbar"
ns.L["enablecastbars"] = "Enable Castbars"
ns.L["enablecastbars2"] = "Enable all castbars"
ns.L["cbIconsize"] = "Castbars Icon Size"
ns.L["cbIconsize2"] = "Castbars Icon Size"
ns.L["aura"] = "Auras"
ns.L["enableauras"] = "Enable Auras"
ns.L["enableauras2"] = "Enable all auras"
ns.L["auraborders"] = "Debuff Border"
ns.L["auraborders2"] = "Color Debuff border based on debuff type."
ns.L["aurasperrow"] = "Aura Per row"
ns.L["aurasperrow2"] = "This controls the size of aura icon."
ns.L["enableplayerdebuff"] = "Player Debuffs"
ns.L["enableplayerdebuff2"] = "Show the debuffs casted on player above player frame"
ns.L["playerdebuffsperrow"] = "Player Debuffs Per row"
ns.L["playerdebuffsperrow2"] = "This controls the size of aura icon."
ns.L["AuraFilterignoreBuff"] = "Aura Filter : Ignore Buff"
ns.L["AuraFilterignoreBuff2"] = "Hide others' buff on friend units."
ns.L["AuraFilterignoreDebuff"] = "Aura Filter : Ignore Debuff"
ns.L["AuraFilterignoreDebuff2"] = "Hide others' debuff on enemies."
ns.L["aurafilterinfo"] = "Edit whitelist to force an aura to show when enable fliter.\nIf a debuff casted by others on a enemy is in whitelist,its color will not fade."
ns.L["input spellID"] = "Input spellID"
ns.L["threatbar"] = "Threatbar"
ns.L["showthreatbar"] = "Enable Threatbar"
ns.L["showthreatbar2"] = "Show a threatbar of target if you gain threat from it."
ns.L["tbvergradient"] = "Vertical Color Gradient"
ns.L["tbvergradient2"] = "Set threat bar color gradient orientation to vertical"
ns.L["pvpicon"] = "Show PvP Icon"
ns.L["pvpicon2"] = "Recommand in a PvE Server"
ns.L["bossframe"] = "Bossframe"
ns.L["bossframes"] = "Enable Bossframes"
ns.L["bossframes2"] = "Enable bossframes"
ns.L["raidshare"] = "Share Settings"
ns.L["enableraid"] = "Enable Raid Frames"
ns.L["enableraid2"] = "Enable raid frames"
ns.L["showraidpet"] = "Show Pets"
ns.L["showraidpet2"] = "Show Pets"
ns.L["raidfontsize"] = "Raid Font Size"
ns.L["raidfontsize2"] = "Font size for raid name, etc"
ns.L["showsolo"] = "Show Solo"
ns.L["showsolo2"] = "Show Raid Frame when solo"
ns.L["autoswitch"] = "disable Auto Switch"
ns.L["autoswitch2"] = "Disable it to switch raid frame mode automaticly when you change your current specialization.\nyou can use /rf to switch manually."
ns.L["raidonlyhealer"] = "Only Healer"
ns.L["raidonlyhealer2"] = "Only show Healer Mode Raid Frame.\nThis option is only available when disable auto switch."
ns.L["raidonlydps"] = "Only Dps/Tank"
ns.L["raidonlydps2"] = "Only show Dps/Tank Mode Raid Frame.\nThis option is only available when disable auto switch."
ns.L["toggleinfo"] = "If you disable all of Auto Switch, Only Healer and Only Dps/Tank,\nthen the addon will choose the raid frame match your specialization when log-in."
ns.L["enablearrow"] = "Enable Arrow"
ns.L["enablearrow2"] = "Enable direction arrow"
ns.L["arrowsacle"] = "Arrow Scale"
ns.L["arrowsacle2"] = "Arrow Scale"
ns.L["healerraidtext"] = "Healer Mode"
ns.L["groupsize"] = "Group Size"
ns.L["healerraidheight"] = "Height"
ns.L["healerraidheight2"] = "Height for each healer raid unit box."
ns.L["healerraidwidth"] = "Width"
ns.L["healerraidwidth2"] = "Width for each healer raid unit box."
ns.L["raidmanabars"] = "Show Mana bars"
ns.L["raidmanabars2"] = "Show Mana bars"
ns.L["anchor"] = "Anchor"
ns.L["partyanchor"] = "Party Anchor"
ns.L["showgcd"] = "GCD Bar"
ns.L["showgcd2"] = "Show GCD bar on raid frame."
ns.L["healprediction"] = "Heal Prediction"
ns.L["healprediction2"] = "Show heal prediction bar on raid frame."
ns.L["dpstankraidtext"] = "DPS/Tank Mode"
ns.L["dpsraidheight"] = "Height"
ns.L["dpsraidheight2"] = "Height for each dps/tank raid unit box."
ns.L["dpsraidwidth"] = "Width"
ns.L["dpsraidwidth2"] = "Width for each dps/tank raid unit box."
ns.L["dpsraidgroupbyclass"] = "Class Order"
ns.L["dpsraidgroupbyclass2"] = "Sort raid members by their class."
ns.L["unitnumperline"] = "Number Per Line"
ns.L["unitnumperline2"] = "How many unit do you want to show per line?"
ns.L["add to white list"] = "has been add to Aura Fliter WhiteList."
ns.L["remove frome white list"] = "has been removed from Aura Fliter WhiteList"
ns.L["not a corret Spell ID"] = "is not a correct spell ID"

ns.L["enableClickCast"] = "Enable Click-Cast"
ns.L["clickcastinro"] = "Input |cffFF3E96target|r to target mouseover unit.\nInput |cffFF3E96tot|r to target mouseover unit's target.\nInput |cffFF3E96follow|r to follow mouseover unit.\nInput |cffFF3E96a spell|r to cast it to the mouseover unit.\n\nReload UI to apply Click-Cast settings.\nBe careful when you Input a spell's name, they should be it's exactly name."
ns.L["1"] = "Left Button"
ns.L["2"] = "Right Button"
ns.L["3"] = "Middle Button"
ns.L["4"] = "Button 4"
ns.L["5"] = "Button 5"
ns.L["Click"] = "Click"
ns.L["shift-"] = "shift"
ns.L["ctrl-"] = "ctrl"
ns.L["alt-"] = "alt"