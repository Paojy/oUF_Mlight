local ADDON_NAME, ns = ...
local cfg = ns.cfg

local spellcache = setmetatable({}, {__index=function(t,v) local a = {GetSpellInfo(v)} if GetSpellInfo(v) then t[v] = a end return a end})
local function GetSpellInfo(a)
    return unpack(spellcache[a])
end

ns.auras = {
    -- Ascending aura timer
    -- Add spells to this list to have the aura time count up from 0
    -- NOTE: This does not show the aura, it needs to be in one of the other list too.
    ascending = {
        --[GetSpellInfo(92956)] = true, -- Wrack
    },

    -- Any Zone
    debuffs = {
        --[GetSpellInfo(6788)] = 16, -- Weakened Soul TEST
    },

    buffs = { -- these display on the second icon
		--[GetSpellInfo(139)] = 15, -- Renew TEST
	--��ʦ
		[GetSpellInfo(33206)] = 15, -- ʹ��ѹ��
        [GetSpellInfo(47788)] = 15, -- �ػ�֮��
	--С��
        [GetSpellInfo(102342)] = 15, -- ��ľ��Ƥ
		[GetSpellInfo(22812)] = 15, -- ��Ƥ��
		[GetSpellInfo(61336)] = 15, -- ���汾��
		[GetSpellInfo(105737)] = 15, -- ������֮��
		[GetSpellInfo(22842)] = 14, -- �񱩻ظ�
	--��ʿ
		[GetSpellInfo(1022)] = 15, -- ����֮��
		[GetSpellInfo(31850)] = 15, -- ���ȷ�����
        [GetSpellInfo(498)] = 15, -- ʥ����
		[GetSpellInfo(642)] = 15, -- ʥ����
		[GetSpellInfo(86659)] = 15, -- Զ����������
	--��ɮ
		[GetSpellInfo(116849)] = 15, -- ���븿��
		[GetSpellInfo(115203)] = 15, -- ׳����
        --[GetSpellInfo(115308)] = 14, -- Ʈ���		
	--DK
        [GetSpellInfo(50397)] = 15, -- ����֮��
		[GetSpellInfo(48707)] = 15, -- ��ħ������
		[GetSpellInfo(48792)] = 15, -- ����֮��
		[GetSpellInfo(49222)] = 14, -- �׹�֮��
		[GetSpellInfo(49028)] = 14, -- ��������
		[GetSpellInfo(55233)] = 15, -- ��������
	--սʿ
        [GetSpellInfo(112048)] = 14, -- ��������
		[GetSpellInfo(12975)] = 15, -- �Ƹ�����
		[GetSpellInfo(871)] = 15, -- ��ǽ
    },

    -- Raid Debuffs
    instances = {
        --["MapID"] = {
        --	[Name or GetSpellInfo(spellID) or SpellID] = PRIORITY,
        --},
		
		--GetCurrentMapAreaID()

        [1] = { --[[Gate of the Setting Sun ������ ]]--

            -- Raigonn ����
            [GetSpellInfo(111644)] = 7, -- Screeching Swarm 111640 111643
        },

		[1] = { --[[Mogu'shan Palace ħ��ɽ��� ]]--

            -- Trial of the King ����������
            [GetSpellInfo(119946)] = 7, -- Ravage
			-- Xin the Weaponmaster <King of the Clans> ������ʦϯ��
			[GetSpellInfo(119684)] = 7, --Ground Slam
        },
		
		[1] = { --[[Scarlet Halls Ѫɫ���� ]]--

            -- Houndmaster Braun <PH Dressing>
            [GetSpellInfo(114056)] = 7, -- Bloody Mess
			-- Flameweaver Koegler
			[GetSpellInfo(113653)] = 7, -- Greater Dragon's Breath
			[GetSpellInfo(11366)] = 6,-- Pyroblast		
        },
		
		[1] = { --[[Scarlet Monastery Ѫɫ�޵�Ժ ]]--

            -- Thalnos the Soulrender
            [GetSpellInfo(115144)] = 7, -- Mind Rot
			[GetSpellInfo(115297)] = 6, -- Evict Soul
        },
		
		[1] = { --[[Scholomance ͨ��ѧԺ ]]--

            -- Instructor Chillheart
            [GetSpellInfo(111631)] = 7, -- Wrack Soul
			-- Lilian Voss
            [GetSpellInfo(111585)] = 7, -- Dark Blaze
			-- Darkmaster Gandling
			[GetSpellInfo(108686)] = 7, -- Immolate
        },
				
		[1] = { --[[Shado-Pan Monastery Ӱ����Ժ ]]--

            -- Sha of Violence
            [GetSpellInfo(106872)] = 7, -- Disorienting Smash
			-- Taran Zhu <Lord of the Shado-Pan>
            [GetSpellInfo(112932)] = 7, -- Ring of Malice
        },
		
		[1] = { --[[Siege of Niuzao Temple Χ���e���� ]]--

            -- Wing Leader Ner'onok 
            [GetSpellInfo(121447)] = 7, -- Quick-Dry Resin
        },
		
		[1] = { --[[Temple of the Jade Serpent ������ ]]--

            -- Wise Mari <Waterspeaker>
            [GetSpellInfo(106653)] = 7, -- Sha Residue
			-- Lorewalker Stonestep <The Keeper of Scrolls>
			[GetSpellInfo(106653)] = 7, -- Agony
			-- Liu Flameheart <Priestess of the Jade Serpent>
			[GetSpellInfo(106823)] = 7, -- Serpent Strike
			-- Sha of Doubt
			[GetSpellInfo(106113)] = 7, --Touch of Nothingness
        },
		
		[1] = { --[[Heart of Fear �־�֮�� ]]--
		    -- Imperial Vizier Zor'lok
			-- Blade Lord Ta'yak
			-- Garalon
			-- Wind Lord Mel'jarak
			-- Amber-Shaper Un'sok
			-- Grand Empress Shek'zeer
        },
		
		[1] = { --[[Mogu'shan Vaults ħ��ɽ���� ]]--
		    -- The Stone Guard
			-- Feng the Accursed
			-- Gara'jal the Spiritbinder
			-- The Spirit Kings
			-- Elegon
			-- Will of the Emperor 
        },
		
		[1] = { --[[Terrace of Endless Spring ����̨ ]]--
		    -- Protectors of the Endless
			-- Sha of Anger
			[GetSpellInfo(119487)] = 7, --Seethe
			-- Salyis's Warband
			[GetSpellInfo(34716)] = 7, -- Stomp
			-- Tsulong
			-- Lei Shi
			-- Sha of Fear
        },

    },
}