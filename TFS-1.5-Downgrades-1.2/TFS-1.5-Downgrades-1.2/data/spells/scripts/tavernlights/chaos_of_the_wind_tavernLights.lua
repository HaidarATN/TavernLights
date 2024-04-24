

function generateSpellArea() -- generate the spell area
  local areaArray = { --area of effect , only generate the 1 value because it is diamond shape like
  {0,0,1,0,0},
  {0,1,1,1,0},
  {1,1,2,1,1},
  {0,1,1,1,0},
  {0,0,1,0,0}
  }

  for i = 1, table.getn(areaArray), 1
  do
    for j = 1, 5,1
    do
      if areaArray[i][j] ~= 2 and areaArray[i][j] == 1 then
        areaArray[i][j] = math.random(0, 1)
      end 
    end
  end

  return areaArray
end

local generatedAreaCombat = {}

--Create each combat object, actually we can make it to an array for a more tidy code, but since each object can be unique,
-- so separating it to different variable is more make sense, and it also only 3 objects 
local combat0_tornado = Combat()
combat0_tornado:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat0_tornado:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO) 
generatedAreaCombat = generateSpellArea()
combat0_tornado:setArea(createCombatArea(generatedAreaCombat))

local combat1_tornado = Combat()
combat1_tornado:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat1_tornado:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
generatedAreaCombat = generateSpellArea()
combat1_tornado:setArea(createCombatArea(generatedAreaCombat))

local combat2_tornado = Combat()
combat2_tornado:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2_tornado:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
generatedAreaCombat = generateSpellArea()
combat2_tornado:setArea(createCombatArea(generatedAreaCombat))

local combat3_tornado = Combat()
combat3_tornado:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat3_tornado:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
generatedAreaCombat = generateSpellArea()
combat3_tornado:setArea(createCombatArea(generatedAreaCombat))

function SpawnTornado(c,cid,var) -- Part
	doCombat(cid, c, var)
end

function onCastSpell(creature, variant)
  SpawnTornado(combat0_tornado,creature,variant) --First spawn
	addEvent(SpawnTornado,400,combat1_tornado,creature,variant) --second spawn
  addEvent(SpawnTornado,800,combat2_tornado,creature,variant) --third spawn
  addEvent(SpawnTornado,1200,combat3_tornado,creature,variant) --fourth spawn

	addEvent(SpawnTornado,1500,combat1_tornado,creature,variant) --second spawn
  addEvent(SpawnTornado,1800,combat2_tornado,creature,variant) --third spawn
  addEvent(SpawnTornado,2100,combat3_tornado,creature,variant) --fourth spawn

  --actually, I can use for loop for a more tidy code. But since each spell can be unique (maybe in the future), separate it will make it more sense and more readable since it is only 3 spells

  --next create array
	return true
end