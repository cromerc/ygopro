--[[
83236601, -- Tribute Lanius
60950180, -- Sharp Lanius
10194329, -- Avenge Vulture
53251824, -- Vanishing Lanius
96345188, -- Mimikry Lanius
05929801, -- Fuzzy Lanius
31314549, -- Singing Lanius
46589034, -- Pain Lanius
97219708, -- Last Strix

01475311, -- Allure
23581825, -- Soul Shave Force
58988903, -- Skip Force
43898403, -- Twin Twister
94145683, -- Swallow's Nest
08559793, -- RR Nest

21648584, -- Readiness
53567095, -- Icarus
05851097, -- Vanity
40605147, -- Strike
66994718, -- Gust
84749824, -- Warning

62541668, -- Seven Sins
86221741, -- Zapdos
23603403, -- Satellite Cannon
10443957, -- CyDra Infinity
81927732, -- Revolution Falcon
56832966, -- Utopia Lightning
84013237, -- Utopia
82633039, -- Castel
96592102, -- Burner Falcon
73347079, -- Force Strix
73887236, -- Rise Falcon
65305468, -- F0
]]

function RaidraptorStartup(deck)
  deck.Init                 = RaidraptorInit
  deck.Card                 = RaidraptorCard
  deck.Chain                = RaidraptorChain
  deck.EffectYesNo          = RaidraptorEffectYesNo
  deck.Position             = RaidraptorPosition
  deck.YesNo                = RaidraptorYesNo
  deck.BattleCommand        = RaidraptorBattleCommand
  deck.AttackTarget         = RaidraptorAttackTarget
  deck.AttackBoost          = RaidraptorAttackBoost
  deck.Tribute              = RaidraptorTribute
  deck.Option               = RaidraptorOption
  deck.ChainOrder           = RaidraptorChainOrder
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = RaidraptorActivateBlacklist
  deck.SummonBlacklist      = RaidraptorSummonBlacklist
  deck.RepositionBlacklist  = RaidraptorRepoBlacklist
  deck.SetBlacklist         = RaidraptorSetBlacklist
  deck.Unchainable          = RaidraptorUnchainable
  --[[
  
  ]]
  deck.PriorityList         = RaidraptorPriorityList
end
RaidraptorIdentifier = 96345188 -- Mimikry Lanius
DECK_RAIDRAPTOR = NewDeck("Raidraptor",RaidraptorIdentifier,RaidraptorStartup) 
RaidraptorActivateBlacklist={
83236601, -- Tribute Lanius
60950180, -- Sharp Lanius
10194329, -- Avenge Vulture
53251824, -- Vanishing Lanius
96345188, -- Mimikry Lanius
05929801, -- Fuzzy Lanius
31314549, -- Singing Lanius
46589034, -- Pain Lanius
97219708, -- Last Strix

23581825, -- Soul Shave Force
58988903, -- Skip Force
94145683, -- Swallow's Nest
08559793, -- RR Nest
01475311, -- Allure

21648584, -- Readiness

62541668, -- Seven Sins
86221741, -- Zapdos
23603403, -- Satellite Cannon
81927732, -- Revolution Falcon
96592102, -- Burner Falcon
73347079, -- Force Strix
73887236, -- Rise Falcon
}
RaidraptorSummonBlacklist={
83236601, -- Tribute Lanius
60950180, -- Sharp Lanius
10194329, -- Avenge Vulture
53251824, -- Vanishing Lanius
96345188, -- Mimikry Lanius
05929801, -- Fuzzy Lanius
31314549, -- Singing Lanius
46589034, -- Pain Lanius
97219708, -- Last Strix

62541668, -- Seven Sins
86221741, -- Zapdos
23603403, -- Satellite Cannon
81927732, -- Revolution Falcon
96592102, -- Burner Falcon
73347079, -- Force Strix
73887236, -- Rise Falcon
}
RaidraptorSetBlacklist={
23581825, -- Soul Shave Force
58988903, -- Skip Force
}
RaidraptorRepoBlacklist={
73347079, -- Force Strix
81927732, -- Revolution Falcon
}
RaidraptorUnchainable={
94145683, -- Swallow's Nest
43898403, -- Twin Twister
53567095, -- Icarus
21648584, -- Readiness
97219708, -- Last Strix
}
function RaidraptorFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xba) and check
end
function RaidraptorMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and RaidraptorFilter(c,exclude)
end
function RaidraptorXYZFilter(c,rank)
  return RaidraptorMonsterFilter(c)
  and FilterType(c,TYPE_XYZ)
  and (not rank or FilterRank(c,rank))
end
function RaidraptorNonXYZFilter(c,exclude)
  return RaidraptorMonsterFilter(c,exclude)
  and not FilterType(c,TYPE_XYZ)
end
function FuzzyGraveFilter(c) -- TODO: possible conflict
  return FilterID(c,05929801) -- Fuzzy Lanius
  and c.turnid == Duel.GetTurnCount()
  and OPTCheck(c.id)
  and OPTCheck(c.id+1)
end
function RaidraptorSearchAvailable(c,exclude)
  local result=0
  if HasIDNotNegated(AICards(),08559793,true,FilterOPT,true)
  then
    result=result+1
  end
  if CardsMatchingFilter(AIGrave(),MimikryGraveFilter)>0 
  then
    result=result+1
  end
  if HasIDNotNegated(AIMon(),73347079,true,FilterOPT)
  then
    result=result+1
  end
  if FieldCheck(4)>1 and HasIDNotNegated(AIExtra(),73347079,true)
  then
    result=result+1
  end
  if CardsMatchingFilter(AIGrave(),FuzzyGraveFilter)>0
  then
    result=result+1
  end
  if result>0 then return result end
  return false
end
function SummonSevenSins(c,mode)
  if mode == 0 then
    return MP2Check()
    and FilterSummonRestriction(c)
  end
  if mode == 1 
  and HasID(AIMon(),86221741,true,Negated)
  then
    return true
  end
end
function SummonLastStrix(c,mode)
  if not DualityCheck() 
  or HasIDNotNegated(AIMon(),c.id,true)
  then
    return false
  end
  if (mode == 1 or mode == 0)
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,8)>0
  and HasID(AIExtra(),86221741,true) -- Zapdos
  then
    return true
  end
  if (mode == 2 or mode == 0)
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,4)>0
  and HasID(AIExtra(),81927732,true,SummonRevolutionFalcon,2)
  then
    return true
  end
  if (mode == 3 or mode == 0)
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,6)>0
  and HasID(AIExtra(),23603403,true,SummonSatelliteCannon,1)
  then
    return true
  end
  if (mode == 4 or mode == 0)
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,10)>0
  and HasID(AIExtra(),62541668,true,SummonSevenSins,0)
  then
    return true
  end
end
function UseLastStrix(c,mode)
  if mode == 1
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,8)>0
  and HasID(AIExtra(),86221741,true) -- Zapdos
  and MP2Check()
  then
    GlobalCardMode = 1
    OPTSet(c.id)
    return true
  end
  if mode == 2
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,4)>0
  and HasID(AIExtra(),81927732,true,SummonRevolutionFalcon,2)
  then
    GlobalCardMode = 2
    OPTSet(c.id)
    return true
  end
  if mode == 3
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,6)>0
  and HasID(AIExtra(),23603403,true,SummonSatelliteCannon,1)
  and MP2Check()
  then
    GlobalCardMode = 3
    OPTSet(c.id)
    return true
  end
  if mode == 4
  and CardsMatchingFilter(AIExtra(),RaidraptorXYZFilter,10)>0
  and HasID(AIExtra(),62541668,true,SummonSevenSins,0)
  and MP2Check()
  then
    GlobalCardMode = 4
    OPTSet(c.id)
    return true
  end
end 
function SkipForceFilter(c,rank)
  return RaidraptorXYZFilter(c,rank)
  and (Affected(c,TYPE_SPELL)
  and Targetable(c,TYPE_SPELL)
  and not (c.id == 96592102 
  and CanWinBattle(c,OppMon())
  and BattlePhaseCheck()
  and c.xyz_material_count>0
  and NotNegated(c))
  or FilterLocation(c,LOCATION_GRAVE)
  and FilterRevivable(c))
end
function SkipForceFilter2(c,rank)
  return SkipForceFilter(c,rank)
  and Negated(c)
  and c.xyz_material_count==0
end
function SkipForceFilter3(c,rank)
  return SkipForceFilter(c,rank)
  and c.xyz_material_count==0
end
GlobalSkipForceRank = nil
function UseSkipForce(c,mode)
  if FilterLocation(c,LOCATION_HAND+LOCATION_SZONE) then
    if mode == 1
    and CardsMatchingFilter(AIMon(),SkipForceFilter3,8)>0
    and HasIDNotNegated(AIExtra(),86221741,true) -- Zapdos
    then
      GlobalSkipForceRank = 8
      return true
    end
    if mode == 2
    and CardsMatchingFilter(AIMon(),SkipForceFilter,4)>0
    and OppHasStrongestMonster()
    and HasIDNotNegated(AIExtra(),81927732,true,SummonRevolutionFalcon,0)
    then
      GlobalSkipForceRank = 4
      return true
    end
    if mode == 3
    and CardsMatchingFilter(AIMon(),SkipForceFilter3,6)>0
    and HasIDNotNegated(AIExtra(),23603403,true,SummonSatelliteCannon,1)
    then 
      GlobalSkipForceRank = 6
      return true
    end
    if mode == 4
    and CardsMatchingFilter(AIMon(),SkipForceFilter,4)>0
    and OppHasStrongestMonster()
    and HasIDNotNegated(AIExtra(),81927732,true,SummonRevolutionFalcon,3)
    then
      GlobalSkipForceRank = 4
      return true
    end
  end
end
function UseSkipForceGrave(c,mode)
  if FilterLocation(c,LOCATION_GRAVE) then
    if mode == 1
    and CardsMatchingFilter(AIGrave(),SkipForceFilter,10)>0
    then
      GlobalSkipForceRank = 10
      GlobalCardMode = 1
      return true
    end
    if mode == 2
    and HasIDNotNegated(AICards(),c.id,true)
    and CardsMatchingFilter(AIGrave(),SkipForceFilter,4)>0
    and HasIDNotNegated(AIExtra(),81927732,true,SummonRevolutionFalcon,0)
    then
      GlobalSkipForceRank = 4
      GlobalCardMode = 1
      return true
    end
    if mode == 3
    and HasIDNotNegated(AICards(),c.id,true)
    and CardsMatchingFilter(AIGrave(),SkipForceFilter,6)>0
    and HasIDNotNegated(AIExtra(),23603403,true,SummonSatelliteCannon,1)
    then
      GlobalSkipForceRank = 6
      GlobalCardMode = 1
      return true
    end
    if mode == 4
    and HasIDNotNegated(AICards(),c.id,true)
    and CardsMatchingFilter(AIGrave(),SkipForceFilter,8)>0
    and HasIDNotNegated(AIExtra(),86221741,true,SummonZapdos,1)
    then
      GlobalSkipForceRank = 8
      GlobalCardMode = 1
      return true
    end
    if mode == 5
    and CardsMatchingFilter(AIGrave(),SkipForceFilter,6)>0
    and OppHasStrongestMonster()
    and CardsMatchingFilter(OppMon(),RevolutionFalconFilter,FindID(81927732,AIGrave()))>0
    then
      GlobalSkipForceRank = 6
      GlobalCardMode = 1
      return true
    end
    if mode == 6
    and CardsMatchingFilter(AIGrave(),SkipForceFilter,8)>0
    and OppHasStrongestMonster()
    and OppGetStrongestAttDef()<3000
    then
      GlobalSkipForceRank = 8
      GlobalCardMode = 1
      return true
    end
  end
end
function MimikryGraveFilter(c)
  return FilterID(c,96345188) -- Mimikry Lanius
  and c.turnid == Duel.GetTurnCount()
  and OPTCheck(c.id)
end
function SummonTributeLanius(c,mode)
  if mode == 1
  and HasIDNotNegated(AIDeck(),96345188,true,FilterOPT,true) -- Mimikry
  and CardsMatchingFilter(AIGrave(),MimikryGraveFilter)==0
  and MacroCheck()
  then
    return true
  end
  if mode == 2
  and HasID(AIDeck(),05929801,true,FilterOPT,true) -- Fuzzy
  and not HasID(AIHand(),05929801,true)
  and DualityCheck()
  and MacroCheck()
  then
    return true
  end
end
function UseTributeLanius(c,mode)
  if (mode == 0 or mode == 1)
  and HasID(AIDeck(),96345188,true,FilterOPT,true) -- Mimikry
  and MacroCheck()
  then
    if mode == 1 then OPTSet(c.id) end
    return true
  end
  if mode == 2
  and HasID(AIDeck(),05929801,true,FilterOPT,05929802) -- Fuzzy
  and not HasAccess(05929801) -- Fuzzy
  and MacroCheck()
  then
    OPTSet(c.id)
    return true
  end
end
function SummonVanishingLanius(c,mode)
  if mode == 1
  and (HasIDNotNegated(AIHand(),83236601,true,UseTributeLanius,0)
  or HasIDNotNegated(AIHand(),96345188,true))
  and NotNegated(c)
  and DualityCheck()
  then
    return true
  end
  if mode == 2 
  and HandCheck(4,RaidraptorMonsterFilter,05929801)>1
  and NotNegated(c)
  and DualityCheck()
  then
    return true
  end
  if mode == 3
  and HasIDNotNegated(AIHand(),97219708,true)
  and HasIDNotNegated(AICards(),58988903,true)
  and OPTCheck(97219708)
  and not HasIDNotNegated(AIMon(),97219708,true)
  then
    return true
  end
end
function UseVanishingLanius(c,mode)
  if mode == 1
  --and FieldCheck(4)==1
  and HandCheck(4)>0
  then
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIHand(),97219708,true)
  and HasIDNotNegated(AICards(),58988903,true)
  and OPTCheck(97219708)
  and not HasIDNotNegated(AIMon(),97219708,true)
  then
    return true
  end
end
function SharpLaniusFilter(c,source)
  if Affected(c,TYPE_MONSTER,4) 
  and Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and (c.attack>=AIGetStrongestAttack()
  and c.defense<math.max(source.attack,AIGetStrongestAttack()))
  then
    return true
  end
  return false
end
function SharpLaniusFilter2(c,source)
  if CanAttackSafely(c,nil,.5) then
    return true
  end
  if Affected(c,TYPE_MONSTER,4) 
  and Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and c.defense<math.max(source.attack,AIGetStrongestAttack())
  then
    return true
  end
end
function SharpLaniusFilter3(c)
  return RaidraptorMonsterFilter(c)
  and FilterRevivable(c)
end
function SharpLaniusFilter4(c,source)
  if Affected(c,TYPE_MONSTER,4) 
  and Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and AI.GetPlayerLP(1)-c.defense+source.attack>800
  and c.attack>AIGetStrongestAttack()
  then
    return true
  end
end
function UseSharpLanius(c,mode)
  if mode == 1
  and c.description == c.id*16+1
  then
    return true
  end
  if mode == 2
  and c.description == c.id*16
  and CardsMatchingFilter(OppMon(),SharpLaniusFilter,c)>0
  then
    return true
  end
  if mode == 3
  and c.description == c.id*16
  and CardsMatchingFilter(AIGrave(),SharpLaniusFilter3)>0
  and DualityCheck()
  and CardsMatchingFilter(OppMon(),SharpLaniusFilter4,c)>0
  then
    return true
  end
end
function SummonSharpLanius(c,mode)
  if mode == 1
  and BattlePhaseCheck()
  and (#OppMon()==0 or CardsMatchingFilter(OppMon(),SharpLaniusFilter2,c)>0)
  and CardsMatchingFilter(AIGrave(),SharpLaniusFilter3)>0
  and DualityCheck()
  then
    return true
  end
  if mode == 2
  and BattlePhaseCheck()
  and (#OppMon()==0 or CardsMatchingFilter(OppMon(),SharpLaniusFilter2,c)>0)
  then
    return true
  end
  if mode == 3
  and BattlePhaseCheck()
  and CardsMatchingFilter(OppMon(),SharpLaniusFilter4,c)>0
  then
    return true
  end
end
function UseFuzzyLanius(c,mode)
  if mode == 1
  and FieldCheck(4) == 1
  then
    OPTSet(c.id)
    GlobalSummonRestriction = 0xba
    return true
  end
  if mode == 2
  and HasID(AIHand(),46589034,true) -- Pain Lanius
  and FieldCheck(4)==0
  then
    OPTSet(c.id)
    GlobalSummonRestriction = 0xba
    return true
  end
  if mode == 3
  and HasID(AIHand(),31314549,true) -- Singing Lanius
  and CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ)>0
  and FieldCheck(4)==0
  then
    OPTSet(c.id)
    GlobalSummonRestriction = 0xba
    return true
  end
  if mode == 4
  and CardsMatchingFilter(AIMon(),RaidraptorMonsterFilter)==1
  and HasIDNotNegated(AICards(),08559793,true,FilterOPT,true) -- RR Nest
  then
    OPTSet(c.id)
    GlobalSummonRestriction = 0xba
    return true
  end
  if mode == 5
  and HasIDNotNegated(AIExtra(),73887236,true,SummonRiseFalcon,1)
  and FieldCheck(4)==2
  and DualityCheck()
  then
    OPTSet(c.id)
    GlobalSummonRestriction = 0xba
    return true
  end
end
function SummonSingingLanius(c,mode)
  if mode == 1
  and FieldCheck(4) == 1
  then
    return true
  end
  if mode == 2
  and HasID(AIHand(),46589034,true) -- Pain
  and FieldCheck(4)==0
  then
    return true
  end
  if mode == 3
  and HasID(AIHand(),05929801,true,FilterOPT,true) -- Fuzzy
  and FieldCheck(4)==0
  then
    return true
  end
  if mode == 4
  and HasIDNotNegated(AIExtra(),73887236,true,SummonRiseFalcon,1)
  and FieldCheck(4)==2
  and DualityCheck()
  then
    return true
  end
  if mode == 5
  and HasIDNotNegated(AICards(),08559793,true,FilterOPT,true)
  and CardsMatchingFilter(AIMon(),RaidraptorMonsterFilter)<2
  then
    return true
  end
end
function UseMimikryLanius(c,mode)
  if mode == 1
  and FilterLocation(c,LOCATION_GRAVE)
  then
    OPTSet(c.id)
    return true
  end
end
function UseRRNest(c,mode)
  if mode == 1
  and (FilterLocation(c,LOCATION_HAND)
  or FilterPosition(c,POS_FACEDOWN))
  and not HasIDNotNegated(AIST(),c.id,true,FilterPosition,POS_FACEUP)
  and CardsMatchingFilter(AIMon(),RaidraptorMonsterFilter)>1
  then
    return true
  end
  if mode == 2
  and FilterLocation(c,LOCATION_SZONE)
  and FilterPosition(c,POS_FACEUP)
  then
    OPTSet(c.id)
    return true
  end
  if mode == 3
  and HasIDNotNegated(AICards(),66994718,true)
  then
    return true
  end
end
function UsePainLanius(c,mode)
  local dmg = 999999
  for i,target in pairs(AIMon()) do
    if RaidraptorMonsterFilter(target)
    and FilterLevel(target,4)
    then
      dmg = math.min(dmg,target.attack,target.defense)
    end
  end
  if dmg >= AI.GetPlayerLP(1) then
    return false
  end
  if mode == 1
  and FieldCheck(4)==1
  then
    return true
  end
  if mode == 2
  and HasID(AIHand(),10194329,true) -- Avenge
  then
    return true
  end
  if mode == 3
  and HasIDNotNegated(AIExtra(),73887236,true,SummonRiseFalcon,1)
  and FieldCheck(4)==2
  and DualityCheck()
  then
    return true
  end
end
function SummonPainLanius(c,mode)
  if mode == 1
  and #AIMon()==0
  and HasIDNotNegated(AICards(),94145683,true) -- Swallow's Nest
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and HasIDNotNegated(AIDeck(),97219708,true,SummonLastStrix,0) -- Last Strix
  and DualityCheck()
  then
    return true
  end
end
function SoulShaveFilter(c,rank)
  return RaidraptorXYZFilter(c,4)
  and FilterRevivable(c)
end
function UseSoulShaveForce(c,mode)
  if mode == 1
  and CardsMatchingFilter(AIGrave(),SoulShaveFilter,4)>0
  and HasIDNotNegated(AIExtra(),10443957,true,SummonInfinityRR,1) -- CyDra Infinity
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(AIGrave(),SoulShaveFilter,4)>0
  and HasIDNotNegated(AIExtra(),81927732,true,SummonRevolutionFalcon,2) -- Revolution Falcon
  then
    return true
  end
end
function SummonForceStrix(c,mode)
  if mode == 1
  and TurnEndCheck()
  then
    return true
  end
  if mode == 2
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and (HasIDNotNegated(AIExtra(),81927732,true,SummonRevolutionFalcon,0)
  or HasIDNotNegated(AIExtra(),81927732,true,SummonRevolutionFalcon,3))
  then
    return true
  end
end
function UseForceStrix(c,mode)
  if mode == 1 
  then
    OPTSet(c)
    return true
  end
end
function SummonRaptor(c,mode)
  if mode == 2
  and FieldCheck(4)==1
  and DualityCheck()
  then
    return true
  end
  if mode == 3
  and c.id~=05929801
  and HasID(AIHand(),05929801,true,OPTCheck,true) -- Fuzzy
  and FieldCheck(4)==0
  and DualityCheck()
  and SpaceCheck()>1
  then
    return true
  end
  if mode == 4
  and HasIDNotNegated(AICards(),08559793,true,OPTCheck,true) -- Nest
  and CardsMatchingFilter(AIMon(),RaidraptorMonsterFilter)==1
  then
    return true
  end
  if mode == 5
  and c.id~=46589034
  and HasID(AIHand(),46589034,true,OPTCheck,true) -- Pain
  and FieldCheck(4)==0
  and DualityCheck()
  and SpaceCheck()>1
  then
    return true
  end
  if mode == 6
  and HasIDNotNegated(AIExtra(),73887236,true,SummonRiseFalcon,1)
  and FieldCheck(4)==2
  and DualityCheck()
  then
    return true
  end
  if mode == 1
  and c.id~=46589034 -- Pain
  and HasID(AIHand(),46589034,true,OPTCheck,true) -- Pain
  and c.id~=10194329 -- Avenge
  and HasID(AIHand(),10194329,true,OPTCheck,true) -- Avenge
  and FieldCheck(4)==0
  and DualityCheck()
  and SpaceCheck()>2
  then
    return true
  end
  if mode == 7
  and #AIMon()==0
  and HasIDNotNegated(AICards(),94145683,true)
  and DualityCheck()
  then
    return true
  end
  if mode == 8
  and #AIMon()==0
  and (#OppMon()==0
  or OppHasStrongestMonster()
  and CanWinBattle(c,OppMon()))
  and c.attack>=1500
  then
    return true
  end
end
function SummonMimikry(c,mode)
  if mode == 1
  and HasIDNotNegated(AIST(),53567095,true)
  and DestroyCheck(OppField())>1
  then
    return true
  end
end
function SummonFuzzy(c,mode)
  if mode == 1
  and HasIDNotNegated(AIST(),53567095,true)
  and DestroyCheck(OppField())>1
  then
    return true
  end
end
function SetRaptor(c,mode)
  if mode == 1
  and #AIMon()==0
  and HasBackrow()
  then
    return true
  end
end
Raptors = {
83236601, -- Tribute Lanius
96345188, -- Mimikry Lanius
60950180, -- Sharp Lanius
10194329, -- Avenge Vulture
53251824, -- Vanishing Lanius
05929801, -- Fuzzy Lanius
31314549, -- Singing Lanius
--46589034, -- Pain Lanius
--97219708, -- Last Strix
}
function BladeBurnerFinishFilter(c,source)
  return CanFinishGame(source,c,4000)
end
function SummonBladeBurner(c,mode)
  if AI.GetPlayerLP(2)-AI.GetPlayerLP(1)>=3000
  then
    c.attack=4000
  end
  if mode == 4
  and BattlePhaseCheck()
  and c.attack==4000
  then 
    return true
  end
  if mode == 3
  and BattlePhaseCheck()
  and CanWinBattle(c,OppMon())
  and DestroyCheck(OppMon())>0
  and OppHasStrongestMonster()
  then
    return true
  end
  if mode == 1
  and BattlePhaseCheck()
  and c.attack==4000
  and (CardsMatchingFilter(OppMon(),BladeBurnerFinishFilter,c)>0
  or #OppMon()==0 and AI.GetPlayerLP(2)<=c.attack)
  then 
    return true
  end
  if mode == 2
  and BattlePhaseCheck()
  and CanWinBattle(c,OppMon())
  and c.attack==4000
  and DestroyCheck(OppMon())>0
  then
    return true
  end
end
function RiseFalconFilter(c,source)
  source.attack=c.attack+100
  return FilterSummon(c,SUMMON_TYPE_SPECIAL)
  and CanWinBattle(source,{c})
end
function RiseFalconFilter2(c,source)
  return Affected(c,TYPE_MONSTER,4)
  and Targetable(c,TYPE_MONSTER)
  and c.attack+100>OppGetStrongestAttDef()
end
function RiseFalconFilter3(c,source)
  return Affected(c,TYPE_MONSTER,4)
  and Targetable(c,TYPE_MONSTER)
  and c.attack>1000
end
function SummonRiseFalcon(c,mode)
  if mode == 1
  and (CardsMatchingFilter(OppMon(),RiseFalconFilter,c)>2
  or CardsMatchingFilter(OppMon(),RiseFalconFilter,c)>1
  and HasPriorityTarget(OppMon(),false,nil,RiseFalconFilter,c))
  and CardsMatchingFilter(OppMon(),RiseFalconFilter2)>0
  and not HasID(AIMon(),81927732,true) -- Revolution Falcon
  and BattlePhaseCheck()
  then
    return true
  end
end
function UseRiseFalcon(c,mode)
  if mode == 1
  and CardsMatchingFilter(OppMon(),RiseFalconFilter3)>0
  then
    return true
  end
end
function SummonSatelliteCannon(c,mode)
  if mode == 1
  and DestroyCheck(OppST())>2
  and (MP2Check() or #AIMon()==0)
  then
    return true
  end
end
function SummonZapdos(c,mode)
  return true
end
function UseIcarusRR(c,mode)
  if mode == 1
  and (HasID(AIMon(),96345188,true,FilterOPT,true)
  or HasID(AIMon(),05929801,true,FilterOPT,05929802)
  and CardsMatchingFilter(AIGrave(),MimikryGraveFilter)==0)
  and DestroyCheck(OppField())>1
  then
    return true
  end
end
function UseTwiTwiRR(c,mode)
  if mode == 1
  and (HasID(AIHand(),96345188,true,FilterOPT,true)
  or HasID(AIHand(),05929801,true,FilterOPT,05929802)
  and CardsMatchingFilter(AIGrave(),MimikryGraveFilter)==0)
  and DestroyCheck(OppST())>1
  then
    return true
  end
  if mode == 2
  and (HasID(AIHand(),96345188,true,FilterOPT,true)
  or HasID(AIHand(),05929801,true,FilterOPT,05929802)
  and CardsMatchingFilter(AIGrave(),MimikryGraveFilter)==0)
  and DestroyCheck(OppST())>0
  and (#AIMon()==0 or OppHasStrongestMonster())
  then
    return true
  end
end
function UseSwallow(c,mode)
  if mode == 1
  and #AIMon() == 1
  and FieldCheck(4,SwallowFilter) == 1
  then
    return true
  end
  if mode == 2
  and FieldCheck(1,SwallowFilter,{1,97219708}) == 1
  and not HasIDNotNegated(AIMon(),97219708,true)
  and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and HasIDNotNegated(AIDeck(),97219708,true,SummonLastStrix,0) -- Last Strix
  and DualityCheck()
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindCardByFilter(AIMon(),SwallowFilter,{1,97219708}))
    return true
  end
end
function RepoForceStrix(c)
  if FilterPosition(c,POS_ATTACK) then
    if not (BattlePhaseCheck() and CanAttack(c))
    then
      return true
    end
    if c.attack<1500
    and #OppMon()>0
    and not CanWinBattle(c,OppMon())
    then
      return true
    end
  end
  if FilterPosition(c,POS_DEFENSE) then
    if not (BattlePhaseCheck() and CanAttack(c))
    then
      return false
    end
    if c.attack>1500
    and #OppMon()==0
    or CanWinBattle(c,OppMon())
    then
      return true
    end
  end
end
function F0RRFilter(c,mode)
  if mode == 1 then
    return FilterID(c,73347079) -- Force Strix
    and (c.attack<1500 or OppHasStrongestMonster())
    and c.xyz_material_count==0
  end
  if mode == 2 then
    return FilterID(c,73347079) -- Force Strix
    and c.xyz_material_count==0
    and FilterPosition(c,POS_ATTACK)
  end
end
function SummonF0RR(c,mode)
  if mode == 1
  and BattlePhaseCheck()
  and CardsMatchingFilter(AIMon(),F0RRFilter,1)>1
  and CardsMatchingFilter(OppMon(),F0Filter)>0
  then
    return true
  end
  if mode == 2
  and not BattlePhaseCheck()
  and CardsMatchingFilter(AIMon(),F0RRFilter,2)>1
  then
    return true
  end
end
function RepoRevolutionFalcon(c)
  if FilterPosition(c,POS_ATTACK) then
    if not (BattlePhaseCheck() and CanAttack(c))
    then
      return true
    end
    if not (CanWinBattle(c,OppMon()) 
    or CardsMatchingFilter(OppMon(),RevolutionFalconFilter)>0 
    and NotNegated(c))
    then
      return true
    end
  end
  if FilterPosition(c,POS_DEFENSE) then
    if not (BattlePhaseCheck() and CanAttack(c))
    then
      return false
    end
    if CanWinBattle(c,OppMon()) 
    or CardsMatchingFilter(OppMon(),RevolutionFalconFilter)>0 
    and NotNegated(c)
    then
      return true
    end
  end
end
function RaidraptorInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,43898403,UseTwiTwiRR,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,73887236,UseRiseFalcon,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,81927732,UseRevolutionFalcon,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,81927732,UseRevolutionFalcon,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,73347079,UseForceStrix,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,83236601,UseTributeLanius,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,83236601,UseTributeLanius,2) then
    return Activate()
  end
  if HasID(Act,96345188,UseMimikryLanius,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,08559793,UseRRNest,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,08559793,UseRRNest,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,08559793,UseRRNest,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForce,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForce,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForce,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForceGrave,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForceGrave,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForceGrave,3) then
    return Activate()
  end  
  if HasIDNotNegated(Act,58988903,UseSkipForceGrave,4) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForceGrave,5) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForceGrave,6) then
    return Activate()
  end
  if HasIDNotNegated(Act,97219708,UseLastStrix,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,97219708,UseLastStrix,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,97219708,UseLastStrix,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,97219708,UseLastStrix,4) then
    return Activate()
  end
  if HasIDNotNegated(Act,23581825,UseSoulShaveForce,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,23581825,UseSoulShaveForce,2) then
    return Activate()
  end
  if HasIDNotNegated(SpSum,96592102,SummonBladeBurner,1) then
    return SpSummon()
  end
  if HasIDNotNegated(Act,60950180,UseSharpLanius,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,60950180,UseSharpLanius,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,60950180,UseSharpLanius,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,53251824,UseVanishingLanius,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,53251824,UseVanishingLanius,2) then
    return Activate()
  end
  if HasIDNotNegated(Sum,53251824,SummonVanishingLanius,1) then
    return Summon()
  end
  if HasIDNotNegated(Sum,53251824,SummonVanishingLanius,2) then
    return Summon()
  end
  if HasIDNotNegated(Sum,53251824,SummonVanishingLanius,3) then
    return Summon()
  end
  if HasIDNotNegated(Sum,83236601,SummonTributeLanius,1) then
    return Summon()
  end
  if HasIDNotNegated(Sum,83236601,SummonTributeLanius,2) then
    return Summon()
  end
  if HasIDNotNegated(Sum,60950180,SummonSharpLanius,1) then
    return Summon()
  end
  if HasID(Act,05929801,UseFuzzyLanius,1) 
  and Duel.GetTurnCount()==1
  then
    return Activate()
  end
  if HasIDNotNegated(SpSum,31314549,SummonSingingLanius,1) then
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,31314549,SummonSingingLanius,2) then
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,31314549,SummonSingingLanius,3) then
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,31314549,SummonSingingLanius,4) then
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,31314549,SummonSingingLanius,5) then
    return SpSummon()
  end
  if HasID(Act,46589034,UsePainLanius,1) then
    return Activate()
  end
  if HasID(Act,46589034,UsePainLanius,2) then
    return Activate()
  end
  if HasID(Act,46589034,UsePainLanius,3) then
    return Activate()
  end
  if HasID(Act,05929801,UseFuzzyLanius,1) then
    return Activate()
  end
  if HasID(Act,05929801,UseFuzzyLanius,2) then
    return Activate()
  end
  if HasID(Act,05929801,UseFuzzyLanius,3) then
    return Activate()
  end
  if HasID(Act,05929801,UseFuzzyLanius,4) then
    return Activate()
  end
  if HasID(Act,05929801,UseFuzzyLanius,5) then
    return Activate()
  end
  if HasID(Act,53567095,UseIcarusRR,1) then
    return Activate()
  end
  if HasIDNotNegated(Sum,60950180,SummonSharpLanius,2) then
    return Summon()
  end
  if HasIDNotNegated(Sum,60950180,SummonSharpLanius,3) then
    return Summon()
  end
  if HasID(Sum,96345188,SummonMimikry,1) then
    return Summon()
  end
  if HasID(Sum,05929801,SummonFuzzy,1) then
    return Summon()
  end
  if HasIDNotNegated(Sum,97219708,SummonLastStrix,1) then
    return Summon()
  end
  for i,c in pairs(Sum) do
    for mode=1,6 do
      for i2,id in pairs(Raptors) do
        if c.id == id and SummonRaptor(c,mode) then
          return Summon(i)
        end
      end
    end
  end
  if HasIDNotNegated(Sum,97219708,SummonLastStrix,1) then
    return Summon()
  end
  if HasIDNotNegated(Sum,97219708,SummonLastStrix,2) then
    return Summon()
  end 
  if HasIDNotNegated(Sum,97219708,SummonLastStrix,3) then
    return Summon()
  end
  if HasIDNotNegated(Sum,97219708,SummonLastStrix,4) then
    return Summon()
  end
  if HasIDNotNegated(SpSum,73887236,SummonRiseFalcon,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,96592102,SummonBladeBurner,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,96592102,SummonBladeBurner,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,96592102,SummonBladeBurner,3) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,73347079,SummonForceStrix,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,73347079,SummonForceStrix,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,96592102,SummonBladeBurner,4) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,62541668,SummonSevenSins,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,94145683,UseSwallow,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,01475311,UseAllure) then
    return Activate()
  end
  if HasIDNotNegated(Act,58988903,UseSkipForce,4) then
    return Activate()
  end
  if HasIDNotNegated(Act,43898403,UseTwiTwiRR,2) then
    return Activate()
  end
  if HasIDNotNegated(Sum,46589034,SummonPainLanius,1) then
    return Summon()
  end
  if HasIDNotNegated(Act,94145683,UseSwallow,2) then
    return Activate()
  end
  for i,c in pairs(Sum) do
    for mode=7,8 do
      for i2,id in pairs(Raptors) do
        if c.id == id and SummonRaptor(c,mode) then
          return Summon(i)
        end
      end
    end
  end
  for i,c in pairs(SetMon) do
    for i2,id in pairs(Raptors) do
      if c.id == id and SetRaptor(c,1) then
        return Set(i)
      end
    end
  end
  if HasID(Rep,73347079,RepoForceStrix) then
    return Repo()
  end
  if HasID(Rep,81927732,RepoRevolutionFalcon) then
    return Repo()
  end
  if HasID(SpSum,65305468,SummonF0RR,1) then
    return XYZSummon()
  end
  if HasID(SpSum,65305468,SummonF0RR,2) then
    return XYZSummon()
  end
  local attack = false
  for i,c in pairs(AIMon()) do
    if CanAttackSafely(c,nil,.5) then
      attack = true
    end
  end
  if HasID(AIHand(),97219708,SummonLastStrix,0) 
  and CardsMatchingFilter(UseLists(AIST(),AIGrave()),FilterType,TYPE_SPELL+TYPE_TRAP)==0
  and #AIMon()>0 and attack
  and SpaceCheck()>1
  and BattlePhaseCheck()
  then
    return SetSpell(math.random(#SetST))
  end
  return nil
end
function LastStrixTarget(cards)
  if LocCheck(cards,LOCATION_EXTRA) then
    if GlobalCardMode and GlobalCardMode == 1 then
      GlobalCardMode = nil
      return Add(cards,PRIO_TOFIELD,1,FilterRank,8)
    end
    if GlobalCardMode and GlobalCardMode == 2 then
      GlobalCardMode = nil
      return Add(cards,PRIO_TOFIELD,1,FilterRank,4)
    end
    if GlobalCardMode and GlobalCardMode == 3 then
      GlobalCardMode = nil
      return Add(cards,PRIO_TOFIELD,1,FilterRank,6)
    end
    if GlobalCardMode and GlobalCardMode == 4 then
      GlobalCardMode = nil
      return Add(cards,PRIO_TOFIELD,1,FilterRank,10)
    end
    if HasIDNotNegated(AICards(),58988903,true) -- Skip Force
    and CardsMatchingFilter(cards,RaidraptorXYZFilter,8)>0
    and HasID(AIExtra(),86221741,true) -- Zapdos
    then
      return Add(cards,PRIO_TOFIELD,1,FilterRank,8)
    end
  end
  return Add(cards,PRIO_TOFIELD)
end
function SkipForceTarget(cards)
  if LocCheck(cards,LOCATION_MZONE) then
    if GlobalSkipForceRank then
      local rank = GlobalSkipForceRank
      GlobalSkipForceRank = nil
      return Add(cards,PRIO_TOGRAVE,1,SkipForceFilter,rank)
    end
    if CardsMatchingFilter(cards,SkipForceFilter,8)>0
    and HasID(AIExtra(),86221741,true) -- Zapdos
    then
      return Add(cards,PRIO_TOGRAVE,1,SkipForceFilter,8)
    end
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_EXTRA) then
    if HasID(cards,86221741,true) then -- Zapdos
      return Add(cards,PRIO_TOFIELD,1,FilterID,86221741) -- Zapdos
    end
    return Add(cards,PRIO_TOFIELD)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    if GlobalCardMode == 1 then
      GlobalCardMode = nil
      local filter = nil
      if GlobalSkipForceRank then
        filter = function(c)return not FilterRank(c,GlobalSkipForceRank) end
      end
      return Add(cards,PRIO_BANISH,1,filter)
    end
    if GlobalSkipForceRank then
      local rank = GlobalSkipForceRank
      GlobalSkipForceRank = nil
      return Add(cards,PRIO_TOGRAVE,1,SkipForceFilter,rank)
    end
    return Add(cards,PRIO_TOFIELD)
  end
end
function SummonInfinityRR(c,mode)
  if mode == 1
  and FilterSummonRestriction(c) 
  then
    return true
  end
end
function RevolutionFalconFilter(c,source)
  return FilterSummon(c,SUMMON_TYPE_SPECIAL)
  and Affected(c,TYPE_MONSTER,4)
  and BattleTargetCheck(c,source)
  and FilterController(c,2)
end
function RevolutionFalconFinish(source)
  local targets = SubGroup(OppMon(),RevolutionFalconFilter,source)
  local dmg = 0
  for i,target in pairs(targets) do
    dmg = dmg + BattleDamage(target,source,nil,0)
  end
  return dmg >= AI.GetPlayerLP(2)
end
function UseRevolutionFalcon(c,mode)
  if mode == 1
  and c.description == c.id*16
  and CardsMatchingFilter(OppMon(),RevolutionFalconFilter,c)>1
  then
    return true
  end
  if mode == 2
  and c.description == c.id*16+1
  then
    return false -- TODO
  end
end
function SummonRevolutionFalcon(c,mode)
  if (mode == 0 or mode == 1)
  and RevolutionFalconFinish(c)
  and BattlePhaseCheck()
  and CardsMatchingFilter(OppMon(),RevolutionFalconFilter,c)>0
  then
    return true
  end
  if (mode == 0 or mode == 2)
  and BattlePhaseCheck()
  and CardsMatchingFilter(OppMon(),RevolutionFalconFilter,c)>1
  then
    return true
  end
  if mode == 3
  and CardsMatchingFilter(OppMon(),RevolutionFalconFilter,c)>0
  and OppHasStrongestMonster()
  and BattlePhaseCheck()
  then
    return true
  end
end
function SoulShaveTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH)
  end
  if HasIDNotNegated(cards,81927732,true,SummonRevolutionFalcon,1) then
    return Add(cards,PRIO_TOFIELD,1,FilterID,81927732)
  end
  if HasIDNotNegated(cards,81927732,true,SummonRevolutionFalcon,2) 
  and CardsMatchingFilter(OppMon(),RevolutionFalconFilter,c)>2
  then
    return Add(cards,PRIO_TOFIELD,1,FilterID,81927732)
  end
  if HasIDNotNegated(cards,10443957,true,SummonInfinityRR,1) then
    return Add(cards,PRIO_TOFIELD,1,FilterID,10443957)
  end
  if HasIDNotNegated(cards,81927732,true,SummonRevolutionFalcon,2) then
    return Add(cards,PRIO_TOFIELD,1,FilterID,81927732)
  end
  return Add(cards,PRIO_TOFIELD)
end
function ZapdosTarget(cards)
  return Add(cards,PRIO_TOGRAVE,1,FilterInvert,RaidraptorXYZFilter)
end
function RRNestTarget(cards)
  return Add(cards)
end
function MimikryTarget(cards)
  return Add(cards)
end
function VanishingTarget(cards)
  if HasIDNotNegated(AICards(),58988903,true) -- Skip Force
  and HasIDNotNegated(AIHand(),97219708,true) -- Last Strix
  and not HasIDNotNegated(AIField(),97219708,true) -- Last Strix
  and (HasID(AIHand(),46589034,true,FilterOPT,true) -- Pain Lanius
  or HasID(AIHand(),05929801,true,FilterOPT,true) -- Fuzzy Lanius
  or HasID(AIHand(),31314549,true) -- Singing Lanius
  or FieldCheck(4)>1)
  then
    return Add(cards,PRIO_TOFIELD,1,FilterID,97219708) -- Last Strix
  end
  return Add(cards,PRIO_TOFIELD,1,FilterLevel,4)
end
function TributeTarget(cards)
  local result = Add(cards,PRIO_TOGRAVE) -- TODO: Consider Rank-Up search
  return result
end
function PainLaniusTarget(cards)
  local dmg = 99999
  local valid = {}
  local result = nil
  for i,c in pairs(cards) do
    if FilterLevel(c,4)
    then
      local v = math.min(c.attack,c.defense)
      if v<dmg then
        result = i
        dmg = v
      end
    end
  end
  if result then
    return {result}
  end
  return Add(cards,PRIO_TOHAND,FilterLevel,4)
end
function SharpLaniusTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards,1,TARGET_OTHER)
end
function FuzzyTarget(cards)
  return Add(cards)
end
function BurnerTarget(cards,c,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,max)
  end
  return BestTargets(cards,max,TARGET_DESTROY)
end
function RiseFalconTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_OTHER,RiseFalconFilter2,c)
end
GlobalSwallowAttack = nil
function SwallowsTarget(cards)
  if LocCheck(cards,LOCATION_MZONE) then
    if GlobalCardMode == 1 then
      GlobalCardMode = nil
      return GlobalTargetGet(cards,true)
    end
    return Add(cards,PRIO_TOGRAVE)
  end
  if GlobalSwallowAttack then
    local atk = GlobalSwallowAttack
    GlobalSwallowAttack = nil
    return Add(cards,PRIO_TOFIELD,1,FilterAttackMin,atk)
  end
  return Add(cards,PRIO_TOFIELD)
end
RaidraptorTargetFunctions={
[97219708] = LastStrixTarget,   -- Last Strix
[83236601] = TributeTarget,     -- Tribute Lanius
[60950180] = SharpLaniusTarget, -- Sharp Lanius
[53251824] = VanishingTarget,   -- Vanishing Lanius
[96345188] = MimikryTarget,     -- Mimikry Lanius
[05929801] = FuzzyTarget,       -- Fuzzy Lanius
[46589034] = PainLaniusTarget,  -- Pain Lanius

[23581825] = SoulShaveTarget,   -- Soul Shave Force
[58988903] = SkipForceTarget,   -- Skip Force
[08559793] = RRNestTarget,      -- RR Nest
[94145683] = SwallowsTarget,    -- Swallow's Nest

[86221741] = ZapdosTarget,      -- Zapdos
[96592102] = BurnerTarget,      -- Blade Burner
[73887236] = RiseFalconTarget,  -- Rise Falcon
}
function RaidraptorCard(cards,min,max,id,c)
  for i,v in pairs(RaidraptorTargetFunctions) do
    if id == i then
      return v(cards,c,min,max)
    end
  end
  return nil
end
function ChainZapdos(c)
  return true
end
function ChainFuzzy(c)
  OPTSet(c.id+1)
  GlobalSummonRestriction = 0xba
  return true
end
function ChainAvenge(c)
  if HasID(AIMon(),46589034,true) -- Pain
  and Duel.GetTurnPlayer()==player_ai
  and (Duel.GetCurrentPhase()==PHASE_MAIN1
  or Duel.GetCurrentPhase()==PHASE_MAIN2)
  then
    GlobalSummonRestriction = 
      function(c) 
        return RaidraptorMonsterFilter(c)
        or not FilterLocation(c,LOCATION_EXTRA)
      end
    return true
  end
  if Duel.GetTurnPlayer()~=player_ai
  and IsBattlePhase()
  and AI.GetPlayerLP(1)-ExpectedDamage()<=800
  then
    GlobalSummonRestriction = 
      function(c) 
        return RaidraptorMonsterFilter(c)
        or not FilterLocation(c,LOCATION_EXTRA)
      end
    return true
  end
end
function ChainBladeBurner(c)
  if IsBattlePhase()
  and DestroyCheck(OppMon())>0
  then
    return true
  end
  if not IsBattlePhase() then
    return true
  end
end
function ChainSatelliteCannon(c)
  if c.description == c.id*16 then
    return true
  end
  if c.description == c.id*16+1 then
    return false -- TODO
  end
end
function ChainLastStrix(c)
  if Duel.GetTurnPlayer() == player_ai then
    return SummonLastStrix(c,0)
  else
    return #AIMon()==1
    and AI.GetPlayerLP(1)-ExpectedDamage()<=800
  end
end
function ChainReadinessGrave(c,check)
  if FilterLocation(c,LOCATION_SZONE) and not check then
    return false
  end
  if RemovalCheckCard(c) then
    return true
  end
  if Duel.GetTurnPlayer()~=player_ai
  and IsBattlePhase()
  then
    if #AIMon()==0
    and AI.GetPlayerLP(1)-ExpectedDamage()<=800
    then
      return true
    end
    local aimon,oppmon=GetBattlingMons()
    if oppmon 
    and CanFinishGame(oppmon,aimon)
    then 
      return true
    end
  end
  if GetBurnDamage() 
  and ((AI.GetPlayerLP(1)-GetBurnDamage()<=800)
  or GetBurnDamage()>3000)
  then
    return true
  end
end
function ReadinessExcludeFilter(c)
  c=GetCardFromScript(c)
  if c.id == 73347079 then
    return c.xyz_material_count>0 and FilterPosition(c,POS_DEFENSE)
  end
  return (c.attack>1500 
  or FilterPosition(c,POS_DEFENSE))
  and Affected(c,TYPE_TRAP)
end
function LightningCanAttack(c)
  return CanAttack(c)
  and c.xyz_material_count>1
  and CardsMatchingFilter(c.xyz_materials,FilterSet,0x7f)>0
end
function ChainReadiness(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return false
  end
  if RemovalCheckCard(c) then
    return true
  end
  local aimon,oppmon=GetBattlingMons()
  if IsBattlePhase()
  and WinsBattle(oppmon,aimon)
  and RaidraptorMonsterFilter(aimon)
  and ReadinessExcludeFilter(aimon)
  then
    return true
  end
  if IsBattlePhase()
  and HasIDNotNegated(AIMon(),86221741,true) -- Zapdos
  and HasIDNotNegated(OppMon(),56832966,true,LightningCanAttack) -- Utopia Lightning
  then
    --return true unaffected :/
  end
  if ChainReadinessGrave(c,true) 
  and CardsMatchingFilter(AIGrave(),RaidraptorMonsterFilter)>0
  then
    return true
  end
  --[[ TODO: revisit, once burn gets a player check
  if AI.GetPlayerLP()-ExpectedBurn()<800 then
    return true
  end]]
end
function ChainBoMRR(card)
  local targets1 = CardsMatchingFilter(OppMon(),MoonOppFilter)
  local targets2 = CardsMatchingFilter(OppMon(),MoonPriorityFilter)
  local e=Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  local c = nil
  if e then
    c = e:GetHandler()
  end
  if RemovalCheckCard(card) and not c:IsCode(12697630) and targets1>0 then
    return true
  end
  if not UnchainableCheck(14087893) then
    return false
  end
  
  cg = NegateCheck()
  if cg and Duel.GetCurrentChain()>1 and not DeckCheck(DECK_BA) then
    if c and c:GetCode() == 29616929 then
      return false
    end
		if cg:IsExists(function(c) return c:IsControler(player_ai) end, 1, nil) 
    then
      local g=cg:Filter(MoonFilter2,nil,player_ai):GetMaxGroup(Card.GetAttack)
      if g then
        GlobalCardMode = 1
        GlobalTargetSet(g:GetFirst(),AIMon())
        return true
      end
    end	
  end
  cg = RemovalCheck()
  if cg then
    if cg:IsExists(function(c) return c:IsControler(player_ai) end, 1, nil) then
      local g=cg:Filter(MoonFilter2,nil,player_ai):GetMaxGroup(Card.GetAttack)
      if g and e and MoonWhitelist2(e:GetHandler():GetCode()) then
        GlobalCardMode = 1
        GlobalTargetSet(g:GetFirst(),AIMon())
        return true
      end
    end
  end
end
function SwallowFilter(c,params)
  local level = 4
  local id = nil
  if params then
    if type(params) == "table" then
      level = params[1] or 4
      id = params[2] or nil
    end
    if type(params) == "number" then
      level = 4
      id = params
    end
  end
  return Affected(c,TYPE_SPELL)
  and Targetable(c,TYPE_SPELL)
  and FilterRace(c,RACE_WINDBEAST)
  and FilterLevel(c,level)
  and (not id or id ~= c.id)
end
function SwallowFinishFilter(c) 
  return c.attack>=AI.GetPlayerLP(2) 
  --and CardsMatchingFilter(AIMon(),SwallowFilter,{4,c.id})>0
end
function ChainSwallow(card)
  local targets = SubGroup(AIMon(),SwallowFilter)
  if RemovalCheckCard(card)
  and #targets>0
  then
    return true
  end
  if not UnchainableCheck(94145683) then
    return false
  end
  for i,c in pairs(targets) do
    if NegateCheckCard(c) 
    and Duel.GetCurrentChain()>1
    then 
      GlobalCardMode = 1
      GlobalTargetSet(c)
      return true
    end
    if RemovalCheckCard(c,nil,nil,true)
    then
      GlobalCardMode = 1
      GlobalTargetSet(c)
      return true
    end
  end
  if IsBattlePhase()
  and #targets>0
  and #OppMon()==0
  and ExpectedDamage(2)==0
  and CardsMatchingFilter(AIDeck(),SwallowFinishFilter)>0
  then
    GlobalSwallowAttack = AI.GetPlayerLP(2)
    return true
  end
end
RaidraptorChainFunctions={
[05929801] = ChainFuzzy, -- Fuzzy
[10194329] = ChainAvenge, -- Avenge Vulture
[97219708] = ChainLastStrix, -- Last Strix

[86221741] = ChainZapdos, -- Zapdos
[96592102] = ChainBladeBurner, -- Blade Burner
[23603403] = ChainSatelliteCannon, -- Satellite Cannon

[21648584] = ChainReadiness, -- Readiness
[94145683] = ChainSwallow, -- Swallow's Nest

}
function RaidraptorChain(cards)
  for id,v in pairs(RaidraptorChainFunctions) do
    if HasID(cards,id,v)  then
      return Chain()
    end
  end
  if HasID(cards,21648584,ChainReadinessGrave) then
    return Chain()
  end
  return nil
end
function RaidraptorEffectYesNo(id,card)
  for i,v in pairs(RaidraptorChainFunctions) do
    if id == i then
      return v(card)
    end
  end
  return nil
end
function RaidraptorYesNo(desc)
end
function RaidraptorTribute(cards,min, max)
end
function RaidraptorBattleCommand(cards,targets,act)
  for i,c in pairs(cards) do
    c.index=i
  end
  if HasIDNotNegated(cards,73887236,CanWinBattle,targets) -- Rise Falcon
  then
    return Attack(CurrentIndex)
  end
  if HasIDNotNegated(cards,81927732) then -- Revolution Falcon
    if CardsMatchingFilter(targets,RevolutionFalconFilter,cards[CurrentIndex])>0
    then
      return Attack(CurrentIndex)
    end
  end
  if HasIDNotNegated(cards,96592102,CanWinBattle,targets) -- Blade Burner Falcon
  then
    return Attack(CurrentIndex)
  end
  if HasIDNotNegated(AIHand(),97219708,true,SummonLastStrix,0)
  and DualityCheck()
  and SpaceCheck(1)
  then
    SortByATK(cards)
    for i,c in pairs(cards) do
      if CanAttackSafely(c,targets,.5)
      and RaidraptorMonsterFilter(c)
      then
        return Attack(i)
      end
    end
  end
end
function RaidraptorAttackTarget(cards,attacker)
  if FilterID(attacker,81927732)
  and NotNegated(attacker)
  then
    return BestTargets(cards,1,TARGET_BATTLE,RevolutionFalconFilter,attacker,true,attacker)
  end
  if FilterID(attacker,73887236)
  and NotNegated(attacker)
  then
    return BestTargets(cards,1,TARGET_BATTLE,FilterSummon,SUMMON_TYPE_SPECIAL,true,attacker)
  end
  if FilterID(attacker,96592102)
  and NotNegated(attacker)
  then
    for i,c in pairs(cards) do
      c.index=i
    end
    table.sort(cards,function(a,b) return BattleDamage(a,attacker)>=BattleDamage(b,attacker) end)
    return {cards[1].index}
  end
end
function RaidraptorAttackBoost(cards)
  if HasIDNotNegated(AIMon(),81927732,true,FilterPosition,POS_FACEUP_ATTACK) then
    for i,c in pairs(cards) do
      if RevolutionFalconFilter(c) then
        c.bonus = c.bonus - c.attack
        c.attack = 0
        c.defense = 0
      end
    end
  end
end
function RaidraptorOption(options)
end
function RaidraptorChainOrder(cards)
end
RaidraptorAtt={
83236601, -- Tribute Lanius
60950180, -- Sharp Lanius
53251824, -- Vanishing Lanius

62541668, -- Seven Sins
86221741, -- Zapdos
23603403, -- Satellite Cannon
81927732, -- Revolution Falcon
96592102, -- Burner Falcon
73887236, -- Rise Falcon
}
RaidraptorVary={
10194329, -- Avenge Vulture
96345188, -- Mimikry Lanius
05929801, -- Fuzzy Lanius
31314549, -- Singing Lanius
46589034, -- Pain Lanius
97219708, -- Last Strix
}
RaidraptorDef={ 
73347079, -- Force Strix
}
function RaidraptorPosition(id,available)
  result = nil
  for i=1,#RaidraptorAtt do
    if RaidraptorAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#RaidraptorVary do
    if RaidraptorVary[i]==id 
    then 
      if (BattlePhaseCheck() or IsBattlePhase())
      and Duel.GetTurnPlayer()==player_ai 
      then 
        result=POS_FACEUP_ATTACK
      else 
        result=POS_FACEUP_DEFENSE 
      end
    end
  end
  for i=1,#RaidraptorDef do
    if RaidraptorDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  if id == 73347079 -- Force Strix
  then
    local atk = (CardsMatchingFilter(AIMon(),FilterRace,RACE_WINDBEAST)-1)*500+100
    if atk > 1000
    and BattlePhaseCheck()
    and (#OppMon()==0
    or OppGetStrongestAttDef()<atk)
    then
      result = POS_FACEUP_ATTACK
    end
  end
  return result
end

function TributeCond(loc,c)
  if loc == PRIO_TOHAND then
    if (NormalSummonsAvailable()>0 and OPTCheck(c.id)
    or CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ)>1)
    and not HasID(AIHand(),c.id,true)
    and HasID(AIDeck(),96345188,true) -- Mimikry
    then
      return true
    end
    if not HasID(AIHand(),c.id,true) then
      return 3
    end
    return false
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
  end
  return true
end
function AvengeCond(loc,c)
  if loc == PRIO_TOHAND then
    if HasID(AIHand(),46589034,true) then -- Pain Lanius
      return true
    end
    return false
  end
end
function VanishingCond(loc,c)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AIHand(),RaidraptorMonsterFilter,c.id)>0
    and not HasID(AIHand(),c.id,true)
    and (NormalSummonsAvailable()>0
    or CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ)>1)
  end
  if loc == PRIO_TOFIELD then
    if HasIDNotNegated(AIHand(),97219708,true) -- Last Strix
    and HasIDNotNegated(AIHand(),58988903,true) -- Skip Force
    then
      return true
    end
    if HandCheck(4,RaidraptorMonsterFilter)>0 
    and FieldCheck(4)<2
    and NormalSummonsAvailable()==0
    then
      return true
    end
    return false
  end
  return true
end
function MimikryCond(loc,c)
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id)
    and CardsMatchingFilter(AIGrave(),MimikryGraveFilter)==0
    and FieldCheck(4)>0
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(c.id)
    and CardsMatchingFilter(AIGrave(),MimikryGraveFilter)==0
    and Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_HAND) 
    or FilterLocation(c,LOCATION_GRAVE) and not MimikryGraveFilter(c)
  end
  return true
end
function FuzzyCond(loc,c)
  if loc == PRIO_TOHAND then
    return (CardsMatchingFilter(AICards(),RaidraptorNonXYZFilter,c.id)>0
    or RaidraptorSearchAvailable())
    and not HasAccess(c.id)
  end
  if loc == PRIO_TOFIELD then
    --[[if FilterLocation(c,LOCATION_HAND)
    and OPTCheck(c.id)
    and HasID(AIHand(),31314549,true)
    then
      return 6
    end]]
    if not FilterLocation(c,LOCATION_HAND) then
      return not HasAccess(c.id)
      and FieldCheck(4)==1
    end
  end
  if loc == PRIO_TOGRAVE then
    return OPTCheck(c.id+1)
    and not (FilterLocation(c,LOCATION_DECK)
    and HasAccess(c.id))
  end
  if loc == PRIO_BANISH then
    return not FilterLocation(c,LOCATION_HAND)
  end
  return true
end
function SingingCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ)==1
    and (FieldCheck(4)==1
    or HasID(AIHand(),05929801,true,OPTCheck,true) -- Fuzzy
    or HasID(AIHand(),46589034,true,OPTCheck,true) -- Pain
    or RaidraptorSearchAvailable())
    and DualityCheck()
    and SpaceCheck()+FieldCheck(4)>1
    then
      return true
    end
    return false
  end
  return true
end
function PainLaniusCond(loc,c)
  if loc == PRIO_TOHAND then
    return FieldCheck(4,RaidraptorMonsterFilter)>0
    or HasID(AIHand(),05929801,true,FilterOPT,true) -- Fuzzy
    or HasID(AIHand(),31314549,true) -- Singing
    and CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ)>0
  end
  return true
end
function LastStrixCond(loc,c)
  if loc == PRIO_TOHAND then
    return not (HasID(AICards(),c.id,true))
    and HasIDNotNegated(AICards(),58988903,true) -- Skip Force
    and (NormalSummonsAvailable()>0 or BattlePhaseCheck())
    and DualityCheck()
  end
  if loc == PRIO_TOFIELD then
    return not BattlePhaseCheck()
    and NormalSummonsAvailable()==0
    and HasIDNotNegated(AICards(),58988903,true)
    and OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return not (FilterLocation(c,LOCATION_HAND)
    and HasIDNotNegated(AICards(),58988903,true))
  end
  return true
end
function RRNestCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AIMon(),RaidraptorMonsterFilter)>1 then
      return true
    end
    if CardsMatchingFilter(AIMon(),RaidraptorMonsterFilter)==1 
    and HasID(AIHand(),05929801,true,OPTCheck,true) -- Fuzzy
    and DualityCheck()
    and SpaceCheck()>0
    then
      return true
    end
    if CardsMatchingFilter(AIMon(),RaidraptorMonsterFilter)==1 
    and HasID(AIHand(),46589034,true,OPTCheck,true) -- Pain
    and AI.GetPlayerLP(1)>=1000
    and DualityCheck()
    and SpaceCheck()>0
    then
      return true
    end
    if CardsMatchingFilter(AIMon(),RaidraptorXYZFilter)==1 
    and HasID(AIHand(),31314549,true) -- Singing
    and DualityCheck()
    and SpaceCheck()>0
    then
      return true
    end
    return false
  end
  return true
end
function ForceStrixCond(loc,c)
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_MZONE) 
    and c.xyz_material_count==0
    then
      return true
    end
    return false
  end
end
function SharpCond(loc,c)
  if loc == PRIO_TOFIELD then
    if SummonSharpLanius(c,1) then
      return true
    end
    if SummonSharpLanius(c,2) 
    or SummonSharpLanius(c,3) 
    then
      return 5
    end
    return false
  end
  return true
end
RaidraptorPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Raidraptor

[83236601] = {7,1,6,1,3,1,1,1,3,1,TributeCond},  -- Tribute Lanius
[60950180] = {2,1,8,1,5,1,1,1,7,1,SharpCond},  -- Sharp Lanius
[10194329] = {3,1,5,1,5,1,1,1,7,1,AvengeCond},  -- Avenge Vulture
[53251824] = {8,1,7,1,5,1,1,1,3,1,VanishingCond},  -- Vanishing Lanius
[96345188] = {1,1,8,1,9,1,1,1,6,1,MimikryCond},  -- Mimikry Lanius
[05929801] = {6,1,4,1,8,1,1,1,5,1,FuzzyCond},  -- Fuzzy Lanius
[31314549] = {4,1,3,1,5,1,1,1,5,1,SingingCond},  -- Singing Lanius
[46589034] = {5,1,1,1,5,1,1,1,5,1,PainLaniusCond},  -- Pain Lanius
[97219708] = {9,1,9,0,4,1,1,1,8,2,LastStrixCond},  -- Last Strix

[23581825] = {1,1,1,1,1,1,1,1,1,1,},  -- Soul Shave Force
[58988903] = {1,1,1,1,1,1,1,1,1,1,},  -- Skip Force
[94145683] = {1,1,1,1,1,1,1,1,1,1,},  -- Swallow's Nest
[08559793] = {10,1,1,1,1,1,1,1,1,1,RRNestCond},  -- RR Nest

[21648584] = {1,1,1,1,4,1,1,1,1,1,},  -- Readiness
[66994718] = {1,1,1,1,1,1,1,1,1,1,},  -- Gust

[62541668] = {1,1,1,1,1,1,1,1,1,1,},  -- Seven Sins
[86221741] = {1,1,1,1,1,1,1,1,1,1,},  -- Zapdos
[23603403] = {1,1,1,1,1,1,1,1,1,1,},  -- Satellite Cannon
[81927732] = {1,1,1,1,1,1,1,1,1,1,},  -- Revolution Falcon
[96592102] = {1,1,1,1,1,1,1,1,1,1,},  -- Burner Falcon
[73347079] = {1,1,2,1,5,1,1,1,1,1,ForceStrixCond},  -- Force Strix
[73887236] = {1,1,1,1,1,1,1,1,1,1,},  -- Rise Falcon
} 