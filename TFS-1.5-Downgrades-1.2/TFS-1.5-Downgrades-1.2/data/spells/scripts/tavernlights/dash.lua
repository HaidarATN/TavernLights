local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local unwanted_tilestates = { TILESTATE_PROTECTIONZONE, TILESTATE_HOUSE, TILESTATE_FLOORCHANGE, TILESTATE_TELEPORT, TILESTATE_BLOCKSOLID, TILESTATE_BLOCKPATH }

function RunPart(c,cid,var) -- Part
    local toPosition = false
    toPosition = cid:getPosition()
    toPosition:getNextPosition(cid:getDirection(), 1) --set dash target position
    cid:getPosition():sendMagicEffect(CONST_ME_BLACKSMOKE) -- spawn dust effect on current position
    cid:teleportTo(toPosition) --dash/"teleport" to target position
    --toPosition:sendMagicEffect(CONST_ME_PURPLETELEPORT) -- spawn effect on finish
end

function removeMonster(monster)
    monster:remove()
end

function onCastSpell(creature, variant)
    -- local target = creature:getTarget()
    -- local toPosition = false
    -- if target then
    --     toPosition = target:getPosition()
    --     toPosition:getNextPosition(target:getDirection(), 1)
    -- else
    --     toPosition = creature:getPosition()
    --     toPosition:getNextPosition(creature:getDirection(), 2)
    -- end
    

    -- --Check restricted tile
    -- local tile = toPosition and Tile(toPosition)
    -- if not tile then
    --     return false
    -- end

    -- for _, tilestate in pairs(unwanted_tilestates) do
    --     if tile:hasFlag(tilestate) then
    --         creature:sendCancelMessage("You cannot dash here.")
    --         return false
    --     end
    -- end

    --return combat:execute(creature, variant)
    
    --Window
    local player = Player(creature:getId())
    player:registerEvent("Window_MovingButton")
    local title = "I'm a moving button"
    local message = "Press me!"

    local window = ModalWindow(1000, title, message)
    window:addButton(100, "Confirm")
    window:setDefaultEnterButton(100)

    window:sendToPlayer(creature)
    local lastPosition = false --define variable for last player position

    local dashCount = 4
    local dashRate = 50

    for i = 1,dashCount,1
    do
        addEvent(function()
            lastPosition = creature:getPosition() --get current player position before dashing
            RunPart(combat,creature,variant) --execute dashing
    
            local monster = Game.createMonster("Player Clone", lastPosition, true) --spawn clone as monster (as illusion dash effect)
            monster:setDirection(creature:getDirection()) --change monster facing direction based on player
    
            addEvent(function() --destroy clone (for effect)
                monster:remove()
              end
              ,300) -- delay before the clone destroyed
          end
          ,dashRate*i)
    end

    return true
end