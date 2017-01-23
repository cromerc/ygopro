--[[
20292186, -- Artifact Scythe
85103922, -- Artifact Moralltach
71007216, -- Wind Witch Glass Bell
86120751, -- Aleister
43722862, -- Wind Witch Ice Bell
23434538, -- Maxx "C"
70117860, -- Wind Witch Snow Bell

01845204, -- Instant Fusion
73628505, -- Terraforming
74063034, -- Eidolon Summoning Magic
67775894, -- Wonder Wand
47679935, -- Reckless Magic Circle

12444060, -- Artifact Sanctum
05851097, -- Vanity
40605147, -- Strike
84749824, -- Warning
43898403, -- Twin Twister

11270236, -- Elysion
75286621, -- Merkabah
48791583, -- Magallanica
12307878, -- Purgatorio
85908279, -- Cocytus
49513164, -- Raideen
13529466, -- Caligula
50954680, -- Crystal Wing
82044279, -- Clear Wing
14577226, -- Wind Witch Winter Bell
56832966, -- Utopia Lightning
84013237, -- Utopia
]]

function EidolonStartup(deck)
  deck.Init                 = EidolonInit
  deck.Card                 = EidolonCard
  deck.Chain                = EidolonChain
  deck.EffectYesNo          = EidolonEffectYesNo
  deck.Position             = EidolonPosition
  deck.YesNo                = EidolonYesNo
  deck.BattleCommand        = EidolonBattleCommand
  deck.AttackTarget         = EidolonAttackTarget
  deck.AttackBoost          = EidolonAttackBoost
  deck.Tribute              = EidolonTribute
  deck.Option               = EidolonOption
  deck.ChainOrder           = EidolonChainOrder
  deck.Sum                  = EidolonSum
  --[[
  
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = EidolonActivateBlacklist
  deck.SummonBlacklist      = EidolonSummonBlacklist
  deck.RepositionBlacklist  = EidolonRepoBlacklist
  deck.SetBlacklist         = EidolonSetBlacklist
  deck.Unchainable          = EidolonUnchainable
  --[[
  
  ]]
  deck.PriorityList         = EidolonPriorityList
end
EidolonIdentifier = 86120751 -- Aleister
DECK_Eidolon = NewDeck("Eidolon Beast",EidolonIdentifier,EidolonStartup) 
EidolonActivateBlacklist={
71007216, -- Wind Witch Glass Bell
86120751, -- Aleister
43722862, -- Wind Witch Ice Bell
70117860, -- Wind Witch Snow Bell

01845204, -- Instant Fusion
73628505, -- Terraforming
74063034, -- Eidolon Summoning Magic
67775894, -- Wonder Wand
47679935, -- Reckless Magic Circle

12444060, -- Artifact Sanctum

11270236, -- Elysion
--75286621, -- Merkabah
48791583, -- Magallanica
12307878, -- Purgatorio
85908279, -- Cocytus
49513164, -- Raideen
13529466, -- Caligula
--50954680, -- Crystal Wing
82044279, -- Clear Wing
14577226, -- Wind Witch Winter Bell
}
EidolonSummonBlacklist={
20292186, -- Artifact Scythe
85103922, -- Artifact Moralltach
71007216, -- Wind Witch Glass Bell
86120751, -- Aleister
43722862, -- Wind Witch Ice Bell
23434538, -- Maxx "C"
70117860, -- Wind Witch Snow Bell

11270236, -- Elysion
75286621, -- Merkabah
48791583, -- Magallanica
12307878, -- Purgatorio
85908279, -- Cocytus
49513164, -- Raideen
13529466, -- Caligula
50954680, -- Crystal Wing
82044279, -- Clear Wing
14577226, -- Wind Witch Winter Bell
--56832966, -- Utopia Lightning
--84013237, -- Utopia
}
EidolonSetBlacklist={
20292186, -- Artifact Scythe
85103922, -- Artifact Moralltach
74063034, -- Eidolon Summoning Magic
01845204, -- Instant Fusion
}
EidolonRepoBlacklist={
11270236, -- Elysion
85908279, -- Cocytus
}
EidolonUnchainable={
86120751, -- Aleister
49513164, -- Raideen
11270236, -- Elysion
}
function EidolonFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xf4) and check
end
function WindWitchFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xf0) and check
end
function EidolonMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and EidolonFilter(c,exclude)
end

function UseIceBell(c,mode)
  if mode == 1 -- synchro climb for Crystal Wing 
  and CanSpecialSummon()
  and SpaceCheck()>2
  and HasIDNotNegated(AIDeck(),71007216,true) -- Glass Bell
  and HasID(Merge(AIDeck(),AIHand()),70117860,true) -- Snow Bell
  and HasIDNotNegated(AIExtra(),50954680,true) -- Crystal Wing
  and CardsMatchingFilter(AIExtra(),function(c) 
    return FilterType(c,TYPE_SYNCHRO) 
    and FilterLevel(c,7) 
  end)>0
  then
    SetSummonLimit(function(c) 
      return (FilterLevelMin(c,5) 
      and FilterAttribute(c,ATTRIBUTE_WIND))
      or not FilterLocation(c,LOCATION_EXTRA)
    end)
    return true
  end  
  if mode == 2 -- enable Wonder Wand
  and CanSpecialSummon()
  and CardsMatchingFilter(AIMon(),FilterRace,RACE_SPELLCASTER)==0
  and HasIDNotNegated(AICards(),67775894,true,FilterPosition,POS_FACEDOWN) -- Wonder Wand
  then
    SetSummonLimit(function(c) 
      return (FilterLevelMin(c,5) 
      and FilterAttribute(c,ATTRIBUTE_WIND))
      or not FilterLocation(c,LOCATION_EXTRA)
    end)
    return true
  end
  if mode == 3 -- just use (for a synchro)
  and CanSpecialSummon()
  and SpaceCheck()>1
  and HasIDNotNegated(AIDeck(),71007216,true) -- Glass Bell
  --[[and CardsMatchingFilter(AIExtra(),function(c) 
    return FilterType(c,TYPE_SYNCHRO) 
    and FilterLevel(c,7) 
  end)>0]]
  then
    SetSummonLimit(function(c) 
      return (FilterLevelMin(c,5) 
      and FilterAttribute(c,ATTRIBUTE_WIND))
      or not FilterLocation(c,LOCATION_EXTRA)
    end)
    return true
  end
end
function SummonGlassBell(c,mode)
  if mode == 1 -- can make Crystal Wing somehow
  and CanSpecialSummon()
  and not HasID(AIMon(),c.id,true)
  and (SpaceCheck()>1
  and #AIMon() == 1
  and HasID(AIMon(),43722862,true) -- Ice Bell
  and HasID(Merge(AIDeck(),AIHand()),70117860,true) -- Snow Bell
  or SpaceCheck()>0
  and HasID(AIMon(),43722862,true) -- Ice Bell
  and HasID(AIMon(),70117860,true)) -- Snow Bell
  and HasIDNotNegated(AIExtra(),50954680,true) -- Crystal Wing
  and CardsMatchingFilter(AIExtra(),function(c) 
    return FilterType(c,TYPE_SYNCHRO) 
    and FilterLevel(c,7) 
  end)>0
  then
    return true
  end
  if mode == 2 -- search
  and CardsMatchingFilter(AIDeck(),WindWitchFilter,c.id)>0
  and OPTCheck(c.id)
  then
    return true
  end
  if mode == 3 -- enable Wonder Wand
  and CardsMatchingFilter(AIMon(),FilterRace,RACE_SPELLCASTER)==0
  and HasIDNotNegated(AICards(),67775894,true,FilterPosition,POS_FACEDOWN) -- Wonder Wand
  then
    return true
  end
end
function SummonIceBell(c,mode)
  if mode == 1 -- can make Crystal Wing somehow
  and CanSpecialSummon()
  and not HasID(AIMon(),c.id,true)
  and (SpaceCheck()>1
  and #AIMon() == 1
  and HasID(AIMon(),71007216,true) -- Glass Bell
  and HasID(AIHand(),70117860,true) -- Snow Bell
  or SpaceCheck()>0
  and HasID(AIMon(),71007216,true) -- Glass Bell
  and HasID(AIMon(),70117860,true)) -- Snow Bell
  and HasIDNotNegated(AIExtra(),50954680,true) -- Crystal Wing
  and CardsMatchingFilter(AIExtra(),function(c) 
    return FilterType(c,TYPE_SYNCHRO) 
    and FilterLevel(c,7) 
  end)>0
  then
    return true
  end
  if mode == 2 -- finish
  and AI.GetPlayerLP(2)<=500
  then
    return true
  end
  if mode == 3 -- enable Wonder Wand
  and CardsMatchingFilter(AIMon(),FilterRace,RACE_SPELLCASTER)==0
  and HasIDNotNegated(AICards(),67775894,true,FilterPosition,POS_FACEDOWN) -- Wonder Wand
  then
    return true
  end
end
function UseWinterBell(c,mode)
  if mode == 1 
  then
    SetSummonLimit(function(c) 
      return FilterAttribute(c,ATTRIBUTE_WIND) 
    end)
    return true
  end
end
function WinterBellFilter(c)
  return WindWitchFilter(c,14577226)
  and c.level*200>=AI.GetPlayerLP(2)
end
function SummonWinterBell(c,mode)
  if mode == 1 -- synchro climb for Crystal Wing 
  and CanSpecialSummon()
  and not HasID(AIMon(),c.id,true)
  and HasID(AIMon(),70117860,true) -- Snow Bell
  and HasIDNotNegated(AIExtra(),50954680,true) -- Crystal Wing
  then
    return true
  end
  if mode == 2 -- finish game
  and NotNegated(c)
  and CardsMatchingFilter(Merge(AIMon(),AIGrave()),WinterBellFilter)>0
  then
    return true
  end
  if mode == 3 -- beatstick
  and CanSpecialSummon()
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function SummonClearWingEidolon(c,mode)
  if mode == 1 -- synchro climb for Crystal Wing 
  and CanSpecialSummon()
  and HasID(AIMon(),70117860,true) -- Snow Bell
  and HasIDNotNegated(AIExtra(),50954680,true) -- Crystal Wing
  then
    return true
  end
  if mode == 2 -- just summon whenever
  --and CanSpecialSummon()
  then
    return true
  end
end
function UseSnowBell(c,mode)
  if mode == 1 -- synchro climb for Crystal Wing 
  and CanSpecialSummon()
  and not HasID(AIMon(),c.id,true)
  and HasIDNotNegated(AIExtra(),50954680,true) -- Crystal Wing
  and CardsMatchingFilter(AIMon(),WindWitchFilter)==2
  then
    return true
  end
  if mode == 2 -- enable Wonder Wand
  and CanSpecialSummon()
  and HasIDNotNegated(AICards(),67775894,true,FilterPosition,POS_FACEDOWN) -- Wonder Wand
  then
    return true
  end
end
function SummonSnowBell(c,mode)
  if mode == 1 -- enable Wonder Wand
  and CardsMatchingFilter(AIMon(),FilterRace,RACE_SPELLCASTER)==0
  and HasIDNotNegated(AICards(),67775894,true,FilterPosition,POS_FACEDOWN) -- Wonder Wand
  then
    return true
  end
end
function UseMagicCircle(c,mode)
  if mode == 1 
  and HasID(AIDeck(),86120751,true) -- Aleister
  then
    return true
  end
end
function RepoAleister(c,mode)
	if mode == 1
  and FilterPosition(c,POS_FACEDOWN_DEFENSE)
  and HasID(AIDeck(),74063034,true) -- Eidolon Magic
  then
    return true
  end
end
function SummonAleister(c,mode)
  if mode == 1
  and HasID(AIDeck(),74063034,true) -- Eidolon Magic
  then
    return true
  end
end
function UseAleister(c,act)
	if HasIDNotNegated(act,74063034,true,UseEidolonSummon,2)
  and CardsMatchingFilter(Merge(AIField(),AIGrave(),OppGrave()),FilterID,c.id)==0
  and CardsMatchingFilter(Merge(AIField(),AIHand()),FilterID,74063034)<2 -- Eidolon Magic
  then
    GlobalEidolonSummonID = nil
		return true
	end 
end
function UseMaxxEidolon(c,act)
  if HasIDNotNegated(act,74063034,true,UseEidolonSummon,2)
  and GlobalEidolonSummonID == 48791583 -- Magallanica
  and CardsMatchingFilter(Merge(AIGrave(),OppGrave()),FilterAttribute,ATTRIBUTE_EARTH)==0
  then
    GlobalEidolonSummonID = nil
		return true
	end 
end
function UseWonderWand(c,mode)
  if mode == 1
  and FilterLocation(c,LOCATION_SZONE)
  and FilterPosition(c,POS_FACEUP)
  and #AIDeck()>5
  then
    return true
  end
  if mode == 2
  and HasID(AIMon(),86120751,true,FilterPosition,POS_FACEUP)
  then
    return true
  end
  if mode == 3
  and FilterPosition(c,POS_FACEDOWN)
  then
    return true
  end
end
function UseEidolonSummon(c,mode)
  if mode == 1 -- from grave
  and  FilterLocation(c,LOCATION_GRAVE)
  then
    OPTSet(c.id)
    return true
  end
  if (mode == 2 or mode == 0)
  and FilterLocation(c,LOCATION_HAND+LOCATION_SZONE)
  and SpaceCheck()+CardsMatchingFilter(AIMon(),FilterID,86120751)>0 -- Aleister
  then
    if HasID(AIExtra(),12307878,true,SummonPurgatorio,3)
    then
      GlobalEidolonSummonID = 12307878
      return true
    end
    if HasID(AIExtra(),11270236,true,SummonElysion,1)
    then
      GlobalEidolonSummonID = 11270236 
      return true
    end
    if HasID(AIExtra(),12307878,true,SummonPurgatorio,1)
    then
      GlobalEidolonSummonID = 12307878
      return true
    end
    if HasID(AIExtra(),75286621,true,SummonMerkabah,1)
    then
      GlobalEidolonSummonID = 75286621
      return true
    end
    if HasID(AIExtra(),49513164,true,SummonRaideen,1)
    then
      GlobalEidolonSummonID = 49513164
      return true
    end
    if HasID(AIExtra(),48791583,true,SummonMagallanica,1)
    then
      GlobalEidolonSummonID = 48791583
      return true
    end
    if HasID(AIExtra(),85908279,true,SummonCocytus,1)
    then
      GlobalEidolonSummonID = 85908279
      return true
    end
    if HasID(AIExtra(),11270236,true,SummonElysion,2)
    then
      GlobalEidolonSummonID = 11270236
      return true
    end
    if HasID(AIExtra(),75286621,true,SummonMerkabah,2)
    then
      GlobalEidolonSummonID = 75286621
      return true
    end
    if HasID(AIExtra(),12307878,true,SummonPurgatorio,2)
    then
      GlobalEidolonSummonID = 12307878
      return true
    end
    if HasID(AIExtra(),49513164,true,SummonRaideen,2)
    then
      GlobalEidolonSummonID = 49513164
      return true
    end
    if HasID(AIExtra(),85908279,true,SummonCocytus,2)
    then
      GlobalEidolonSummonID = 85908279
      return true
    end
  end
end
function EidolonMaterialFilter(c,mode)
  if mode == 2 then
    return FilterLocation(c,LOCATION_GRAVE)
    or FilterLocation(c,LOCATION_HAND) --and FilterID(c,86120751,true) -- Aleister
    or FilterLocation(c,LOCATION_MZONE) 
    and not (FilterType(c,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ)
    or FilterCrippled(c) or FilterOwner(c,2))
  end
end
function EidolonMaterialFilter2(c,attribute)
  return c.attribute == attribute
  and ExcludeID(c,86120751,true) -- Aleister
end
function ElysionMaterialFilter(c,args)
  local mode = args[1]
  local cards = args[2]
  return FilterPreviousLocation(c,LOCATION_EXTRA)
  and (mode == 2 or FilterID(c,13529466) or FilterCrippled(c)) -- Caligula
  and CardsMatchingFilter(cards,EidolonFilter,c)>0
end
function CanSummonEidolon(c,mode)
  if not (CanSpecialSummon()
  and CheckSummonLimit(c)
  and FilterLocation(c,LOCATION_EXTRA)
  and EidolonFilter(c))
  then
    return false
  end
  if mode == 1
  and HasIDNotNegated(AIMon(),c.id,true,FilterNotCrippled)
  then
    return false
  end
  local cards = {}
  if mode == 1 then -- can summon using favourable materials only
    cards = Merge(AIGrave(),OppGrave(),SubGroup(Merge(AIField(),AIHand()),EidolonMaterialFilter,2))
  elseif mode == 2 then -- can summon at all, regardless of materials
    cards = Merge(AIHand(),AIField(),AIGrave(),OppGrave())
  end
  if c.id == 11270236 then -- Elysion
    return CardsMatchingFilter(AIMon(),ElysionMaterialFilter,{mode,cards})>0
  end
  if not HasID(cards,86120751,true) then -- Aleister
    return false
  end
  return CardsMatchingFilter(cards,EidolonMaterialFilter2,c.attribute)>0
end
function SummonElysion(c,mode)
  if mode == 1
  and CanSummonEidolon(c,1)
  and NotNegated(c)
  then
    return true
  end
  if mode == 2
  and CanSummonEidolon(c,1)
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function SummonMerkabah(c,mode)
  if mode == 1
  and CanSummonEidolon(c,1)
  and NotNegated(c)
  then
    return true
  end
  if mode == 2
  and CanSummonEidolon(c,1)
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function SummonCocytus(c,mode)
  if mode == 1
  and CanSummonEidolon(c,1)
  and NotNegated(c)
  then
    return true
  end
  if mode == 2
  and CanSummonEidolon(c,1)
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function SummonMagallanica(c,mode)
  if mode == 1
  and CanSummonEidolon(c,1)
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function SummonRaideen(c,mode)
  if mode == 1
  and CanSummonEidolon(c,1)
  and NotNegated(c)
  then
    return true
  end
  if mode == 2
  and CanSummonEidolon(c,1)
  and CanWinBattle(c,OppMon())
  then
    return true
  end
  if mode == 3
  and NotNegated(c)
  and CanSpecialSummon()
  and CheckSummonLimit(c)
  and not HasIDNotNegated(AIMon(),c.id,true,FilterNotCrippled)
  then
    return true
  end
end
function PurgatorioBattleDamage(c,targets,aleister)
    c = GetCardFromScript(c)
    local amount = 0
    local bonus = 0
    if FilterLocation(c,LOCATION_MZONE) and NotNegated(c) then
      bonus = -100*(#OppMon()-1) -- gets reduced for each kill
    end
    if FilterLocation(c,LOCATION_EXTRA) and NotNegated(c) then
      bonus = 100*(#OppMon()+1)
    end
    if MacroCheck() 
    and aleister 
    then
      bonus = bonus + 1000 * CardsMatchingFilter(AIHand(),FilterID,86120751) -- Aleister
      if OPTCheck(74063034) -- Eidolon Summoning Magic
      and CardsMatchingFilter(Merge(AIMon(),AIGrave()),FilterID,86120751) -- Aleister
      then
        bonus = bonus + 1000
      end
    end
    for i,target in pairs(targets) do
      amount = amount + BattleDamage(target,c,c.attack+bonus,nil,nil,true)
    end
    return amount
end
function PurgatorioFilter(c,source)
  source = GetCardFromScript(source)
  c = GetCardFromScript(c)
  return CanWinBattle(source,{c})
end
function SummonPurgatorio(c,mode)
  if mode == 1 
  and CanSummonEidolon(c,1)
  and BattlePhaseCheck()
  and CardsMatchingFilter(OppMon(),PurgatorioFilter,c)>1
  then
    return true
  end
  if mode == 2
  and CanSummonEidolon(c,1)
  and CanWinBattle(c,OppMon())
  then
    return true
  end
  if mode == 3 -- finish
  and CanSummonEidolon(c,1)
  and BattlePhaseCheck()
  then
    local targets = SubGroup(OppMon(),PurgatorioFilter,c)
    if PurgatorioBattleDamage(c,targets,true)>=AI.GetPlayerLP(2) then
      return true
    end
  end
end
function SummonCaligula(c,mode)
  if mode == 1 -- summon via Instant Fusion to enable Elysion
  and CanSpecialSummon()
  and FilterLocation(c,LOCATION_EXTRA)
  and CheckSummonLimit(c)
  and HasIDNotNegated(AICards(),74063034,true) -- Eidolon Magic
  and HasID(AIExtra(),11270236,true) -- Elysion
  and CardsMatchingFilter(Merge(AIGrave(),OppGrave()),EidolonFilter)>0
  then
    return true
  end
end
function UseIFEidolon(c,mode)
  if AI.GetPlayerLP(1)<=1000
  or not CanSpecialSummon()
  then
    return false
  end
  if mode == 1
  and HasID(AIExtra(),13529466,true,SummonCaligula,1)
  then
    GlobalIFTarget=13529466 -- Caligula
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIExtra(),49513164,true,SummonRaideen,3)
  then
    GlobalIFTarget=49513164 -- Raideen
    return true
  end
end
function UseRaideen(c,mode)
  if mode == 1 then
    targets = SubGroup(OppMon(),RaideenFilter)
    targets = SubGroup(OppMon(),MoonWhitelist)
    if #targets>0 then
      GlobalCardMode = 1
      GlobalTargetSet(targets[1])
      return true
    end
  end
  if mode == 2
  then 
    local attackers = SubGroup(AIMon(),CanAttack)
    local targets = SubGroup(OppMon(),RaideenFilter)
    targets = SubGroup(targets,FilterPosition,POS_FACEUP_ATTACK)
    table.sort(attackers,function(a,b) return a.attack>b.attack end)
    table.sort(targets,function(a,b) return a.attack>b.attack end)
    if #attackers>0 and #targets>0
    and attackers[1].attack<=targets[1].attack 
    then
      GlobalCardMode = 1
      GlobalTargetSet(targets[1])
      return true
    end
    targets = SubGroup(OppMon(),RaideenFilter)
    targets = SubGroup(targets,function (c) return c.equip_count>0 end)
    if #targets>0 then
      table.sort(targets,function(a,b) return a.equip_count>b.equip_count end)
      GlobalCardMode = 1
      GlobalTargetSet(targets[1])
      return true
    end
  end
  if mode == 3
  and HasID(AIDeck(),74063034,true) -- Eidolon Summon
  then
    for i,c in pairs(AIMon()) do
      if FilterID(c,86120751) -- Aleister
      and FilterPosition(c,POS_FACEUP)
      and CanChangePos(c)
      then
        GlobalCardMode = 1
        GlobalTargetSet(c)
        return true
      end
    end
  end   
  if mode == 4
  then
    local filter = function(c) 
      return FilterCrippled(c) 
      and FilterPosition(c,POS_FACEUP)
      and CanChangePos(c)
    end
    for i,c in pairs(AIMon()) do
      if filter(c) then
        GlobalCardMode = 1
        GlobalTargetSet(c)
        return true
      end
    end
  end
end
function UseTerraformingEidolon(c,mode)
  if mode == 1
  and not HasIDNotNegated(AIST(),05851097,true,FilterPosition,POS_FACEUP)
  or OppHasStrongestMonster()
  then 
    return true
  end
end
function EidolonInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,49513164,UseRaideen,1) then
    return Activate()
	end
  if HasIDNotNegated(Act,49513164,UseRaideen,3) then
    return Activate()
	end
  if HasIDNotNegated(Act,49513164,UseRaideen,4) then
    return Activate()
	end
  for i,c in pairs(Rep) do
    for j,id in pairs(EidolonAtt) do
      if FilterPosition(c,POS_FACEDOWN_DEFENSE)
      and FilterID(c,id)
      then
        return Repo(i)
      end
    end
  end
	if HasIDNotNegated(Act,73628505,UseTerraformingEidolon,1) then -- Terraforming
		return Activate()
	end
	if HasIDNotNegated(Act,74063034,UseEidolonSummon,1) then
	  return Activate()
  end
  if HasIDNotNegated(Act,47679935,UseMagicCircle,1) then
	  return Activate()
  end
  if HasIDNotNegated(Act,43722862,UseIceBell,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,70117860,UseSnowBell,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,70117860,UseSnowBell,2) then
    return Activate()
  end
  if HasID(Sum,43722862,SummonIceBell,2) then
    return Summon()
  end
  if HasID(Sum,71007216,SummonGlassBell,1) then
    return Summon()
  end
  if HasID(Sum,43722862,SummonIceBell,1) then
    return Summon()
  end
  if HasID(Act,14577226,UseWinterBell,1) then
    return Activate()
  end
  if HasID(SpSum,14577226,SummonWinterBell,2) then
    return SynchroSummon()
  end
  if HasID(SpSum,14577226,SummonWinterBell,1) then
    return SynchroSummon()
  end
  if HasID(SpSum,82044279,SummonClearWingEidolon,1) then
    return SynchroSummon()
  end
  if HasID(SpSum,50954680,SummonCrystalWing,1) then
    return SynchroSummon()
  end
  if HasID(SpSum,82044279,SummonClearWingEidolon,2) then
    return SynchroSummon()
  end
  if HasID(SpSum,14577226,SummonWinterBell,3) then
    return SynchroSummon()
  end
  if HasIDNotNegated(Rep,86120751,RepoAleister,1) then
    return Repo()
  end
	if HasIDNotNegated(Sum,86120751,SummonAleister,1) then
    return Summon()
  end
  if HasIDNotNegated(Act,67775894,UseWonderWand,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,67775894,UseWonderWand,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,67775894,UseWonderWand,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,43722862,UseIceBell,2) then
    return Activate()
  end
  if HasID(Sum,71007216,SummonGlassBell,3) then
    return Summon()
  end
  if HasID(Sum,43722862,SummonIceBell,3) then
    return Summon()
  end
  if HasID(Sum,70117860,SummonSnowBell,1) then
    return Summon()
  end
  if HasIDNotNegated(Act,01845204,UseIFEidolon,1) then
		return Activate()
	end
  if HasID(Act,86120751,UseAleister,Act) then
		return Activate()
	end
  if HasID(Act,23434538,UseMaxxEidolon,Act) then
		return Activate()
	end
	if HasIDNotNegated(Act,74063034,UseEidolonSummon,2) then
		return Activate()
	end
  if HasIDNotNegated(Act,49513164,UseRaideen,2) then
    return Activate()
	end
  if HasIDNotNegated(Act,01845204,UseIFEidolon,2) then
		return Activate()
	end
  if HasIDNotNegated(Act,43722862,UseIceBell,3) then
    return Activate()
  end
  if HasID(Sum,71007216,SummonGlassBell,2) then
    return Summon()
  end
  
  if #SetST > 0 
  and TurnEndCheck()
  then
    local setThisTurn = 0
    for i,c in pairs(AIST()) do
      if FilterStatus(c,STATUS_SET_TURN) then
        setThisTurn=setThisTurn+1
      end
    end
    local targets = {}
    for i,c in pairs(SetST) do
      if setThisTurn < 3 and #AIST()<4
      and (SetBlacklist(c.id)==0 
      and FilterType(c,TYPE_TRAP+TYPE_QUICKPLAY)
      or FilterType(c,TYPE_MONSTER)
      and ArtifactFilter(c)
      and HasID(AICards(),43898403,true)) -- Twin Twister
      and DiscardCheck()
      then
        targets[#targets+1]=i
      end
    end
    if #targets>0 then
      return SetSpell(targets[math.random(#targets)])
    end
  end
  return nil
end
function IceBellTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
function GlassBellTarget(cards)
  return Add(cards)
end
function WinterBellTarget(cards)
  local result = {0,0}
  for i,c in pairs(cards) do
    if c.level > result[1] then
      result[1]=c.level
      result[2]=i
    end
  end
  return {result[2]}
end
function AleisterTarget(cards)
  if LocCheck(cards,LOCATION_MZONE) then
    if GlobalCardMode == 1 then
      GlobalCardMode = nil
      return BestTargets(cards,1,TARGET_PROTECT,FilterGlobalTarget,cards)
    end
    return BestTargets(cards,1,TARGET_PROTECT,FilterID,12307878) -- Purgatorio
  end
  return Add(cards)
end
function EidolonSummonFilter(c)
  return FilterOwner(c,2)
  and FilterLocation(c,LOCATION_GRAVE)
end
function EidolonSummonTarget(cards)
  if LocCheck(cards,LOCATION_EXTRA) then
    if GlobalEidolonSummonID then
      local id = GlobalEidolonSummonID
      GlobalEidolonSummonID = nil
      return Add(cards,PRIO_TOFIELD,1,FilterID,id)
    end
    return Add(cards,PRIO_TOFIELD)
  end
  if CardsMatchingFilter(cards,EidolonSummonFilter)>0
  then
    return BestTargets(cards,1,TARGET_BANISH,EidolonSummonFilter)
  end
  if CardsMatchingFilter(cards,FilterLocation,LOCATION_GRAVE)==0
  and CardsMatchingFilter(cards,FilterID,86120751)==#cards -- Aleister
  then
    return Add(cards,PRIO_BANISH,1,FilterLocation,LOCATION_MZONE)
  end
  return Add(cards,PRIO_BANISH,1,FilterLocation,LOCATION_GRAVE)
end
function RaideenTarget(cards)
  if GlobalCardMode == 2 then
    GlobalCardMode = nil
    return BestTargets(cards,1,TARGET_FACEDOWN,FilterID,86120751) -- Aleister
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return BestTargets(cards,1,TARGET_FACEDOWN,FilterGlobalTarget,cards)
  end
  return BestTargets(cards,1,TARGET_FACEDOWN)
end
function ElysionTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return BestTargets(cards,1,TARGET_BANISH,FilterGlobalTarget,cards)
  end
  return BestTargets(cards,1,TARGET_BANISH,FilterID,11270236) -- Elysion
end
function WonderWandTarget(cards)
  return Add(cards,PRIO_TOGRAVE,1,FilterID,86120751) -- Aleister
end
function SanctumTargetEidolon(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    local id = GlobalSanctumID
    GlobalSanctumID = nil
    return Add(cards,PRIO_TOFIELD,1,FilterID,id)
  end
  if CardsMatchingFilter(OppField,MoralltachFilter)>0 then
    return Add(cards,PRIO_TOFIELD,1,FilterID,85103922) -- Moralltach
  end
  return Add(cards,PRIO_TOFIELD,1,FilterID,20292186) -- Scythe
end
EidolonTargetFunctions={
[43722862] = IceBellTarget,
[71007216] = GlassBellTarget,
[14577226] = WinterBellTarget,
[86120751] = AleisterTarget,
[74063034] = EidolonSummonTarget,
[49513164] = RaideenTarget,
[11270236] = ElysionTarget,
[67775894] = WonderWandTarget,
}
function EidolonCard(cards,min,max,id,c)
  for i,v in pairs(EidolonTargetFunctions) do
    if id == i then
      return v(cards,c,min,max)
    end
  end
end
function ChainIceBell(c)
  return true
end
function ChainGlassBell(c)
  OPTSet(c.id)
  return true
end
function ChainAleister(c)
	if c.description == c.id*16+1 
  and NotNegated(c)
  then
		return true
	end
	if c.description == c.id*16
  and IsBattlePhase()
  and Duel.GetCurrentPhase()==PHASE_DAMAGE
	then
		local aimon,oppmon = GetBattlingMons()
		local count = CardsMatchingFilter(AIHand(),FilterID,c.id)
    if aimon and oppmon 
    and FilterID(aimon,12307878) -- Purgatorio
    then
      local targets = SubGroup(OppMon(),PurgatorioFilter,aimon)
      if PurgatorioBattleDamage(aimon,targets,false) < AI.GetPlayerLP(2)
      and PurgatorioBattleDamage(aimon,targets,true) >= AI.GetPlayerLP(2)
      and UnchainableCheck(c.id)
      then
        GlobalCardMode = 1
        GlobalTargetSet(aimon)
        return true
      end
    end
		if aimon and oppmon
    and EidolonMonsterFilter(aimon)
    and (AttackBoostCheck(1000*count) 
		or (CanFinishGame(aimon,oppmon,aimon:GetAttack()+1000*count)
    and not CanFinishGame(aimon,oppmon)))
		and UnchainableCheck(c.id)
		then
      GlobalCardMode = 1
      GlobalTargetSet(aimon)
			return true
		end
    if aimon and #OppMon()==0
    and EidolonMonsterFilter(aimon)
    and CanFinishGame(aimon,nil,aimon:GetAttack()+1000*count)
    and not CanFinishGame(aimon,nil)
		and UnchainableCheck(c.id)
		then
      GlobalCardMode = 1
      GlobalTargetSet(aimon)
			return true
		end
	end
end
function RaideenFilter(c,opp)
  return FilterType(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP)
  and Affected(c,TYPE_MONSTER,5)
  and Targetable(c,TYPE_MONSTER)
  and not FilterType(c,TYPE_TOKEN)
  and not (opp and FilterType(c,TYPE_FLIP))
end

function IFTargetFilter(c)
  c = GetScriptFromCard(c)
  return c:GetFlagEffect(1845204)~=0
end
function ChainRaideen(c)
  if Negated(c) then return false end
  local targets1 = SubGroup(OppMon(),RaideenFilter,true)
  local targets2 = SubGroup(targets1,MoonWhitelist)
  if #targets2>0
  and (UnchainableCheck(c.id)
  or RemovalCheckCard(c))
  then
    return true
  end
  local IF = SubGroup(AIMon(),IFTargetFilter)
  if Duel.CheckTiming(TIMING_END_PHASE) 
  and #IF>0
  then
    GlobalCardMode = 1
    GlobalTargetSet(IF[1])
    return true
  end
  for i=1,Duel.GetCurrentChain() do
    local protect = NegateCheckList(AIMon(),nil,i,RaideenFilter)
    local tg = Duel.GetChainInfo(i,CHAININFO_TARGET_CARDS)
    if tg and tg:GetCount()>0
    and protect and #protect>0
    and i>1
    then
      GlobalCardMode = 1
      GlobalTargetSet(protect[1])
      SetNegated(i)
      return true
    end
    protect = RemovalCheckList(AIMon(),nil,nil,i,RaideenFilter)
    local e,c,id = EffectCheck(1-player_ai,i)
    if e and MoonWhitelist2(e:GetHandler():GetCode())
    and protect and #protect>0
    then
      GlobalCardMode = 1
      GlobalTargetSet(protect[1])
      SetNegated(i)
      return true
    end
  end
  if UnchainableCheck(c.id)
  or RemovalCheckCard(c)
  then
    for i=1,Duel.GetCurrentChain() do
      local e,c,id = EffectCheck(1-player_ai,i)
      if e 
      and (FilterSet(c,0x95) -- Rank-Up 
      or FilterSet(c,0xa5)) -- Mask Change
      then
        local target = Duel.GetChainInfo(i,CHAININFO_TARGET_CARDS):GetFirst()
        if target and RaideenFilter(target) then
          GlobalCardMode = 1
          GlobalTargetSet(target[1])
          SetNegated(i)
          return true
        end
      end
    end    
  end
  if IsBattlePhase() 
  and Duel.GetTurnPlayer()==1-player_ai 
  and (UnchainableCheck(c.id)
  or RemovalCheckCard(c))
  then
    local aimon,oppmon = GetBattlingMons()
    if aimon and oppmon 
    --and WinsBattle(oppmon,aimon) 
    and FilterID(aimon,86120751) -- Aleister
    and FilterPosition(aimon,POS_FACEUP)
    and HasID(AIDeck(),74063034,true) -- Eidolon Magic
    then
      GlobalCardMode = 1
      GlobalTargetSet(aimon)
      return true
    end
    if aimon and oppmon 
    and WinsBattle(oppmon,aimon) 
    and RaideenFilter(oppmon) 
    then
      GlobalCardMode = 1
      GlobalTargetSet(oppmon)
      return true
    end
  end
  if IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai 
  and (UnchainableCheck(c.id)
  or RemovalCheckCard(c))
  then
    local attackers = SubGroup(AIMon(),CanAttack)
    local targets = SubGroup(OppMon(),RaideenFilter)
    targets = SubGroup(targets,FilterPosition,POS_FACEUP_ATTACK)
    table.sort(attackers,function(a,b) return a.attack>b.attack end)
    table.sort(targets,function(a,b) return a.attack>b.attack end)
    if #attackers>0 and #targets>0
    and attackers[1].attack<=targets[1].attack 
    then
      GlobalCardMode = 1
      GlobalTargetSet(targets[1])
      return true
    end
    local targets = SubGroup(OppMon(),RaideenFilter)
    targets = SubGroup(targets,function (c) return c.equip_count>0 end)
    if #targets>0 then
      table.sort(targets,function(a,b) return a.equip_count>b.equip_count end)
      GlobalCardMode = 1
      GlobalTargetSet(targets[1])
      return true
    end
  end
  if Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetCurrentChain()==0 
  and HasID(AIMon(),86120751,true,FilterPosition,POS_FACEUP) -- Aleister
  then
    GlobalCardMode = 2
    return true
  end
  if Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetCurrentChain()==0 
  and Duel.GetTurnPlayer()==1-player_ai
  then
    local filter = function(c) 
      return FilterCrippled(c) 
      and FilterPosition(c,POS_FACEUP)
      and CanChangePos(c)
    end
    for i,c in pairs(AIMon()) do
      if filter(c) then
        GlobalCardMode = 1
        GlobalTargetSet(c)
        return true
      end
    end
  end
  if RemovalCheckCard(c) then
    if #targets1>0 
    and Duel.GetTurnPlayer()==1-player_ai
    then
      return true
    end
    if HasID(AIMon(),86120751,true,FilterPosition,POS_FACEUP) -- Aleister
    then
      GlobalCardMode = 2
      return true
    end
  end
end
function ElysionFilter(c,attribute)
  return Affected(c,TYPE_MONSTER,10)
  and FilterAttribute(c,0x3f) -- all attributes but divine
  and not attribute or FilterAttribute(c,attribute)
end
function ChainElysion(source)
  if Negated(source) then return false end
  local cards = SubGroup(Merge(AIMon(),AIGrave()),EidolonMonsterFilter,source)
  local eidolons = {}
  for i,c in pairs(cards) do
    eidolons[c.attribute]=c
  end
  local targets = SubGroup(OppMon(),ElysionFilter)
  local prio = SubGroup(targets,PriorityTarget)
  --print("targets: "..#targets)
  --print("priority: "..#prio)
  --[[if RemovalCheckList(eidolons) 
  and UnchainableCheck(source.id)
  then
    local removal = RemovalCheckList(eidolons)
    for attribute,c in removal, do
      if FilterLocation(c,LOCATION_ONFIELD) 
      and CardsMatchingFilter(targets,FilterAttribute,attribute)>1]]
  if RemovalCheckCard(source) 
  and #targets>0 
  then
    return true
  end
  for i,c in pairs(AIMon()) do
    if EidolonMonsterFilter(c,source)
    and RemovalCheckCard(c)
    and CardsMatchingFilter(targets,FilterAttribute,c.attribute)>1
    then
      GlobalCardMode = 1
      GlobalTargetSet(c)
      return true
    end
  end
  if UnchainableCheck(source.id)
  and Duel.GetTurnPlayer()==1-player_ai
  then
    local phasemod = 0
    if Duel.CheckTiming(TIMING_END_PHASE) then
      phasemod = 1
    end
    for attribute,c in pairs(eidolons) do
      if FilterLocation(c,LOCATION_GRAVE) 
      and CardsMatchingFilter(targets,FilterAttribute,attribute)
      +CardsMatchingFilter(prio,FilterAttribute,attribute)*2>2-phasemod
      then
        GlobalCardMode = 1
        GlobalTargetSet(c)
        return true
      end
      if FilterLocation(c,LOCATION_MZONE) 
      and CardsMatchingFilter(targets,FilterAttribute,attribute)
      +CardsMatchingFilter(prio,FilterAttribute,attribute)*2>3-phasemod
      then
        GlobalCardMode = 1
        GlobalTargetSet(c)
        return true
      end
    end
    if #prio*2+#targets>3-phasemod then
      return true
    end
    local aimon,oppmon = GetBattlingMons()
    if IsBattlePhase() 
    and aimon and oppmon
    and WinsBattle(oppmon,aimon)
    then
      for attribute,c in pairs(eidolons) do
        if FilterLocation(c,LOCATION_GRAVE) 
        and FilterAttribute(c,oppmon:GetAttribute())
        and ElysionFilter(oppmon)
        then
          GlobalCardMode = 1
          GlobalTargetSet(c)
          return true
        end
      end
      if EidolonMonsterFilter(aimon,source)
      and CardsMatchingFilter(targets,FilterAttribute,attribute)>0
      then
        GlobalCardMode = 1
        GlobalTargetSet(aimon)
        return true
      end
      if CardsEqual(aimon,source)
      and #targets>0
      then
        return true
      end
    end
  end
end
function ChainSanctumEidolon(c)
  if Negated(c) then return false end
  local targets = SubGroup(OppField(),MoralltachFilter)
  local prio = SubGroup(targets,PriorityTarget)
  if (UnchainableCheck(c)
  or RemovalCheckCard(c))
  and #prio>0
  and HasIDNotNegated(AIDeck(),85103922,true) -- Moralltach
  then
    GlobalCardMode = 1
    GlobalSanctumID = 85103922 -- Moralltach
    return true
  end
  if (UnchainableCheck(c)
  or RemovalCheckCard(c))
  and Duel.GetTurnPlayer()==1-player_ai
  and IsMainPhase()
  and HasIDNotNegated(AIDeck(),20292186,true) -- Scythe
  and ScytheCheck()
  then
    GlobalCardMode = 1
    GlobalSanctumID = 20292186 -- Scythe
    return true
  end
  if IsBattlePhase()
  and (UnchainableCheck(c)
  or RemovalCheckCard(c))
  and HasIDNotNegated(AIDeck(),85103922,true) -- Moralltach
  then
    local aimon, oppmon = GetBattlingMons()
    if WinsBattle(oppmon,aimon)
    and MoralltachFilter(oppmon)
    then
      GlobalCardMode = 1
      GlobalSanctumID = 85103922 -- Moralltach
      return true
    end
  end
  if Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetTurnPlayer()==1-player_ai
  and CanSpecialSummon()
  and Duel.GetCurrentChain()==0
  then
    if HasIDNotNegated(AIDeck(),85103922,true) -- Moralltach
    and #targets>0
    then
      GlobalCardMode = 1
      GlobalSanctumID = 85103922 -- Moralltach
      return true
    end
    if HasIDNotNegated(AIDeck(),20292186,true) -- Scythe
    and CardsMatchingFilter(Merge(AICards(),AIGrave(),OppGrave()),FilterAttribute,ATTRIBUTE_LIGHT)==0
    then
      GlobalCardMode = 1
      GlobalSanctumID = 20292186 -- Scythe
      return true
    end
  end
  if RemovalCheckCard(c) then
    return true
  end
end
function ChainTwinTwister(c,mode)
  local targets = DestroyCheck(OppST())
  local facedown = DestroyCheck(OppST(),nil,nil,nil,FilterPosition,POS_FACEDOWN)
  local prio = HasPriorityTarget(OppST(),true)
  local endphase = CardsMatchingFilter(OppST(),MSTEndPhaseFilter)
  local scythe = CardsMatchingFilter(AIST(),FilterID,20292186) -- Scythe
  local moralltach = CardsMatchingFilter(AIST(),FilterID,85103922) -- Moralltach
  local artifacts = scythe+moralltach
  if not (CanSpecialSummon() 
  and SpaceCheck()>0
  and Duel.GetTurnPlayer()==1-player_ai) 
  then
    scythe = 0
    moralltach = 0
    artifacts = 0
  end
  if RemovalCheckCard(c)
  then
    return targets>1 or targets>0 
    and (PriorityCheck(AIHand(),PRIO_TOGRAVE)>3
    or artifacts>0)
  end
  if not UnchainableCheck(c) then
    return false
  end
  if scythe>0 
  and ScytheCheck()
  and targets>0
  then
    GlobalTwinTwisterTarget = FindID(20292186,AIST())
    return true
  end
  if Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetCurrentChain()==0
  and endphase>0
  and (targets>1
  or targets>0 and artifacts>0)
  then
    GlobalTwinTwisterTarget = MSTEndPhaseFilter
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai
  and prio
  and (targets>1 or artifacts>0)
  then
    return true
  end
  local target = RemoveOnActivation(nil,MSTFilter)
  if target and (targets>1 or artifacts>0) then
    GlobalTwinTwisterTarget = target
    return true
  end
end
EidolonChainFunctions={
[43722862] = ChainIceBell,
[71007216] = ChainGlassBell,
[86120751] = ChainAleister,
[49513164] = ChainRaideen,
[11270236] = ChainElysion,
[12444060] = ChainSanctumEidolon,
}
function EidolonChain(cards)
  for id,v in pairs(EidolonChainFunctions) do
    if HasID(cards,id,v) then
      return Chain()
    end
  end
end
function EidolonEffectYesNo(id,card)
  for i,v in pairs(EidolonChainFunctions) do
    if id == i 
    and NotNegated(card) 
    then
      return v(card)
    end
  end
  return result
end
function EidolonSum(cards,sum,card)
end
function EidolonYesNo(desc)
  if desc == 43722862*16+1 then -- Ice Bell
    if CanSpecialSummon() then
      return 1
    end
    return 0
  end
end
function EidolonTribute(cards,min, max)
end
function EidolonBattleCommand(cards,targets,act)
  -- Purgatorio
  if HasID(cards,12307878,CanWinBattle,targets) then 
    return Attack()
  end
end
function EidolonAttackTarget(cards,attacker)
end
function EidolonAttackBoost(cards)
 -- Aleister
  local count = CardsMatchingFilter(AIHand(),FilterID,86120751) -- Aleister
  if count>0 then
    for j,c in pairs(cards) do
      if EidolonMonsterFilter(c)
      and Affected(c,TYPE_MONSTER,4)
      and Targetable(c,TYPE_MONSTER)
      and CurrentOwner(c)==1
      and MacroCheck()
      then
        c.attack=c.attack+1000*count
        c.bonus=(c.bonus or 0)+1000*count
      end
    end
  end
end
function EidolonOption(options)
end
function EidolonChainOrder(cards)
  local result = {}
  for i,c in pairs(cards) do
    c.index = i
  end
  if HasID(cards,43722862,true) -- Wind Witch Ice Bell
  and HasID(cards,71007216,true) -- Wind Witch Glass Bell
  then
    for i,c in pairs(cards) do
      if c.id == 71007216 then -- Wind Witch Glass Bell
        result[#result+1] = c.index
        table.remove(cards,i)
      end
    end
    for i,c in pairs(cards) do
      if c.id == 43722862 then -- Wind Witch Ice Bell
        result[#result+1] = c.index
        table.remove(cards,i)
      end
    end
  end
  for i,c in pairs(cards) do
    result[#result+1] = c.index
  end
  return result
end
EidolonAtt={
20292186, -- Artifact Scythe
85103922, -- Artifact Moralltach
71007216, -- Wind Witch Glass Bell

11270236, -- Elysion
75286621, -- Merkabah
48791583, -- Magallanica
12307878, -- Purgatorio
49513164, -- Raideen
50954680, -- Crystal Wing
82044279, -- Clear Wing
14577226, -- Wind Witch Winter Bell
56832966, -- Utopia Lightning
84013237, -- Utopia
}
EidolonVary={
}
EidolonDef={
43722862, -- Wind Witch Ice Bell
23434538, -- Maxx "C"
70117860, -- Wind Witch Snow Bell

85908279, -- Cocytus
13529466, -- Caligula
}
function EidolonPosition(id,available)
  result = nil
  for i=1,#EidolonAtt do
    if EidolonAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#EidolonVary do
    if EidolonVary[i]==id 
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
  for i=1,#EidolonDef do
    if EidolonDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end

function AleisterCond(loc,c)
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
    and (CardsMatchingFilter(AIHand(),FilterID,c.id)>1
    or HasIDNotNegated(AICards(),74063034,true)) -- Eidolon Summon
    then
      return true
    end
    return false
  end 
  return true
end
function SnowBellCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AIMon(),WindWitchFilter)==2
    and CardsMatchingFilter(AIMon(),FilterTuner)==1
    and CanSpecialSummon()
    then
      return true
    end
    return false
  end
  return true
end
EidolonPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Eidolon

[20292186] = {1,1,1,1,5,1,1,1,3,1,ScytheCond}, -- Artifact Scythe
[85103922] = {1,1,1,1,4,1,1,1,3,1,MoralltachCond},  -- Artifact Moralltach
[71007216] = {2,1,4,1,1,1,1,1,3,1,GlassBellCond},  -- Wind Witch Glass Bell
[86120751] = {5,1,5,1,7,1,1,1,6,1,AleisterCond},  -- Aleister
[43722862] = {5,1,2,1,1,1,1,1,4,1,IceBellCond},  -- Wind Witch Ice Bell
[23434538] = {1,1,1,1,1,1,1,1,5,1,MaxxCond},  -- Maxx "C"
[70117860] = {7,1,3,1,1,1,1,1,6,1,SnowBellCond},  -- Wind Witch Snow Bell

[01845204] = {1,1,1,1,1,1,1,1,1,1,IFCond},  -- Instant Fusion
[73628505] = {1,1,1,1,1,1,1,1,1,1,TerraformingCond},  -- Terraforming
[74063034] = {1,1,1,1,1,1,1,1,1,1,SummoningMagicCond},  -- Eidolon Summoning Magic
[67775894] = {1,1,1,1,1,1,1,1,1,1,WonderWandCond},  -- Wonder Wand
[47679935] = {1,1,1,1,1,1,1,1,1,1,RecklessCircleCond},  -- Reckless Magic Circle

[12444060] = {1,1,1,1,1,1,1,1,1,1,SanctumCond},  -- Artifact Sanctum
[05851097] = {1,1,1,1,1,1,1,1,1,1,VanityCond},  -- Vanity
[40605147] = {1,1,1,1,1,1,1,1,1,1,StrikeCond},  -- Strike
[84749824] = {1,1,1,1,1,1,1,1,1,1,WarningCond},  -- Warning
[43898403] = {1,1,1,1,1,1,1,1,1,1,TwiTwiCond},  -- Twin Twister

[11270236] = {1,1,1,1,1,1,1,1,1,1,ElysionCond},  -- Elysion
[75286621] = {1,1,1,1,1,1,1,1,1,1,MerkabahCond},  -- Merkabah
[48791583] = {1,1,1,1,1,1,1,1,1,1,MagallanicaCond},  -- Magallanica
[12307878] = {1,1,1,1,1,1,1,1,1,1,PurgatorioCond},  -- Purgatorio
[85908279] = {1,1,1,1,1,1,1,1,1,1,CocytusCond},  -- Cocytus
[49513164] = {1,1,1,1,1,1,1,1,1,1,RaideenCond},  -- Raideen
[13529466] = {1,1,1,1,1,1,1,1,5,1,CaligulaCond},  -- Caligula
[50954680] = {1,1,1,1,1,1,1,1,1,1,CrystalWingCond},  -- Crystal Wing
[82044279] = {1,1,1,1,1,1,1,1,1,1,ClearWingCond},  -- Clear Wing
[14577226] = {1,1,1,1,1,1,1,1,1,1,WinterBellCond},  -- Wind Witch Winter Bell
[56832966] = {1,1,1,1,1,1,1,1,1,1,LightningCond},  -- Utopia Lightning
[84013237] = {1,1,1,1,1,1,1,1,1,1,UtopiaCond},  -- Utopia
} 

