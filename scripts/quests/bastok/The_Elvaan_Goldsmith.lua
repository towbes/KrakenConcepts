-----------------------------------
-- The Elvaan Goldsmith
-----------------------------------
-- Log ID: 1, Quest ID: 13
-- Michea : !pos -298 -16 -157 235
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.THE_ELVAAN_GOLDSMITH)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.BASTOK,
    gil      = 180,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] = quest:progressEvent(215),

            onEventFinish =
            {
                [215] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- These functions check the status of ~= xi.questStatus.QUEST_AVAILABLE to support repeating
    -- the quest.  Does not have to be flagged again to complete an additional time.
    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE or
            player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.COPPER_INGOT) then
                        return quest:progressEvent(216)
                    end
                end,
            },

            onEventFinish =
            {
                [216] = function(player, csid, option, npc)
                    player:confirmTrade()
                    if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                        quest:complete(player)
                        player:needToZone(true)
                    else
                        player:addFame(xi.fameArea.BASTOK, 5)
                        npcUtil.giveCurrency(player, 'gil', xi.settings.main.GIL_RATE * 180)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },
}

return quest
