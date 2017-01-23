function BAFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xb1) and check
end
function PKFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xdb) and check
end
function PKNonXYZFilter(c,exclude)
  return PKFilter(c,exclude) 
  and FilterType(c,TYPE_MONSTER)
  and not FilterType(c,TYPE_XYZ)
end
function TPKFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0x10db) and check
end
function BAMonsterFilter(c,exclude,boss)
  return FilterType(c,TYPE_MONSTER) and BAFilter(c,exclude)
  and (FilterPosition(c,POS_FACEUP) or not FilterLocation(c,LOCATION_ONFIELD))
  and (not boss or FilterID(c,00601193) or FilterID(c,83531441)
  or FilterID(c,18386170) or FilterID(c,35330871))
end
function BASelfDestructFilter(c,exclude)
  return BAMonsterFilter(c,exclude) and not BAMonsterFilter(c,exclude,true)
  and NotNegated(c)
end
function NotBAMonsterFilter(c)
  return FilterType(c,TYPE_MONSTER) and not BAMonsterFilter(c)
end
function BAFloater(c,check)
  return c.id == 57143342 and (not check or OPTCheck(57143342) and CardsMatchingFilter(AIDeck(),BAMonsterFilter,20758643)>0)
      or c.id == 20758643 and (not check or OPTCheck(57143342) and CardsMatchingFilter(AIGrave(),BAMonsterFilter,20758643)>0)
      or c.id == 84764038 and (not check or OPTCheck(84764038) and CardsMatchingFilter(AIDeck(),ScarmDeckFilter)>0 and CardsMatchingFilter(AIGrave(),ScarmGraveFilter)==0)
      or c.id == 83531441 and (not check or CardsMatchingFilter(AIGrave(),BAMonsterFilter,83531441)>0)
end
function BAXYZSummonCheck(count)
  if count == nil then count = 1 end
  return CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  and FieldCheck(3)==count
  and CanXYZSummon(3)
end
function BAStartup(deck)
  deck.Init                 = BAInit

  deck.ActivateBlacklist    = BAActivateBlacklist
  deck.SummonBlacklist      = BASummonBlacklist
  
  deck.PriorityList         = BAPriorityList
end

DECK_BA           = NewDeck("Burning Abyss",57143342,BAStartup) -- BA Cir

BAActivateBlacklist={
53932291,63821877,90432163, -- Speedroid Taketomborg, PK Cloak, Glove
36426778,62709239,25542642, -- PK Boots, Break Sword, Fog Blade
03298689,85252081,95992081, -- PK Launch, Super Quantum Granpulse, Leviair
}
BASummonBlacklist={
81275020,53932291,63821877, -- Speedroid Terrortop, Taketomborg, PK Cloak
36426778,90432163,62709239, -- PK Glove, Boots, Break Sword
85252081,95992081, -- Super Quantum Granpulse, Leviair
}


function ScarmGraveFilter(c)
  return c.id == 84764038 and c.turnid == Duel.GetTurnCount()
end
function ScarmDeckFilter(c)
  return FilterLevel(c,3) and FilterAttribute(c,ATTRIBUTE_DARK)
  and FilterRace(c,RACE_FIEND) and c.id ~= 84764038
end
function ScarmCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),84764038,true)
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_REMOVED) then
      return 1
    end
    return OPTCheck(84764038) and CardsMatchingFilter(AIGrave(),ScarmGraveFilter)==0
    and CardsMatchingFilter(AIDeck(),ScarmDeckFilter)>0
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(84764038) and CardsMatchingFilter(AIGrave(),ScarmGraveFilter)==0
    and CardsMatchingFilter(AIDeck(),ScarmDeckFilter)>0
  end
  return true
end
function GraffCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),20758643,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(20758643) 
    and CardsMatchingFilter(AIDeck(),BAMonsterFilter,20758643)>0
    and not HasID(AIMon(),20758643,true)
    and (CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
    or GlobalSummonNegated)
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(20758643) and CardsMatchingFilter(AIDeck(),BAMonsterFilter,20758643)>0
  end
  return true
end
function CirCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),57143342,true)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(57143342) and CardsMatchingFilter(AIGrave(),BAMonsterFilter,57143342)>0
    and not HasID(AIMon(),57143342,true)
    and (CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
    or GlobalSummonNegated)
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(57143342) and CardsMatchingFilter(AIGrave(),BAMonsterFilter,57143342)>0
  end
  return true
end
function AlichFilter(c)
  return FilterType(c,TYPE_MONSTER+TYPE_EFFECT) 
  and Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,3)
  and FilterPosition(c,POS_FACEUP)
  and not FilterAffected(c,EFFECT_DISABLE_EFFECT)
end
function AlichCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),47728740,true)
  end
  if loc == PRIO_TOFIELD then
    return not(FilterLocation(c,LOCATION_GRAVE))
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(47728740) and CardsMatchingFilter(OppMon(),AlichFilter)>0
  end
  return true
end
function CalcabFilter(c)
  return FilterPosition(c,POS_FACEDOWN) 
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET) == 0
end
function CalcabCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),73213494,true)
  end
  if loc == PRIO_TOFIELD then
    return not(FilterLocation(c,LOCATION_GRAVE))
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(73213494) and CardsMatchingFilter(OppST(),CalcabFilter)>0
  end
  return true
end
function RubicCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),00734741,true)
    and not HasAccess(00601193)
  end
  if loc == PRIO_TOFIELD then
    return not(FilterLocation(c,LOCATION_GRAVE))
    and HasID(AIMon(),83531441,true)
    and not HasID(AIMon(),10802915,true)
    and not HasID(AICards(),00734741,true)
    and Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and CardsMatchingFilter(AIHand(),BAMonsterFilter,00734741)>0
    and (#AIST()==0 or not NormalSummonCheck())
    and HasID(AIExtra(),00601193,true)
    and not HasID(AIMon(),00601193,true)
  end
  return true 
end
function FarfaFilter(c)
  return FilterType(c,TYPE_MONSTER) 
  and Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,3)
  and CurrentOwner(c)==2
end
function FarfaCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),36553319,true)
  end
  if loc == PRIO_TOFIELD then
    return not(FilterLocation(c,LOCATION_GRAVE))
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(36553319) and CardsMatchingFilter(OppMon(),FarfaFilter)>0
  end
  return true
end
function CagnaCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),09342162,true)
  end
  if loc == PRIO_TOFIELD then
    return not(FilterLocation(c,LOCATION_GRAVE))
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(09342162) and not (HasID(AIGrave(),62835876,true) 
    or HasID(UseLists(AIHand(),AIGrave(),AIST()),36006208,true) )
    and CardsMatchingFilter(AIHand(),BAFilter)>0
  end
  return true
end
function BarbarDamage()
  return math.min(3,CardsMatchingFilter(AIGrave(),BAMonsterFilter,81992475))*300
end
function BarbarFinish(cards)
  if not cards then cards=AIDeck() end
  return HasID(cards,81992475,true,FilterOPT,true)
  and BarbarDamage()>=AI.GetPlayerLP(2)
  and MacroCheck()
end
function BarbarCond(loc,c)
  if loc == PRIO_TOHAND then
    return BarbarDamage()>=AI.GetPlayerLP(2) 
    and not FilterLocation(c,LOCATION_DECK)
  end
  if loc == PRIO_TOFIELD then
    return BarbarDamage()>=AI.GetPlayerLP(2)
  end
  if loc == PRIO_TOGRAVE then
    return BarbarDamage()>=AI.GetPlayerLP(2)
  end
  return true
end
function LibicFilter(c,source)
  return FilterSet(c,0xb1) and FilterType(c,TYPE_MONSTER) and FilterLevel(c,3)
  and not CardsEqual(c,source)
end
function LibicCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists(AIHand(),AIMon()),62957424,true)
  end
  if loc == PRIO_TOFIELD then
    if OPTCheck(62957424) 
    and CardsMatchingFilter(AIHand(),LibicFilter,c)>0 
    and CardsMatchingFilter(AIMon(),NotBAMonsterFilter)>0 
    and not GlobalSummonNegated
    then
      return 9
    end
    return not(FilterLocation(c,LOCATION_GRAVE)) 
  end
  if loc == PRIO_TOGRAVE then
    if OPTCheck(62957424) and CardsMatchingFilter(AIHand(),LibicFilter,c)>0 then
      if CardsMatchingFilter(AIMon(),NotBAMonsterFilter)>0 
      and not GlobalSummonNegated
      then
        return 9
      end
      return true
    end
    return false
  end
  return true
end
function DanteCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(AIGrave(),BAFilter)>0
  end
  return true
end
function VirgilCond(loc,c)
  return true
end
function ReleaserCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return not DeckCheck(DECK_BA) or HasID(AIHand(),35330871,true)
  end
  return true
end
function GECond(loc,c)
  if loc == PRIO_TOHAND then
    return HasID(AIHand(),35330871,true)
  end
  if loc == PRIO_TOGRAVE then
    --return not HasID(AIGrave(),62835876,true)
  end
  return true
end
function MalacodaCond(loc,c)
  if loc == PRIO_TOHAND then
    return HasID(AIHand(),62835876,true)
  end
  return true
end
function FireLakeCond(loc,c)
  if loc == PRIO_TOHAND then
    return GetMultiple(36006208)==0 
    and not HasID(GlobalTargetList,36006208,true)
    and not HasID(UseLists(AIHand(),AIST()),36006208,true)
    and CardsMatchingFilter(AICards(),BAMonsterFilter)>1
  end
  return true
end
function GloveCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
function CloakCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
function BootsCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
function BreakSwordCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
function LaunchCond(loc,c)
  if loc == PRIO_TOHAND then
    if HasID(AIMon(),16195942,true,FilterMaterials,0)
    and HasIDNotNegated(AIExtra(),01621413,true)
    and DualityCheck()
    and NotNegated(c)
    then
      return true
    end
    return false
  end
  return true
end
function FogBladeCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
BAPriorityList={
-- Burning Abyss

[57143342] = {7,2,7,3,7,1,1,1,2,1,CirCond},      -- BA Cir
[73213494] = {3,2,3,1,3,3,1,1,6,1,CalcabCond},   -- BA Calcab
[47728740] = {2,2,3,1,3,3,1,1,6,1,AlichCond},    -- BA Alich
[20758643] = {6,2,8,2,8,2,1,1,5,1,GraffCond},    -- BA Graff
[10802915] = {8,2,3,2,2,1,4,1,8,3,TourGuideCond},-- Tour Guide
[84764038] = {5,2,5,4,5,2,6,1,4,2,ScarmCond},    -- BA Scarm
[00734741] = {4,2,6,3,3,3,1,1,6,1,RubicCond},    -- BA Rubic
[36553319] = {4,2,4,1,4,3,1,1,6,1,FarfaCond},    -- BA Farfa
[09342162] = {3,2,6,1,6,3,1,1,6,1,CagnaCond},    -- BA Cagna
[62957424] = {3,2,3,1,3,3,1,1,6,1,LibicCond},    -- BA Libic
[81992475] = {9,2,9,1,9,1,1,1,6,1,BarbarCond},   -- BA Barbar
[35330871] = {8,2,1,1,2,2,1,1,5,1,MalacodaCond}, -- BA Malacoda

[63821877] = {1,1,1,1,4,1,1,1,1,1,GloveCond},    -- PK Glove
[90432163] = {1,1,1,1,3,1,1,1,1,1,CloakCond},    -- PK Cloak
[36426778] = {1,1,1,1,5,1,1,1,1,1,BootsCond},    -- PK Boots

[03298689] = {9,1,1,1,1,1,1,1,1,1,LaunchCond},   -- PK Launch (Rank-Up)
[25542642] = {6,2,1,1,1,1,1,1,1,1,FogBladeCond}, -- PK Fog Blade

[81275020] = {9,1,5,1,1,1,1,1,1,1},              -- Speedroid Terrortop
[53932291] = {8,1,1,1,1,1,1,1,1,1},              -- Speedroid Taketomborg

[73680966] = {5,1,1,1,1,1,1,1,1,1,TBOTECond},    -- The Beginning of the End
[62835876] = {9,1,1,1,5,1,1,1,1,1,GECond},       -- BA Good&Evil
[36006208] = {8,2,1,1,4,1,1,1,1,1,FireLakeCond}, -- BA Fire Lake
[20036055] = {4,2,1,1,3,1,1,1,1,1,},             -- BA Traveler
[63356631] = {1,1,1,1,1,1,1,1,1,1,PWWBCond},     -- PWWB
[71587526] = {1,1,1,1,1,1,1,1,1,1,KarmaCutCond}, -- Karma Cut
[20513882] = {1,1,1,1,1,1,1,1,1,1},              -- Painful Escape

[00601193] = {1,1,10,1,1,1,1,1,1,1,VirgilCond},  -- BA Virgil
[72167543] = {1,1,1,1,1,1,1,1,1,1},              -- Downerd Magician
[81330115] = {1,1,1,1,1,1,1,1,1,1},              -- Acid Golem of Destruction
[31320433] = {1,1,1,1,1,1,1,1,1,1},              -- Nightmare Shark
[47805931] = {1,1,1,1,1,1,1,1,1,1},              -- Giga-Brillant
[75367227] = {1,1,1,1,1,1,1,1,1,1},              -- Ghostrick Alucard
[68836428] = {1,1,1,1,1,1,1,1,1,1},              -- Tri-Edge Levia
[52558805] = {1,1,1,1,1,1,1,1,1,1},              -- Temptempo the Percussion Djinn
[78156759] = {1,1,1,1,1,1,1,1,1,1},              -- Wind-Up Zenmaines
[83531441] = {1,1,9,1,5,2,1,1,5,1,DanteCond},    -- BA Dante
[16259549] = {1,1,1,1,1,1,1,1,1,1},              -- Fortune Tune
[26563200] = {1,1,1,1,1,1,1,1,1,1},              -- Muzurythm the String Djinn
[27552504] = {1,1,1,1,1,1,1,1,1,1},              -- Beatrice, the Eternal Lady
[18386170] = {1,1,1,1,1,1,1,1,1,1},              -- Dante, Pilgrim of the Burning Abyss
[65305468] = {1,1,1,1,1,1,1,1,1,1},              -- Number F0 Utopic Future
[01621413] = {1,1,1,1,1,1,1,1,1,1},              -- Requiem Dragon
[16195942] = {1,1,1,1,1,1,1,1,1,1},              -- Rebellion Dragon
[62709239] = {1,1,1,1,1,1,1,1,1,1,BreakSwordCond}, -- PK Break Sword
[85252081] = {1,1,1,1,1,1,1,1,1,1},              -- Super Quantum Granpulse
[95992081] = {1,1,1,1,1,1,1,1,1,1},              -- Leviair
}
function SSBA(c)
  return #AIST()==0 
  and (c == nil or OPTCheck(c.id)) 
  and CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and DualityCheck()
  and (FieldCheck(3)==1 or FieldCheck(3)==0 
  and CardsMatchingFilter(AIHand(),BAMonsterFilter)>1)
  and OverExtendCheck(3)
  and CardsMatchingFilter(AIMon(),FilterID,83531441)<2 -- Dante
end
function TourguideFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and bit32.band(c.race,RACE_FIEND)>0 and c.level==3
end
function SummonTourguide()
  return CardsMatchingFilter(UseLists({AIDeck(),AIHand()}),TourguideFilter)>1 
  and DualityCheck()
  and (DeckCheck(DECK_BA) 
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  or not DeckCheck(DECK_BA) 
  and HasID(AIExtra(),83531441,true))
end
function SummonCir()
  return  CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and OverExtendCheck(3) and (FieldCheck(3)==1 or CardsMatchingFilter(AIMon(),BAMonsterFilter)==1) 
  --and CardsMatchingFilter(AIGrave(),BAMonsterFilter,57143342)>0 and OPTCheck(57143342)
end
function SummonGraff()
  return  CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and OverExtendCheck(3) 
  and (FieldCheck(3)==1 
  or CardsMatchingFilter(AIMon(),BAMonsterFilter)==1) 
  --and CardsMatchingFilter(AIDeck(),BAMonsterFilter,20758643)>0 and OPTCheck(20758643)
end
function SummonScarm()
  return CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and OverExtendCheck(3) and (FieldCheck(3)==1 or CardsMatchingFilter(AIMon(),BAMonsterFilter)==1) 
  --and CardsMatchingFilter(AIDeck(),ScarmDeckFilter)>0 and OPTCheck(84764038)
end
function SummonBA(c)
  return (FieldCheck(3)==1 or CardsMatchingFilter(AIHand(),BAMonsterFilter,c)>0)
  and CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and OverExtendCheck(3)
  and CardsMatchingFilter(AIMon(),FilterID,83531441)<2 -- Dante
end
function SummonRubic()
  return FieldCheck(3)==1 and CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and not HasID(AIMon(),00734741,true) and SummonVirgil()
end
function VirgilFilter(c)
  return Targetable(c,TYPE_MONSTER) and Affected(c,TYPE_MONSTER,6) and FilterLocation(c,LOCATION_ONFIELD)
end
function SummonVirgil()
  return (CardsMatchingFilter(OppField(),VirgilFilter)>0 and CardsMatchingFilter(AIHand(),BAFloater)>0
  or HasID(AIMon(),83531441,true) and not HasID(AIGrave(),00601193,true))
  and not HasID(AIMon(),00601193,true)
end
function UseVirgil()
  local targets = CardsMatchingFilter(OppField(),VirgilFilter)
  return HasPriorityTarget(OppField(),false,nil,VirgilFilter) or targets>0 and PriorityCheck(AIHand(),PRIO_TOGRAVE,1,BAFilter)>3
end
function SSGraff()
  return CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and CardsMatchingFilter(AIMon(),BAMonsterFilter)==1
end
function SSCir()
  return CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and CardsMatchingFilter(AIMon(),BAMonsterFilter)==1
end
function SSScarm()
  return CardsMatchingFilter(AIMon(),NotBAMonsterFilter)==0 
  and CardsMatchingFilter(AIMon(),BAMonsterFilter)==1
  and CardsMatchingFilter(AIGrave(),ScarmGraveFilter)==0
end
function SummonDanteBA()
  return OppGetStrongestAttDef()<2500
  or not HasID(AIMon(),83531441,true)
end
function SetBA()
  return #AIMon() == 0 and DeckCheck(DECK_BA)
end
function SetCir()
  return SetBA() and CardsMatchingFilter(AIGrave(),BAMonsterFilter,57143342)>0
end
function UseGE()
  return PriorityCheck(AIHand(),PRIO_TOGRAVE,1,BAFilter)>3
end
function SummonGigaBrillant()
  return CardsMatchingFilter(AIMon(),BASelfDestructFilter)<3 and #AIMon()>3
  and BattlePhaseCheck()
end
function AlucardFilter(c)
  return FilterPosition(c,POS_FACEDOWN) and DestroyFilter(c)
end
function UseAlucard()
  return CardsMatchingFilter(OppField(),AlucardFilter)>0
end
function SummonAlucard()
  return CardsMatchingFilter(AIMon(),BASelfDestructFilter)<3 
  and UseAlucard() and DeckCheck(DECK_BA)
end
function SummonLevia()
  return CardsMatchingFilter(AIMon(),BASelfDestructFilter)<4
end
function TemtempoFilter(c)
  return FilterType(c,TYPE_XYZ) 
  and c.xyz_material_count>0 
  and Targetable(c,TYPE_MONSTER) 
  and Affected(c,3)
end
function UseTemtempo()
  return CardsMatchingFilter(OppMon(),TemtempoFilter)>0
end
function SummonTemtempo()
  return CardsMatchingFilter(AIMon(),BASelfDestructFilter)<3 and UseTemtempo()
end
function MuzurythmFilter(c)
  return c.attack>=2500 and c.attack<3000 
  and not FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
  and not FilterAffected(c,EFFECT_INDESTRUCTABLE_BATTLE)
end
function SummonMuzurythm()
  return CardsMatchingFilter(AIMon(),BASelfDestructFilter)<3 and CardsMatchingFilter(OppMon(),MuzurythmFilter)>0
  and GlobalBPAllowed and Duel.GetCurrentPhase == PHASE_MAIN1
end
function SummonNightmareShark()
  return CardsMatchingFilter(AIMon(),BASelfDestructFilter)<3 
  and GlobalBPAllowed and Duel.GetCurrentPhase() == PHASE_MAIN1 
  and AI.GetPlayerLP(2)<=4000
  and DeckCheck(DECK_BA)
end
function SummonDownerd()
  if CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0 
  and HasID(AIMon(),83531441,true,DisabledDanteFilter)
  and Duel.GetCurrentPhase()==PHASE_MAIN2
  then
    GlobalSSCardID = 72167543
    return true
  end
end
function SummonZenmainesBA()
  return false -- temp
end
function SummonFortuneTune()
  return false -- temp
end
function RepoDante(c)
  return FilterPosition(c,POS_DEFENSE)
  and BattlePhaseCheck()
  and (#OppMon()==0 or OppGetStrongestAttDef()<=c.attack)
  and NotNegated(c)
  or FilterPosition(c,POS_FACEUP_ATTACK)
  and (Negated(c)
  or TurnEndCheck()
  or OppGetStrongestAttDef()>=1000 
  and OppHasStrongestMonster())
end
function DisabledDanteFilter(c)
  return FilterAffected(c,EFFECT_DISABLE_EFFECT)
  or FilterAffected(c,EFFECT_DISABLE)
  or FilterAffected(c,EFFECT_CANNOT_ATTACK)
  or TurnEndCheck() and FilterPosition(c,POS_FACEUP_ATTACK)
  or c.xyz_material_count==0 and (c.attack<2500 or TurnEndCheck())
end
function BeatriceDiscardFilter(c)
  return BAMonsterFilter(c)
  -- and 
end
function SummonBeatrice(c,mode)
  if mode == 1 
  and HasID(AIMon(),83531441,true,DisabledDanteFilter)
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)<2
  --and CardsMatchingFilter(AIHand(),BeatriceDiscardFilter)>0
  then
    GlobalSSCardID = c.id
    return true
  end
  if mode == 2
  and HasID(AIMon(),83531441,true)
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)<1
  and PriorityCheck(AIHand(),PRIO_TOGRAVE,1,BeatriceDiscardFilter)>3
  and MP2Check(2500)
  then
    GlobalSSCardID = c.id
    return true
  end
end
function SummonF0(c,mode) 
  if (F0Check(c,OppMon(),2500) 
  and CardsMatchingFilter(AIMon(),FilterID,83531441)>1
  or F0Check(c,OppMon())
  and CardsMatchingFilter(AIMon(),DisabledDanteFilter)>1
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)<2
  and OppHasStrongestMonster())
  and BattlePhaseCheck()
  and mode == 1
  then
    GlobalSSCardID = c.id
    return true
  end
  if OppHasStrongestMonster()
  and F0Check(c,OppMon())
  and BattlePhaseCheck()
  and mode == 2
  then
    GlobalSSCardID = c.id
    return true
  end
  return false
end
function RepoF0(c)
  return FilterPosition(c,POS_DEFENSE)
  and NotNegated(c)
  or FilterPosition(c,POS_FACEUP_ATTACK)
  and Negated(c)
end
function UsePainfulEscape(c)
  local cards = UseLists(AIDeck(),AIGrave())
  local targets = {}
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if CardsMatchingFilter(cards,PainfulEscapeFilter,c)>0 then
      targets[#targets+1]=c
    end
  end
  if PriorityCheck(targets,PRIO_TOGRAVE,1)>4
  then
    return true
  end
  return false
end
function SummonPKGlove(c,mode)
  if mode == 1 -- Boots in hand
  and BAXYZSummonCheck(0)
  and HasID(AIHand(),36426778,true)
  then
    return true
  end
  if mode == 2 -- Level 3 on field
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  and BAXYZSummonCheck(1)
  then
    return true
  end
end
function UsePKGlove(c,mode)
  if mode == 1
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  and (CardsMatchingFilter(AIGrave(),PKFilter,62709239)>2 
  and BAXYZSummonCheck(0)
  or CardsMatchingFilter(AIGrave(),PKFilter,62709239)>1
  and BAXYZSummonCheck())
  and HasID(AIDeck(),25542642,true,FilterOPT,true) -- Fog Blade
  and not HasID(AIGrave(),25542642,true) -- Fog Blade
  and MacroCheck()
  then
    GlobalPKGloveID = 25542642 -- Fog Blade
    return true
  end
  if mode == 2
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  and HasID(AIDeck(),90432163,true,FilterOPT,true) -- PK Cloak
  and CardsMatchingFilter(AIMon(),TPKFilter)>0
  and (HasID(AIDeck(),36426778,true,FilterOPT,true) -- PK Boots
  or NormalSummonCheck())
  and BAXYZSummonCheck()
  and MacroCheck()
  then
    GlobalPKGloveID = 90432163 -- PK Cloak
    return true
  end
  if mode == 3
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  and HasID(AIDeck(),90432163,true,FilterOPT,true) -- PK Cloak
  and HasID(AIDeck(),36426778,true,FilterOPT,true) -- PK Boots
  and HasID(AIGrave(),25542642,true,FilterOPT,true) -- Fog Blade
  and CardsMatchingFilter(AIGrave(),PKFilter,62709239)>2
  and BAXYZSummonCheck(0)
  and MacroCheck()
  then
    GlobalPKGloveID = 90432163 -- PK Cloak
    return true
  end
  if mode == 4
  and HasID(AIDeck(),90432163,true,UsePKCloak)
  and not HasID(AIGrave(),90432163,true)
  and MacroCheck()
  then
    GlobalPKGloveID = 90432163 -- PK Cloak
    return true
  end
  if mode == 5
  and HasID(AIDeck(),36426778,true,UsePKBoots,0)
  and not HasID(AIGrave(),36426778,true)
  and MacroCheck()
  then
    GlobalPKGloveID = 36426778 -- PK Boots
    return true
  end
end
function SummonPKCloak(c,mode)
  if mode == 1 -- Boots in hand
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  and BAXYZSummonCheck(0)
  and HasID(AIHand(),36426778,true)
  then
    return true
  end
  if mode == 2 -- Level 3 on field
  and BAXYZSummonCheck()
  then
    return true
  end
end
function UsePKCloak(c,mode)
  return CardsMatchingFilter(AIGrave(),PKFilter,62709239)>2
  or (CardsMatchingFilter(AIHand(),PKMonsterFilter)==1
  and NormalSummonsAvailable()>0
  or CardsMatchingFilter(AIMon(),PKMonsterFilter)==1)
  and HasIDNotNegated(AIDeck(),36426778,true,FilterOPT)
  and BAXYZSummonCheck(0)
end
function SummonPKBoots(c,mode)
  if mode == 1 -- Special Summon
  and BAXYZSummonCheck()
  then
    OPTSet(c.id)
    return true
  end
  if mode == 2 -- another Boots in hand
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  and BAXYZSummonCheck(0)
  and HasID(AIHand(),36426778,true,CardsNotEqual,c)
  then
    return true
  end
  if mode == 3 -- Level 3 on field
  and BAXYZSummonCheck()
  then
    return true
  end
end
function UsePKBoots(c,mode)
  if (mode == 1 or mode == 0)
  and HasID(AIMon(),16195942,true,FilterMaterials,0) -- Rebellion Dragon
  and DualityCheck()
  and HasIDNotNegated(AIDeck(),03298689,true) -- PK Launch
  and HasIDNotNegated(AIExtra(),01621413,true) -- Requiem Dragon
  then
    OPTSet(364267781)
    return true
  end
  if (mode == 2 or mode == 0)
  and TurnEndCheck()
  and HasID(AIDeck(),25542642,true) -- PK Fog Blade
  then  
    OPTSet(364267781)
    return true
  end
end
function UsePKLaunch(c,mode)
  if mode == 1
  and HasID(AIMon(),16195942,true,FilterMaterials,0) -- Rebellion Dragon
  and HasIDNotNegated(AIExtra(),01621413,true) -- Requiem Dragon
  then 
    return true
  end
end
function UsePKFogBlade(c,mode)
  if FilterLocation(c,LOCATION_GRAVE) then
    if mode == 1 
    and BAXYZSummonCheck(1)
    then
      return true
    end
    if mode == 2
    and BAXYZSummonCheck(0)
    and (CardsMatchingFilter(AIHand(),PKNonXYZFilter)>0
    and not NormalSummonCheck()
    or HasID(AIHand(),36426778,FilterOPT,true))
    then
      return true
    end
    if mode == 3
    and HasID(AIGrave(),62709239,true,FilterRevivable) -- BK Break Sword
    and (HasIDNotNegated(AICards(),03298689,true) -- PK Launch
    or HasIDNotNegated(AIDeck(),03298689,true) -- PK Launch
    and (HasID(AIGrave(),36426778,true,FilterOPT) -- PK Boots
    or HasID(AIGrave(),63821877,true))) -- PK Glove
    then
      GlobalCardMode = 1
      GlobalTargetSet = FindID(62709239,AIGrave())
      return true
    end
  end
end
function PKBreakSwordFodder(c)
  if c.id == 83531441 -- Dante
  and FilterMaterials(c,0)
  and (FilterAttackMax(1000)
  or FilterPosition(c,POS_FACEUP_ATTACK)
  and not BattlePhaseCheck())
  then
    return true
  end
  if c.id == 25542642 -- PK Fog Blade
  and CardTargetCheck(c)==0
  then
    return true
  end
  if FilterCrippled(c) then
    return true
  end
end
function PKBreakSwordFilter(c,prio)
  return Affected(c,TYPE_MONSTER,3)
  and Targetable(c,TYPE_MONSTER)
  and DestroyFilter(c)
  and (not prio or FilterPriorityTarget(c))
end
function SummonPKBreakSword(c,mode)
  if mode == 1 -- Rank-Up play
  and OppHasStrongestMonster()
  and CardsMatchingFilter(UseLists(AIMon(),AIGrave()),PKNonXYZFilter)>1
  and HasID(UseLists(AIMon(),AIGrave()),36426778,true)
  and CardsMatchingFilter(OppCards(),PKBreakSwordFilter)>0
  and #OppCards()>1
  and HasIDNotNegated(UseLists(AIDeck(),AIST(),AIHand()),03298689,true) -- PK Launch
  and HasIDNotNegated(AIExtra(),16195942,true) -- Rebellion Dragon
  and HasIDNotNegated(AIExtra(),01621413,true) -- Requiem Dragon
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(OppCards(),PKBreakSwordFilter,true)>0
  then 
    return true
  end
  if mode == 3
  and CardsMatchingFilter(OppCards(),PKBreakSwordFilter)>0
  and MP2Check(c)
  and CardsMatchingFilter(AICards,PKBreakSwordFodder)>0
  then
    return true
  end
end
function UsePKBreakSword(c,mode)
  if mode == 1 -- Rank-Up play
  and CardsMatchingFilter(UseLists(c.xyz_materials,AIGrave()),PKNonXYZFilter)>1
  and #OppMon()>0
  and #OppField()>1
  and MacroCheck()
  and DestroyCheck(OppField())>0
  and HasIDNotNegated(AIExtra(),16195942,true) -- Rebellion Dragon
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(OppCards(),PKBreakSwordFilter,true)>0
  then 
    return true
  end
  if mode == 3
  and CardsMatchingFilter(OppCards(),PKBreakSwordFilter)>0
  and CardsMatchingFilter(AICards,PKBreakSwordFodder)>0
  then
    return true
  end
end
function SummonRebellionBA(c,mode)
  return true
end
function GrampulseFilter(c)
  return DestroyFilter(c) 
  and Affected(c,TYPE_MONSTER,3)
  and Targetable(c,TYPE_MONSTER)
end
function SummonGrampulse(c,mode)
  if mode == 1 
  and CardsMatchingFilter(OppST(),GrampulseFilter)>0
  then
    return true
  end 
end
function UseGrampulse(c,mode)
  if mode == 1 
  and CardsMatchingFilter(OppST(),GrampulseFilter)>0
  then
    return true
  end 
end
function SummonLeviairBA(c,mode)
  if mode == 1
  and FieldCheck(3)==3
  and CardsMatchingFilter(AIBanish(),PKNonXYZFilter)>0
  then
    return true
  end
end
function UseLeviair(c,mode)
  if mode == 1
  and CardsMatchingFilter(AIBanish(),FilterLevel,3)>0
  then
    return true
  end
end
function UseAllureBA(c,mode)
  if mode == 1 then
    return CardsMatchingFilter(SubGroup(AIHand(),FilterAttribute,ATTRIBUTE_DARK),ExcludeID,57143342)>0
  end
end
function BAInit(cards)
  GlobalPreparation = nil
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  
  if HasID(Act,85252081,UseGrampulse,1) then
    return Activate()
  end
  if HasID(SpSum,81275020,SummonTerrortop,1) then
    return SpSummon()
  end

  if HasID(Act,03298689,UsePKLaunch,1) then
    return Activate()
  end
  if HasID(Act,36426778,UsePKBoots,1) then
    return Activate()
  end
  if HasID(Act,63821877,UsePKGlove,1) then
    return Activate()
  end
  if HasID(Act,70368879) and not HasID(AIMon(),31320433,true) then -- Upstart
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,62709239,UsePKBreakSword,1) then
    return Activate()
  end
  if HasID(Act,62709239,UsePKBreakSword,2) then
    return Activate()
  end
  if HasID(Act,62709239,UsePKBreakSword,3) then
    return Activate()
  end
  if HasID(Act,73680966) then -- The Beginning of the End
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,75367227) and UseAlucard() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,52558805) and UseTemtempo() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,00601193) and UseVirgil() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,62709239,SummonPKBreakSword,1) then
    return SpSummon()
  end
  if HasID(SpSum,00601193) and SummonVirgil() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,85252081,SummonLeviairBA,1) then
    return SpSummon()
  end
  if HasID(Act,83531441,UseDante) then
    GlobalActivatedCardID = 83531441
    return Activate()
  end
  if HasID(SpSum,83531441) and SummonDanteBA() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,65305468,SummonF0,1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,27552504,SummonBeatrice,1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,27552504,SummonBeatrice,2) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,62709239,SummonPKBreakSword,2) then
    return SpSummon()
  end
  if HasID(SpSum,62709239,SummonPKBreakSword,3) then
    return SpSummon()
  end
  if HasID(SpSum,16195942,SummonRebellionBA,1) then
    return SpSummon()
  end
  if HasID(SpSum,31320433) and SummonNightmareShark() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,47805931) and SummonGigaBrillant() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,75367227) and SummonAlucard() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,68836428) and SummonLevia() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,52558805) and SummonTemtempo() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
   if HasID(SpSum,26563200) and SummonMuzurythm() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,85252081,SummonGrampulse,1) then
    return SpSummon()
  end
  if HasID(Act,62835876,false,nil,LOCATION_HAND) then -- Good & Evil
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,53932291,SummonTaketomborg,1) 
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  then
    return SpSummon()
  end
  if HasID(Sum,81275020,SummonTerrortop,2) 
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  then
    return Summon()
  end
  if HasID(Sum,81275020,SummonTerrortop,3) 
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  then
    return Summon()
  end
  if HasID(Sum,53932291,SummonTaketomborg,2) 
  and CardsMatchingFilter(AIMon(),BASelfDestructFilter)==0
  then
    return Summon()
  end
  if HasID(Sum,10802915) and SummonTourguide() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,25542642,UsePKFogBlade,1) then
    return Activate()
  end
  if HasID(Act,25542642,UsePKFogBlade,2) then
    return Activate()
  end
  if HasID(SpSum,36426778,SummonPKBoots,1) then
    return SpSummon()
  end
  if HasID(Sum,63821877,SummonPKGlove,1) then
    return Summon()
  end
  if HasID(Sum,90432163,SummonPKCloak,1) then
    return Summon()
  end
  if HasID(Sum,63821877,SummonPKGlove,2) then
    return Summon()
  end
  if HasID(Sum,90432163,SummonPKCloak,2) then
    return Summon()
  end
  if HasID(Sum,36426778,SummonPKBoots,2) then
    return Summon()
  end
  if HasID(Sum,36426778,SummonPKBoots,3) then
    return Summon()
  end
  if HasID(Act,63821877,UsePKGlove,2) then
    return Activate()
  end
  if HasID(Act,63821877,UsePKGlove,3) then
    return Activate()
  end
  if HasID(Act,63821877,UsePKGlove,4) then
    return Activate()
  end
  if HasID(Act,90432163,UsePKCloak,1) then
    return Activate()
  end
  if HasID(Act,62835876,false,nil,LOCATION_GRAVE) and UseGE() then -- Good & Evil
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,81439173) then -- Foolish
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,00734741,false,nil,LOCATION_HAND) and SummonRubic() then -- Rubic
    OPTSet(00734741)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,20758643) and SummonGraff() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,57143342) and SummonCir() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,84764038) and SummonScarm() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,81992475,false,nil,LOCATION_HAND,SSBA)  -- Barbar
  and not BarbarFinish(AIHand())
  then
    OPTSet(81992475)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,73213494,false,nil,LOCATION_HAND,SSBA) then -- Calcab
    OPTSet(73213494)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,47728740,false,nil,LOCATION_HAND,SSBA) then -- Alich
    OPTSet(47728740)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,62957424,false,nil,LOCATION_HAND,SSBA) then -- Libic
    OPTSet(62957424)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,36553319,false,nil,LOCATION_HAND,SSBA) then -- Farfa
    OPTSet(36553319)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,09342162,false,nil,LOCATION_HAND,SSBA) then -- Cagna
    OPTSet(09342162)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,00734741,false,nil,LOCATION_HAND,SSBA) then -- Rubic
    OPTSet(00734741)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,800734741) and SummonRubic() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,36553319,SummonBA) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,09342162,SummonBA) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,62957424,SummonBA) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,81992475,SummonBA) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,73213494,SummonBA) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,47728740,SummonBA) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,20513882,UsePainfulEscape) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,00734741,SummonBA) then
    return Activate()
  end
  if HasID(Act,84764038,false,nil,LOCATION_HAND) and SSScarm(Act[CurrentIndex]) then
    OPTSet(84764038)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end  
  if HasID(Act,20758643,false,nil,LOCATION_HAND) and SSGraff(Act[CurrentIndex]) then
    OPTSet(20758643)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,57143342,false,nil,LOCATION_HAND) and SSCir(Act[CurrentIndex]) then
    OPTSet(57143342)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,84764038,false,nil,LOCATION_HAND,SSBA) then -- Scarm
    OPTSet(84764038)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,57143342,false,nil,LOCATION_HAND,SSBA) then -- Cir
    OPTSet(57143342)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,65305468,SummonF0,2) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Act,63821877,UsePKGlove,5) then
    return Activate()
  end
  if HasID(Act,36426778,UsePKBoots,2) then
    return Activate()
  end
  if HasID(Act,01475311,UseAllureBA,1) then
    return Activate()
  end
  if HasID(SetMon,57143342) and SetCir() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,20758643) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,84764038) and SetBA()then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,73213494) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,81992475) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,36553319) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,09342162) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,62957424) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,47728740) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,00734741) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,57143342) and SetBA() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SpSum,72167543) and SummonDownerd() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,78156759) and SummonZenmainesBA() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,16259549) and SummonFortuneTune() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Act,47805931) then -- Giga-Brillant
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Rep,83531441,RepoDante) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,65305468,RepoF0) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  return nil
end
function FireLakeTarget(cards,min,max)
  local count = 0
  for i=1,#cards do
    if CurrentOwner(cards[i])==1 and bit32.band(cards[i].setcode,0xb1)>0 then
      count = count +1
    end
  end 
  if count == #cards then
    return Add(cards,PRIO_TOGRAVE,max)
  else
    return BestTargets(cards,math.min(CardsMatchingFilter(cards,FireLakeFilter),max),TARGET_DESTROY)
  end
end
function PWWBTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_TODECK)
end
function KarmaCutTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_BANISH)
end
function VirgilTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_TODECK,VirgilFilter)
end
function MalacodaTarget(cards,c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return BestTargets(cards,1,TARGET_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards)
end
function GETarget(cards,c)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards,PRIO_TOHAND)
end
function AlucardTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function TemtempoTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_OTHER)
end
function BeatriceSummonTarget(cards)
  if LocCheck(cards,LOCATION_ONFIELD) then
    GlobalSSCardID = nil
    return Add(cards,PRIO_TOGRAVE,1,DisabledDanteFilter)
  elseif LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
end
function BeatriceTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    if GlobalBeatriceID 
    and HasID(c.xyz_materials,GlobalBeatriceID,true)
    then
      local id = GlobalBeatriceID
      GlobalBeatriceID = nil
      return Add(cards,PRIO_TOGRAVE,1,FilterID,id)
    else
      return Add(cards,PRIO_TOGRAVE)
    end
  elseif LocCheck(cards,LOCATION_DECK) then
    if GlobalBeatriceID then
      local id = GlobalBeatriceID
      GlobalBeatriceID = nil
      return Add(cards,PRIO_TOGRAVE,1,FilterID,id)
    else
      return Add(cards,PRIO_TOGRAVE)
    end
  elseif LocCheck(cards,LOCATION_EXTRA) then
    return Add(cards,PRIO_TOFIELD,1,FilterID,18386170)
  end
  return Add(cards,PRIO_TOGRAVE)   
end
function DownerdSummonTarget(cards)
  if LocCheck(cards,LOCATION_ONFIELD) then
    GlobalSSCardID = nil
    return Add(cards,PRIO_TOGRAVE,1,DisabledDanteFilter)
  end
end
GlobalPilgrimID = nil
function PilgrimTarget(cards)
  if GlobalPilgrimID then
    local id = GlobalPilgrimID
    GlobalPilgrimID = nil
    return Add(cards,PRIO_TOGRAVE,1,FilterID,id)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function BarbarTarget(cards,max)
  return Add(cards,PRIO_BANISH,max)
end
GlobalGriefingID = nil
function FiendGriefingTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    if GlobalCardMode == 1 then
      GlobalCardMode = nil
      return GlobalTargetGet(cards,true)
    end
    return BestTargets(cards,1,TARGET_TODECK)
  elseif LocCheck(cards,LOCATION_DECK) then
    if GlobalGriefingID then
      local id = GlobalGriefingID
      GlobalGriefingID = nil
      return Add(cards,PRIO_TOGRAVE,1,FilterID,id)
    end
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards)
end
function TravelerTarget(cards,max)
  return Add(cards,PRIO_TOFIELD,max)
end
function F0SummonTarget(cards,min)
  GlobalSSCardID = nil
  return Add(cards,PRIO_TOGRAVE,min,DisabledDanteFilter)
end
function F0Target(cards)
  GlobalActivatedCardID = nil
  return Add(cards,PRIO_TOGRAVE)
end
function F0Filter(c,atk)
  return Affected(c,TYPE_MONSTER,1)
  and not FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
  and (not atk or c.attack>atk and not Targetable(c,TYPE_MONSTER))
end
function F0Check(c,targets,atk)
  return NotNegated(c) 
  and CardsMatchingFilter(targets,F0Filter,atk)>0
  and (FilterLocation(c,LOCATION_EXTRA) 
  or Duel.GetLocationCount(player_ai,LOCATION_MZONE)>0)
end
function PainfulEscapeTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards)
end
function RankUpCheck(mode)
  if mode == 1 -- Break Sword target selection
  and HasIDNotNegated(AIExtra(),16195942,true) -- Rebellion Dragon
  and HasIDNotNegated(AIExtra(),01621413,true) -- Requiem Dragon
  and (HasIDNotNegated(UseLists(AIHand(),AIST()),03298689,true) -- PK Launch
  or HasID(UseLists(AIMaterials(),AIGrave()),36426778,true,FilterOPT,364267781) -- PK Boots
  and HasIDNotNegated(AIDeck(),03298689,true)) -- PK Launch
  and MacroCheck()
  and DualityCheck()
  then
    return true
  end
  return false -- TODO
end
function BreakSwordTarget(cards,min)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOFIELD,min)
  end
  if RankUpCheck(1) then
    if FilterController(cards[1],1) then
      return Add(cards,PRIO_TOGRAVE,1,FilterID,62709239) -- PK Break Sword
    else
      if #OppMon()==1 and DestroyCheck(OppField())>1 then
        return BestTargets(cards,1,TARGET_DESTROY,FilterType,TYPE_SPELL+TYPE_TRAP)
      end
      return BestTargets(cards,1,TARGET_DESTROY)
    end
  end
  if FilterController(cards[1],1) then
    return Add(cards,PRIO_TOGRAVE)
  else
    return BestTargets(cards,1,TARGET_DESTROY)
  end
end
function PKGloveTarget(cards)
  local id = GlobalPKGloveID
  if id then
    GlobalPKGloveID = nil
    return Add(cards,PRIO_TOGRAVE,1,FilterID,id)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function PKBootsTarget(cards)
  return Add(cards)
end
function PKCloakTarget(cards)
  return Add(cards,1,PRIO_TOHAND,FilterType,TYPE_MONSTER)
end
function GrampulseTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function LeviairTargetBA(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards,PRIO_TOFIELD,1,PKNonXYZFilter)
end
function BACard(cards,min,max,id,c)
  if not c and GlobalSSCardID == 27552504 then
    return BeatriceSummonTarget(cards)
  end
  if not c and GlobalSSCardID == 72167543 then
    return DownerdSummonTarget(cards)
  end
  if not c and GlobalSSCardID == 65305468 then
    return F0SummonTarget(cards,min)
  end
  if GlobalActivatedCardID == 65305468 then
    return F0Target(cards)
  end
  if c then
    id = c.id
  end
  if id == 63821877 then
    return PKGloveTarget(cards,min)
  end
  if id == 95992081 then
    return LeviairTargetBA(cards)
  end
  if id == 85252081 then
    return GrampulseTarget(cards)
  end
  if id == 36426778 then
    return PKBootsTarget(cards,min)
  end
  if id == 62709239 then
    return BreakSwordTarget(cards,min)
  end
  if id == 60743819 then
    return FiendGriefingTarget(cards)
  end
  if id == 20036055 then
    return TravelerTarget(cards,max)
  end
  if id == 81992475 then
    return BarbarTarget(cards,max)
  end
  if id == 27552504 then
    return BeatriceTarget(cards,c)
  end
  if id == 18386170 then
    return PilgrimTarget(cards,c)
  end
  if id == 20758643 then
    return Add(cards,PRIO_TOFIELD)
  end
  if id == 57143342 then
    return Add(cards,PRIO_TOFIELD)
  end
  if id == 73213494 then
    return BestTargets(cards,1,TARGET_TOHAND)
  end
  if id == 47728740 then
    return BestTargets(cards,1,TARGET_TOGRAVE)
  end
  if id == 84764038 then
    return Add(cards)
  end
  if id == 36006208 then
    return FireLakeTarget(cards,min,max)
  end
  if id == 63356631 then
    return PWWBTarget(cards)
  end
  if id == 71587526 then
    return KarmaCutTarget(cards)
  end
  if id == 00601193 then
    return VirgilTarget(cards)
  end
  if id == 36553319 then
    return BestTargets(cards,1,TARGET_BANISH) 
  end
  if id == 09342162 then
    return Add(cards,PRIO_TOGRAVE)
  end
  if id == 62957424 then
    GlobalSummonNegated = true
    return Add(cards,PRIO_TOFIELD,1,BAMonsterFilter)
  end
  if id == 35330871 then
    return MalacodaTarget(cards,c)
  end
   if id == 62835876 then
    return GETarget(cards,c)
  end
  if id == 47805931 or id == 81330115 
  or id == 31320433 or id == 26563200
  then
    return Add(cards,PRIO_TOGRAVE)
  end
  if id == 75367227 then
    return AlucardTarget(cards)
  end
  if id == 68836428 then
    return LeviaTarget(cards)
  end
  if id == 52558805 then
    return TemtempoTarget(cards)
  end
  if id == 16195942 then -- Dark Rebellion Dragon
    return BestTargets(cards,min)
  end
  if id == 20513882 then
    return PainfulEscapeTarget(cards)
  end
  if id == 90432163 then
    return PKCloakTarget(cards)
  end
  return nil
end
function ChainAlich(c)
  return FilterLocation(c,LOCATION_GRAVE) and CardsMatchingFilter(OppMon(),AlichFilter)>0
end
function FireLakeFilter(c)
  return DestroyFilter(c,true) and Targetable(c,TYPE_TRAP) 
  and Affected(c,TYPE_TRAP) and CurrentOwner(c)==2
end
function FireLakeFilter2(c)
  return FireLakeFilter(c) and PriorityTarget(c,true)
end
function ChainFireLake()
  local targets = CardsMatchingFilter(OppField(),FireLakeFilter)
  local targets2 = CardsMatchingFilter(OppField(),FireLakeFilter2)
  if RemovalCheck(36006208) and targets>1 or targets2>0 then
    return true
  end
  if not UnchainableCheck(36006208) then
    return false
  end
  if targets>2 or targets2>1 or targets>1 and targets2>0 then
    return true
  end
  return false
end
function KarmaCutFilter(c)
  return Targetable(c,TYPE_TRAP) and Affected(c,TYPE_TRAP)
end
function KarmaCutFilter2(c)
  return KarmaCutFilter(c) and (PriorityTarget(c) or CardsMatchingFilter(OppGrave(),FilterID,c.id)>0)
end
function ChainKarmaCut()
  local targets = CardsMatchingFilter(OppMon(),KarmaCutFilter)
  local targets2 = CardsMatchingFilter(OppMon(),KarmaCutFilter2)
  local discard = PriorityCheck(AIHand(),PRIO_TOGRAVE,1)>3
  if RemovalCheck(71587526) and targets>0 then
    return discard
  end
  if not UnchainableCheck(71587526) then
    return false
  end
  if targets2>0 then
    return discard
  end
  return false
end
function PWWBFilter(c)
  return Targetable(c,TYPE_TRAP) and Affected(c,TYPE_TRAP)
end
function PWWBFilter2(c)
  return PWWBFilter(c) and PriorityTarget(c)
end
function ChainPWWB()
  local targets = CardsMatchingFilter(OppField(),PWWBFilter)
  local targets2 = CardsMatchingFilter(OppField(),PWWBFilter2)
  local discard = PriorityCheck(AIHand(),PRIO_TOGRAVE,1)>3
  if RemovalCheck(63356631) and targets>0 then
    return discard
  end
  if not UnchainableCheck(63356631) then
    return false
  end
  if targets2>0 then
    return discard
  end
  if targets>0 and SignCheck(AIHand()) 
  and Duel.GetCurrentPhase()==PHASE_END
  and Duel.GetTurnPlayer()==1-player_ai
  then
    return true
  end
end
function ChainFarfa()
  return CardsMatchingFilter(OppMon(),FarfaFilter)>0
end
function ChainLibic(c)
  return CardsMatchingFilter(AIHand(),LibicFilter,c)>0
end
GlobalBeatriceID = nil
function ChainBeatrice(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  elseif FilterLocation(c,LOCATION_ONFIELD) then
    if RemovalCheckCard(c) or NegateCheckCard(c) then
      return true
    end
    if (BarbarFinish(AIDeck()) and NotNegated(c)
    or BarbarFinish(c.xyz_materials))
    and UnchainableCheck(81992475)
    then
      GlobalGriefingID = 81992475
      return true
    end
    if HasPriorityTarget(OppMon(),false,nil,FarfaFilter)
    and (HasID(AIDeck(),36553319,true,FilterOPT,true) and NotNegated(c)
    or HasID(c.xyz_materials,36553319,true,FilterOPT,true))
    and UnchainableCheck(27552504)
    then
      GlobalBeatriceID = 36553319
      return true
    end
    if Duel.CheckTiming(TIMING_END_PHASE) 
    and Duel.GetTurnPlayer() == 1-player_ai
    and (NotNegated(c) or PriorityCheck(c.xyz_materials,PRIO_TOGRAVE)>3)
    and UnchainableCheck(27552504)
    then
      return true
    end
    if Duel.GetTurnPlayer() == player_ai
    and UnchainableCheck(27552504)
    and (NotNegated(c) or PriorityCheck(c.xyz_materials,PRIO_TOGRAVE)>3)
    then
      return true
    end
    local aimon,oppmon=GetBattlingMons()
    if aimon and oppmon and WinsBattle(oppmon,aimon)
    and Duel.GetTurnPlayer()==1-player_ai
    and (NotNegated(c) or PriorityCheck(c.xyz_materials,PRIO_TOGRAVE)>3)
    and aimon:GetCode()==27552504
    then
      return true
    end
  end
  return false
end
function ChainPilgrim(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  elseif FilterLocation(c,LOCATION_ONFIELD) then
    if RemovalCheckCard(c) or NegateCheckCard(c) then
      return PriorityCheck(AIHand(),PRIO_TOGRAVE)>3
      and NotNegated(c)
    end
    if BarbarFinish(AIHand())
    and UnchainableCheck(81992475)
    then
      GlobalGriefingID = 81992475
      return true
    end
    if HasPriorityTarget(OppMon(),false,nil,FarfaFilter)
    and HasID(AIHand(),36553319,true,FilterOPT,true) 
    and NotNegated(c)
    and UnchainableCheck(18386170)
    then
      GlobalPilgrimID = 36553319
      return true
    end
    if Duel.CheckTiming(TIMING_END_PHASE) 
    and Duel.GetTurnPlayer() == 1-player_ai
    and PriorityCheck(AIHand(),PRIO_TOGRAVE)>3
    and NotNegated(c)
    and UnchainableCheck(18386170)
    then
      return true
    end
    if Duel.GetTurnPlayer() == player_ai
    and UnchainableCheck(18386170)
    and PriorityCheck(AIHand(),PRIO_TOGRAVE)>3
    and NotNegated(c)
    then
      return true
    end
    local aimon,oppmon=GetBattlingMons()
    if aimon and oppmon and WinsBattle(oppmon,aimon)
    and Duel.GetTurnPlayer()==1-player_ai
    and NotNegated(c)
    and aimon:GetCode()==18386170
    then
      return true
    end
  end
  return false
end
function ChainBarbar(c)
  return BarbarDamage()>=0.8*AI.GetPlayerLP(2)
  and OPTCheck(81992475)
end
function ChainFiendGriefing(c)
  if RemovalCheckCard(c) then
    return true
  end
  if BarbarFinish(AIDeck())
  and UnchainableCheck(81992475)
  then
    GlobalGriefingID = 81992475
    return true
  end
  if HasPriorityTarget(OppMon(),false,nil,FarfaFilter)
  and HasID(AIDeck(),36553319,true,FilterOPT,true) 
  and UnchainableCheck(60743819)
  then
    GlobalGriefingID = 36553319
    return true
  end
  if Duel.CheckTiming(TIMING_END_PHASE) 
  and Duel.GetTurnPlayer() == 1-player_ai
  and UnchainableCheck(60743819)
  then
    return true
  end
  if Duel.GetTurnPlayer() == player_ai
  and UnchainableCheck(60743819)
  and NotBAMonsterFilter(c)==0
  and (Duel.GetCurrentPhase()==PHASE_MAIN1
  or Duel.GetCurrentPhase()==PHASE_MAIN2)
  then
    return true
  end
  local card=CheckTarget(c,OppGrave(),true,FilterType,TYPE_MONSTER)
  if card then
    GlobalCardMode=1
    GlobalTargetSet(card)
    return true
  end
  local card=CheckSS(c,OppGrave(),true,LOCATION_GRAVE,FilterType,TYPE_MONSTER)
  if card then
    GlobalCardMode=1
    GlobalTargetSet(card)
    return true
  end
  return false
end
function TravelerFilter(c)
  return BAMonsterFilter(c)
  and FilterRevivable(c)
  and c.turnid == Duel.GetTurnCount()
end
function ChainTraveler(c)
  if RemovalCheckCard(c) then
    return true
  end
  local targets = CardsMatchingFilter(AIGrave(),TravelerFilter)
  local space = Duel.GetLocationCount(player_ai,LOCATION_MZONE)
  local count = math.min(targets,space)
  if Duel.CheckTiming(TIMING_END_PHASE) 
  and Duel.GetTurnPlayer() == 1-player_ai
  and Duel.GetCurrentChain() == 0
  and count>2
  then
    return true
  end
  if Duel.GetTurnPlayer() == player_ai
  and Duel.GetCurrentChain() == 0
  and count>2
  then
    return true
  end
  if Duel.GetTurnPlayer() == 1-player_ai
  and IsBattlePhase()
  and #AIMon()==0
  and ExpectedDamage(1)>=0.7*AI.GetPlayerLP(1)
  then
    return true
  end
end
function ChainF0(c)
  local aimon,oppmon = GetBattlingMons()
  if aimon and oppmon 
  and NotNegated(c)
  then
    if Duel.GetTurnPlayer()==player_ai then
      return true
    else
      return FilterAttackMin(oppmon,OppGetStrongestAttack())
    end
  end
  return false
end
function PainfulEscapeFilter(c,source)
  return FilterAttribute(c,source.attribute)
  and FilterRace(c,source.race)
  and FilterLevel(c,source.level)
  and not FilterID(c,source.id)
end
function ChainPainfulEscape(card)
  local cards = UseLists(AIDeck(),AIGrave())
  local targets = {}
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if CardsMatchingFilter(cards,PainfulEscapeFilter,c)>0 then
      targets[#targets+1]=c
    end
  end
  for i=1,#targets do
    local c = targets[i]
    if RemovalCheckCard(c)
    or NegateCheckCard(c) 
    and Duel.GetCurrentChain()>0
    then
      GlobalCardMode = 1
      GlobalTargetSet(c)
      return true
    end
  end
  if RemovalCheckCard(card) then
    return true
  end
  if IsBattlePhase()
  and Duel.GetTurnPlayer()==1-player_ai
  then
    local aimon,oppmon = GetBattlingMons()
    if aimon and oppmon 
    and WinsBattle(oppmon,aimon)
    and ListHasCard(targets,GetCardFromScript(aimon))
    then
      GlobalCardMode = 1
      GlobalTargetSet(aimon)
      return true
    end
  end
  if Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetTurnPlayer()==1-player_ai
  and Duel.GetCurrentChain()==0
  and PriorityCheck(targets,PRIO_TOGRAVE,1)>4
  then
    return true
  end
  local i = HasID(targets,36553319,true,FilterOPT,true)
  if i and HasPriorityTarget(OppMon(),false,nil,FarfaFilter)
  then
    GlobalCardMode = 1
    GlobalTargetSet(targets[i])
    return true
  end
  return false
end
function ChainPKBreakSword(c)
  return true
end
function BAChain(cards)
  if HasID(cards,20036055,ChainTraveler) then
    return {1,CurrentIndex}
  end
  if HasID(cards,62709239,ChainPKBreakSword) then
    return Chain()
  end
  if HasID(cards,81992475,ChainBarbar) then
    return {1,CurrentIndex}
  end
  if HasID(cards,27552504,ChainBeatrice) then
    return {1,CurrentIndex}
  end
  if HasID(cards,18386170,ChainPilgrim) then
    return {1,CurrentIndex}
  end
  if HasID(cards,57143342,false,nil,LOCATION_GRAVE) then -- Cir
    OPTSet(57143342)
    return {1,CurrentIndex}
  end
  if HasID(cards,20758643,false,nil,LOCATION_GRAVE) then -- Graff
    OPTSet(20758643)
    return {1,CurrentIndex}
  end
  if HasID(cards,73213494,false,nil,LOCATION_GRAVE) then -- Calcab
    OPTSet(73213494)
    return {1,CurrentIndex}
  end
  if HasID(cards,36553319,false,nil,LOCATION_GRAVE) and ChainFarfa() then -- Farfa
    OPTSet(36553319)
    return {1,CurrentIndex}
  end
  if HasID(cards,09342162,false,nil,LOCATION_GRAVE) then -- Cagna
    OPTSet(09342162)
    return {1,CurrentIndex}
  end
  if HasID(cards,62957424,false,nil,LOCATION_GRAVE,ChainLibic) then -- Libic
    OPTSet(62957424)
    return {1,CurrentIndex}
  end
  if HasID(cards,00601193,false,nil,LOCATION_GRAVE) then -- Virgil
    return {1,CurrentIndex}
  end
  if HasID(cards,83531441,false,nil,LOCATION_GRAVE) then -- Dante
    return {1,CurrentIndex}
  end
  if HasID(cards,47728740,false,nil,LOCATION_GRAVE) and ChainAlich(cards[CurrentIndex]) then -- Calcab
    OPTSet(47728740)
    return {1,CurrentIndex}
  end
  if HasID(cards,36006208) and ChainFireLake() then
    return {1,CurrentIndex}
  end
  if HasID(cards,71587526) and ChainKarmaCut() then
    return {1,CurrentIndex}
  end
  if HasID(cards,63356631,ChainPWWB) then
    return Chain()
  end
  if HasID(cards,20513882,ChainPainfulEscape) then
    return Chain()
  end
  if HasID(cards,65305468,ChainF0) then
    return {1,CurrentIndex}
  end
  if HasID(cards,60743819,ChainFiendGriefing) then
    return {1,CurrentIndex}
  end
  if HasID(cards,65305468,ChainF0) then
    return {1,CurrentIndex}
  end
  return nil
end

function BAEffectYesNo(id,card)
  local result = nil
  if id == 65305468 and ChainF0(card) then
    result = 1
  end
  if id == 62709239 and ChainPKBreakSword(card) then
    return 1
  end
  if id == 18386170 and ChainPilgrim(card) then
    result = 1
  end
  if id == 81992475 and ChainBarbar(card) then
    result = 1
  end
  if id == 27552504 and ChainBeatrice(card) then
    result = 1
  end
  if id==57143342 and FilterLocation(card,LOCATION_GRAVE) then -- Cir
    OPTSet(57143342)
    result = 1
  end
  if id==20758643 and FilterLocation(card,LOCATION_GRAVE) then -- Graff
    OPTSet(20758643)
    result = 1
  end
  if id==73213494 and FilterLocation(card,LOCATION_GRAVE) then -- Calcab
    OPTSet(73213494)
    result = 1
  end
 if id==36553319 and FilterLocation(card,LOCATION_GRAVE) and ChainFarfa() then
    OPTSet(36553319)
    result = 1
  end
  if id==09342162 and FilterLocation(card,LOCATION_GRAVE) then -- Cagna
    OPTSet(09342162)
    result = 1
  end
  if id==62957424 and FilterLocation(card,LOCATION_GRAVE) and ChainLibic(card) then
    OPTSet(62957424)
    result = 1
  end
  if id==00601193 and FilterLocation(card,LOCATION_GRAVE) then -- Virgil
    result = 1
  end
  if id==83531441 and FilterLocation(card,LOCATION_GRAVE) then -- Dante
    result = 1
  end
  if id==47728740 and ChainAlich(card) then -- Alich
    OPTSet(47728740)
    result = 1
  end
  return result
end
BAAtt={
  00601193,26563200,72167543, -- Virgil, Muzurythm, Downerd
  81330115,31320433,47805931, -- Acid, Nightmare Shark, Giga-Brillant
  75367227,68836428,52558805, -- Alucard, Levia, Temtempo
  18386170,65305468,62709239, -- Pilgrim, F0, PK Break Sword
}
BAVary={
  57143342,73213494,09342162, -- Cir, Calcab, Cagna
  47728740,20758643,62957424, -- Alich, Graff, Libic
  27552504, -- Beatrice
}
BADef={
  84764038,00734741,78156759, -- Scarm, Rubic, Zenmaines
  16259549,62957424,36553319, -- Fortune Tune, Farfa
  63821877,36426778, -- PK Boots, Glove
  81275020,53932291, -- Speedroid Terrortop, Taketomborg
}

function BAPosition(id,available)
  result = nil
  for i=1,#BAAtt do
    if BAAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#BAVary do
    if BAVary[i]==id 
    then 
      if BattlePhaseCheck() 
      and Duel.GetTurnPlayer()==player_ai 
      then 
        result=nil 
      else 
        result=POS_FACEUP_DEFENSE 
      end
    end
  end
  for i=1,#BADef do
    if BADef[i]==id then result=POS_FACEUP_DEFENSE end
  end
  return result
end
