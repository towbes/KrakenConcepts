-----------------------------------
-- Area: Horlais_Peak
-----------------------------------
zones = zones or {}

zones[xi.zone.HORLAIS_PEAK] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6394, -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6399, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        PARTY_MEMBERS_HAVE_FALLEN     = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        YOU_DECIDED_TO_SHOW_UP        = 7755, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7756, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7757, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7758, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7759, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7760, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7761, -- Ungh... That'll hurt in the morning...
        DEEP_SLEEP                    = 7947, -- Aries falls into a deep sleep...
        EVIL_OSCAR_BEGINS_FILLING     = 7948, -- Evil Oscar begins filling his lungs with the foul air around him...
        PROMISE_ME_YOU_WONT_GO_DOWN   = 7964, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 7965, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 7966, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 7967, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 7968, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 7969, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 7970, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?

        -- TODO: Shift IDs
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7224, -- Your time in the battlefield is up! Now exiting...
        NO_BATTLEFIELD_ENTRY          = 7238, -- A cursed seal has been placed upon this platform.
        PARTY_MEMBERS_ARE_ENGAGED     = 7239, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        TESTIMONY_IS_TORN             = 7282, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7283, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7530, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7531, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7533, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7534, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7535, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        ENTERING_THE_BATTLEFIELD_FOR  = 7597, -- Entering the battlefield for [The Rank 2 Final Mission/Tails of Woe/Dismemberment Brigade/The Secret Weapon/Hostile Herbivores/Shattering Stars (WAR)/Shattering Stars (BLM)/Shattering Stars (RNG)/Carapace Combatants/Shooting Fish/Dropping Like Flies/Horns of War/Under Observation/Eye of the Tiger/Shots in the Dark/Double Dragonian/Today's Horoscope/Contaminated Colosseum/Kindergarten Cap/Last Orc-Shunned Hero/Beyond Infinity/Tails of Woe/Dismemberment Brigade/A Feast Most Dire/A.M.A.N. Trove (Mars)/A.M.A.N. Trove (Venus)/Inv. from Excenmille/Inv. from Excenmille and Co.]!
        SOUL_GEM_REACTS               = 7949, -- The <keyitem> reacts to the <keyitem>, sending a jolt of energy through your veins!

    },
    mob =
    {
        ARMSMASTER_DEKBUK       = GetFirstID('Armsmaster_Dekbuk'),
        ATORI_TUTORI            = GetFirstID('Atori-Tutori_qm'),
        DAROKBOK_OF_CLAN_REAPER = GetFirstID('Darokbok_of_Clan_Reaper'),
        DREAD_DRAGON            = GetFirstID('Dread_Dragon'),
        HELLTAIL_HARRY          = GetFirstID('Helltail_Harry'),
        MAAT                    = GetFirstID('Maat'),
    },
    npc =
    {
    },
}

return zones[xi.zone.HORLAIS_PEAK]
