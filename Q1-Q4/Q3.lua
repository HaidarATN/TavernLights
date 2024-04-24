--Original code
function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    local party = player:getParty()
    
    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
        party:removeMember(Player(membername))
        end
    end
end

-- First, this code looks like having a goal to kick a party member xD , so I will change the function name to be
-- more relevant such as "kickMemberByName" . Second, I will make sure that the player and party is exist as well to prevent
-- null exception like on Q2. Second, I'm not quite sure if getMembers() will return a player object, so I just want to be save
-- that I will compare v name with membername instead of player object. And I assume that there aren't any player with similar name
-- so I will break the loop once it is done removing the specific member. And also I add another handler where if there are no specific
-- player with name of membername is found, it will send a message

-- My code
function kickMemberByName(playerId, membername)
    player = Player(playerId)
    
    if player then
        local party = player:getParty()

        if party then
            local members = party:getMembers()
            local memberCount = 0
            
            for i in pairs(members) do
                memberCount = memberCount + 1
            end

            for k,v in pairs(members) do
                local checkedMemberName = v:getName()
                if checkedMemberName == membername then
                    party:removeMember(Player(membername))
                    break
                end

                if k >= memberCount
                    print("Not player with name " .. membername .. "is found")
                end
            end
        end
    else
        print("Player not found")
    end  
end