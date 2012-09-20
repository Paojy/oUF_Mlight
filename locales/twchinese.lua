﻿local addon, ns = ...
if ns.Client ~= "zhTW" then return end

ns.L["apply"] = "使用/omf來移動單位框體，重載界面以生效。"
ns.L["don't have to rl"] = "這些設置立即生效"
ns.L["fade"] = "漸隱"
ns.L["enablefade"] = "啓用漸隱"
ns.L["enablefade2"] = "當你不施法，不在戰鬥，沒有目標且達到\n最大生命值和最大/最小能量值時啓用單位框架漸隱。"
ns.L["fadingalpha"] = "漸隱透明度"
ns.L["fadingalpha2"] = "“隱藏”時的透明度"
ns.L["font"] = "字體"
ns.L["fontfile"] = "字體路徑"
ns.L["fontfile2"] = "在你添加或替換字體文件之前請先退出遊戲。"
ns.L["fontsize"] = "字體大小"
ns.L["fontflag"] = "字體描邊"
ns.L["fontsize2"] = "生命值，能量值，名字和施法條等文本的字體大小。"
ns.L["colormode"] = "顔色模式"
ns.L["classcolormode"] = "職業顔色模式"
ns.L["classcolormode2"] = "啓用: 按職業染色生命條，按能量類型染色能能條。\n禁用 : 按血量百分比染色生命條，按職業染色能量條。"
ns.L["transparentmode"] = "反向填充模式"
ns.L["transparentmode2"] = "反向填充生命條"
ns.L["onlywhentransparent"] = "透明度调整只茬反向填充生命條"
ns.L["startcolor"] = "漸變開始透顔色"
ns.L["endcolor"] = "漸變結束透顔色"
ns.L["nameclasscolormode"] = "名字職業染色"
ns.L["nameclasscolormode2"] = "啓用: 職業顔色 禁用: 白色"
ns.L["portrait"] = "肖像"
ns.L["enableportrait"] = "显示肖像"
ns.L["portraitalpha"] = "肖像透明度"
ns.L["portraitalpha2"] = "如果你禁用反向填充，\n請降低肖像透明度使使生命條更清晰。"
ns.L["framesize"] = "框體尺寸"
ns.L["height"] = "框體高度"
ns.L["height2"] = "框體高度"
ns.L["width"] = "框體寬度"
ns.L["width2"] = "玩家，目標和焦點框體的寬度。"
ns.L["widthpet"] = "寵物框體寬度"
ns.L["widthpet2"] = "寵物框體寬度"
ns.L["widthboss"] = "首領框體寬度"
ns.L["widthboss2"] = "首領框體寬度"
ns.L["scale"] = "框體尺寸"
ns.L["scale2"] = "框體尺寸"
ns.L["hpheight"] = "生命條高度比"
ns.L["hpheight2"] = "生命條高度和框體高度的比例"
ns.L["castbar"] = "施法條"
ns.L["enablecastbars"] = "啓用施法條"
ns.L["enablecastbars2"] = "啓用所用施法條"
ns.L["cbIconsize"] = "施法條圖標大小"
ns.L["cbIconsize2"] = "施法條圖標大小"
ns.L["aura"] = "光環"
ns.L["enableauras"] = "啓用光環"
ns.L["enableauras2"] = "啓用所有光環"
ns.L["auraborders"] = "減益邊框"
ns.L["auraborders2"] = "根據減益類型染色減益邊框."
ns.L["aurasperrow"] = "每行的光環數量"
ns.L["aurasperrow2"] = "控制圖標大小。"
ns.L["enableplayerdebuff"] = "玩家減益"
ns.L["enableplayerdebuff2"] = "在玩家框體上顯示施放在減益玩家"
ns.L["playerdebuffsperrow"] = "每行的玩家減益數量"
ns.L["playerdebuffsperrow2"] = "控制圖標大小。"
ns.L["AuraFilterignoreBuff"] = "光環過濾 : 忽視增益"
ns.L["AuraFilterignoreBuff2"] = "隱藏其他玩家是放在友方單位身上的增益。"
ns.L["AuraFilterignoreDebuff"] = "光環過濾 : 忽視減益"
ns.L["AuraFilterignoreDebuff2"] = "隱藏其他玩家是放在敵方單位身上的減益。"
ns.L["aurafilterinfo"] = "編輯白名單來使一個光環在啓用過濾時強制顯示。\n在白名單中，一個其他玩家是放在敵方單位身上的減益顔色不會變灰。"
ns.L["input spellID"] = "輸入法術ID"
ns.L["threatbar"] = "仇恨條"
ns.L["showthreatbar"] = "啓用仇恨條"
ns.L["showthreatbar2"] = "顯示目標仇恨條如果你已從目標獲得仇恨."
ns.L["tbvergradient"] = "垂直顔色漸變"
ns.L["tbvergradient2"] = "使仇恨條顔色漸變的方向改爲垂直。"
ns.L["bossframe"] = "首領框體"
ns.L["bossframes"] = "啓用首領框體"
ns.L["bossframes2"] = "啓用首領框體"
ns.L["raidshare"] = "通用設置"
ns.L["enableraid"] = "啓用團隊框架"
ns.L["enableraid2"] = "啓用團隊框架"
ns.L["raidfontsize"] = "團隊框架字體大小"
ns.L["raidfontsize2"] = "團隊成員名字等文本的字體大小。"
ns.L["showsolo"] = "未進組時顯示"
ns.L["showsolo2"] = "未進組時顯示"
ns.L["autoswitch"] = "禁用自動切換"
ns.L["autoswitch2"] = "禁用根據天賦變化自動切換框體。\n你可以用 /rf 手動切換。"
ns.L["raidonlyhealer"] = "僅治療"
ns.L["raidonlyhealer2"] = "僅顯示治療模式團隊框體。\n 這個選項僅在禁用自動切換時生效。"
ns.L["raidonlydps"] = "僅Dps/Tank"
ns.L["raidonlydps2"] = "僅顯示Dps/Tank模式團隊框體.\n 這個選項僅在禁用自動切換時生效。"
ns.L["toggleinfo"] = "如果你禁用自動切換,僅治療和僅Dps/Tank，\n那麽插件會根據進入遊戲時的天賦選擇團隊框體。"
ns.L["enablearrow"] = "啓用箭頭"
ns.L["enablearrow2"] = "啓用方向指示箭頭"
ns.L["arrowsacle"] = "箭頭尺寸"
ns.L["arrowsacle2"] = "箭頭尺寸"
ns.L["healerraidtext"] = "治療模式"
ns.L["groupsize"] = "团队规模"
ns.L["healerraidheight"] = "高度"
ns.L["healerraidheight2"] = "每個治療團隊單位框體的高度。"
ns.L["healerraidwidth"] = "寬度"
ns.L["healerraidwidth2"] = "每個治療團隊單位框體的寬度"
ns.L["anchor"] = "排列方向"
ns.L["partyanchor"] = "小隊排列方向"
ns.L["showgcd"] = "GCD"
ns.L["showgcd2"] = "在團隊框體上指示GCD。"
ns.L["healprediction"] = "治療預估"
ns.L["healprediction2"] = "在團隊框體指示預計治療。"
ns.L["dpstankraidtext"] = "DPS/Tank模式"
ns.L["dpsraidheight"] = "高度"
ns.L["dpsraidheight2"] = "每個DPS/Tank團隊單位框體的高度。"
ns.L["dpsraidwidth"] = "寬度"
ns.L["dpsraidwidth2"] = "每個DPS/Tank團隊單位框體的寬度。"
ns.L["dpsraidgroupbyclass"] = "職業順序"
ns.L["dpsraidgroupbyclass2"] = "根據職業順序排列。"
ns.L["unitnumperline"] = "整體高度"
ns.L["unitnumperline2"] = "每一列的框體數量"
ns.L["add to white list"] = "被添加到法術過濾白名單中。"
ns.L["remove frome white list"] = "從法術過濾白名單中移出。"
ns.L["not a corret Spell ID"] = "不是一個有效的法術ID。"