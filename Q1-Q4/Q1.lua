--Original code
local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end
    
function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    
    return true
end

-- My explanation :
-- for me, when checking some value in storage with ID 1000 (in line 7), I'd love to use "player:getStorageValue(1000) > 0" rather
-- than an exact number of 1, because since a game cycle can be fast, we sometimes can miss that "1" value in a frame

--My code
local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end
    
function onLogout(player)
    if player:getStorageValue(1000) > 0 then
        addEvent(releaseStorage, 1000, player)
    end
    
    return true
end