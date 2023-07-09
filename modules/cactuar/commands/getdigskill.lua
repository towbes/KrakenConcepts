-----------------------------------
-- func: getskill <skill name or ID> <target>
-- desc: returns target's level of specified skill
-----------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 0,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getdigskill (player)")
end

function onTrigger(player, craftname, target)

    local skillID = tonumber(craftName) or xi.skill[string.upper(craftName)]
    local targ = nil

    if target == nil then
        if player:getCursorTarget() == nil then
            targ = player
        else
            if player:getCursorTarget():isPC() then
                targ = player:getCursorTarget()
            else
                error(player, "You must target a player or specify a name.")
                return
            end
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            player:PrintToPlayer(string.format("Player named '%s' not found!", target))
            return
        end
    end

    player:PrintToPlayer(string.format("%s's current Chocobo Dig Skill is Level: %s", targ:getName(), (targ:getCharSkillLevel(skillID) / 10)))
end
