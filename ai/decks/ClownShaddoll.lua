
function ClownShaddollStartup(deck)
  deck.Init                 = ClownShaddollInit
  deck.Card                 = ClownShaddollCard
  deck.Chain                = ClownShaddollChain
  deck.EffectYesNo          = ClownShaddollEffectYesNo
  deck.Position             = ClownShaddollPosition
  deck.YesNo                = ClownShaddollYesNo
  deck.BattleCommand        = ClownShaddollBattleCommand
  deck.AttackTarget         = ClownShaddollAttackTarget
  deck.AttackBoost          = ClownShaddollAttackBoost
  deck.Tribute				      = ClownShaddollTribute
  deck.Option               = ClownShaddollOption
  deck.ChainOrder           = ClownShaddollChainOrder
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = ClownShaddollActivateBlacklist
  deck.SummonBlacklist      = ClownShaddollSummonBlacklist
  deck.RepositionBlacklist  = ClownShaddollRepoBlacklist
  deck.SetBlacklist		      = ClownShaddollSetBlacklist
  deck.Unchainable          = ClownShaddollUnchainable
  --[[
  
  ]]
  deck.PriorityList         = ClownShaddollPriorityList
  
end

ClownShaddollIdentifier = {06417578,68819554} -- El-Shaddoll Fusion, Performage Damage Juggler

DECK_CLOWNSHADDOLL = NewDeck("Clown Shaddoll",ClownShaddollIdentifier,ClownShaddollStartup) 


ClownShaddollActivateBlacklist={
}
ClownShaddollSummonBlacklist={
}
ClownShaddollSetBlacklist={
}
ClownShaddollRepoBlacklist={
}
ClownShaddollUnchainable={
}
function ShaddollFilter(c,exclude)
  return FilterSet(card,0x109d)
  and (exclude == nil or c.id~=exclude)
end
function ShaddollMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and ShaddollFilter(c,exclude)
end
function ShaddollSTFilter(c,exclude)
  return FilterType(c,TYPE_SPELL+TYPE_TRAP)
  and ShaddollFilter(c,exclude)
end
function PerformageFilter(c,exclude)
  return FilterSet(card,0xc6)
  and (exclude == nil or c.id~=exclude)
end
function PerformageMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and PerformageFilter(c,exclude)
end

ClownShaddollPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- ClownShaddoll

[37445295] = {6,3,3,1,7,1,6,1,1,1,FalconCond},        -- Shaddoll Falcon
[04939890] = {5,2,2,1,5,4,5,4,1,1,HedgehogCond},      -- Shaddoll Hedgehog
[30328508] = {4,1,5,1,9,1,9,1,1,1,SquamataCond},      -- Shaddoll Squamata
[77723643] = {3,1,4,1,7,1,7,1,1,1,DragonCond},        -- Shaddoll Dragon
[03717252] = {2,1,6,1,5,1,8,1,1,1,BeastCond},         -- Shaddoll Beast

[67696066] = {1,1,1,1,1,1,1,1,1,1,ClownCond},         -- Performage Trick Clown
[68819554] = {1,1,1,1,1,1,1,1,1,1,JugglerCond},       -- Performage Damage Juggler
[31292357] = {1,1,1,1,1,1,1,1,1,1,HatCond},           -- Performage Hat Tricker

[41386308] = {1,1,1,1,1,1,1,1,1,1,MathCond},          -- Mathematician
[23434538] = {1,1,1,1,1,1,1,1,1,1},                   -- Maxx "C"
[97268402] = {1,1,1,1,1,1,1,1,1,1},                   -- Effect Veiler

[44394295] = {9,5,1,1,1,1,1,1,1,1,ShadFusionCond},    -- Shaddoll Fusion
[06417578] = {8,6,1,1,1,1,1,1,1,1,ElFusionCond},      -- El-Shaddoll Fusion
[04904633] = {4,2,1,1,9,1,9,1,1,1,CoreCond},          -- Shaddoll Core

[01845204] = {1,1,1,1,1,1,1,1,1,1},                   -- Instant Fusion
[12580477] = {1,1,1,1,1,1,1,1,1,1},                   -- Raigeki
[81439173] = {1,1,1,1,1,1,1,1,1,1},                   -- Foolish Burial
[14087893] = {1,1,1,1,1,1,1,1,1,1},                   -- Book of Moon
[29401950] = {1,1,1,1,1,1,1,1,1,1},                   -- Bottomless Trap Hole
[29616929] = {1,1,1,1,1,1,1,1,1,1},                   -- Traptrix Trap Hole Nightmare
[53582587] = {1,1,1,1,1,1,1,1,1,1},                   -- Torrential Tribute
[78474168] = {1,1,1,1,1,1,1,1,1,1},                   -- Breakthrough Skill
[05851097] = {1,1,1,1,1,1,1,1,1,1},                   -- Vanity's Emptiness


[20366274] = {1,1,6,4,2,1,2,1,1,1,ConstructCond},     -- El-Shaddoll Construct
[94977269] = {1,1,7,3,2,1,2,1,1,1,WindaCond},         -- El-Shaddoll Winda
[74822425] = {1,1,1,1,1,1,1,1,1,1,ShekinagaCond},     -- El-Shaddoll Shekinaga
[19261966] = {1,1,1,1,1,1,1,1,1,1,AnoyatilisCond},    -- El-Shaddoll Anoyatilis

[52687916] = {1,1,1,1,1,1,1,1,1,1},                   -- Trishula
[17016362] = {1,1,1,1,1,1,1,1,1,1},                   -- Trapeze Magician
[82633039] = {1,1,1,1,6,1,1,1,1,1,CastelCond},        -- Skyblaster Castel
[00581014] = {1,1,1,1,1,1,1,1,1,1},                   -- Daigusto Emeral
[00581014] = {1,1,1,1,1,1,1,1,1,1},                   -- Emeral
[21044178] = {1,1,1,1,1,1,1,1,1,1},                   -- Dweller
[06511113] = {1,1,1,1,1,1,1,1,1,1},                   -- Rafflesia
} 
function ShadollFusionFilter(c)
  return c and c.summon_type and c.previous_location
  and bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
  and bit32.band(c.previous_location,LOCATION_EXTRA)==LOCATION_EXTRA
end
function UseShaddollFusion(c,mode)
  if mode == 1 then
    if CardsMatchingFilter(OppMon(),ShadollFusionFilter)>0 
    then
      return true
    end
  end
  if mode == 2 then
  end
  return false
end
function SummonMathShaddoll(c)
end
function ClownShaddollInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,44394295,UseShaddollFusion,1) then
    return Activate()
  end
  if HasIDNotNegated(Sum,41386308,SummonMathShaddoll) then
    return Summon()
  end
  return nil
end
function ElFusionTarget(cards,min)
end
function ClownShaddollCard(cards,min,max,id,c)
  if id == 06417578 then
    return ElFusionTarget(cards,min)
  end
  return nil
end
GlobalElFusionTargets=nil
function ChainElFusion(c) then
  if RemovalCheckCard(c) then
    local targets = {}
    for i=1,#AIMon() do
      local c = AIMon()[i]
      if RemovalCheckCard(c) then
        targets[#targets+1]=c
      end
    end
    if #targets>0 then GlobalElFusionTargets=targets
    return true
  end
  return false
end
function ClownShaddollChain(cards)
  if HasIDNotNegated(cards,06417578,ChainElFusion) then
    return true
  end
  return nil
end
function ClownShaddollEffectYesNo(id,card)
end
function ClownShaddollYesNo(desc)
end
function ClownShaddollTribute(cards,min, max)
end
function ClownShaddollBattleCommand(cards,targets,act)
end
function ClownShaddollAttackTarget(cards,attacker)
end
function ClownShaddollAttackBoost(cards)
end
function ClownShaddollOption(options)
end
function ClownShaddollChainOrder(cards)
end
ClownShaddollAtt={
}
ClownShaddollDef={
}
function ClownShaddollPosition(id,available)
  result = nil
  for i=1,#ClownShaddollAtt do
    if ClownShaddollAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#ClownShaddollDef do
    if ClownShaddollDef[i]==id 
    then 
      result=POS_FACEUP_DEFENCE 
    end
  end
  return result
end

