function SpecterStartup(deck)
  -- function called at the start of the duel, if the AI was detected playing your deck.
  --AI.Chat("Startup functions loaded.")
  AI.Chat("You are now playing against AI_Majespecter version 1.5 by Xaddgx.")
  AI.Chat("Good luck!")
  -- Your links to the important AI functions. If you don't specify a function,
  -- or your function returns nil, the default logic will be used as a fallback.
  deck.Init                 = SpecterInit
  deck.Card                 = SpecterCard
  deck.Chain                = SpecterChain
  deck.EffectYesNo          = SpecterEffectYesNo
  deck.Position             = SpecterPosition
  deck.ActivateBlacklist    = SpecterActivateBlacklist
  deck.SummonBlacklist      = SpecterSummonBlacklist
  deck.SetBlacklist         = SpecterSetBlacklist
  deck.RepositionBlacklist  = SpecterRepoBlacklist
  deck.Unchainable          = SpecterUnchainable
  deck.PriorityList         = SpecterPriorityList
  deck.BattleCommand        = SpecterBattleCommand
  deck.AttackTarget         = SpecterAttackTarget
  deck.YesNo                = SpecterYesNo

  --[[
  Other, more obscure functions, in case you need them. Same as before,
  not defining a function or returning nil causes default logic to take over
  deck.Option
  deck.Sum
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
--[[  local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
		--Duel.ConfirmCards(1-player_ai,g)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	Duel.RegisterEffect(e2,0)
  local e3=Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_PUBLIC)
  e3:SetTargetRange(LOCATION_HAND,0)
  Duel.RegisterEffect(e3,player_ai)]]
end

-- Your deck. The startup function must be on top of this line.
-- 3 required parameters.
-- First one: Your deck's name, as a string. Will be displayed in debug mode.
-- 2nd: The deck identifier. Can be a card ID (as a number) or a list of IDs.
--   Use a card or a combination of cards, that identifies your deck from others.
-- 3rd: The Startup function. Must be defined here, so it can be called at the start of the duel.
--  Technically not required, but doesn't make a lot of sense to leave it out, it would prevent
--  you from setting up all your functions and blacklists.

DECK_SPECTER = NewDeck("Majespecter",{76473843,53208660},SpecterStartup) -- Majesty's Pegasus, Pendulum Call Xaddgx
-- BlueEyes White Dragon and BlueEyes Maiden. BEWD is used in the Exodia deck as well,
-- so we use a 2nd card to identify the deck 100%. Could just use Maiden as well.

SpecterActivateBlacklist={
-- Blacklist of cards to never activate or chain their effects by the default AI logic
-- Anything you add here should be handled by your script, otherwise the cards will never activate
51531505, -- Dragonpit Scale 8
15146890, -- Dragonpulse Scale 1
14920218, -- Peasant Scale 2
13972452, -- Specter Storm
53208660, -- Pendulum Call
96598015, -- Pot of Riches
43898403, -- Twin Twister
49366157, -- Specter Cyclone
76473843, -- Majesty's Pegasus
36183881, -- Specter Tornado
78949372, -- Specter Supercell
02572890, -- Specter Tempest
05650082, -- Storming Mirror Force
18326736, -- Ptolemaeus
62709239, -- Phantom Knights XYZ
85252081, -- Granpulse XYZ
94784213, -- Specter Fox
00645794, -- Specter Toad
68395509, -- Specter Crow
31991800, -- Specter Raccoon
05506791, -- Specter Cat
82633039, -- Castel
52558805, -- Temtempo Djinn
72714461, -- Insight Magician
31437713, -- Heartlandraco
21044178, -- Abyss Dweller
93568288, -- Rhapsody
40318957, -- Joker
70368879, -- Upstart
58577036, -- Reasoning
95992081, -- Leviair
12014404, -- Cowboy
82697249, -- Dane Cook
22653490, -- Lightning Chidori
79816536, -- Summoner's Art
}
SpecterSummonBlacklist={
-- Blacklist of cards to never be normal summoned or set by the default AI logic (apparently this includes special summoning?)
94784213, -- Specter Fox
00645794, -- Specter Toad
68395509, -- Specter Crow
31991800, -- Specter Raccoon
05506791, -- Specter Cat
51531505, -- Dragonpit Scale 8
15146890, -- Dragonpulse Scale 1
14920218, -- Peasant Scale 2
18326736, -- Ptolemaeus
62709239, -- Phantom Knights XYZ
85252081, -- Granpulse
52558805, -- Temtempo Djinn
34945480, -- Azathoth
09272381, -- Constellar Diamond
88722973, -- Majester Paladin
71068247, -- Totem Bird
72714461, -- Insight Magician
21044178, -- Abyss Dweller
22653490, -- Lightning Chidori
82633039, -- Castel
84013237, -- Utopia
56832966, -- Utopia Lightning
31437713, -- Heartlandraco
93568288, -- Rhapsody
40318957, -- Joker
95992081, -- Leviair
12014404, -- Cowboy
82697249, -- Dane Cook
}
SpecterSetBlacklist={
-- Blacklist for cards to never set to the S/T Zone to chain or as a bluff
12580477, -- Raigeki
13972452, -- Storm
96598015, -- Pot of Riches
76473843, -- Majesty's Pegasus
}
SpecterRepoBlacklist={
-- Blacklist for cards to never be repositioned
51531505, -- Dragonpit Scale 8
05506791, -- Specter Cat
19665973, -- Battle Fader
12014404, -- Cowboy
}
SpecterUnchainable={
-- Blacklist for cards to not chain multiple copies in the same chain
--59616123, -- trapstun
-- don't chain Maiden to herself. Sounds pointless because she is once per turn,
-- but this will also prevent chaining from other unchainable cards, like chaining
-- DPrison on something attacking Maiden, even though she would negate the attack anyways
43898403, -- Twin Twister
49366157, -- Specter Cyclone
05650082, -- Storming Mirror Force
36183881, -- Specter Tornado
78949372, -- Specter Supercell
02572890, -- Specter Tempest
18326736, -- Ptolemaeus2
52558805, -- Temtempo Djinn
}
 
function RaccoonCond(loc)
  if loc == PRIO_TOHAND then
    return Duel.GetCurrentPhase() == PHASE_END
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(31991800) and not (HasScales() and HasID(AIExtra(),31991800,true))
	and (not HasID(AIHand(),31991800,true) or (HasID(AIHand(),31991800,true) and NormalSummonCheck(player_ai)))
  end
  if loc == PRIO_BANISH then
    return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)>0 or not HasID(AIExtra(),31991800,true)
  end
 return true
end

function FoxCond(loc)
  if loc == PRIO_TOHAND then
    return (OPTCheck(94784213)
	and CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)<2 and not Duel.GetCurrentPhase()==PHASE_END
	and CardsMatchingFilter(AIDeck(),SpecterTrapFilter)>0
	and not HasID(UseLists({AIExtra(),AIHand()}),94784213,true))
	or (HasScales() and CardsMatchingFilter(UseLists({AIExtra(),AIMon(),AIHand()}),function(c) return c.id==94784213 end)==0)
  end
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)<2 and OPTCheck(94784213)
	and (not HasID(AIHand(),94784213,true) or (HasID(AIHand(),94784213,true) and NormalSummonCheck(player_ai))
	and Duel.GetTurnCount() == SpecterGlobalPendulum)
	and not (HasScales() and HasID(AIExtra(),94784213,true))
  end
  if loc == PRIO_BANISH then
    return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==2 or not HasID(AIExtra(),94784213,true)
  end
 return true
end

function CatCond(loc)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)>=2 and not Duel.GetCurrentPhase()==PHASE_END
	and not HasID(UseLists({AIExtra(),AIHand(),AIMon()}),05506791,true)
  end
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)>=2 and OPTCheck(05506791)
	and not (HasScales() and Duel.GetTurnCount() ~= SpecterGlobalPendulum and HasID(AIExtra(),05506791,true))
  end
  if loc == PRIO_BANISH then
    return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==1 or not HasID(AIExtra(),05506791,true)
  end
 return true
end

function CrowCond(loc) --Code a to field/hand if Majespecter Cyclone would be useful for removing an opponent's monster.
  if loc == PRIO_TOHAND then
    return (OPTCheck(68395509)
	and CardsMatchingFilter(AIDeck(),SpecterSpellFilter)>0
	and CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)<2
	and not HasID(UseLists({AIExtra(),AIHand()}),68395509,true))
    or (HasScales() and CardsMatchingFilter(UseLists({AIExtra(),AIMon(),AIHand()}),function(c) return c.id==68395509 end)==0)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(68395509)
	and CardsMatchingFilter(AIDeck(),SpecterSpellFilter)>0
	and (not HasID(AIHand(),68395509,true)
	or (HasID(AIHand(),68395509,true) and NormalSummonCheck(player_ai))
	and Duel.GetTurnCount() == SpecterGlobalPendulum)
	and not (HasScales() and HasID(AIExtra(),68395509,true))
  end
  if loc == PRIO_BANISH then
    return NeedsSStormOverSCyclone()
	and Duel.GetTurnPlayer()==player_ai
	and HasScales()
	and Duel.GetTurnCount() ~= SpecterGlobalPendulum
	and DualityCheck()
	and (not HasID(AIMon(),31991800,true) or HasID(AIExtra(),31991800,true))
	and not HasID(AIExtra(),68395509,true)
	and not UsableSTornado()
  end
 return true
end

function ToadCond(loc)
  if loc == PRIO_TOHAND then
    return OPTCheck(00645794)
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(00645794)
	and (not HasID(AIHand(),00645794,true)
	or (HasID(AIHand(),00645794,true) and NormalSummonCheck(player_ai)))
  end
 return true
end

function STempestCond(loc)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIST(),AIHand()}),02572890,true)
	and not NeedsRaccoonEnd()
  end
  if loc == PRIO_TOFIELD then
    return not HasID(UseLists({AIST(),AIHand()}),02572890,true)
	and not NeedsRaccoonEnd()
  end
 return true
end
  

function STornadoCond(loc)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIST(),AIHand()}),36183881,true)
	and not NeedsRaccoonEnd()
  end
  if loc == PRIO_TOFIELD then
    return not HasID(UseLists({AIST(),AIHand()}),36183881,true)
	and not NeedsRaccoonEnd()
  end
 return true
end

function SCycloneCond(loc)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIST(),AIHand()}),49366157,true)
	and not NeedsRaccoonEnd()
  end
  if loc == PRIO_TOFIELD then
    return not HasID(UseLists({AIST(),AIHand()}),49366157,true)
	and not NeedsRaccoonEnd()
  end
 return true
end

function SStormCond(loc)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIST(),AIHand()}),13972452,true)
	and not NeedsRaccoonEnd()
  end
  if loc == PRIO_TOFIELD then
    return not HasID(UseLists({AIST(),AIHand()}),13972452,true)
	and not NeedsRaccoonEnd()
  end
 return true
end

function SCellCond(loc)
  if loc == PRIO_TOHAND then
    return (CardsMatchingFilter(AIGrave(),SpecterCardFilter)>=4 or CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)>=2)
	and not NeedsRaccoonEnd()
  end
  if loc == PRIO_TOFIELD then
    return (CardsMatchingFilter(AIGrave(),SpecterCardFilter)>=4 or CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)>=2)
	and not NeedsRaccoonEnd()
  end
 return true
end

function DragonpitCond(loc)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AIST(),ScaleHighFilter)==0
	and not HasID(UseLists({AIST(),AIHand()}),51531505,true)
	and not HasScales()
	and not NeedsRaccoonEnd()
  end
 return true
end

function DragonpulseCond(loc)
  if loc == PRIO_TOHAND then
    return (not HasID(UseLists({AIST(),AIHand()}),15146890,true)
	or HasScales())
	and not NeedsRaccoonEnd()
  end
 return true
end

function InsightCond(loc)
  if loc == PRIO_TOHAND then
    return ((NeedsScale5() and not HasID(AIDeck(),51531505,true))
	or HasScales())
	and not NeedsRaccoonEnd()
  end
 return true
end

function SpecterPeasantCond(loc)
  if loc == PRIO_TOHAND then
    return (not HasID(UseLists({AIST(),AIHand()}),14920218,true)
	or HasScales()
	or (MajestyCheck()
	and HasID(AIST(),51531505,true)
	and HasScales()))
	and not NeedsRaccoonEnd()
  end
 return true
end
  
function SpecterMonsterFilter(c)
  return (IsSetCode(c.setcode,0xd0) or c.id==14920218) and bit32.band(c.type,TYPE_MONSTER)>0
end

function TrueSpecterMonsterFilter(c)
  return IsSetCode(c.setcode,0xd0) and FilterType(c,TYPE_MONSTER)
end

function SpecterCardFilter(c)
  return IsSetCode(c.setcode,0xd0)
end

function SpecterBackrowFilter(c)
  return c.id==49366157
  or c.id==36183881
  or c.id==02572890
end

function SpecterPendulumFilter(c)
  return IsSetCode(c.setcode,0xd0) and bit32.band(c.type,TYPE_PENDULUM)>0
end

function SpecterSpellFilter(c)
  return IsSetCode(c.setcode,0xd0) and bit32.band(c.type,TYPE_SPELL)>0
end

function SpecterTrapFilter(c)
  return IsSetCode(c.setcode,0xd0) and bit32.band(c.type,TYPE_TRAP)>0
end

function AllPendulumFilter(c)
  return bit32.band(c.type,TYPE_PENDULUM)>0
end

function LevelThreeFieldCheck(c)
  return c.id==05506791 --Cat
  or c.id==31991800 --Raccoon
end

function LevelFourFieldCheck(c) --Script error on below line for some reason
  return c.id==00645794 --Toad
  or c.id==68395509 --Crow
  or c.id==94784213 --Fox
  or c.id==15146890 --Dragonpulse Scale 1
  or c.id==40318957 --Joker
end

function LevelFourSpecterFilter(c)
  return c.id==00645794
  or c.id==68395509
  or c.id==94784213
end

function AllMonsterFilter(c)
  return FilterType(c,TYPE_MONSTER)
end

function NotJokerMonsterFilter(c)
  return FilterType(c,TYPE_MONSTER) and c.id~=40318957
end

function ScaleHighExcludeRaccoonFilter(c)
  return c.id==51531505
  or c.id==00645794
  or c.id==68395509
  or c.id==72714461
end

function ScaleHighFilter(c)
  return c.id==51531505 --Dragonpit Scale 8
  or c.id==00645794 --Toad
  or c.id==68395509 --Crow
  or c.id==31991800 --Raccoon
  or c.id==72714461 --Insight
end

function ScaleLowFilter(c)
  return c.id==15146890 --Dragonpulse Scale 1
  or c.id==14920218 --Peasant Scale 2
  or c.id==94784213 --Fox
  or c.id==05506791 --Cat
end
  
function SummonRaccoon1()
  return OPTCheck(31991800)
end

function SummonRaccoon2()
  return CardsMatchingFilter(AIMon(),LevelThreeFieldCheck)==1 or CardsMatchingFilter(AIMon(),LevelThreeFieldCheck)==3
end

function SummonRaccoon3() --Summon normally before Pendulum Summoning, in case Solemn Warning is around.
  return HasScales()
  and SummonRaccoon1()
  and (OppDownBackrow()
  or MajestyCheck()
  or HasID(AIHand(),40318957,true))
end

function SummonRaccoon4() --Summon normally if you can get another scale 5.
  return SummonRaccoon1()
  and NeedsScale5Raccoon()
end

function SummonRaccoon5()
  if (EnemyHasSummonNegatorMon() or EnemyHasTimeRafflesia())
  and SummonRaccoon1()
  and MajestyCheck()
  and SummonCrow1()
  and (HasScales() or NeedsScale5Raccoon())
  and ((HasID(AIDeck(),13972452,true) and CardsMatchingFilter(OppMon(),SStormFilter5)>0)
  or (HasID(AIDeck(),49366157,true) and CardsMatchingFilter(OppMon(),SpecterCycloneFilter5)>0)) then
   return true
  end
  if EnemyHasSummonNegatorMon()
  and (SummonForUsableBackrow() 
  or MajestyCheck()) then
   return true
  end
  if EnemyHasTimeRafflesia()
  and (SummonForUsableSpellBackrow()
  or MajestyCheck()) then
   return true
  end
 return false
end

function RaccoonHandCheck()
  return HasID(AIHand(),31991800,true)
  and HasScales()
  and OppDownBackrow()
  and #AIMon()<5
  and not NormalSummonCheck(player_ai)
  and not EnemyHasSkillDrainOnly()
end

function SummonFox1()
  return OPTCheck(94784213)
end

function SummonFox2()
  return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==1 or CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==3
end

function SummonFox3() --Summon normally before Pendulum Summoning, in case Solemn Warning is around.
  return HasScales()
  and SummonFox1()
  and (OppDownBackrow()
  or MajestyCheck())
end

function SummonFox4()
  if EnemyHasSummonNegatorMon()
  and (SummonForUsableBackrow() 
  or MajestyCheck()) then
   return true
  end
  if EnemyHasTimeRafflesia()
  and (SummonForUsableSpellBackrow() 
  or MajestyCheck()) then
   return true
  end
  if SummonFox1()
  and ((CardsMatchingFilter(AIHand(),ScaleHighFilter)==2
  and CardsMatchingFilter(AIHand(),DragonpitFilter)==2)
  or CardsMatchingFilter(AIHand(),ScaleHighFilter)==3
  and CardsMatchingFilter(AIHand(),DragonpitFilter)==3)
  and CardsMatchingFilter(AIHand(),ScaleLowFilter)==1
  and HasID(AIHand(),94784213,true)
  and not HasScales() then
   return true
  end
 return false
end

function SummonCat1()
  return OPTCheck(05506791)
end

function SummonCat2()
  return CardsMatchingFilter(AIMon(),LevelThreeFieldCheck)==1 or CardsMatchingFilter(AIMon(),LevelThreeFieldCheck)==3
end

function SummonCat3() --Summon normally before Pendulum Summoning, in case Solemn Warning is around.
  return HasScales()
  and SummonCat1()
  and (OppDownBackrow()
  or MajestyCheck())
  and NeedsRaccoon()
end

function SummonCat4()
  if EnemyHasSummonNegatorMon()
  and (SummonForUsableBackrow() 
  or MajestyCheck()) then
   return true
  end
  if EnemyHasTimeRafflesia()
  and (SummonForUsableSpellBackrow()
  or MajestyCheck()) then
   return true
  end
  if SummonCat1()
  and ((CardsMatchingFilter(AIHand(),ScaleHighFilter)==2
  and CardsMatchingFilter(AIHand(),DragonpitFilter)==2)
  or CardsMatchingFilter(AIHand(),ScaleHighFilter)==3
  and CardsMatchingFilter(AIHand(),DragonpitFilter)==3)
  and CardsMatchingFilter(AIHand(),ScaleLowFilter)==1
  and HasID(AIHand(),05506791,true)
  and not HasScales() then
   return true
  end
 return false
end

function SummonCrow1()
  return OPTCheck(68395509)
end

function SummonCrow2()
  return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==1 or CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==3
end

function SummonCrow3() --Summon normally before Pendulum Summoning, in case Solemn Warning is around.
  return HasScales()
  and SummonCrow1()
  and (OppDownBackrow()
  or MajestyCheck())
end

function SummonCrow4()
  if (EnemyHasSummonNegatorMon() or EnemyHasTimeRafflesia())
  and SummonCrow1()
  and ((HasID(AIDeck(),13972452,true) and CardsMatchingFilter(OppMon(),SStormFilter5)>0)
  or (HasID(AIDeck(),49366157,true) and CardsMatchingFilter(OppMon(),SpecterCycloneFilter5)>0))
  and not SummonRaccoon5() then
   return true
  end
  if EnemyHasSummonNegatorMon()
  and (SummonForUsableBackrow() 
  or MajestyCheck()) then
   return true
  end
  if EnemyHasTimeRafflesia()
  and (SummonForUsableSpellBackrow()
  or MajestyCheck()) then
   return true
  end
 return false
end

function SummonToad1()
  return OPTCheck(00645794)
end

function SummonToad2()
  return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==1 or CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==3
end

function SummonToad3() --Summon normally before Pendulum Summoning, in case Solemn Warning is around.
  return HasScales()
  and SummonToad1()
  and (OppDownBackrow()
  or MajestyCheck())
end

function SummonToad4()
  if EnemyHasSummonNegatorMon()
  and (SummonForUsableBackrow() 
  or MajestyCheck()) then
   return true
  end
  if EnemyHasTimeRafflesia()
  and (SummonForUsableSpellBackrow()
  or MajestyCheck()) then
   return true
  end
 return false
end

function SpecterPendulumSummon(count)
  if count == nil then count = 1 end
  return CardsMatchingFilter(UseLists({AIExtra(),AIHand()}),NotJokerMonsterFilter)>=count
  and DualityCheck() and SpecterPendulumSummonCheck()
end

function SpecterPendulumSummonCheck()
  return SpecterGlobalPendulum~=Duel.GetTurnCount()
end

function PlayMajesty()
  return CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0
  and not HasID(AIST(),76473843,true)
end

function UseMajesty()
  return true
end

function DiscardTargetFilter(c)
  return c.id==51531505 --Dragonpit 8
  or c.id==15146890 --Dragonpulse 1
  or c.id==14920218 --Peasant 2
  or c.id==13972452 --SStorm
  or c.id==19665973 --Fader
  or c.id==02572890 --STempest
  or c.id==36183881 --STornado
  or c.id==49366157 --SCyclone
  or c.id==40318957 --Joker
  or c.id==68395509 --Crow
  or c.id==00645794 --Toad
  or c.id==05506791 --Cat
end

function MajestyDiscardAvailable() --Getting lazy with the last line...
  return (HasID(AIHand(),76473843,true) and HasID(AIST(),76473843,true))
  or CardsMatchingFilter(AIHand(),function(c) return c.id==76473843 end)>1
  or (CardsMatchingFilter(AIExtra(),AllMonsterFilter)>0 and #AIMon()==0 and #AIHand()<3 and HasID(AIHand(),76473843,true))
end

function PendulumCallDiscardAvailable()
  return CardsMatchingFilter(AIHand(),function(c) return c.id==53208660 end)>1
end

function DiscardTargetAvailable()
  return CardsMatchingFilter(AIHand(),DiscardTargetFilter)>0
  or MajestyDiscardAvailable()
  or PendulumCallDiscardAvailable()
end

function UsePendulumCallSpecter()
  return DiscardTargetAvailable()
  and OPTCheck(53208660)
  and (NoScalesInsight() and CardsMatchingFilter(UseLists({AIHand(),AIST()}),function(c) return c.id==72714461 end)<2)
end

function NoScalesInsight()
  return CardsMatchingFilter(AIST(),AllPendulumFilter)<2
end

function NoScales()
  return NeedsScale5()
  or NeedsScale2()
end

function UsePendulumCallScaleReplaceSpecter()
  if HasID(AIHand(),31991800,true) and OPTCheck(31991800) and not NormalSummonCheck(player_ai) then return false end
  if OPTCheck(53208660)
  and NoScales()
  and SpecterExtraCount() 
  and not MajestyCheck() then
    return true
  end
end

function SpecterExtraCount()
  return CardsMatchingFilter(AIExtra(),SpecterMonsterFilter)>0
end

function PlayDragonpit() --Scale 8
  return (CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)>0
  and CardsMatchingFilter(AIST(),ScaleHighFilter)==0)
  or HasID(AIST(),72714461,true) --Insight
end

function PlayToad() --Scale5
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)>0
  and CardsMatchingFilter(AIST(),ScaleHighFilter)==0
  and not HasID(AIHand(),51531505,true) --Dragonpit 8
end

function PlayCrow() --Scale5
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)>0
  and CardsMatchingFilter(AIST(),ScaleHighFilter)==0
  and not HasID(AIHand(),51531505,true) --Dragonpit 8
  and not HasID(AIHand(),00645794,true) --Specter Toad
end

function PlayRaccoon() --Scale5
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)>0
  and CardsMatchingFilter(AIST(),ScaleHighFilter)==0
  and not HasID(AIHand(),51531505,true) --Dragonpit 8
  and not HasID(AIHand(),00645794,true) --Specter Toad
  and not HasID(AIHand(),68395509,true) --Specter Crow
end

function PlayDragonpulse() --Scale 1
  return (CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleHighFilter)>0
  and CardsMatchingFilter(AIST(),ScaleLowFilter)==0)
  or HasID(AIST(),72714461,true)
end

function PlayPeasant()
  return (CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleHighFilter)>0
  and CardsMatchingFilter(AIST(),ScaleLowFilter)==0)
  or HasID(AIST(),72714461,true)
end

function PlayCat() --Scale 2
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleHighFilter)>0
  and CardsMatchingFilter(AIST(),ScaleLowFilter)==0
  and not HasID(AIHand(),15146890,true) --Dragonpulse 1
  and not HasID(AIHand(),14920218,true) --Peasant 2
end

function PlayFox() --Scale2
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleHighFilter)>0
  and CardsMatchingFilter(AIST(),ScaleLowFilter)==0
  and not HasID(AIHand(),15146890,true) --Dragonpulse 1
  and not HasID(AIHand(),14920218,true) --Peasant 2
  and not HasID(AIHand(),05506791,true) --Specter Cat
end

function NeedsScale5Raccoon()
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)>0
  and CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleHighExcludeRaccoonFilter)==0
end

function NeedsScale5()
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)>0
  and CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleHighFilter)==0
end

function NeedsScale2()
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleHighFilter)>0
  and CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)==0
end

function HasScales()
  return CardsMatchingFilter(AIST(),ScaleHighFilter)==1
  and CardsMatchingFilter(AIST(),ScaleLowFilter)==1
end

function NeedsRaccoon()
  return CardsMatchingFilter(UseLists({AIMon(),AIHand(),AIExtra()}),function(c) return c.id==31991800 end)==0
end

function NeedsFox()
  return CardsMatchingFilter(UseLists({AIMon(),AIHand(),AIExtra()}),function(c) return c.id==94784213 end)==0
end

function SpecterPtolemaeusSummon()
  return XYZSummonOkay() and SpecterMP2Check()
  and HasID(AIExtra(),18326736,true)
end

function SpecterPtolemaeusFilter1(c)
  return c.id==18326736 and c.xyz_material_count==2
end

function SpecterPtolemaeusFilter2(c)
  return c.id==18326736 and c.xyz_material_count>2
end

function EndPhasePtolemaeus()
  return CardsMatchingFilter(AIMon(),SpecterPtolemaeusFilter1)>0
  and Duel.GetCurrentPhase()==PHASE_END
end

function PtolemaeusAzathoth()
  return CardsMatchingFilter(AIMon(),SpecterPtolemaeusFilter2)>0
  and Duel.GetCurrentPhase()==PHASE_DRAW
  and Duel.GetTurnPlayer()==1-player_ai
end

function WorthPendulumActivation()
  return ((CardsMatchingFilter(AIExtra(),SpecterMonsterFilter)>0
  or HasID(AIExtra(),72714461,true))
  or CardsMatchingFilter(UseLists({AIHand(),AIST()}),AllPendulumFilter)>2
  or (PlayInsight4() and PlayDragonpit2())
  or (CardsMatchingFilter(UseLists({AIHand(),AIST()}),MagicianPendulumFilter)>1 and HasID(UseLists({AIHand(),AIST()}),72714461,true)
  and OPTCheck(53208660)))
  and (not HasID(AIHand(),40318957,true) or (HasID(AIHand(),40318957,true) and NormalSummonCheck(player_ai)) or not OPTCheck(40318957)
  or not (SpecterSummonJoker1() and SpecterSummonJoker2()))
end

function WorthPendulumSummoning()
  return (CardsMatchingFilter(AIExtra(),AllPendulumFilter)>0
  or CardsMatchingFilter(AIHand(),AllMonsterFilter)>1
  or (CardsMatchingFilter(AIHand(),AllMonsterFilter)==1 and NormalSummonCheck(player_ai))
  or (HasScales() and HasID(AIHand(),51531505,true))
  or (CardsMatchingFilter(AIHand(),AllMonsterFilter)==1 and (HasID(AIHand(),05506791,true) or HasID(AIHand(),14920218,true))))
  and (not HasID(AIHand(),40318957,true) or (HasID(AIHand(),40318957,true) and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),AllMonsterFilter)>1))
end

function DragonpitScaleAndHand()
  return HasID(AIHand(),51531505,true)
  and HasID(AIST(),51531505,true)
end

function SpecterMP2Check()
  return AI.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed
end

function SpecterSetSummoners()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetSTempest()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetSTornado()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetSCell()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetSCyclone()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetSStorm()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetTwinTwister()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetVanity()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetStormingMirror()
  return Duel.GetTurnCount() == 1 or (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
end

function SetPendulumCall()
  return (Duel.GetCurrentPhase()==PHASE_MAIN2 or (Duel.GetCurrentPhase()==PHASE_MAIN1 and not GlobalBPAllowed))
  and not (HasID(AIDeck(),51531505,true) or (HasID(AIDeck(),15146890,true) or HasID(AIDeck(),14920218,true))) --Magicians
  and not HasID(UseLists({AIST(),AIHand()}),43898403,true) --Twin Twister
end

function UseSCell()
  return CardsMatchingFilter(AIGrave(),SpecterCardFilter)>=5
  or CardsMatchingFilter(AIST(),SpecterPendulumFilter)>0
end

function MagicianPendulumFilter(c)
  return c.id==51531505 --Dragonpit Scale 8
  or c.id==15146890 --Dragonpulse Scale 1
  or c.id==72714461 --Insight
  or c.id==14920218 --Peasant
end

function ScaleHighSpecterFilter(c)
  return c.id==68395509
  or c.id==00645794
  or c.id==31991800
end

function PlayInsight1()
  return OPTCheck(53208660)
  and CardsMatchingFilter(UseLists({AIST(),AIHand()}),MagicianPendulumFilter)>1
  and CardsMatchingFilter(AIST(),ScaleHighSpecterFilter)==0
end

function PlayInsight2()
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),ScaleLowFilter)>0
  and CardsMatchingFilter(AIST(),ScaleHighFilter)==0
end

function PlayInsight3()
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),function(c) return c.id==72714461 end)>1
  and OPTCheck(53208660)
  and CardsMatchingFilter(AIST(),ScaleHighSpecterFilter)==0
end

function PlayInsight4()
  return (CardsMatchingFilter(AIST(),DragonpitFilter)==1 or (HasID(AIHand(),51531505,true) and CardsMatchingFilter(AIST(),ScaleHighFilter)==0))
  and CardsMatchingFilter(UseLists({AIExtra(),AIHand(),AIST()}),TrueSpecterMonsterFilter)==0
  and HasID(AIHand(),14920218,true)
  and not PlayInsight3()
end

function PlayDragonpit2()
  return CardsMatchingFilter(UseLists({AIExtra(),AIHand(),AIST()}),TrueSpecterMonsterFilter)==0
  and HasID(UseLists({AIHand(),AIExtra()}),14920218,true)
  and HasID(UseLists({AIHand(),AIST()}),72714461,true)
  and not PlayInsight3()
end

function UseInsight()
  return OPTCheck(53208660)
  and ((HasID(AIST(),51531505,true) and HasID(AIDeck(),14920218,true))
  or HasID(AIST(),14920218,true) and HasID(AIDeck(),51531505,true))
end

function DragonpitFilter(c)
  return c.id==51531505
end

function DragonpulseFilter(c)
  return c.id==15146890
end

function MakeRoom()
  return (#AIMon()==5 
  and (CardsMatchingFilter(AIHand(),SpecterMonsterFilter)>0
  or CardsMatchingFilter(AIHand(),LevelFourMagicianFilter)>0)
  and not NormalSummonCheck(player_ai))
  or (#AIMon()==5 and HasScales() and Duel.GetTurnCount() ~= SpecterGlobalPendulum and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)>0)
  or (#AIMon()==4 and HasScales() and Duel.GetTurnCount() ~= SpecterGlobalPendulum and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)>1)
  or (#AIMon()==3 and HasScales() and Duel.GetTurnCount() ~= SpecterGlobalPendulum and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)>2)
  or (#AIMon()==2 and HasScales() and Duel.GetTurnCount() ~= SpecterGlobalPendulum and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)>3)
  or (#AIMon()==1 and HasScales() and Duel.GetTurnCount() ~= SpecterGlobalPendulum and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)>4)
end

function TotemBirdFilter(c)
  return FilterPosition(c,POS_FACEDOWN)
end

function SummonTotemBird()
  return (CardsMatchingFilter(OppST(),TotemBirdFilter)>0
  and (AIGetStrongestAttack() > OppGetStrongestAttack() or OppGetStrongestAttack()<1900)
  and ((AI.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed) or Duel.GetTurnCount() == 1))
  and XYZSummonOkayWind()
  and HasID(AIExtra(),71068247,true)
end

function SummonTotemBirdRoom()
  return MakeRoom()
  and HasID(AIExtra(),71068247,true)
  and ((CardsMatchingFilter(OppST(),TotemBirdFilter)>0 or #OppHand()>0)
  and (AIGetStrongestAttack() > OppGetStrongestAttack() or OppGetStrongestAttack()<1900)
  and ((AI.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed) or Duel.GetTurnCount() == 1))
end

function SpecterGranpulseFilter(c)
  return bit32.band(c.type,TYPE_PENDULUM)>0
  and SpecterDestroyFilter(c)
end

function OppHasScales()
  return CardsMatchingFilter(OppST(),AllPendulumFilter)>1
end

function SpecterSummonGranpulse()
  return (CardsMatchingFilter(OppST(),SpecterGranpulseFilter)>0 and AI.GetCurrentPhase() == PHASE_MAIN2 and OppHasScales())
  and (XYZSummonOkay() or MakeRoom())
  and HasID(AIExtra(),85252081,true)
end

function SpecterSummonGranpulse2()
  return ((CardsMatchingFilter(OppST(),SpecterGranpulseFilter)>0 and OppHasScales()
  and (AI.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed)
  and #OppHand()<2
  and XYZSummonOkay())
  or (CardsMatchingFilter(OppST(),OppDownBackrowFilter)>0 and Duel.GetTurnCount() ~= SpecterGlobalPendulum and HasScales()
  and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),SpecterMonsterFilter)>0))
  and HasID(AIExtra(),85252081,true)
end

function SpecterSummonGranpulse3()
  return (XYZSummonOkay() or MakeRoom())
  and SpecterMP2Check()
  and OppGetStrongestAttack() > AIGetStrongestAttack()
  and CardsMatchingFilter(OppMon(),GranpulseEnemyFilter)>0
  and CardsMatchingFilter(AIMon(),LevelFourFieldCheck)<2
end
  
function GranpulseEnemyFilter(c)
  return c.attack>=2000
  and c.attack<=2800
  and FilterPosition(c,POS_FACEUP_ATTACK)
end

function SpecterUseGranpulse()
  return CardsMatchingFilter(OppST(),OppBackrowFilter)>0
end

function OppBackrowFilter(c)
  return FilterLocation(c,LOCATION_SZONE)
  and SpecterDestroyFilter(c)
end

function OppHasBackrow()
  return #OppST()>0
end

function OppDownBackrowFilter(c)
  return FilterPosition(c,POS_FACEDOWN)
  and SpecterDestroyFilter(c)
  and not (DestroyBlacklist(c)
  and (bit32.band(c.position, POS_FACEUP)>0 
  or FilterPublic(c))
  and not FilterPublic(c))
--  and not FilterType(c,TYPE_FIELD)
end

function OppDownBackrow()
  return CardsMatchingFilter(OppST(),OppDownBackrowFilter)>0
end

function NeedsRaccoonEnd()
  return NeedsRaccoon()
  and AI.GetCurrentPhase() == PHASE_END
end

function SummonDragonpulse()
  return true
end

function SummonInsight()
  return ((AIGetStrongestAttack() > OppGetStrongestAttack() 
  or OppGetStrongestAttack()<1500)
  and Duel.GetTurnCount() ~= 1)
  or CardsMatchingFilter(AIMon(),LevelFourFieldCheck)>0
end

function SetInsight()
  return SpecterMP2Check()
  or Duel.GetTurnCount() == 1
end

function StormingMirrorFilter1(c)
  return not FilterStatus(c,STATUS_LEAVE_CONFIRMED)
  and not FilterAffected(c,EFFECT_IMMUNE_EFFECT)
  and Affected(c,TYPE_TRAP)
  and c.attack>=1000 and c.attack<2000 and FilterPosition(c,POS_FACEUP_ATTACK)
  and c:is_affected_by(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0 and c:is_affected_by(EFFECT_CANNOT_ATTACK)==0
end

function StormingMirrorFilter2(c)
  return not FilterStatus(c,STATUS_LEAVE_CONFIRMED)
  and not FilterAffected(c,EFFECT_IMMUNE_EFFECT)
  and Affected(c,TYPE_TRAP)
  and c.attack>=2000 and c.attack<3000 and FilterPosition(c,POS_FACEUP_ATTACK)
  and c:is_affected_by(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0 and c:is_affected_by(EFFECT_CANNOT_ATTACK)==0
end

function StormingMirrorFilter3(c)
  return not FilterStatus(c,STATUS_LEAVE_CONFIRMED)
  and not FilterAffected(c,EFFECT_IMMUNE_EFFECT)
  and Affected(c,TYPE_TRAP)
  and c.attack>=3000 and FilterPosition(c,POS_FACEUP_ATTACK)
  and c:is_affected_by(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0 and c:is_affected_by(EFFECT_CANNOT_ATTACK)==0
end

function StormingMirrorFilter4(c)
  return EnemySummonNegatorMonFilter(c)
  and Affected(c,TYPE_TRAP)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and not FilterAffected(c,EFFECT_IMMUNE_EFFECT)
end

function ChainStormingMirror()
  return CardsMatchingFilter(OppMon(),StormingMirrorFilter1)>2 
  or CardsMatchingFilter(OppMon(),StormingMirrorFilter2)>1 
  or CardsMatchingFilter(OppMon(),StormingMirrorFilter3)>0
  or (CardsMatchingFilter(OppMon(),StormingMirrorFilter1)>1
  and CardsMatchingFilter(OppMon(),StormingMirrorFilter2)>0)
  or CardsMatchingFilter(OppMon(),StormingMirrorFilter4)>0
  or ExpectedDamage(1)>AI.GetPlayerLP(1)
end

function EnableKozmoFunctionsFilter(c)
  return IsSetCode(c.setcode,0xd2)
end

function EnableKozmoFunctions()
  return CardsMatchingFilter(OppDeck(),EnableKozmoFunctionsFilter)>=5
end

function KLightningTargets(c)
  return c.id==55885348
  or c.id==20849090
  or c.id==29491334
  or c.id==94454495
  or c.id==37679169
  or c.id==54063868
end

function SpecterKozmoSummonUtopiaLightning()
  return EnableKozmoFunctions()
  and CardsMatchingFilter(OppMon(),KLightningTargets)>0
  and ((XYZSummonOkay() or MakeRoom()) or (#AIMon()>=3 and AI.GetPlayerLP(2)<=4000))
  and Duel.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and not EnemyHasStall()
  and not EnemyHasBattleStallLightning()
end

function SpecterKozmoSummonUtopiaLightningRoom()
  return SpecterKozmoSummonUtopiaLightning()
  and MakeRoom()
end

function ChainTempestKozmo()
  if not EnableKozmoFunctions() then return false end
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==31061682 
	and e:GetHandlerPlayer()==1-player_ai then
	 return true
	elseif Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_SPECIAL_SUMMON) 
	and e:GetHandler():GetCode()==93302695 then
	 return true
	end
  end
 return false
end

function MultiDangerFilter(c)
  return c.attack >= AIGetStrongestAttack()
end

function MultiDanger()
  return CardsMatchingFilter(OppMon(),MultiDangerFilter)>1
end

function NoSpecterBackrow()
  return CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterBackrowFilter)==0
end

function SpecterHasMonsters()
  return CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>2
  or (CardsMatchingFilter(AIMon(),LevelFourMagicianFilter)==1 and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>1)
  or CardsMatchingFilter(AIMon(),LevelFourMagicianFilter)>1
end

function SpecterHasMonstersWind()
  return CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>2
end

function XYZSummonOkay()
  return SpecterHasMonsters()
  or (NoSpecterBackrow()
  and SpecterMiscBackrow())
end

function SpecterMiscBackrowFilter(c)
  return (c.id==05851097 or c.id==05650082)
  and ((FilterLocation(c,LOCATION_SZONE)
  and FilterPosition(c,POS_FACEUP))
  or FilterLocation(c,LOCATION_HAND))
end

function SpecterMiscBackrow()
  return CardsMatchingFilter(UseLists({AIHand(),AIST()}),SpecterMiscBackrowFilter)>0
end

function XYZSummonReallyOkay()
  return CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>3
  or (CardsMatchingFilter(AIMon(),LevelFourMagicianFilter)==2 and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>1)
  or CardsMatchingFilter(AIMon(),LevelFourMagicianFilter)>2
end

function XYZSummonOkayWind()
  return SpecterHasMonstersWind()
  or NoSpecterBackrow()
end

function LevelFourMagicianFilter(c)
  return c.id==15146890
  or c.id==72714461
  or c.id==40318957
end

function SpecterPhantomFilter(c)
  return (Targetable(c,TYPE_MONSTER)
  and SpecterDestroyFilter(c)
  and Affected(c,TYPE_MONSTER,3)
  and not SpecterCodedTargets(c)
  and not SpecterCodedTargets2(c))
  or FilterPosition(c,POS_FACEDOWN)
end

function SpecterPhantomFilter2(c)
  return Targetable(c,TYPE_MONSTER)
  and SpecterDestroyFilter(c)
  and Affected(c,TYPE_MONSTER,3)
  and not SpecterCodedTargets(c)
  and not SpecterCodedTargets2(c)
end

function SpecterSummonPhantom()
  return CardsMatchingFilter(OppMon(),SpecterPhantomFilter)>0
  and (XYZSummonOkay() or MakeRoom())
  and (CardsMatchingFilter(AIST(),MagicianPendulumFilter)>0 and not OPTCheck(53208660))
  and (CardsMatchingFilter(OppST(),OppDownBackrowFilter)<2 or not HasID(AIExtra(),71068247,true))
  and HasID(AIExtra(),62709239,true)
end

function SpecterSummonPhantom2()
  return (XYZSummonOkay() or MakeRoom())
  and HasID(AIExtra(),62709239,true)
  and CardsMatchingFilter(OppMon(),SpecterPhantomFilter2)>0
  and CardsMatchingFilter(AIMon(),AllyPhantomFilter2)>0
  and HasScales()
  and OppGetStrongestAttDef() > AIGetStrongestAttack()
  and (Duel.GetTurnCount() ~= SpecterGlobalPendulum 
  or (CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>2 or CardsMatchingFilter(AIMon(),MagicianPendulumFilter)>0))
end

function SpecterSummonPhantom3()
  return (XYZSummonOkay() or MakeRoom())
  and HasID(AIExtra(),62709239,true)
  and CardsMatchingFilter(OppMon(),SpecterPhantomFilter2)>0
  and CardsMatchingFilter(AIST(),AllyPhantomFilter3)>0
  and OppGetStrongestAttDef() > AIGetStrongestAttack()
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
end

function SpecterUsePhantom()
  return CardsMatchingFilter(OppMon(),SpecterPhantomFilter)>0
  and CardsMatchingFilter(AIST(),MagicianPendulumFilter)>0 and not OPTCheck(53208660)
end

function SpecterUsePhantom2()
  return CardsMatchingFilter(OppMon(),SpecterPhantomFilter2)>0
  and CardsMatchingFilter(AIMon(),AllyPhantomFilter2)>0
end

function SpecterUsePhantom3()
  return CardsMatchingFilter(OppMon(),SpecterPhantomFilter2)>0
  and CardsMatchingFilter(AIST(),AllyPhantomFilter3)>0
end

function AllyPhantomFilter(c)
  return FilterType(c,TYPE_PENDULUM)
  and FilterLocation(c,LOCATION_SZONE)
end

function AllyPhantomFilter2(c)
  if CardsMatchingFilter(AIMon(),MagicianPendulumFilter)>0 then
    return IsSetCode(c.setcode,0x98) and FilterLocation(c,LOCATION_MZONE)
  elseif (CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>1 and HasID(AIMon(),62709239,true)) then
    return IsSetCode(c.setcode,0xd0) and FilterType(c,TYPE_MONSTER) and FilterLocation(c,LOCATION_MZONE)
  elseif CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>3 then
    return IsSetCode(c.setcode,0xd0) and FilterType(c,TYPE_MONSTER) and FilterLocation(c,LOCATION_MZONE)
  end
end

function AllyPhantomFilter3(c)
  if CardsMatchingFilter(AIST(),ScaleHighFilter)>0 and HasScales() and CardsMatchingFilter(AIHand(),ScaleHighFilter)>0 then
    return (c.id==51531505 or c.id==72714461 or c.id==00645794 or c.id==68395509 or c.id==31991800) and FilterLocation(c,LOCATION_SZONE)
  elseif CardsMatchingFilter(AIST(),ScaleLowFilter)>0 and HasScales() and CardsMatchingFilter(AIHand(),ScaleLowFilter)>0 then
    return (c.id==15146890 or c.id==05506791 or c.id==94784213 or c.id==14920218) and FilterLocation(c,LOCATION_SZONE)
  end
end

function SpecterTornadoFilter(c)
  return Targetable(c,TYPE_TRAP)
  and Affected(c,TYPE_TRAP)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and not SpecterCodedTargets(c)
end

function SpecterTornadoFilter2(c)
  return Targetable(c,TYPE_TRAP)
  and Affected(c,TYPE_TRAP)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and (bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION)>0 or c.level>4)
  and not SpecterCodedTargets(c)
  and not EnemyHasUnaffectedAttackerFilter(c)
  and not SpecterBPBackrow(c)
  and not SpecterEPBackrow(c)
--  and not SpecterCodedUnaffectedAttackers(c)
end

function SpecterTornadoFilter3(c)
  return EnemySummonNegatorMonFilter(c)
  and SpecterTornadoFilter(c)
end

function SpecterTornadoFilter4(c)
  if (EnemyHasFireflux() or EnemyHasPPalOrOddEyes()
  or EnemyHasStargazer() or EnemyHasTimegazer())
  and IsBattlePhase() then
    return c.attack > SpecterAIGetWeakestAttDef()
    and FilterPosition(c,POS_FACEUP_ATTACK)
	and SpecterTornadoFilter(c)
    and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
    and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
  end
  if EnemyHasFireflux() or EnemyHasPPalOrOddEyes()
  or EnemyHasStargazer() or EnemyHasTimegazer() then
    return (bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION)>0 or c.level>4)
	and SpecterTornadoFilter(c)
  end
  return EnemyHasUnaffectedAttackerFilter(c)
  and SpecterTornadoFilter(c)
end

function SpecterTornadoFilter5(c)
  return SpecterBPBackrowFilter(c)
  and SpecterTornadoFilter(c)
end

function SpecterTornadoFilter6(c)
  return SpecterTornadoFilter(c)
  and FilterPosition(c,POS_FACEUP_ATTACK)
end

function SpecterTornadoFilter7(c)
  return SpecterTornadoFilter(c)
  and (FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
  or FilterAffected(c,EFFECT_INDESTRUCTABLE_BATTLE))
  and (FilterPosition(c,POS_FACEUP)
  or FilterPublic(c))
end

function ChainSpecterTornado()
  return CardsMatchingFilter(OppMon(),SpecterTornadoFilter)>0
  and (NeedsRaccoonExtra() or NeedsCatExtra()
  or NeedsFoxExtra() or NeedsCrowExtra()
  or NeedsToadExtra())
  and HasScales()
  and ((Duel.GetTurnPlayer()==player_ai and Duel.GetTurnCount() ~= SpecterGlobalPendulum)
  or (Duel.GetTurnPlayer()==1-player_ai and AI.GetCurrentPhase() == PHASE_END))
  and UnchainableCheck(36183881)
  and not MajestyCheck()
end

function ChainSpecterTornado2()
  return CardsMatchingFilter(OppMon(),SpecterTornadoFilter2)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and UnchainableCheck(36183881)
  and not MajestyCheck()
end

function ChainSpecterTornado3()
  return CardsMatchingFilter(OppMon(),SpecterTornadoFilter)>0
  and HasScales()
  and (Duel.GetTurnPlayer()==player_ai and Duel.GetTurnCount() ~= SpecterGlobalPendulum)
  and VanityRemovalNeeded()
  and UnchainableCheck(36183881)
end

function ChainSpecterTornado4()
  if IsBattlePhase() and Duel.GetTurnPlayer()==1-player_ai then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
	  and Targetable(source,TYPE_TRAP) and Affected(source,TYPE_TRAP)
	  and SpecterDestroyFilter(source)
	  and WinsBattle(source,target)
	  and UnchainableCheck(36183881)
	  and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
	  then
--	  GlobalTargetSet(source,OppMon())
      return true
     end
   end
  end
 return false
end

function ChainSpecterTornado5()
  return CardsMatchingFilter(OppMon(),SpecterTornadoFilter3)>0
  and UnchainableCheck(36183881)
  and HasScales()
  and ((Duel.GetTurnPlayer()==player_ai and Duel.GetTurnCount() ~= SpecterGlobalPendulum)
  or (Duel.GetTurnPlayer()==1-player_ai and AI.GetCurrentPhase() == PHASE_END))
  and not MajestyCheck()
end

function ChainSpecterTornado6()
  return CardsMatchingFilter(OppMon(),SpecterTornadoFilter4)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and IsBattlePhase()
  and UnchainableCheck(36183881)
end

function ChainSpecterTornado7()
  return CardsMatchingFilter(OppMon(),SpecterTornadoFilter5)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and IsBattlePhase()
  and UnchainableCheck(36183881)
end

function ChainSpecterTornado8()
  return ((CardsMatchingFilter(OppMon(),SpecterTornadoFilter7)==1
  and #OppMon()==1
  and CardsMatchingFilter(AIMon(),MajespecterAttack)>2
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableFreelyBackrowFilter)>0
  and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>1)
  or (CardsMatchingFilter(OppMon(),SpecterTornadoFilter7)==2
  and #OppMon()==2
  and CardsMatchingFilter(AIMon(),MajespecterAttack)>3
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableFreelyBackrowFilter)>1
  and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>2)
  or (CardsMatchingFilter(OppMon(),SpecterTornadoFilter7)==3
  and #OppMon()==3
  and CardsMatchingFilter(AIMon(),MajespecterAttack)>4
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableFreelyBackrowFilter)>2
  and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>3))
  and IsBattlePhase()
  and Duel.GetTurnPlayer()==player_ai
  and UnchainableCheck(36183881)
end

function NeedsRaccoonExtra()
  return HasID(AIMon(),31991800,true)
  and not HasID(AIExtra(),31991800,true)
end

function NeedsCatExtra()
  return HasID(AIMon(),05506791,true)
  and not HasID(AIExtra(),05506791,true)
end

function NeedsFoxExtra()
  return HasID(AIMon(),94784213,true)
  and not HasID(AIExtra(),94784213,true)
end

function NeedsCrowExtra()
  return HasID(AIMon(),68395509,true)
  and not HasID(AIExtra(),68395509,true)
end

function NeedsToadExtra()
  return HasID(AIMon(),00645794,true)
  and not HasID(AIExtra(),00645794,true)
end

function VanityFilter(c)
  return c.id==05851097 and FilterPosition(c,POS_FACEUP)
end

function VanityLockdown()
  return AIGetStrongestAttack() > OppGetStrongestAttDef()
  and CardsMatchingFilter(AIST(),VanityFilter)>0
end

function VanityRemovalNeeded()
  return AIGetStrongestAttack() <= OppGetStrongestAttDef()
  and CardsMatchingFilter(AIST(),VanityFilter)>0
  and CardsMatchingFilter(OppST(),VanityFilter)==0
end

function SpecterChainTotemBird() --Might as well negate whatever the opponent plays if they have one card or less in the hand.
  if #OppHand()<2
  and EffectCheck(1-player_ai)~=nil then
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()~=NegateBlackList
	and e:GetHandlerPlayer()==1-player_ai then
    return true
    end
   end
  end
 return false
end

function SpecterCycloneFilter(c)
  return Targetable(c,TYPE_SPELL)
  and Affected(c,TYPE_SPELL)
  and SpecterDestroyFilter(c)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and not SpecterCodedTargets(c)
  and not SpecterTornadoFirst(c)
end

function SpecterCycloneFilter2(c)
  return Targetable(c,TYPE_SPELL)
  and Affected(c,TYPE_SPELL)
  and SpecterDestroyFilter(c)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and (bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION)>0 or c.level>4)
  and not SpecterCodedTargets(c)
  and not EnemyHasUnaffectedAttackerFilter(c)
  and not SpecterBPBackrow(c)
  and not SpecterTornadoFirst(c)
  and not SpecterEPBackrow(c)
--  and not SpecterCodedUnaffectedAttackers(c)
end

function SpecterCycloneFilter3(c)
  if EnemyHasTimeRafflesia() then
    return EnemyHasRafflesiaFilter(c)
	and SpecterCycloneFilter(c)
  end
  return EnemySummonNegatorMonFilter(c)
  and SpecterCycloneFilter(c)
end

function SpecterCycloneFilter4(c)
  if (EnemyHasFireflux() or EnemyHasPPalOrOddEyes()
  or EnemyHasStargazer() or EnemyHasTimegazer())
  and IsBattlePhase() then
    return c.attack > SpecterAIGetWeakestAttDef()
    and FilterPosition(c,POS_FACEUP_ATTACK)
	and SpecterCycloneFilter(c)
    and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
    and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
  end
  if EnemyHasFireflux() or EnemyHasPPalOrOddEyes()
  or EnemyHasStargazer() or EnemyHasTimegazer() then
    return (bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION)>0 or c.level>4)
	and SpecterCycloneFilter(c)
  end
  return EnemyHasUnaffectedAttackerFilter(c)
  and SpecterCycloneFilter(c)
end

function SpecterCycloneFilter5(c)
  return SpecterBPBackrowFilter(c)
  and SpecterCycloneFilter(c)
  and not SpecterTornadoFirst(c)
end

function SpecterCycloneFilter6(c)
  return SpecterCycloneFilter(c)
  and FilterPosition(c,POS_FACEUP_ATTACK)
end

function SpecterCycloneFilter7(c)
  return SpecterCycloneFilter(c)
  and (FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
  or FilterAffected(c,EFFECT_INDESTRUCTABLE_BATTLE))
  and (FilterPosition(c,POS_FACEUP)
  or FilterPublic(c))
end

function ChainSpecterCyclone()
  return CardsMatchingFilter(OppMon(),SpecterCycloneFilter)>0
  and (NeedsRaccoonExtra() or NeedsCatExtra()
  or NeedsFoxExtra() or NeedsCrowExtra()
  or NeedsToadExtra())
  and HasScales()
  and ((Duel.GetTurnPlayer()==player_ai and Duel.GetTurnCount() ~= SpecterGlobalPendulum)
  or (Duel.GetTurnPlayer()==1-player_ai and AI.GetCurrentPhase() == PHASE_END))
  and UnchainableCheck(49366157)
  and not MajestyCheck()
end

function ChainSpecterCyclone2()
  return CardsMatchingFilter(OppMon(),SpecterCycloneFilter2)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and UnchainableCheck(49366157)
  and not MajestyCheck()
end

function ChainSpecterCyclone3()
  return CardsMatchingFilter(OppMon(),SpecterCycloneFilter)>0
  and HasScales()
  and (Duel.GetTurnPlayer()==player_ai and Duel.GetTurnCount() ~= SpecterGlobalPendulum)
  and VanityRemovalNeeded()
  and UnchainableCheck(49366157)
end

function ChainSpecterCyclone4()
  if IsBattlePhase() and Duel.GetTurnPlayer()==1-player_ai then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
	  and Targetable(source,TYPE_SPELL) and Affected(source,TYPE_SPELL)
	  and SpecterDestroyFilter(source)
	  and WinsBattle(source,target)
	  and UnchainableCheck(49366157)
	  and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
	  then
--	  GlobalTargetSet(source,OppMon())
      return true
     end
   end
  end
 return false
end

function ChainSpecterCyclone5()
  return CardsMatchingFilter(OppMon(),SpecterCycloneFilter3)>0
  and Duel.GetTurnPlayer()==player_ai
  and UnchainableCheck(49366157)
  and HasScales()
  and ((Duel.GetTurnPlayer()==player_ai and Duel.GetTurnCount() ~= SpecterGlobalPendulum)
  or (Duel.GetTurnPlayer()==1-player_ai and AI.GetCurrentPhase() == PHASE_END))
  and not MajestyCheck()
end

function ChainSpecterCyclone6()
  return CardsMatchingFilter(OppMon(),SpecterCycloneFilter4)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and IsBattlePhase()
  and UnchainableCheck(49366157)
end

function ChainSpecterCyclone7()
  return CardsMatchingFilter(OppMon(),SpecterCycloneFilter5)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and IsBattlePhase()
  and UnchainableCheck(49366157)
end

function ChainSpecterCyclone8()
  return ((CardsMatchingFilter(OppMon(),SpecterCycloneFilter7)==1
  and #OppMon()==1
  and CardsMatchingFilter(AIMon(),MajespecterAttack)>2
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableFreelyBackrowFilter)>0
  and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>1)
  or (CardsMatchingFilter(OppMon(),SpecterCycloneFilter7)==2
  and #OppMon()==2
  and CardsMatchingFilter(AIMon(),MajespecterAttack)>3
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableFreelyBackrowFilter)>1
  and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>2)
  or (CardsMatchingFilter(OppMon(),SpecterCycloneFilter7)==3
  and #OppMon()==3
  and CardsMatchingFilter(AIMon(),MajespecterAttack)>4
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableFreelyBackrowFilter)>2
  and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>3))
  and IsBattlePhase()
  and Duel.GetTurnPlayer()==player_ai
  and UnchainableCheck(49366157)
end

function SpecterHeroTrashTalkFilter(c)
  return c.id==08949584 --A Hero Lives
  and FilterPosition(c,POS_FACEUP)
end

function SpecterHeroTrashTalk()
  return AI.GetPlayerLP(2)==4000
  and CardsMatchingFilter(OppST(),SpecterHeroTrashTalkFilter)>0
  and Duel.GetTurnCount() == 2
  and CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0
  and CardsMatchingFilter(AIST(),SpecterBackrowFilter)>0
  and not VanityLockdown()
end

function DetectShadowMist()
  return CardsMatchingFilter(OppMon(),function(c) return c.id==50720316 end)>0
  and Duel.GetTurnCount() == 2
  and #OppMon()==1
end

function TornadoShadowMistFilter(c)
  return SpecterTornadoFilter(c)
  and c.id==50720316
end

function TornadoShadowMist()
  return AI.GetCurrentPhase() == PHASE_END
  and CardsMatchingFilter(OppMon(),TornadoShadowMistFilter)==1
  and Duel.GetTurnCount() == 2
end

function CycloneShadowMistFilter(c)
  return SpecterCycloneFilter(c)
  and c.id==50720316
end

function CycloneShadowMist()
  return AI.GetCurrentPhase() == PHASE_END
  and CardsMatchingFilter(OppMon(),CycloneShadowMistFilter)==1
  and Duel.GetTurnCount() == 2
end

function SpecterChainNegationTempest(card)
  local e,c,id 
  if EffectCheck(1-player_ai)~=nil then
    e,c,id = EffectCheck()
    if SpecterEffectNegateFilter(c,card) then
      SetNegated()
      return true
    end
  else
    local cards = SubGroup(OppMon(),FilterStatus,STATUS_SUMMONING)
    if #cards > 1 and Duel.GetCurrentChain()<1 then
      return true
    end
    if #cards == 1 and Duel.GetCurrentChain()<1 then
      c=cards[1]
      return SpecterSummonNegateFilter(c,card)
    end
  end
  return false
end

function SpecterEffectNegateFilter(c,card)
  local id = c:GetCode()
--First lines are Totem Bird negations
  if (id == 21143940
  or id == 93600443
  or id == 84536654) then
    return true
  end
  if id == 58996430 and Duel.GetCurrentPhase() == PHASE_END then -- Wulf, Lightsworn Beast
    return false
  end
  if id == 30328508 and not Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_DESTROY) then -- Don't negate Squamata's sending effect.
    return false
  end
  if id == 09411399 and HasID(OppGrave(),09411399,true) then -- Don't negate Malicious if there is already a second in the graveyard.
    return false
  end
  if id == 37445295 and #OppHand()>2 and not IsBattlePhase() then -- Falco
    return false
  end
  if id == 33420078 and #OppHand()>0 then --Plaguespreader
    return false
  end
  if id == 49959355 and #OppMon()==1 then --Uni-Zombie
    return true
  end
  if IsSetCode(c.setcode,0xd0) then --Majespecters
    return false
  end
  if id == 64280356 then --Kozmo Tincan
    return true
  end
  if id == 21044178 then --Abyss Dweller has no effect against this deck.
    return false
  end
-- If the A.I. controls no XYZs, do not negate Aigaion.
  if id == 10678778 and SpecterSeaCastleCheck() then
    return false
  end
-- Never negate Galaxy Tomahawk or Crazy Box.
  if id == 10389142
  or id == 42421606 then
    return false
  end
-- Never negate these when A.I. has backrow: Sword Breaker,
-- CXyz DFCG, 14, Shark Fort, 33, 94, 32, Papilloperative,
-- Dark Rebellion, Trapeze, 105, Shadow Shien, 10, Comics Hero,
-- Praesepe, Thanatos, Albverdich, 18, King Feral, Vixen,
-- BAN, Snowdust, Gandiva, Merrowgeist, KKDragon,
-- Excalibur, 82, Zubaba, GGG Samurai, Downerd
  if UsableBackrow() then
	if id == 64689404
	or id == 23454876
	or id == 21313376
	or id == 50449881
	or id == 39139935
	or id == 62070231
	or id == 09053187
	or id == 65676461
	or id == 02191144
	or id == 16195942
	or id == 17016362
	or id == 59627393
	or id == 01828513
	or id == 11411223
	or id == 46871387
	or id == 77631175
	or id == 02091298
	or id == 65884091
	or id == 28290705
	or id == 23649496
	or id == 11398059
	or id == 58712976
	or id == 82944432
	or id == 73659078
	or id == 48009503
	or id == 76372778
	or id == 69069911
	or id == 60645181
	or id == 31437713
	or id == 31563350
	or id == 91499077
	or id == 72167543 then
	  return false
	end
-- Begin conditional negates with backrow: 
-- Targetable - Gauntlet, Shogi, 61
    if (id == 15561463
	or id == 75253697
	or id == 29669359)
	and SpecterTMon() then
	  return false
	end
-- Activation location graveyard (probably don't need a check for this) - 37
    if id == 37279508 then
	  return true
	end
-- Has STornado - 79
	if id == 71921856
	and UsableSTornado() then
	  return false
	end
-- Targetable and Destroyable - Magnaliger
    if id == 57031794
	and SpecterTarOrDesMon() then
	  return false
	end
	-- Misc - 21, Zereort, Corebage, CDragon Nova, 19, E of Prophecy, C32
	-- CXyz Mechquipped, 91, Dolkka, Aeroboros, Archduke, Pho Papilloperative
	-- 50, 101, Castel
    if (id == 57707471 and Specter21Check())
    or (id == 13183454 and SpecterZereortCheck())
    or (id == 58600555 and SpecterCorebageCheck())
    or (id == 58069384 and SpecterCNovaCheck())
    or (id == 55067058 or Specter19Check())
    or (id == 00770365 and SpecterEmpressCheck())
    or (id == 49221191 and SpecterC32Check())
	or (id == 41309158 and SpecterAngeneralCheck())
	or (id == 84417082 and Specter91Check())
	or (id == 42752141 and SpecterDolkkaCheck())
	or (id == 11646785 and SpecterAeroborosCheck())
	or (id == 66506689 and SpecterAeroborosCheck())
	or (id == 28150174 and SpecterAngeneralCheck())
	or (id == 51735257 and Specter50Check())
	or (id == 48739166 and Specter101Check())
	or (id == 82633039 and SpecterCastelCheck()) then
      return false
    end
  end
-- Begin cards with conditions that do not involve backrow:
-- Exa-Stag, 53, 
  if (id == 26211048 and SpecterStagCheck())
  or (id == 23998625 and #OppMon()>1) then
    return false
  end
  if id == 20563387 then
    return true
  end
  if (EnableShadollFunctions() or EnableBAFunctions() 
  or EnableLightswornFunctions() or EnableZombieFunctions()) then
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
      if e and (Duel.GetOperationInfo(i,CATEGORY_TOGRAVE)
      or Duel.GetOperationInfo(i,CATEGORY_DECKDES)) 
	  and e:GetHandlerPlayer()==1-player_ai then
	    return true
	  end
	end
	if KuribanditTrace() then
	  return true
	end
  end
  return ChainNegation(card)
end

function SpecterSummonNegateFilter(c,card)
  local id = c.id
  if SpecterMaterialNegateFilter(c) then
    return true
  end
  if (CardsMatchingFilter(OppMon(),EnemySummoningUnaffectedAttackerFilter)>0 or CardsMatchingFilter(OppMon(),EnemyUtopiaTempestRemoval)>0)
  and (UsableSTornado() or UsableSCyclone()) then
	return false
  end
  if CardsMatchingFilter(OppMon(),EnemySummoningUnaffectedAttackerFilter2)>0 then
--  and (UsableSTornado() or UsableSCyclone()) then
	return true
  end
-- If the A.I. controls no XYZs, do not negate Aigaion.
  if id == 10678778 and SpecterSeaCastleCheck() then
    return false
  end
-- Never negate Galaxy Tomahawk or Crazy Box.
  if id == 10389142
  or id == 42421606 then
    return false
  end
-- Never negate these when A.I. has backrow: GDTC, C73, 25, Sword Breaker, CXyz Comics, 
-- CXyz DFCG, 14, Shark Fort, 33, 94, Gagagigo, 32, Papilloperative, GK Pearl, Dark Rebellion,
-- Trapeze, 105, Shadow Shien, Laggia, 55, Comics Hero, Praesepe, Thanatos, King Feral,
-- Albverdich, 10, 18, Vixen, BAN, Snowdust, Gandiva, Merrowgeist, KKDragon, Downerd
-- Gtrick Angel, Excalibur, 106, 82, Zubaba, Minerva XYZ, GGG Samurai
  if UsableBackrow() then
    if id == 91949988
	or id == 96864105
	or id == 64554883
	or id == 64689404
	or id == 13030280
	or id == 23454876
	or id == 21313376
	or id == 50449881
	or id == 39139935
	or id == 62070231
	or id == 09053187
	or id == 65676461
	or id == 02191144
	or id == 71594310
	or id == 16195942
	or id == 17016362
	or id == 59627393
	or id == 01828513
	or id == 74294676
	or id == 46871387
	or id == 77631175
	or id == 02091298
	or id == 65884091
	or id == 11398059
	or id == 28290705
	or id == 11411223
	or id == 23649496
	or id == 58712976
	or id == 82944432
	or id == 73659078
	or id == 48009503
	or id == 76372778
	or id == 69069911
	or id == 72167543
	or id == 53334641
	or id == 60645181
	or id == 63746411
	or id == 31437713
	or id == 31563350
	or id == 30100551
	or id == 91499077 then
	  return false
	end
-- Begin conditional negates with backrow: 
-- Targetable - Gauntlet, Shogi, 61, 36
    if (id == 15561463
	or id == 75253697
	or id == 29669359
	or id == 50260683)
	and SpecterTMon() then
	  return false
	end
-- Has STornado - 37, 79, Full-Armored Lancer
    if (id == 37279508
	or id == 71921856
	or id == 25853045)
	and UsableSTornado() then
	  return false
	end
-- Targetable and Destroyable - Magnaliger
    if id == 57031794
	and SpecterTarOrDesMon() then
	  return false
	end
-- Targetable XYZs AI - One-Eyed, 8
	if (id == 75620895
	or id == 47387961)
	and SpecterTarXYZ() then
	  return false
	end
-- Targetable XYZs Both - HCrest
    if id == 02407234
	and SpecterTarXYZBoth() then
	  return false
	end
-- Targetable ATK - Disigma, Paladynamo
    if (id == 39987164
	or id == 61344030)
	and SpecterTarATK() then
	  return false
	end
-- Misc - 21, Zereort, Corebage, CDragon Nova, 19, E of Prophecy, C32, Aeroboros, Dolkka
-- Bahamut, CXyz Mechquipped, 103, Tin Archduke, Pho Papilloperative, Dragun, 50, 101
-- Galaxion, Castel
    if (id == 57707471 and Specter21Check())
    or (id == 13183454 and SpecterZereortCheck())
    or (id == 58600555 and SpecterCorebageCheck())
    or (id == 58069384 and SpecterCNovaCheck())
    or (id == 55067058 or Specter19Check())
    or (id == 00770365 and SpecterEmpressCheck())
    or (id == 49221191 and SpecterC32Check())
	or (id == 11646785 and SpecterAeroborosCheck())
	or (id == 42752141 and SpecterDolkkaCheck()) 
	or (id == 36757171 and SpecterBahamutCheck()) 
	or (id == 41309158 and SpecterAngeneralCheck())
	or (id == 94380860 and Specter103Check()) 
	or (id == 66506689 and SpecterAeroborosCheck())
	or (id == 28150174 and SpecterAngeneralCheck())
	or (id == 90726340 and SpecterDragunCheck())
	or (id == 51735257 and Specter50Check())
	or (id == 48739166 and Specter101Check())
	or (id == 40390147 and SpecterGalaxionCheck())
	or (id == 82633039 and SpecterCastelCheck()) then
      return false
    end
  end
-- Begin cards with conditions that do not involve backrow:
-- Exa-Stag, 53, 91
  if (id == 26211048 and SpecterStagCheck())
  or (id == 23998625 and #OppMon()>1) 
  or (id == 84417082 and Specter91Check()) then
    return false
  end
--Cards that should actually be negated
--C80, Tzolkin, Bishbaalkin
  if (id == 20563387
  or id == 01686814
  or id == 90884403) then
    return true
  end
 return ChainNegation(card)
end

function SpecterBPBackrow(c)
  if SpecterTMon() and (HasID(OppMon(),15561463,true) or HasID(OppMon(),75253697,true)
  or HasID(OppMon(),29669359,true) or HasID(OppMon(),50260683,true)) then
    return c.id==15561463
	or c.id==75253697
	or c.id==29669359
	or c.id==50260683
  end
  if SpecterTarOrDesMon() and HasID(OppMon(),57031794,true) then
    return c.id==57031794
  end
  if Specter21Check() and HasID(OppMon(),57707471,true) then
	return c.id==57707471
  end
  if SpecterZereortCheck() and HasID(OppMon(),13183454,true) then
	return c.id==13183454
  end
  if SpecterCorebageCheck() and HasID(OppMon(),58600555,true) then
	return c.id==58600555
  end
  if Specter94Check() and HasID(OppMon(),62070231,true) then
	return c.id==62070231
  end
  if SpecterEmpressCheck() and HasID(OppMon(),00770365,true) then
	return c.id==00770365
  end
  if #OppMon()>1 and HasID(OppMon(),23998625,true) then
	return c.id==23998625
  end
  if SpecterC32Check() and HasID(OppMon(),49221191,true) then
	return c.id==49221191
  end
  if SpecterTarXYZBoth() and HasID(OppMon(),02407234,true) then
    return c.id==02407234
  end
  if SpecterTarXYZ() and (HasID(OppMon(),47387961,true) 
  or HasID(OppMon(),75620895,true)) then
    return c.id==47387961
	or c.id==75620895
  end
  if SpecterTarATK() and (HasID(OppMon(),39987164,true)
  or HasID(OppMon(),61344030,true)) then
    return c.id==39987164
	or c.id==61344030
  end
  if SpecterLaggiaCheck() and HasID(OppMon(),74294676,true) then
    return c.id==74294676
  end
  if Specter91Check() and HasID(OppMon(),84417082,true) then
    return c.id==84417082
  end
  if SpecterDolkkaCheck() and HasID(OppMon(),42752141,true) then
    return c.id==42752141
  end
  if UsableSCyclone() and not (UsableSTornado() or UsableSStorm()) and HasID(OppMon(),71921856,true) then
    return c.id==71921856
  end
  if SpecterAeroborosCheck() and (HasID(OppMon(),11646785,true)
  or HasID(OppMon(),66506689,true)) then
    return c.id==11646785
	or c.id==66506689
  end
  if (UsableSTornado() or UsableSStorm()) and HasID(OppMon(),58712976,true) then
    return c.id==58712976
  end
  if SpecterDragunCheck() and HasID(OppMon(),90726340,true) then
    return c.id==90726340
  end
  if SpecterAngeneralCheck() and HasID(OppMon(),28150174,true) then
    return c.id==28150174
  end
  if Specter50Check() and HasID(OppMon(),51735257,true) then
    return c.id==51735257
  end
  if Specter101Check() and HasID(OppMon(),48739166,true) then
    return c.id==48739166
  end
  if (UsableSTornado() or UsableSStorm()) and HasID(OppMon(),25853045,true) then
    return c.id==25853045
  end
  if SpecterGalaxionCheck() and HasID(OppMon(),40390147,true) then
    return c.id==40390147
  end
  if SpecterCastelCheck() and HasID(OppMon(),82633039,true) then
    return c.id==82633039
  end
  return c.id==96864105
  or c.id==91949988
  or c.id==64554883
  or c.id==64689404
  or c.id==13030280
  or c.id==23454876
  or c.id==21313376
  or c.id==50449881
  or c.id==39139935
  or c.id==55067058
  or c.id==26211048
  or c.id==09053187
  or c.id==65676461
  or c.id==37279508
  or c.id==02191144
  or c.id==71594310
  or c.id==41309158
  or c.id==16195942
  or c.id==17016362
  or c.id==59627393
  or c.id==01828513
  or c.id==11411223
  or c.id==46871387
  or c.id==77631175
  or c.id==02091298
  or c.id==36757171
  or c.id==65884091
  or c.id==28290705
  or c.id==23649496
  or c.id==94380860
  or c.id==82944432
  or c.id==73659078
  or c.id==48009503
  or c.id==76372778
  or c.id==69069911
  or c.id==72167543
  or c.id==60645181
  or c.id==63746411
  or c.id==31437713
  or c.id==31563350
  or c.id==91499077
end

function SpecterBPBackrowFilter(c)
  return SpecterBPBackrow(c)
  and c.attack > SpecterAIGetWeakestAttDef()
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
  and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
end

function SpecterTornadoFirst(c)
  if (UsableSTornado() or UsableSStorm()) and HasID(OppExtra(),97403510,true) and HasID(OppMon(),23998625,true) then
    return c.id==23998625
  end
  if (UsableSTornado() or UsableSTempest() or UsableSStorm()) 
  and SpecterCNovaCheck() and HasID(OppMon(),58069384,true) then
    return c.id==58069384
  end
  if (UsableSTornado() or UsableSStorm()) and SpecterTrapezeCheck() and HasID(OppMon(),17016362,true) then
    return c.id==17016362
  end
  if (UsableSTornado() or UsableSStorm()) and SpecterWaveCaesarCheck() and HasID(OppMon(),03758046,true) then
    return c.id==03758046
  end
  if (UsableSTornado() or UsableSStorm()) and Specter18Check() and HasID(OppMon(),23649496,true) then
    return c.id==23649496
  end
  if (UsableSTornado() or UsableSStorm()) and SpecterVixenCheck() and HasID(OppMon(),58712976,true) then
    return c.id==58712976
  end
  if (UsableSTornado() or UsableSStorm()) and SpecterFFTigerCheck() and HasID(OppMon(),96381979,true) then
    return c.id==96381979
  end
  if (UsableSTornado() or UsableSStorm()) then
    return c.id==16691074
	or c.id==00007152
	or c.id==23454876
	or c.id==37279508
	or c.id==56638325
	or c.id==71921856
	or c.id==42589641
	or c.id==30100551
  end
end

function SpecterEPBackrow(c)
  return c.id==42421606
  or c.id==10389142
end

function SpecterFFTigerFilter(c)
  return (IsSetCode(c.setcode,0x7c)
  and FilterPosition(c,POS_FACEUP))
  or FilterPosition(c,POS_FACEDOWN)
end

function SpecterFFTigerCheck()
  return CardsMatchingFilter(OppST(),OppBackrowFilter)>2
end

function SpecterVixenFilter(c)
  return c.attack >= 2500
end

function SpecterVixenCheck()
  return CardsMatchingFilter(OppMon(),SpecterVixenFilter)>0
end

function SpecterCastelEnemyFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP)
end

function SpecterCastelCheck()
  return CardsMatchingFilter(AIField(),SpecterCastelEnemyFilter)==0
end

function SpecterGalaxionFilter(c)
  return c.original_id==40390147
end

function SpecterGalaxionCheck()
  return CardsMatchingFilter(OppGrave(),SpecterGalaxionFilter)<3
end

function Specter101Filter(c)
  return Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)>0
end

function Specter101Check()
  return CardsMatchingFilter(AIMon(),Specter101Filter)==0
end

function Specter50Filter(c)
  return Targetable(c,TYPE_MONSTER)
  and c.attack <= 2100
  and not FilterType(c,TYPE_PENDULUM)
end

function Specter50Check()
  return CardsMatchingFilter(AIMon(),Specter50Filter)==0
end

function SpecterDragunFilter(c)
  return c.level>=5
  and FilterRace(c,RACE_DRAGON)
end

function SpecterDragunCheck()
  return CardsMatchingFilter(OppGrave(),SpecterDragunFilter)==0
end

function SpecterLaggiaFilter(c)
  return c.xyz_material_count==0
end

function SpecterLaggiaCheck()
  return CardsMatchingFilter(OppMon(),SpecterLaggiaFilter)>0
end

function Specter18Filter(c)
  return IsSetCode(c.setcode,0x76)
end

function Specter18Check()
  return CardsMatchingFilter(OppMon(),Specter18Filter)>1
end

function SpecterWaveCaesarCheck()
  return Duel.GetCurrentPhase() ~= PHASE_MAIN2
  and Duel.GetCurrentPhase() ~= PHASE_END
end

function SpecterTrapezeFilter(c)
  return IsSetCode(c.setcode,0xc6)
end

function SpecterTrapezeCheck()
  return CardsMatchingFilter(OppDeck(),SpecterTrapezeFilter)>0
end

function Specter103Filter(c)
  return c.attack~=c.base_attack
  and FilterPosition(c,POS_FACEUP_ATTACK)   
  and FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)==0
  and Targetable(c,TYPE_MONSTER)
end

function Specter103Check()
  return CardsMatchingFilter(AIMon(),Specter103Filter)==0
end

function SpecterAngeneralCheck()
  return not (HasID(AIMon(),51531505,true)
  and HasID(AIMon(),85252081,true)
  and HasID(AIMon(),93568288,true))
end

function SpecterTATKFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK)
end

function SpecterTarATK()
  return CardsMatchingFilter(AIMon(),SpecterTATKFilter)==0
end

function Specter91Filter(c)
  return FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
end

function Specter91SelfFilter(c)
  return c.xyz_material_count==3
  and c.id==84417082
end

function Specter91Check()
  return (CardsMatchingFilter(AIMon(),Specter91Filter)==0
  or CardsMatchingFilter(OppMon(),Specter91Filter)>2)
  and CardsMatchingFilter(OppMon(),Specter91SelfFilter)>0
end

function SpecterBahamutCheck()
  return CardsMatchingFilter(AIMon(),SpecterTargetableMonster)==0
  or #OppHand()==0
end

function SpecterTarXYZFilter(c)
  return FilterType(c,TYPE_XYZ)
  and Targetable(c,TYPE_MONSTER)
end

function SpecterTarXYZ()
  return CardsMatchingFilter(AIMon(),SpecterTarXYZFilter)==0
end

function SpecterTarXYZBoth()
  return CardsMatchingFilter(AIMon(),SpecterTarXYZFilter)==0
  and CardsMatchingFilter(OppMon(),SpecterTarXYZFilter)==1
end

function SpecterUnusedTotem(c)
  return c.id==71068247
  and c.xyz_material_count>1
  and NotNegated(c)
end

function SpecterDolkkaCheck()
  return CardsMatchingFilter(AIMon(),SpecterUnusedTotem)==0
  and Duel.GetTurnPlayer()==1-player_ai
end

function SpecterAeroborosFilter(c)
  return HasID(c.xyz_materials,85374678,true)
end

function SpecterAeroborosCheck()
  return CardsMatchingFilter(OppMon(),SpecterAeroborosFilter)==0
  or SpecterTMon()==0
end

function SpecterTargetableMonster(c)
  return Targetable(c,TYPE_MONSTER)
end

function SpecterTMon()
  return CardsMatchingFilter(AIMon(),SpecterTargetableMonster)==0
end

function SpecterTarOrDes(c)
  return Targetable(c,TYPE_MONSTER)
  and FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
end

function SpecterTarOrDesMon()
  return CardsMatchingFilter(AIMon(),SpecterTarOrDes)==0
end

function Specter21Filter(c)
  return FilterPosition(c,POS_DEFENSE)
  and FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
end

function Specter21Check()
  return CardsMatchingFilter(AIMon(),Specter21Filter)==0
end

function SpecterZereortFilter(c)
  return FilterPosition(c,POS_FACEUP_ATTACK)
  and Targetable(c,TYPE_MONSTER)
end

function SpecterZereortCheck()
  return CardsMatchingFilter(AIMon(),SpecterZereortFilter)==0
end

function SpecterCorebageFilter(c)
  return FilterPosition(c,POS_DEFENSE)
  and Targetable(c,TYPE_MONSTER)
end

function SpecterCorebageCheck()
  return CardsMatchingFilter(AIMon(),SpecterCorebageFilter)==0
end

function SpecterCNovaFilter(c)
  return FilterType(c,TYPE_FUSION)
  and FilterRace(c,RACE_MACHINE)
end

function SpecterCNovaCheck()
  return CardsMatchingFilter(OppExtra(),SpecterCNovaFilter)>0
end

function Specter19Filter(c)
  return FilterStatus(c,STATUS_SUMMONING)
  and FilterPosition(c,POS_FACEUP_DEFENSE)
  and c.id==55067058
end

function Specter19Check()
  return CardsMatchingFilter(OppMon(),Specter19Filter)>0
end

function SpecterEmpressFilter1(c)
  return IsSetCode(c.setcode,0x106e)
end

function SpecterEmpressFilter2(c)
  return FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
end

function SpecterEmpressCheck()
  return CardsMatchingFilter(OppDeck(),SpecterEmpressFilter1)==0
  or CardsMatchingFilter(AIMon(),SpecterEmpressFilter2)==0
end

function SpecterC32Filter(c)
  return Targetable(c,TYPE_MONSTER)
end

function SpecterC32Check()
  return CardsMatchingFilter(AIMon(),SpecterC32Filter)==0
  or AI.GetPlayerLP(2)>1000
end

function SpecterStagFilter1(c)
  return Targetable(c,TYPE_MONSTER)
end

function SpecterStagFilter2(c)
  return c.attack >= 2000
end

function SpecterStagCheck()
  return CardsMatchingFilter(AIMon(),SpecterStagFilter1)==0
  and CardsMatchingFilter(AIGrave(),SpecterStagFilter2)==0
end

function SpecterSeaCastleFilter(c)
  return FilterType(c,TYPE_XYZ)
end

function SpecterSeaCastleCheck()
  return CardsMatchingFilter(AIMon(),SpecterSeaCastleFilter)==0
end

function SpecterMaterialNegateFilter(c)
  return FilterStatus(c,STATUS_SUMMONING)
  and (HasID(c.xyz_materials,38331564,true)
  or HasID(c.xyz_materials,24610207,true)
  or HasID(c.xyz_materials,12948099,true)
  or HasID(c.xyz_materials,67120578,true)
  or HasID(c.xyz_materials,94344242,true))
end

function Specter94Filter(c)
  return Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK)
end

function Specter94Check()
  return CardsMatchingFilter(AIMon(),Specter94Filter)==0
end

function SpecterTemtempoFilter1(c) --Honor Ark, Honor Dark, Full-Armored Lancer, Cowboy, Ignis, Zenmaines, Sky Cavalry, Gachi Gachi.
  return Affected(c,TYPE_MONSTER,3)
  and FilterType(c,TYPE_XYZ) 
  and c.xyz_material_count==1 
  and Targetable(c,TYPE_MONSTER)
  and (c.id==48739166
  or c.id==12744567
  or c.id==25853045
  or (c.id==12014404 and FilterPosition(c,POS_FACEUP_DEFENSE) and AI.GetPlayerLP(1)<=800)
  or c.id==03989465
  or c.id==78156759
  or c.id==36776089
  or c.id==10002346)
end

function SpecterTemtempoFilter2(c) --Totem Bird, Starliege Paladynamo, Brotherhood Cardinal
  return Affected(c,TYPE_MONSTER,3)
  and FilterType(c,TYPE_XYZ)
  and c.xyz_material_count==2
  and Targetable(c,TYPE_MONSTER)
  and (c.id==71068247
  or c.id==61344030
  or c.id==58504745)
end

function SpecterTemtempoFilter3(c) --Only chain during opponent's turn. Dark Rebellion, GTomahawk, Shogi XYZ, Excalibur, Castel, ARK Knight
  return Affected(c,TYPE_MONSTER,3)
  and FilterType(c,TYPE_XYZ)
  and c.xyz_material_count==2
  and Targetable(c,TYPE_MONSTER)
  and (c.id==16195942
  or c.id==10389142
  or c.id==75253697
  or c.id==60645181
  or c.id==82633039
  or c.id==48739166)
end

function SpecterTemtempoFilter4(c) --Utopia Lightning
  return Affected(c,TYPE_MONSTER,3)
  and FilterType(c,TYPE_XYZ)
  and c.xyz_material_count==3
  and Targetable(c,TYPE_MONSTER)
  and c.id==56832966
end

function SpecterSummonTemtempo() --Pure gimmick mode initiated, you don't have to check if you have Majespecters, who even needs those?
  return (CardsMatchingFilter(OppMon(),SpecterTemtempoFilter1)>0
  or CardsMatchingFilter(OppMon(),SpecterTemtempoFilter2)>0)
  and HasID(AIExtra(),52558805,true)
end

function SpecterChainTemtempo1()
  return CardsMatchingFilter(OppMon(),SpecterTemtempoFilter1)>0
end

function SpecterChainTemtempo2()
  return CardsMatchingFilter(OppMon(),SpecterTemtempoFilter2)>0
end

function SpecterChainTemtempo3()
  return CardsMatchingFilter(OppMon(),SpecterTemtempoFilter3)>0
  and Duel.GetTurnPlayer() == 1-player_ai
end

function SpecterChainTemtempo4()
  return CardsMatchingFilter(OppMon(),SpecterTemtempoFilter4)>0
  and Duel.GetTurnPlayer() == 1-player_ai
  and AI.GetCurrentPhase() == PHASE_BATTLE
end

function SpecterChainTemtempo5()
  return not (SpecterChainTemtempo1()
  and SpecterChainTemtempo2()
  and SpecterChainTemtempo3()
  and SpecterChainTemtempo4())
end

function SpecterXYZSummon(index,id)
  if index == nil then
    index = CurrentIndex
  end
  SpecterGlobalMaterial = true
  if id then
    SpecterGlobalSSCardID = id
  end
  return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
end

--[[function SpecterXYZSetup(cards,minTargets,maxTargets,triggeringID,triggeringCard) --Cheating AI. Pretty much the best mistake of my life.
--  if SpecterGlobalMaterial then
    if not triggeringCard then
	local function compare(a,b)
	local result = {}
      return a.attack < b.attack
    end
	local list = {}
    for i=1,#cards do
      if cards[i] and bit32.band(cards[i].type,TYPE_MONSTER) > 0
      then   
        cards[i].index=i
        list[#list+1]=cards[i]
        if cards[i].id == 72714461 or cards[i].id == 15146890 or cards[i].id == 40318957 then
            cards[i].attack = -3
        else
            cards[i].attack = -1
        end
      end
    end
    table.sort(list,compare)
    result={}
    check={}
    for i=1,#minTargets do
      result[i]=list[i].index
      check[i]=list[i]
    end
  end
 return result
end]]

function SpecterOnSelectMaterial(cards,min,max,id)
  if id == SpecterGlobalSSCardID then
   return Add(cards,PRIO_TOGRAVE,min)
  end
end

function SStormFilter1(c)
  return Targetable(c,TYPE_SPELL)
  and Affected(c,TYPE_SPELL)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and not SpecterCodedTargets(c)
end

function SStormFilter2(c)
  return Targetable(c,TYPE_SPELL)
  and Affected(c,TYPE_SPELL)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and (bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION)>0 or c.level>4)
  and not SpecterCodedTargets(c)
  and not EnemyHasUnaffectedAttackerFilter(c)
  and not SpecterBPBackrow(c)
--  and not SpecterCodedUnaffectedAttackers(c)
end

function SStormFilter4(c)
  return Targetable(c,TYPE_SPELL)
  and Affected(c,TYPE_SPELL)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and BypassDestroyFilter(c)
  and not SpecterCodedTargets(c)
end

function SStormFilter5(c)
  if EnemyHasTimeRafflesia() then
    return EnemyHasRafflesiaFilter(c)
	and SStormFilter1(c)
  end
  return EnemySummonNegatorMonFilter(c)
  and SStormFilter1(c)
end

function SStormFilter6(c)
  if EnemyHasFireflux() or EnemyHasPPalOrOddEyes()
  or EnemyHasStargazer() or EnemyHasTimegazer() then
    return (bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION)>0 or c.level>4)
	and SStormFilter1(c)
  end
 return false
--  return EnemyHasUnaffectedAttackerFilter(c)
--  and SStormFilter1(c)
end

function UseSStorm1()
  return HasScales()
  and CardsMatchingFilter(OppMon(),SStormFilter1)>0
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and (NeedsRaccoonExtra() or NeedsCatExtra()
  or NeedsFoxExtra() or NeedsCrowExtra()
  or NeedsToadExtra())
  and not MajestyCheck()
end

function UseSStorm2()
  return CardsMatchingFilter(OppMon(),SStormFilter2)>0
  and not MajestyCheck()
end

function UseSStorm3()
  return CardsMatchingFilter(OppMon(),SStormFilter1)>0
  and HasScales()
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and VanityRemovalNeeded()
end

function UseSStorm4()
  return CardsMatchingFilter(OppMon(),SStormFilter4)>0
  and not MajestyCheck()
end

function UseSStorm5()
  return CardsMatchingFilter(OppMon(),SStormFilter5)>0
  and Duel.GetTurnPlayer()==player_ai 
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and HasScales()
  and not MajestyCheck()
end

function UseSStorm6()
  return CardsMatchingFilter(OppMon(),SStormFilter6)>0
  and not MajestyCheck()
end

function MajestyCheck()
  if EnemyHasSpecterCounterCardST() then return false end
  if Duel.GetTurnPlayer() == player_ai
  and OPTCheck(76473843) 
  and ((Duel.GetTurnCount() ~= SpecterGlobalPendulum and HasScales() and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)>0) or CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0)
  and (HasIDNotNegated(AIST(),76473843,true,nil,nil,POS_FACEUP)
  or HasID(AIHand(),76473843,true) and not FieldSpellNotActivatable() and not HasFaceupMajesty()) then
   return true
  end
 return false
end

function FieldSpellNotActivatableFilter(c) --Field Barrier, Closed Forest, Anti-Spell Fragrance, Spell Canceller, Spell Sealing
  return (c.id==07153114
  or c.id==78082039
  or c.id==58921041
  or c.id==84636823
  or c.id==71983925)
  and FilterPosition(c,POS_FACEUP)
  and NotNegated(c)
end

function FieldSpellNotActivatable() --Checks for cards that prevent another Field from being played. Necrovalley etc., Mechanical Hound, Bamboo Shoot.
  return CardsMatchingFilter(UseLists({OppMon(),OppST()}),FieldSpellNotActivatableFilter)>0
  or (HasIDNotNegated(OppMon(),58139128,true)
  and (HasIDNotNegated(OppST(),47355498,true) and HasIDNotNegated(OppMon(),03381441,true)))
  or (HasIDNotNegated(OppMon(),22512237,true) and #OppHand()==0)
  or HasIDNotNegated(OppMon(),20174189,true)
end

function SpecterSummonChidori2()
  return Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and OppDownBackrow()
  and HasScales()
  and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)>0
  and HasID(AIExtra(),22653490,true)
end

function SpecterSummonCastel()
  return XYZSummonOkay()
  and OppGetStrongestAttack() > AIGetStrongestAttack()
  and (OppGetStrongestAttack() > 2000 and not SpecterSummonMajester1())
  and CardsMatchingFilter(OppMon(),SpecterCastelFilter)>0 
  and HasID(AIExtra(),82633039,true) 
  and MP2Check()
end

function SpecterSummonCastelRoom()
  return MakeRoom()
  and OppGetStrongestAttack() > AIGetStrongestAttack()
  and (OppGetStrongestAttack() > 2000 and (not HasID(AIExtra(),88722973,true) and NeedsRaccoon()))
  and CardsMatchingFilter(OppMon(),SpecterCastelFilter)>0
  and HasID(AIExtra(),82633039,true)
end

function SpecterCastelFilter(c)
  return FilterPosition(c,POS_FACEUP)
  and Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,4)
  and not SpecterCodedTargets2(c)
  and c.attack == OppGetStrongestAttDef()
end

function SpecterUseCastel()
  return CardsMatchingFilter(OppField(),SpecterCastelFilter)>0
end

function SpecterSummonUtopiaLightning()
  return CardsMatchingFilter(OppMon(),SpecterLightningFilter)>0
  and XYZSummonOkay()
  and OppGetStrongestAttDef() >= AIGetStrongestAttack()
  and AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and HasID(AIExtra(),56832966,true)
  and not HasID(AIMon(),56832966,true)
  and not EnemyHasStall()
  and not EnemyHasBattleStallLightning()
end

function SpecterSummonUtopiaLightningRoom()
  return MakeRoom()
  and CardsMatchingFilter(OppMon(),SpecterLightningFilter)>0
  and OppGetStrongestAttDef() >= AIGetStrongestAttack()
  and AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and not EnemyHasStall()
  and not EnemyHasBattleStallLightning()
end

function SpecterSummonUtopiaLightningSmart()
  return CardsMatchingFilter(OppMon(),SpecterGraveyardEffectBattleFilter)>0
  and XYZSummonOkay()
  and AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and HasID(AIExtra(),56832966,true)
  and not HasID(AIMon(),56832966,true)
  and not EnemyHasStall()
  and not EnemyHasBattleStallLightning()
end

function SpecterLightningFilter(c)
  return not FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
  and not FilterAffected(c,EFFECT_INDESTRUCTABLE_BATTLE)
end

function SpecterSummonHeartland()
  return XYZSummonReallyOkay()
  and HasScales()
  and HasID(AIExtra(),31437713,true)
  and SpecterMP2Check()
  and not HasPtolemaeusExtra()
end

function SpecterActivateHeartland()
  return OppGetStrongestAttDef() >= AIGetStrongestAttack()
--  and #AIMon() < #OppMon()
end

function SpecterSummonHeartlandFinish()
  return AI.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed
  and AI.GetPlayerLP(2)<=2000
  and #OppMon()>0
  and HasID(AIExtra(),31437713,true)
end

function SpecterActivateHeartlandFinish()
  return AI.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed
  and AI.GetPlayerLP(2)<=2000
end

function HasPtolemaeusExtra()
  return HasID(AIExtra(),18326736,true)
  and HasID(AIExtra(),09272381,true)
  and HasID(AIExtra(),34945480,true)
end

function SpecterSummonMajester1()
  return (XYZSummonOkay() or CardsMatchingFilter(AIMon(),LevelFourMagicianFilter)>1)
  and NeedsRaccoon()
  and SpecterMP2Check()
  and OPTCheck(05506791)
  and HasID(AIExtra(),88722973,true)
end

function SpecterSummonMajester2() --???
  return MakeRoom()
  and HasID(AIExtra(),88722973,true)
end

function SpecterSummonMajesterRoom()
  return MakeRoom()
  and HasID(AIExtra(),88722973,true)
end

function SpecterUseDragonpit()
  return CardsMatchingFilter(OppST(),OppDownBackrowFilter)>0
  and (CardsMatchingFilter(AIExtra(),AllPendulumFilter)>0
  or CardsMatchingFilter(AIHand(),AllPendulumFilter)>1)
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and OPTCheck(51531505)
  and not RaccoonHandCheck()
end

function UseDragonpitVanitys()
  return CardsMatchingFilter(OppST(),VanityFilter)>0
  and CardsMatchingFilter(AIST(),VanityFilter)==0
  and (CardsMatchingFilter(AIExtra(),AllPendulumFilter)>0
  or CardsMatchingFilter(AIHand(),AllPendulumFilter)>1
  or (CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0
  and HasID(AIST(),76473843,true)
  and OPTCheck(76473843)))
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and OPTCheck(51531505)
  and not RaccoonHandCheck()
end

function DragonpitVanitysTargetFilter(c)
  return FilterType(c,TYPE_SPELL+TYPE_TRAP)
  and not FilterType(c,TYPE_PENDULUM)
  and SpecterDestroyFilter(c)
end

function RaccoonFilter(c) --Test
  return c.id==31991800
end

--Lol, Shadolls are with me in spirit and copied coding.

function SpecterGetPriority(c,loc)
  local checklist = nil
  local result = 0
  local id = c.id
  if loc == nil then
    loc = PRIO_TOHAND
  end
  checklist = Prio[id]
  if checklist then
    if checklist[11] and not(checklist[11](loc,c)) then
      loc = loc + 1
    end
    result = checklist[loc]
  end
  return result
end

function SpecterAssignPriority(cards,loc,filter)
  local index = 0
  for i=1,#cards do
    cards[i].index=i
    cards[i].prio=SpecterGetPriority(cards[i],loc)
  end
end

function SpecterPriorityCheck(cards,loc,count,filter)
  if count == nil then count = 1 end
  if loc==nil then loc=PRIO_TOHAND end
  if cards==nil or #cards<count then return -1 end
  SpecterAssignPriority(cards,loc,filter)
  table.sort(cards,function(a,b) return a.prio>b.prio end)
  return cards[count].prio
end

function SpecterTrapPriorityFilter(c)
  return (c.id==78949372
  or c.id==36183881
  or c.id==02572890)
  and FilterLocation(c,LOCATION_DECK)
end

function SpecterSpellPriorityFilter(c)
  return (c.id==49366157
  or c.id==13972452)
  and FilterLocation(c,LOCATION_DECK)
end

function EnableBlueEyesFunctionsFilter(c)
  return c.id==71039903
  or c.id==45467446
  or c.id==38517737
end

function EnableBlueEyesFunctions()
  return CardsMatchingFilter(UseLists({OppDeck(),OppGrave()}),EnableBlueEyesFunctionsFilter)>5
end

function EnableShadollFunctionsFilter(c)
  return IsSetCode(c.setcode,0x9d)
end

function EnableShadollFunctions()
  return CardsMatchingFilter(UseLists({OppDeck(),OppGrave()}),EnableShadollFunctionsFilter)>5
end

function SpecterBlueSummonAbyss()
  return EnableBlueEyesFunctions()
  and (XYZSummonReallyOkay()
  and SpecterMP2Check()
  and AIGetStrongestAttack() > OppGetStrongestAttDef()
  or MakeRoom())
end

function SpecterShadollSummonAbyss()
  return EnableShadollFunctions()
  and (XYZSummonOkay()
  and SpecterMP2Check()
  and AIGetStrongestAttack() > OppGetStrongestAttDef()
  or MakeRoom())
end

function SpecterShadollSummonAbyssRoom()
  return EnableShadollFunctions()
  and MakeRoom()
--  and AIGetStrongestAttack() > OppGetStrongestAttDef()
end

function SpecterShadollFusionGrave()
  return (HasID(OppGrave(),44394295,true)
  or HasID(OppGrave(),06417578,true)
  or HasID(OppGrave(),60226558,true))
  and EnableShadollFunctions()
end

function ChainSpecterAbyss()
--  if (EnableBlueEyesFunctions()
  if (EnableShadollFunctions()
  or EnableRaidraptorFunctions()
  or EnableBAFunctions()
  or EnableHieraticFunctions()
  or EnableLightswornFunctions()
  or EnableZombieFunctions()
  or EnableBlueEyesAbyssFunctions())
  and Duel.GetTurnPlayer()==1-player_ai then return true end
  if EnableShadollFunctions() then
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
      if e and (e:GetHandler():GetCode()==84968490 or e:GetHandler():GetCode()==77505534 or e:GetHandler():GetCode()==06417578 or e:GetHandler():GetCode()==74519184) 
	  and e:GetHandlerPlayer()==1-player_ai then
	   return true
	  end
	end
  end
  if EnableShadollFunctions() then
    if SpecterDestroyCheckOpp(03717252) or SpecterDestroyCheckOpp(77723643) or SpecterDestroyCheckOpp(30328508) or SpecterDestroyCheckOpp(52551211)
	or SpecterDestroyCheckOpp(04939890) or SpecterDestroyCheckOpp(37445295) or SpecterDestroyCheckOpp(74822425) or SpecterDestroyCheckOpp(19261966)
    or SpecterDestroyCheckOpp(20366274) or SpecterDestroyCheckOpp(48424886) or SpecterDestroyCheckOpp(74009824) or SpecterDestroyCheckOpp(94977269)
	or SpecterDestroyCheckOpp(03717252) or (SpecterDestroyCheckOpp(04904633) and SpecterShadollFusionGrave()) then
	  return true
	end
  end
  if EnableShadollFunctions() then
    if IsBattlePhase() then
    local source = Duel.GetAttacker()
	local target = Duel.GetAttackTarget()
      if source and target then
        if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
        end
        if target:IsControler(player_ai)
		and source:IsPosition(POS_FACEUP)
		and target:IsPosition(POS_FACEUP_ATTACK)
		and WinsBattle(target,source)
		and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
		and ((source:IsCode(94977269) or source:IsCode(74822425) 
		or source:IsCode(48424886) or source:IsCode(20366274) 
		or source:IsCode(19261966) or source:IsCode(74009824) 
		or source:IsCode(04904633)) and SpecterShadollFusionGrave())
		then
		  return true
		end
	  end
	end
  end 
  if EnableBAFunctions() then
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
      if e and (e:GetHandler():GetCode()==60743819 or e:GetHandler():GetCode()==20513882 or e:GetHandler():GetCode()==36006208 or e:GetHandler():GetCode()==57728570 or e:GetHandler():GetCode()==53582587) 
	  and e:GetHandlerPlayer()==1-player_ai then
	   return true
	  end
	end
  end
  if EnableBAFunctions() then
    if IsBattlePhase() then
    local source = Duel.GetAttacker()
	local target = Duel.GetAttackTarget()
      if source and target then
        if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
        end
        if target:IsControler(player_ai)
		and source:IsPosition(POS_FACEUP)
		and target:IsPosition(POS_FACEUP_ATTACK)
		and WinsBattle(target,source)
		and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
		and (source:IsCode(20758643) or source:IsCode(57143342) or source:IsCode(09342162) or source:IsCode(36553319) or source:IsCode(84764038) 
		or source:IsCode(27552504) or (source:IsCode(62957424) and #OppHand()>0) or source:IsCode(00601193) or source:IsCode(18386170) 
		or source:IsCode(83531441))
		then
		  return true
		end
	  end
	end
  end
--[[  if EnableBAFunctions() and GlobalMurderDante then
    GlobalMurderDante = false
	return true
  end]]
  if EnableBAFunctions() and SpecterDestroyCheckOpp(83531441) then
    return true
  end
  if EnableBAFunctions() and SpecterRemovalCheckOpp(83531441) and EnemyHasDante() then
    return true
  end
  if EnableArtifactFunctions() and SpecterArtifactDestroyCheckOpp(OppST()) and Duel.GetTurnPlayer()==player_ai then
    return true
  end
  if RemovalCheck(21044178) then
    return true
  end
  if CardsMatchingFilter(OppGrave(),SpecterMiscAbyssMP1Filter)>0 
  and Duel.GetCurrentPhase() == PHASE_MAIN1 
  and Duel.GetTurnPlayer()==player_ai then
    return true
  end
  if CardsMatchingFilter(OppGrave(),SpecterMiscAbyssMP2Filter)>0
  and Duel.GetTurnPlayer()==1-player_ai then
    return true
  end
  if SpecterStardustCheck() or SpecterStarAssaultModeCheck() then
    return true
  end
  if CardsMatchingFilter(OppMon(),SpecterGraveyardEffectBattleFilter)>0 then
    if IsBattlePhase() then
    local source = Duel.GetAttacker()
	local target = Duel.GetAttackTarget()
      if source and target then
        if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
        end
        if target:IsControler(player_ai)
		and source:IsPosition(POS_FACEUP)
		and target:IsPosition(POS_FACEUP_ATTACK)
		and WinsBattle(target,source)
		and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
		and not target:IsCode(56832966) then
		  return true
		end
	  end
	end
  end
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and (Duel.GetOperationInfo(i,CATEGORY_TOGRAVE)
    or Duel.GetOperationInfo(i,CATEGORY_DECKDES)) 
	and e:GetHandlerPlayer()==1-player_ai then
     return true
	end
  end
 return false
end

function SpecterBASummonAbyss()
  return EnableBAFunctions()
  and (XYZSummonOkay()
  and (SpecterMP2Check() 
  or CardsMatchingFilter(OppMon(),SpecterBABattleTargets)>0 and GlobalBPAllowed and Duel.GetCurrentPhase() == PHASE_MAIN1)
  and AIGetStrongestAttack() > OppGetStrongestAttDef()
  or MakeRoom())
end

function SpecterBABattleTargets(c)
  return c.id==20758643
  or c.id==57143342
  or c.id==09342162
  or c.id==36553319
  or c.id==84764038
  or c.id==27552504
  or c.id==62957424
  or c.id==00601193
  or c.id==18386170
end

function EnableExodiaLibraryFunctionsFilter(c)
  return c.id==89997728
  or c.id==70791313
  or c.id==33396948
  or c.id==07902349
  or c.id==08124921
  or c.id==44519536
  or c.id==70903634
  or c.id==70368879
  or c.id==79814787
  or c.id==39701395
  or c.id==38120068
end

function EnableExodiaLibraryFunctions()
  return CardsMatchingFilter(UseLists({OppDeck(),OppGrave(),OppHand()}),EnableExodiaLibraryFunctionsFilter)>=15
end

function ChainTempestLibrary()
  if not EnableExodiaLibraryFunctions() then return false end
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==70791313 
	and e:GetHandlerPlayer()==1-player_ai then
	 return true
	end
  end
 return false
end

function ChainSCycloneLibrary()
  if not EnableExodiaLibraryFunctions() then return false end
  if HasID(OppMon(),70791313,true) 
  and UnchainableCheck(49366157) then
    return true
  end
 return false
end

function ChainSTornadoLibrary()
  if not EnableExodiaLibraryFunctions() then return false end
  if HasID(OppMon(),70791313,true) 
  and UnchainableCheck(36183881) then
    return true
  end
 return false
end

function LibraryRemoved()
  return EnableExodiaLibraryFunctions()
  and HasID(UseLists({OppGrave(),OppBanish()}),70791313,true)
  and #OppMon()==0
end

--[[function LossToExodia()
  return EnableExodiaLibraryFunctions()
  and HasID(AIHand(),33396948,true)
  and HasID(AIHand(),07902349,true)
  and HasID(AIHand(),08124921,true)
  and HasID(AIHand(),44519536,true)
  and HasID(AIHand(),70903634,true)
end]]

function NeedsSStormOverSCycloneFilter(c)
  return Targetable(c,TYPE_SPELL)
  and Affected(c,TYPE_SPELL)
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and (c.attack > AIGetStrongestAttack() 
  or FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET))
  and (FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
    or (c.id==23998625
    or c.id==58069384
    or c.id==17016362
    or c.id==03758046
    or c.id==23649496
    or c.id==58712976
    or c.id==96381979
    or c.id==16691074
	or c.id==00007152
	or c.id==23454876
	or c.id==37279508
	or c.id==56638325
	or c.id==71921856
	or c.id==42589641
	or c.id==30100551))
  and not SpecterDestroyFilter(c)
end

function NeedsSStormOverSCyclone()
  return (CardsMatchingFilter(OppMon(),NeedsSStormOverSCycloneFilter)>0
  or CardsMatchingFilter(OppMon(),BypassDestroyFilter)>0
  or (EnableBAFunctions()
  and EnemyHasDante()))
  and HasID(AIDeck(),13972452,true)
end

function BypassDestroyFilter(c) --Indexes cards that the AI fails to check with DestroyFilter normally. Sins, C-Lancer, ArchSeraph, eartH, Kagutsuchi, Sentry, Beetle, Yoke, SHARK, Full Lancer, Maestroke, Zenmaines, Gantetsu, U-Future, Angineer, Winda, Wickedwitch
 if SpecterStardustSparkCheck() then
    return c.id==83994433
	and NotNegated(c)
  end
  return (((c.id==62541668
  or c.id==99469936
  or c.id==67173574
  or c.id==23998625
  or c.id==01855932
  or c.id==49678559
  or c.id==76067258
  or c.id==23232295
  or c.id==48739166
  or c.id==25853045
  or c.id==25341652
  or c.id==78156759
  or c.id==10002346
  or c.id==65305468
  or c.id==15914410)
  and c.xyz_material_count>0)
  or c.id==94977269
  or c.id==93302695)
  and NotNegated(c)
end

function SpecterDestroyFilter(c,nontarget) --Wait, why have I been writing as if someone else is here? And why am I still doing it? Man, I'm stupid. That's why I'm copying more code.
  return not FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
  and not FilterStatus(c,STATUS_LEAVE_CONFIRMED)
  and (nontarget==true or not FilterAffected(c,EFFECT_CANNOT_BE_EFFECT_TARGET))
  and not (DestroyBlacklist(c)
  and FilterPublic(c))
  and not BypassDestroyFilter(c)
end

function UsePeasantPendulum()
  return HasID(AIST(),51531505,true)
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and CardsMatchingFilter(OppST(),OppDownBackrowFilter)>0
  and OPTCheck(14920218)
  and OPTCheck(51531505)
end

function InsightfulPhantomSetup()
  return HasID(AIExtra(),62709239,true)
  and (HasID(AIST(),72714461,true) or HasID(AIHand(),72714461,true))
  and CardsMatchingFilter(OppField(),InsightfulPhantomEnemyFilter)>0
  and CardsMatchingFilter(AIST(),InsightfulPhantomAllyFilter)==1
  and CardsMatchingFilter(AIST(),MagicianPendulumFilter)==1
  and CardsMatchingFilter(AIHand(),MagicianPendulumFilter)>0
  and OPTCheck(53208660)
  and DualityCheck()
  and CardsMatchingFilter(UseLists({AIST(),OppST()}),VanityFilter)==0
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and ((HasID(AIDeck(),14920218,true) and HasID(AIST(),51531505,true))
  or HasID(AIDeck(),51531505,true) and HasID(AIST(),14920218,true))
end

function InsightfulPhantomEnemyFilter(c)
  return SpecterDestroyFilter(c)
end

function InsightfulPhantomAllyFilter(c)
  return IsSetCode(c.setcode,0xd0)
  and FilterLocation(c,LOCATION_SZONE)
end

function InsightfulLevel3Filter(c)
  return c.id==31991800
  or c.id==05506791
end

function InsightfulMajestyFilter(c) --Index non-level 3 monsters to be tributed
  return c.id==14920218
  or c.id==94784213
  or c.id==68395509
  or c.id==00645794
end

function InsightfulPhantomSummon()
  return InsightfulPhantomSetup()
end

function InsightfulRaccoonSummon()
  return CardsMatchingFilter(AIMon(),InsightfulLevel3Filter)==1
  and InsightfulPhantomSetup()
end

function InsightfulCatSummon()
  return CardsMatchingFilter(AIMon(),InsightfulLevel3Filter)==1
  and InsightfulPhantomSetup()
end

function InsightfulFodderSummon()
  return InsightfulPhantomSetup()
  and CardsMatchingFilter(AIMon(),InsightfulLevel3Filter)==1
  and HasID(AIST(),76473843,true)
  and OPTCheck(76473843)
  and (HasID(AIDeck(),31991800,true) or HasID(AIDeck(),05506791,true))
end

function InsightfulMajesty()
  return InsightfulPhantomSetup()
  and ((CardsMatchingFilter(AIMon(),InsightfulLevel3Filter)==1
  and CardsMatchingFilter(AIMon(),InsightfulMajestyFilter)>0)
  or CardsMatchingFilter(AIMon(),InsightfulMajestyFilter)>0
  and CardsMatchingFilter(AIHand(),InsightfulLevel3Filter)>0
  and not NormalSummonCheck(player_ai))
end

function InsightfulPhantomUse()
  return (HasID(AIST(),72714461,true) or HasID(AIHand(),72714461,true))
  and CardsMatchingFilter(OppField(),InsightfulPhantomEnemyFilter)>0
  and CardsMatchingFilter(AIST(),InsightfulPhantomAllyFilter)==1
  and CardsMatchingFilter(AIST(),MagicianPendulumFilter)==1
  and CardsMatchingFilter(AIHand(),MagicianPendulumFilter)>0
  and OPTCheck(53208660)
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and ((HasID(AIDeck(),14920218,true) and HasID(AIST(),51531505,true))
  or HasID(AIDeck(),51531505,true) and HasID(AIST(),14920218,true))
end

function SpecterChainUtopiaLightning()
  if EnableKozmoFunctions() then return false end
	local source = Duel.GetAttacker()
	local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
      and source:IsPosition(POS_FACEUP_ATTACK) 
	  and target:IsPosition(POS_FACEUP_ATTACK) then
	   return true
	  end
	end
  return false
end

function FaceupEnemiesFilter(c)
  return FilterPosition(c,POS_FACEUP)
end

function FaceupEnemies()
  return CardsMatchingFilter(OppMon(),FaceupEnemiesFilter)>0
end

function CrowAttack()
  return AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and (AIGetStrongestAttack() > OppGetStrongestAttDef()
  or OppGetStrongestAttDef() < 1000)
  and (FaceupEnemies() or #OppMon()==0)
end

function MajesterAttack()
  return AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and (AIGetStrongestAttack() > OppGetStrongestAttDef()
  or OppGetStrongestAttDef() < 1850
  or (FaceupEnemies() or #OppMon()==0))
end

function CrowChangeToAttack()
  return AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and ((AIGetStrongestAttack() > OppGetStrongestAttDef() and #OppMon()==1) 
  or OppGetStrongestAttDef() < 1000)
  and (FaceupEnemies() or #OppMon()==0)
end

function CrowChangeToDefence()
  return AI.GetCurrentPhase() == PHASE_MAIN2 
  or not GlobalBPAllowed
end

function MajesterChangeToAttack()
  return AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and ((AIGetStrongestAttack() > OppGetStrongestAttDef() and #OppMon()==1) 
  or OppGetStrongestAttDef() < 1850)
  and (FaceupEnemies() or #OppMon()==0)
end

function MajesterChangeToDefence()
  return AI.GetCurrentPhase() == PHASE_MAIN2
  or not GlobalBPAllowed
end

function CatChangeToDefence()
  return true
end

function HasSTempest()
  return HasID(UseLists({AIHand(),AIST()}),02572890,true)
end

function HasSTornado()
  return HasID(UseLists({AIHand(),AIST()}),36183881,true)
end

function HasSCyclone()
  return HasID(UseLists({AIHand(),AIST()}),49366157,true)
end

function HasSStorm()
  return HasID(UseLists({AIHand(),AIST()}),13972452,true)
end

function HasSCell()
  return HasID(UseLists({AIHand(),AIST()}),78949372,true)
end

function EnableRaidraptorFunctionsFilter(c)
  return IsSetCode(c.setcode,0xb7)
end

function EnableRaidraptorFunctions()
  return CardsMatchingFilter(UseLists({OppDeck(),OppGrave()}),EnableRaidRaptorFunctionsFilter)>=10
  or CardsMatchingFilter(UseLists({OppMon(),OppGrave()}),EnemyUltimateFalconFilter)>0
end

function EnemyUltimateFalconFilter(c)
  return c.id==86221741
  and NotNegated(c)
end

function EnemyUltimateFalconFirstTurn()
  return CardsMatchingFilter(OppMon(),EnemyUltimateFalconFilter)>0
  and Duel.GetTurnCount() == 1
end

function EnemyUltimateFalcon()
  return CardsMatchingFilter(OppMon(),EnemyUltimateFalconFilter)>0
end

function SummonUtopiaLightningFalcon()
  return EnemyUltimateFalcon()
  and AI.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and not EnemyHasStall()
  and not EnemyHasBattleStallLightning()
end

function SummonUtopiaLightningFalconRoom()
  return SummonUtopiaLightningFalcon()
  and MakeRoom()
end

function UsedUtopiaLightningFilter(c)
  return c.id==56832966
  and c.xyz_material_count<2
end

function UsedUtopiaLightning()
  return CardsMatchingFilter(AIMon(),UsedUtopiaLightningFilter)>0
  and IsBattlePhase()
end

function UsedUtopiaLightning2()
  return CardsMatchingFilter(AIMon(),UsedUtopiaLightningFilter)>0
  and Duel.GetCurrentPhase() == PHASE_MAIN2
end

function EnemyGraveFalconRevival()
  return EnableRaidraptorFunctions()
  and HasID(OppGrave(),58988903,true)
  and HasID(OppGrave(),86221741,true)
  and not EnemyUltimateFalcon()
end

function SpecterRaidraptorSummonAbyss()
  return EnemyGraveFalconRevival()
  and FalconDestroyTalk
end

function SpecterRaidraptorSummonHeartland()
  return FalconReviveTalk
  and EnemyUltimateFalcon()
  and Duel.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and HasID(AIExtra(),31437713,true)
end

function HeartlandRaidraptor(c)
  return c.attack>0
  and FilterPosition(c,POS_FACEUP_ATTACK)
end

function SpecterRaidraptorActivateHeartland()
  return OppGetStrongestAttDef() >= AIGetStrongestAttack()
  and FalconReviveTalk
  and EnemyUltimateFalcon()
  and CardsMatchingFilter(AIMon(),HeartlandRaidraptor)>0
  and Duel.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
end

function ChainTempestLastStrix()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==97219708
	and e:GetHandlerPlayer()==1-player_ai then
	 return true
	end
  end
 return false
end

function ChainSCycloneLastStrix()
  return HasID(OppMon(),97219708,true)
  and CardsMatchingFilter(OppMon(),EnemyLastStrixSC)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and UnchainableCheck(49366157)
end

function ChainSTornadoLastStrix()
  return HasID(OppMon(),97219708,true)
  and CardsMatchingFilter(OppMon(),EnemyLastStrixST)>0
  and Duel.GetTurnPlayer()==1-player_ai
  and UnchainableCheck(36183881)
end
  
function EnemyLastStrixSC(c)
  return SpecterCycloneFilter(c)
  and c.id==97219708
end
  
function EnemyLastStrixST(c)
  return SpecterTornadoFilter(c)
  and c.id==97219708
end

function EnableBAFunctionsFilter(c)
  return IsSetCode(c.setcode,0xb1)
end

function EnableBAFunctions()
  return CardsMatchingFilter(UseLists({OppMon(),OppDeck(),OppGrave(),OppBanish()}),EnableBAFunctionsFilter)>=10
end

function EnableHieraticFunctionsFilter(c)
  return IsSetCode(c.setcode,0x69)
end

function EnableHieraticFunctions()
  return CardsMatchingFilter(UseLists({OppMon(),OppDeck(),OppGrave(),OppBanish()}),EnableHieraticFunctionsFilter)>=10
end

function EnemyBATempest(c)
  return (c.id==83531441 or c.id==10802915)
  and FilterStatus(c,STATUS_SUMMONING)
end

function EnemyDante(c)
  return c.id==83531441
  and c.xyz_material_count>0
end

function EnemyASF(c)
  return c.id==58921041
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasASF()
  return CardsMatchingFilter(OppST(),EnemyASF)>0
end

function EnemyHasDante()
  return CardsMatchingFilter(OppMon(),EnemyDante)>0
end

function ChainSTempestBA()
  if not EnableBAFunctions() then return false end
  if HasIDNotNegated(AIST(),36183881,true) then return false end
  if HasIDNotNegated(AIST(),49366157,true) then return false end
  if CardsMatchingFilter(OppMon(),EnemyBATempest)>0 then
    return true
  end
 return false
end

function ChainSTornadoDante()
  if not EnableBAFunctions() then return false end
  if HasSStorm() and not EnemyHasASF() and Duel.GetTurnPlayer()==player_ai then return false end
  if not HasIDNotNegated(AIST(),36183881,true) then return false end
  if EnemyHasDante() and Duel.GetTurnPlayer()==1-player_ai then
    return true
  end
  if EnemyHasDante() and not SpecterBACanGetAbyss() and Duel.GetTurnPlayer()==player_ai and MajestyCheck() then
    return true
  end
 return false
end

function ChainSCycloneDante()
  if not EnableBAFunctions() then return false end
  if ChainSTornadoDante() then return false end
  if HasSStorm() and not EnemyHasASF() and Duel.GetTurnPlayer()==player_ai then return false end
  if EnemyHasDante() and Duel.GetTurnPlayer()==1-player_ai then
    return true
  end
  if EnemyHasDante() and not SpecterBACanGetAbyss() and Duel.GetTurnPlayer()==player_ai and MajestyCheck() then
    return true
  end
 return false
end

function UseSStormDante()
  if not EnableBAFunctions() then return false end
  if EnemyHasDante() and not SpecterBACanGetAbyss() then
    return true
  end
 return false
end

function SpecterCanXYZLevel4()
  return (CardsMatchingFilter(AIMon(),LevelFourFieldCheck)>1
  or (CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==1
  and (HasIDNotNegated(AIST(),76473843,true) or (HasID(AIHand(),76473843,true) and not FieldSpellNotActivatable()))
  or (CardsMatchingFilter(AIHand(),LevelFourFieldCheck)>0 and not NormalSummonCheck(player_ai)))
  or (HasScales() and CardsMatchingFilter(UseLists({AIMon(),AIExtra(),AIHand()}),LevelFourFieldCheck)>1)
  or (HasID(AIHand(),31991800,true) and HasScales() and not NormalSummonCheck(player_ai) and OPTCheck(31991800)))
end

function SpecterBACanGetAbyss()
  return SpecterCanXYZLevel4()
  and HasID(AIExtra(),21044178,true)
  and (XYZSummonOkay() or MakeRoom())
  and EnableBAFunctions()
  and DualityCheck()
end

function SpecterBASummonAbyss2()
  return SpecterBACanGetAbyss()
end

function SpecterBAAbyssKill()
  return SpecterBACanGetAbyss()
  and (UsableSCyclone() or UsableSStorm())
  and HasScales()
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
end

function SpecterBASummonAbyssRoom()
  return MakeRoom()
  and SpecterBACanGetAbyss()
end

function SpecterCodedTargets(c) --List of cards that shouldn't be removed by S/T effects.
  if EnableBAFunctions() and HasID(OppMon(),83531441,true) then
    return c.id==83531441
  end
  if EnableShadollFunctions() then
    if WindaLives() then
      return c.id==94977269
	end
  end
  if EnemyNodenTrace() then
    return c.id==17412721
  end
  if SpecterOmegaCheck() then
    return c.id==74586817
  end
  if SpecterConomegaCheck() then
    return c.id==26329679
  end
end

function SpecterCodedTargets2(c) --List of cards that shouldn't be removed by monster effects.
  if SpecterOmegaCheck() then
    return c.id==74586817
  end
  if SpecterClearWingCheck() then
    return c.level>4
  end
  if SpecterCrystalWingCheck() then
    return true
  end
  if SpecterShekhinagaCheck() then
    return c.id==74822425
  end
end

function EnemyNodenTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==17412721
	and e:GetHandlerPlayer()==1-player_ai then
	 return true
	end
  end
 return false
end

function WindaLives()
  return (Duel.GetCurrentPhase() ~= PHASE_BATTLE
  or RemovalCheck(36183881))
  and Duel.GetTurnPlayer()==1-player_ai
  and HasID(OppMon(),94977269,true)
end

function SpecterOmegaCheck()
  return (Duel.GetCurrentPhase() == PHASE_MAIN1
  or Duel.GetCurrentPhase() == PHASE_MAIN2)
  and HasID(OppMon(),74586817,true)
  and #AIHand()>0
end

function SpecterClearWingCheck()
  return OPTCheck(82044279)
  and HasID(OppMon(),82044279,true)
end

function SpecterClearWingTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==82044279
	and e:GetHandlerPlayer()==1-player_ai then
	 OPTSet(82044279)
	 return true
	end
  end
 return false
end

function SpecterCrystalWingCheck()
  return OPTCheck(50954680)
  and HasID(OppMon(),50954680,true)
end

function SpecterCrystalWingTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==50954680
	and e:GetHandlerPlayer()==1-player_ai then
	 OPTSet(50954680)
	 return true
	end
  end
 return false
end

function SpecterShekhinagaCheck()
  return OPTCheck(74822425)
  and HasID(OppMon(),74822425,true)
  and #OppHand()>0
end

function SpecterShekhinagaTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==74822425
	and e:GetHandlerPlayer()==1-player_ai then
	 OPTSet(74822425)
	 return true
	end
  end
 return false
end

function SpecterConomegaCheck()
  return OPTCheck(26329679)
  and CardsMatchingFilter(OppMon(),EnemyHasConomegaFilter)>0
end

function EnemyHasConomegaFilter(c)
  return c.id==26329679
  and c.xyz_material_count>0
end

function SpecterConomegaTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==26329679
	and e:GetHandlerPlayer()==1-player_ai then
	 OPTSet(26329679)
	 return true
	end
  end
 return false
end

function SpecterBACanGetChidori()
  return SpecterCanXYZLevel4()
  and HasID(AIExtra(),22653490,true)
  and EnableBAFunctions()
  and (XYZSummonOkayWind() or MakeRoom())
  and DualityCheck()
  and OppDownBackrow()
  and EnemyHasDante()
  and not SpecterBAAbyssKill()
end

function SpecterBASummonChidori()
  return SpecterBACanGetChidori()
end

function SpecterBACanGetCastel()
  return SpecterCanXYZLevel4()
  and HasID(AIExtra(),82633039,true)
  and EnableBAFunctions()
  and (XYZSummonOkay() or MakeRoom())
  and DualityCheck()
  and EnemyHasDante()
  and not SpecterBAAbyssKill()
end

function SpecterBASummonCastel()
  return SpecterBACanGetCastel()
end

function SpecterBASummonCastelRoom()
  return MakeRoom()
  and SpecterBACanGetCastel()
end

function SummonForUsableSpellBackrow()
  return CardsMatchingFilter(AIMon(),SpecterMonsterFilter)==0
  and (CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableSCycloneFilter)>0
  or HasID(UseLists({AIHand(),AIST()}),13972452,true))
end

function SummonForUsableBackrow()
  return CardsMatchingFilter(AIMon(),SpecterMonsterFilter)==0
  and (CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableSCycloneFilter)>0
  or CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableSTornadoFilter)>0
  or HasID(UseLists({AIHand(),AIST()}),13972452,true)
  or (CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableSTempestFilter)>0
  and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),SpecterMonsterFilter)>1))
end

function UsableBackrow()
  return UsableSStorm()
  or UsableSCyclone()
  or UsableSTornado()
end

function UsableFreelyBackrowFilter(c)
  return UsableSCycloneFilter(c)
  or UsableSTornadoFilter(c)
end

function UsableSpellBackrow()
  return UsableSStorm()
  or UsableSCyclone()
end

function UsableSCycloneFilter(c)
  return (FilterLocation(c,LOCATION_HAND)
  or FilterLocation(c,LOCATION_SZONE)
  and not FilterStatus(c,STATUS_SET_TURN))
  and c.id==49366157
end

function UsableSCyclone()
  return CardsMatchingFilter(UseLists({AIHand(),AIST()}),UsableSCycloneFilter)>0
  and (CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0
  or MajestyTrace())
end

function UsableSStorm()
  return HasID(UseLists({AIHand(),AIST()}),13972452,true)
  and (CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0
  or MajestyTrace())
  and Duel.GetTurnPlayer()==player_ai
end

function UsableSTornadoFilter(c)
  return c.id==36183881
  and FilterLocation(c,LOCATION_SZONE)
  and not FilterStatus(c,STATUS_SET_TURN)
end

function UsableSTornado()
  return CardsMatchingFilter(AIST(),UsableSTornadoFilter)>0
  and (CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0
  or MajestyTrace())
end

function UsableSTempestFilter(c)
  return c.id==02572890
  and FilterLocation(c,LOCATION_SZONE)
  and not FilterStatus(c,STATUS_SET_TURN)
end

function UsableSTempest()
  return CardsMatchingFilter(AIST(),UsableSTempestFilter)>0
  and (CardsMatchingFilter(AIMon(),SpecterMonsterFilter)>0
  or MajestyTrace())
end

function SpecterDestroyCheckOpp(id,category) --Currently don't know how to make this check for public cards.
  if Duel.GetCurrentChain() == 0 then return false end
  local cat={CATEGORY_DESTROY,CATEGORY_TOGRAVE}
  if category then cat={category} end
  for i=1,#cat do
    for j=1,Duel.GetCurrentChain() do
      local ex,cg = Duel.GetOperationInfo(j,cat[i])
      if ex and CheckNegated(j) then
        if id==nil then 
          return cg
        end
        if cg and id~=nil and cg:IsExists(function(c) return c:IsControler(1-player_ai) and c:IsCode(id) end, 1, nil) then
          return true
        end
      end
    end
  end
  return false
end

function SpecterRemovalCheckOpp(id,category)
  if Duel.GetCurrentChain() == 0 then return false end
  local cat={CATEGORY_DESTROY,CATEGORY_REMOVE,CATEGORY_TOGRAVE,CATEGORY_TOHAND,CATEGORY_TODECK}
  if category then cat={category} end
  for i=1,#cat do
    for j=1,Duel.GetCurrentChain() do
      local ex,cg = Duel.GetOperationInfo(j,cat[i])
      if ex and CheckNegated(j) then
        if id==nil then 
          return cg
        end
        if cg and id~=nil and cg:IsExists(function(c) return c:IsControler(1-player_ai) and c:IsCode(id) end, 1, nil) then
          return true
        end
      end
    end
  end
  return false
end

function SpecterArtifactDestroyCheckOpp(id,category)
  if Duel.GetCurrentChain() == 0 then return false end
  if not EnableArtifactFunctions() then return false end
  local cat={CATEGORY_DESTROY}
  if category then cat={category} end
  for i=1,#cat do
    for j=1,Duel.GetCurrentChain() do
      local ex,cg = Duel.GetOperationInfo(j,cat[i])
      if ex and CheckNegated(j) then
        if id==nil then 
          return cg
        end
        if cg and id~=nil and cg:IsExists(function(c) return c:IsControler(1-player_ai) and c:IsType(TYPE_SPELL+TYPE_TRAP) 
		and c:IsPosition(POS_FACEDOWN) end, 1, nil) then
          return true
        end
      end
    end
  end
  return false
end

function SpecterRhapsodyATKCheck()
  local cards=AIMon()
  if not HasID(UseLists({AIMon(),AIExtra()}),56832966,true) 
  and not HasID(AIExtra(),56832966,true) then
    for i=1,#cards do
      if bit32.band(cards[i].type,TYPE_XYZ)>0 and cards[i].attack+1200 > OppGetStrongestAttack() then
	    return true
	  end
	end
  end
 return false
end

function SpecterRhapsodyMP1Filter(c)
  if SpecterStarAssaultModeCheck() then
    return c.id==61257789
  end
  if RhapsodyGospelMP1() then
    return c.id==06853254
  end
  if RhapsodyRRReturnMP1() then
    return c.id==30500113
  end
  if RhapsodyTasukeMP1() then
    return c.id==86039057
  end
  if RhapsodyIAvenger() then
    return c.id==85475641
  end
  if RhapsodyDirectProtectors() then
    return c.id==80208158
    or c.id==34620088
    or c.id==02830693
    or c.id==24212820
    or c.id==77462146
	or c.id==01833916
	or c.id==96427353
	or c.id==46613515
  end
  return c.id==34710660
  or c.id==04906301
  or c.id==93830681
  or c.id==27978707
  or c.id==27660735
  or c.id==62017867
  or c.id==82593786
  or c.id==50185950
  or c.id==69764158
end

function SpecterRhapsodyMP2Filter(c) --Come back to this later for Bujingi Hare conditions
  if SpecterStardustCheck() then
    return c.id==44508094
  end
  if SpecterStarAssaultModeCheck() then
    return c.id==61257789
  end
  if RhapsodyBreakthroughPriority() then
    return c.id==78474168
  end
  if RhapsodyMalicious() then
    return c.id==09411399
  end
  if RhapsodyCyclone() then
    return c.id==05133471
  end
  if RhapsodyRedice() then
    return c.id==85704698
  end
  if RhapsodySSScout() then
    return c.id==90727556
  end
  if RhapsodyTasukeMP2() then
    return c.id==86039057
  end
  if RhapsodyTombShield() then
    return c.id==51606429
  end
  return c.id==92826944
  or c.id==29904964
  or c.id==17502671
  or c.id==04081665
  or c.id==00128454
  or c.id==94919024
  or c.id==05818294
  or c.id==88940154
  or c.id==13521194
  or c.id==69723159
  or c.id==88728507
  or c.id==56574543
  or c.id==68819554
  or c.id==99315585
  or c.id==49919798
  or c.id==19310321
  or c.id==42551040
  or c.id==45705025
  or c.id==36704180
  or c.id==54320860
  or c.id==52158283
  or c.id==96427353
  or c.id==70124586
  or c.id==23857661
  or c.id==21767650
  or c.id==34710660
  or c.id==33145233
  or c.id==67489919
  or c.id==03580032
  or c.id==08903700
  or c.id==37984162
  or c.id==48427163
  or c.id==59640711
  or c.id==63821877
  or c.id==90432163
  or c.id==15981690
  or c.id==36426778
  or c.id==59463312
  or c.id==72291078
  or c.id==23893227
  or c.id==36736723
  or c.id==45206713
  or c.id==71039903
  or c.id==33245030
  or c.id==18988391
  or c.id==72413000
  or c.id==23740893
  or c.id==79234734
  or c.id==06853254
  or c.id==14816688
  or c.id==22842126
  or c.id==41201386
  or c.id==44771289
  or c.id==74335036
  or c.id==81994591
  or c.id==88204302
  or c.id==99330325
  or c.id==18803791
  or c.id==30392583
  or c.id==34834619
  or c.id==47435107
  or c.id==62835876
  or c.id==08437145
  or c.id==46008667
  or c.id==15155568
  or c.id==19254117
  or c.id==21648584
  or c.id==30500113
  or c.id==63227401
  or c.id==73694478
  or c.id==67381587
  or c.id==78474168
  or c.id==70043345
  or c.id==61257789
  or c.id==92418590
  or c.id==11366199
  or c.id==77121851
  or c.id==56174248
  or c.id==24861088
  or c.id==92572371
  or c.id==32623004
  or c.id==23571046
  or c.id==33420078
  or c.id==01357146
  or c.id==09742784
  or c.id==11747708
  or c.id==66853752
  or c.id==92901944
  or c.id==85475641
  or c.id==00286392
  or c.id==80208158
  or c.id==34620088
  or c.id==02830693
  or c.id==24212820
  or c.id==77462146
  or c.id==69764158
  or c.id==01833916
  or c.id==36630403
  or c.id==94919024
  or c.id==82744076
  or c.id==46613515
  or c.id==26268488
  or c.id==56532353
  or c.id==48444114
  or c.id==09659580
  or c.id==07922915
  or c.id==57354389
end

function SpecterAllTrapFilter(c)
  return FilterType(c,TYPE_TRAP)
end

function SpecterUsableAbyss(c)
  return c.id==21044178
  and c.xyz_material_count>0
end

function RhapsodyBreakthroughPriority()
  return CardsMatchingFilter(AIMon(),SpecterUsableAbyss)>0
  and HasID(OppGrave(),78474168,true)
  and (EnableShadollFunctions()
  or EnableBAFunctions())
end

function RhapsodyTombShield()
  return HasID(OppGrave(),51606429,true)
  and CardsMatchingFilter(UseLists({AIST(),AIHand()}),SpecterAllTrapFilter)>0
end

function RhapsodyMalicious()
  return HasID(OppGrave(),09411399,true)
  and HasID(OppDeck(),09411399,true)
end

function RhapsodyCyclone()
  return (OPTCheck(53208660)
  or CardsMatchingFilter(AIST(),MagicianPendulumFilter)<2
  or HasIDNotNegated(AIST(),76473843,true)
  or HasIDNotNegated(AIST(),78949372,true))
  and HasID(OppGrave(),05133471,true)
end

function RhapsodyGospelMP1()
  return CardsMatchingFilter(OppMon(),FilterRace,RACE_DRAGON)>0
  and HasID(OppGrave(),06853254,true)
end

function RhapsodyRRReturnMP1()
  return CardsMatchingFilter(OppMon(),EnableRaidRaptorFunctionsFilter)>0
  and HasID(OppGrave(),30500113,true)
end

function RhapsodyRedice()
  return CardsMatchingFilter(OppMon(),SpecterSpeedroidTuners)==0
  and HasID(OppGrave(),85704698,true)
end

function SpecterSpeedroidTuners(c)
  return FilterType(c,TYPE_TUNER)
  and IsSetCode(c.setcode,0x2016)
end

function RhapsodyTasukeMP1()
  return #OppHand()==0
  and HasID(OppGrave(),86039057,true)
  and not TasukeOpponentActivated
end

function RhapsodyTasukeMP2()
  return HasID(OppGrave(),86039057,true)
  and not TasukeOpponentActivated
end

function TasukeOpponentCheck()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==86039057
	and e:GetHandlerPlayer()==1-player_ai 
	and CardsMatchingFilter(AIST(),VanityFilter)==0 then
	 return true
	end
  end
 return false
end

function RhapsodySSScout()
  return #OppST()==0
  and HasID(OppGrave(),90727556,true)
end

function RhapsodyIAvenger()
  return #OppHand()==0
  and HasID(OppGrave(),85475641,true)
  and #OppMon()>0
end

function RhapsodyAquaFilter(c)
  return IsSetCode(c.setcode,0x2b)
end

function RhapsodyAqua()
  return CardsMatchingFilter(OppGrave(),RhapsodyAquaFilter)>1
end

function RhapsodyDirectProtectors() --Imperfection, still needs to check if it would destroy monsters and then get direct attacks
  return #OppMon()==0
  and (HasID(OppGrave(),80208158,true)
  or HasID(OppGrave(),34620088,true)
  or HasID(OppGrave(),02830693,true)
  or HasID(OppGrave(),24212820,true)
  or HasID(OppGrave(),77462146,true)
  or HasID(OppGrave(),01833916,true)
  or (HasID(OppGrave(),96427353,true)
  and RhapsodyAqua())
  or HasID(OppGrave(),46613515,true))
end
  
--Is Kaeynn the Master Blacksmith really worth it? No, no it isn't.
--An exception for Soulbang Cannon will need to be added later.
--Interceptomato is not worth it.
--Is Overlay Eater really worth it?
--Is Spell Recycler really worth it?
--May add Void Seer to MP1 list later, under specific conditions.
--May add Destruction Sword Flash to MP1 list later, under specific conditions.
--Dice-Roll Battle would be a good target if this deck actually used synchros.
--Damage Diet would be a target if this deck actually inflicted effect damage.
--I think The Phantom Wing, The Phantom Fog Blade, and The Phantom Sword would just chain?
--Blaze Accelerator Reload would undoubtedly chain.
--Is D/D Rebuild really worth it?
--PSY-Frame Overload would just chain.
--Is Vampire Grace really worth it?
--Is InterplanetaryPurlyThornywhothehellcares Beast really worth it?
--Revival Rose is not worth it.
--Worm Yagan is not worth it.
--They can't conduct their battle phase against a Majespecter deck if they use Gogogo Gigas.
--Might need an exception for NoPenguin in MP1? Not like anyone actually knows how Penguin decks work.
--I guess Majosheldon could be an unknown Monarch card? Still not worth it.
--Naturia Pineapple is not worth it.
--Maybe Scrap Searcher should be hit during MP1, but I'll leave it as a MP2 monster for now.
--Naturia Ladybug is not worth it.
--Stardust Xiaolong is not worth it.
--Samsara Lotus MIGHT be worth it, but I'm not including it for now.
--Will add Stardust Dragon later.

--Look buddy, Rhapsody is at least 170 lines of code. If you think I'm about to sit here and label every single ID that I actually did use,
--then you're crazy. If you wish to seek them out easily, I searched "banish this card from your graveyard" first.
--After that, I searched "Special Summon this card from your graveyard."
--Stuff beyond that I thought of later.

function SpecterSummonRhapsodyMP1()
  return XYZSummonOkay()
  and Duel.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed
  and CardsMatchingFilter(OppGrave(),SpecterRhapsodyMP1Filter)>0
  and SpecterRhapsodyATKCheck()
  and not SpecterSummonUtopiaLightning()
end

function SpecterSummonRhapsodyRoom()
  return MakeRoom()
  and Duel.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed
  and CardsMatchingFilter(OppGrave(),SpecterRhapsodyMP1Filter)>0
  and SpecterRhapsodyATKCheck()
  and not SpecterSummonUtopiaLightning()
end

function SpecterSummonRhapsodyMP2()
  local cards=AIMon()
  if XYZSummonOkay()
  and SpecterMP2Check()
  and CardsMatchingFilter(OppGrave(),SpecterRhapsodyMP2Filter)>0 then
    for i=1,#cards do
	  if bit32.band(cards[i].type,TYPE_XYZ)>0 then
	    return true
	  end
	end
  end
 return false
end

function SpecterUseRhapsody()
  return true
end

function SpecterMiscAbyssMP1Filter(c)
  if RhapsodyTasukeMP1() then
    return c.id==86039057
  end
  if RhapsodyIAvenger() then
    return c.id==85475641
  end
  if RhapsodyDirectProtectors() then
    return c.id==80208158
    or c.id==34620088
    or c.id==02830693
    or c.id==24212820
    or c.id==77462146
	or c.id==01833916
	or c.id==96427353
	or c.id==46613515
  end
  return c.id==34710660
  or c.id==04906301
  or c.id==93830681
  or c.id==27978707
  or c.id==27660735
  or c.id==62017867
  or c.id==82593786
  or c.id==69764158
end

function SpecterMiscAbyssMP2Filter(c)
  if RhapsodyMalicious() then
    return c.id==09411399
  end
  if RhapsodyCyclone() then
    return c.id==05133471
  end
  if RhapsodyRedice() then
    return c.id==85704698
  end
  if RhapsodySSScout() then
    return c.id==90727556
  end
  if RhapsodyTombShield() then
    return c.id==51606429
  end
  if AbyssCatastrophe() then
    return c.id==67381587
  end
  return c.id==92826944
  or c.id==17502671
  or c.id==04081665
  or c.id==00128454
  or c.id==94919024
  or c.id==05818294
  or c.id==88940154
  or c.id==13521194
  or c.id==69723159
  or c.id==88728507
  or c.id==56574543
  or c.id==68819554
  or c.id==99315585
  or c.id==49919798
  or c.id==19310321
  or c.id==42551040
  or c.id==45705025
  or c.id==36704180
  or c.id==54320860
  or c.id==52158283
  or c.id==70124586
  or c.id==23857661
  or c.id==21767650
  or c.id==67489919
  or c.id==37984162
  or c.id==48427163
  or c.id==59640711
  or c.id==63821877
  or c.id==90432163
  or c.id==15981690
  or c.id==36426778
  or c.id==59463312
  or c.id==72291078
  or c.id==23893227
  or c.id==36736723
  or c.id==45206713
  or c.id==71039903
  or c.id==18988391
  or c.id==72413000
  or c.id==23740893
  or c.id==79234734
  or c.id==14816688
  or c.id==22842126
  or c.id==41201386
  or c.id==44771289
  or c.id==74335036
  or c.id==81994591
  or c.id==88204302
  or c.id==99330325
  or c.id==18803791
  or c.id==30392583
  or c.id==34834619
  or c.id==47435107
  or c.id==62835876
  or c.id==08437145
  or c.id==46008667
  or c.id==15155568
  or c.id==19254117
  or c.id==30500113
  or c.id==73694478
  or c.id==92418590
  or c.id==11366199
  or c.id==24861088
  or c.id==92572371
  or c.id==32623004
  or c.id==23571046
  or c.id==33420078
  or c.id==01357146
  or c.id==09742784
  or c.id==11747708
  or c.id==66853752
  or c.id==92901944
  or c.id==00286392
  or c.id==36630403
  or c.id==94919024
  or c.id==56532353
  or c.id==26268488
  or c.id==48444114
  or c.id==09659580
  or c.id==57354389
end

function SpecterStarAssaultModeTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==61257789
	and e:GetHandlerPlayer()==1-player_ai then
	OPTSet(61257789)
	 return true
	end
  end
 return false
end

function SpecterStarAssaultModeCheck()
  return not OPTCheck(61257789)
  and HasID(OppGrave(),61257789,true)
end

function SpecterStardustTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==44508094
	and e:GetHandlerPlayer()==1-player_ai then
	OPTSet(44508094)
	 return true
	end
  end
 return false
end

function SpecterStardustCheck()
  return not OPTCheck(44508094)
  and HasID(OppGrave(),44508094,true)
end

function SpecterStardustSummonAbyss()
  if SpecterStardustCheck() and XYZSummonOkay() and HasID(AIExtra(),21044178,true) and not UsableSTempest() then
	if ((Duel.GetCurrentPhase() == PHASE_MAIN1 and not GlobalBPAllowed) or Duel.GetCurrentPhase() == PHASE_MAIN2)
	and (AIGetStrongestAttack() > OppGetStrongestAttack() or OppGetStrongestAttack() <= 1700) then
	 return true
	end
  end
  if SpecterStarAssaultModeCheck() and not UsableSTempest() then
    return true
  end
 return false
end

function RhapsodyNotNeeded()
  if not OPTCheck(21044178) then return true end
  if HasID(AIExtra(),21044178,true) then return true end
  if UsableSTempest() then return true end
 return false
end

function SpecterStardustSummonRhapsody()
  if RhapsodyNotNeeded() then return false end
  if SpecterStardustCheck() 
  and XYZSummonOkay()
  and ((Duel.GetCurrentPhase() == PHASE_MAIN1 and not GlobalBPAllowed) or Duel.GetCurrentPhase() == PHASE_MAIN2) 
  and AIGetStrongestAttack() > OppGetStrongestAttack() then
   return true
  end
  if SpecterStarAssaultModeCheck() then 
   return true 
  end
 return false
end

function SpecterCatastropheFilter(c)
  return IsSetCode(c.setcode,0xcc)
  and FilterPosition(c,POS_FACEUP)
end

function AbyssCatastrophe()
  return HasID(OppGrave(),67381587,true)
  and (CardsMatchingFilter(OppMon(),SpecterCatastropheFilter)==0
  or Duel.GetTurnPlayer()==1-player_ai)
end

function SpecterMiscSummonAbyssMP1()
  return (AIGetStrongestAttack() > OppGetStrongestAttDef() or OppGetStrongestAttDef() < 1700)
  and CardsMatchingFilter(OppGrave(),SpecterMiscAbyssMP1Filter)>0
  and XYZSummonOkay()
  and Duel.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed
end

function SpecterMiscSummonAbyssMP1Room()
  return MakeRoom()
  and Duel.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed
  and CardsMatchingFilter(OppGrave(),SpecterMiscAbyssMP1Filter)>0
end

function SpecterMiscSummonAbyssMP2()
  return (AIGetStrongestAttack() > OppGetStrongestAttack() or OppGetStrongestAttack() < 1700)
  and CardsMatchingFilter(OppGrave(),SpecterMiscAbyssMP2Filter)>0
  and XYZSummonOkay()
  and Duel.GetCurrentPhase() == PHASE_MAIN2
end

function SpecterMiscSummonAbyssMP2Room()
  return MakeRoom()
  and Duel.GetCurrentPhase() == PHASE_MAIN2
  and CardsMatchingFilter(OppGrave(),SpecterMiscAbyssMP2Filter)>0
end

function EnemyHasStallFilter(c)
  if EnemyHasTraffic() then
    return c.id==46083380 and FilterPosition(c,POS_FACEUP)
	and NotNegated(c)
  end
  if EnemyHasDoor() then
    return c.id==30606547 and FilterPosition(c,POS_FACEUP)
	and NotNegated(c)
  end
  if EnemyHasMessenger() then
    return c.id==44656491 and FilterPosition(c,POS_FACEUP)
	and NotNegated(c)
  end
  if EnemyHasInsectBarrier() then
    return c.id==23615409 and FilterPosition(c,POS_FACEUP)
	and NotNegated(c)
  end
  if EnemyHasKaiser() then
    return c.id==35059553 and FilterPosition(c,POS_FACEUP)
	and NotNegated(c)
  end
  if EnemyHasGravityBind() then
    return (c.id==85742772 or c.id==03136426) and FilterPosition(c,POS_FACEUP)
	and NotNegated(c)
  end
  if EnemyHasLswornBarrier() then
    return c.id==22201234 and FilterPosition(c,POS_FACEUP)
	and NotNegated(c)
  end
  return (c.id==72302403
  or c.id==58775978
  or c.id==18634367
  or c.id==93087299
  or c.id==17078030
  or c.id==00296499)
  and FilterPosition(c,POS_FACEUP)
  and NotNegated(c)
end

function EnemyHasStall()
  return CardsMatchingFilter(OppST(),EnemyHasStallFilter)>0
  and AIGetStrongestAttack() > OppGetStrongestAttDef()
  and #AIMon()>2
  and CardsMatchingFilter(AIMon(),MajespecterAttack)>2
end

function MajespecterAttack(c)
  return FilterPosition(c,POS_FACEUP_ATTACK)
end

function SpecterLightswornFilter(c)
  return IsSetCode(c.setcode,0x38)
end

function EnemyHasLswornBarrier()
  return HasID(OppST(),22201234,true)
  and CardsMatchingFilter(OppMon(),SpecterLightswornFilter)>0
end

function EnemyHasTraffic()
  return HasID(OppST(),46083380,true)
  and #AIMon()>2
end

function EnemyHasDoor()
  return HasID(OppST(),30606547,true)
  and #AIMon()>3
end

function EnemyHasMessenger()
  return HasID(OppST(),44656491,true)
  and AIGetStrongestAttack() > 1500
end

function EnemyHasInsectBarrier()
  return HasID(OppST(),23615409,true)
  and CardsMatchingFilter(AIMon(),SpecterConvertedInsects)>1
end

function SpecterConvertedInsects(c)
  return FilterRace(c,RACE_INSECT)
end

function EnemyHasKaiser()
  return HasID(OppST(),35059553,true)
  and #OppMon()>0
  and #OppMon()<5
end

function SpecterGravityFilter(c)
  return c.level>3
  and not FilterType(c,TYPE_XYZ)
end

function EnemyHasGravityBind()
  return (HasID(OppST(),85742772,true) or HasID(OppST(),03136426,true))
  and CardsMatchingFilter(AIMon(),SpecterGravityFilter)>1
end

--function EnemyHasMonsterStall()

--[[function EnemyHasHeliosphere() --Implement monster stall
  return #AIHand()<=4
  and #OppMon()==1
  and HasID(OppMon(),51043053,true)
end]]

function UseDragonpitStall()
  return EnemyHasStall()
  and OPTCheck(51531505)
  and (not RaccoonHandCheck() or #AIMon()==5)
end

function UseDragonpitDestiny()
  return EnemyHasDestinyBoard()
  and OPTCheck(51531505)
  and not RaccoonHandCheck()
end

function EnemyHasDestinyBoardFilter(c) -- F I N A L
  return (c.id==94212438
  or c.id==31893528
  or c.id==67287533
  or c.id==94772232
  or c.id==30170981)
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasDestinyBoard()
  return CardsMatchingFilter(OppST(),EnemyHasDestinyBoardFilter)>1
end

function EnemyGrystaFilter(c)
  return c.id==48424886
  and NotNegated(c)
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHeraldFilter(c)
  return c.id==48546368
  and NotNegated(c)
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasGrysta()
  return CardsMatchingFilter(OppMon(),EnemyGrystaFilter)>0
  and #OppHand()>0
end

function EnemyHasHerald()
  return CardsMatchingFilter(OppMon(),EnemyHeraldFilter)>0
  and #OppHand()>0
end

function EnemySummonNegatorMonFilter(c)
  if EnemyHasGrysta() then
    return EnemyGrystaFilter(c)
  end
  if EnemyHasHerald() then
    return EnemyHeraldFilter(c)
  end
  return (c.id==14309486
  or (c.id==74294676 and c.xyz_material_count>=2)
  or c.id==74892653)
  and FilterPosition(c,POS_FACEUP)
  and NotNegated(c)
end

function EnemyHasSummonNegatorMon()
  return CardsMatchingFilter(OppMon(),EnemySummonNegatorMonFilter)>0
end

function MajestyCrow()
  if OPTCheck(31991800) and HasID(AIDeck(),31991800,true) and not NormalSummonCheck(player_ai) then return false end
  if EnableShadollFunctions()
  and HasID(AIDeck(),68395509,true)
  and HasID(AIDeck(),13972452,true) 
  and not WindaCheck() then
   return true
  end
  if EnemyHasSummonNegatorMon()
  and HasID(AIDeck(),68395509,true)
  and OPTCheck(68395509)
  and not UsableBackrow()
  and not UsableSTempest()
  and (HasID(AIDeck(),13972452,true)
  or HasID(AIDeck(),49366157,true)) then
   return true
  end
  if EnemyHasTimeRafflesia()
  and not UsableSpellBackrow()
  and HasID(AIDeck(),68395509,true)
  and OPTCheck(68395509)
  and CardsMatchingFilter(AIDeck(),SpecterSpellFilter)>0 then
    return true
  end
 return false
end

function RaccoonAddCrow()
  return (NeedsSStormOverSCyclone() or (EnemyHasSummonNegatorMon() and not UsableSTempest()))
  and not NormalSummonCheck(player_ai)
  and HasID(AIDeck(),68395509,true)
  and (HasID(AIDeck(),13972452,true) or HasID(AIDeck(),49366157,true))
  and OPTCheck(68395509)
  and not HasID(AIHand(),68395509,true)
  and ((HasScales() and not HasID(AIExtra(),68395509,true)) or not HasScales()
  or not WindaCheck())
end

function MajesterAddInsight()
  return (CardsMatchingFilter(AIST(),MagicianPendulumFilter)==1
  or (CardsMatchingFilter(AIST(),AllPendulumFilter)==0 
  and CardsMatchingFilter(AIHand(),MagicianPendulumFilter)>0))
  and NoScales()
  and HasID(AIDeck(),72714461,true)
end

function MajesterAddPeasant()
  return HasID(AIST(),51531505,true)
  and (HasID(AIGrave(),51531505,true) or HasID(AIGrave(),72714461,true))
end

--[[function EnableMaleficFunctionsFilter(c)
  return IsSetCode(c.setcode,0x23)
end

function EnableMaleficFunctions()
  return CardsMatchingFilter(OppMon(),EnableMaleficFunctionsFilter)>0
end

function SpecterFZoneFilter(c)
  return FilterType(c,TYPE_FIELD)
end

function SpecterFZoneDownFilter(c) --What moron plays Malefics and then puts their field spell facedown? Can't hurt to be thorough.
  return FilterType(c,TYPE_FIELD)
  and FilterPosition(c,POS_FACEDOWN)
end]]

function SetMajesty() --Shouldn't I be coding something more important, like destroying Skill Drain or ASF?
  if EnemyHasASF()
  and (Duel.GetCurrentPhase() == PHASE_MAIN2 or (Duel.GetCurrentPhase() == PHASE_MAIN1 and not GlobalBPAllowed))
  and HasID(AIHand(),76473843,true)
  and not HasID(AIST(),76473843,true) then
    return true
  end
 return false
end

--[[  if not EnableMaleficFunctions() then return false end
	if HasFaceupMajesty() 
	and HasID(AIHand(),76473843,true)
	and (CardsMatchingFilter(OppST(),SpecterFZoneFilter)==0
	or CardsMatchingFilter(OppST(),SpecterFZoneDownFilter)>0) then
	 return true
  end]]

function ReplayMajesty() --Senseless to play it against Malefics if they have no field spell of their own, but I think the official A.I. forcefully activates a face-down field spell. --Lucky you, Chandler.
  return OPTCheck(76473843)
end

function EnemyHasSkillDrainFilter(c) --Skill Drain, Lose a Turn
  return (c.id==82732705
  or c.id==24348804)
  and FilterPosition(c,POS_FACEUP)
end

function EnemyLoseTurn(c)
  return c.id==24348804
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasLoseTurn()
  return CardsMatchingFilter(OppST(),EnemyLoseTurn)>0
end

function EnemyHasSkillDrainOnly()
  return CardsMatchingFilter(OppST(),function(c) return c.id==82732705 end)>0
end

function EnemyHasSkillDrain()
  return CardsMatchingFilter(OppST(),EnemyHasSkillDrainFilter)>0
end

function UseDragonpitSkillDrain()
  return EnemyHasSkillDrain()
  and OPTCheck(51531505)
  and not RaccoonHandCheck()
end

function UseDragonpitASF()
  if not EnemyHasASF() then return false end
  if not OPTCheck(51531505) then return false end
  if RaccoonHandCheck() then return false end
  if HasID(AIHand(),76473843,true)
  and not HasFaceupMajesty() then
    return true
  end
  if HasID(AIHand(),13972452,true) and (UseSStorm2() or UseSStorm4()) then
    return true
  end
  if HasID(AIHand(),49366157,true) and ChainSpecterCyclone2() then
    return true
  end
 return false
end

function SpecterGranpulseTargetASF()
  if not EnemyHasASF() then return false end
  if HasID(AIHand(),76473843,true)
  and not HasFaceupMajesty() then
    return true
  end
  if NeedsScale5Activation() or NeedsScale2Activation() or NeedsScaleBothActivation() then
    return true
  end
  if HasID(AIHand(),13972452,true) and (UseSStorm2() or UseSStorm4()) then
    return true
  end
  if HasID(AIHand(),49366157,true) and ChainSpecterCyclone2() then
    return true
  end
  if HasID(AIHand(),53208660,true) and (UsePendulumCallSpecter() or UsePendulumCallScaleReplaceSpecter()) then
    return true
  end
 return false
end

function SpecterSummonGranpulseASF()
  return HasID(AIExtra(),85252081,true)
  and EnemyHasASF()
  and NeedsScaleActivation()
end

function AmorphageCheckFilter(c)
  return IsSetCode(c.setcode,0xe0)
end

function AmorphageOlgaCheck()
  return CardsMatchingFilter(OppMon(),AmorphageCheckFilter)>0
  and HasIDNotNegated(OppST(),79794767,true)
end

function EnemyHasSpecterCounterCardSTFilter(c) --Mask of Restrict, DNA Surgery, DNA Transplant, Poisonous Winds, Zombie World
  if AmorphageOlgaCheck() then
    return c.id==79794767
	and SpecterDestroyFilter(c)
	and NotNegated(c)
  end
  return (FilterPosition(c,POS_FACEUP)
  or FilterPublic(c))
  and NotNegated(c)
  and SpecterDestroyFilter(c)
  and (c.id==29549364
  or c.id==74701381
  or c.id==56769674
  or c.id==95561280
  or c.id==04064256)
end

function EnemyHasSpecterCounterCardST()
  return CardsMatchingFilter(OppST(),EnemyHasSpecterCounterCardSTFilter)>0
end

function UseDragonpitSpecterCounterCardST()
  return EnemyHasSpecterCounterCardST()
  and OPTCheck(51531505)
  and not RaccoonHandCheck()
end

function SpecterSummonGranpulseSpecterCounterCardST()
  return EnemyHasSpecterCounterCardST()
  and HasID(AIExtra(),85252081,true)
  and XYZSummonOkay()
  and ((HasIDNotNegated(AIST(),76473843,true) and OPTCheck(76473843)) 
  or (UsableBackrow() or UsableSTempest()))
end

function NeedsScale5Activation()
  return CardsMatchingFilter(AIST(),ScaleLowFilter)>0
  and CardsMatchingFilter(AIHand(),ScaleHighFilter)>0
  and CardsMatchingFilter(AIST(),ScaleHighFilter)==0
end

function NeedsScale2Activation()
  return CardsMatchingFilter(AIST(),ScaleHighFilter)>0
  and CardsMatchingFilter(AIHand(),ScaleLowFilter)>0
  and CardsMatchingFilter(AIST(),ScaleLowFilter)==0
end

function NeedsScaleBothActivation()
  return CardsMatchingFilter(AIST(),AllPendulumFilter)==0
  and CardsMatchingFilter(AIHand(),ScaleHighFilter)>0
  and CardsMatchingFilter(AIHand(),ScaleLowFilter)>0
end

function NeedsScaleActivation()
  return NeedsScale5Activation()
  or NeedsScale2Activation()
  or NeedsScaleBothActivation()
end

function FaceupMajesty(c)
  return c.id==76473843
  and FilterPosition(c,POS_FACEUP)
end

function HasFaceupMajesty()
  return CardsMatchingFilter(AIST(),FaceupMajesty)>0
end

function SpecterStardustSparkTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==83994433
	and e:GetHandlerPlayer()==1-player_ai then
	OPTSet(83994433)
	 return true
	end
  end
 return false
end

function SpecterStardustSparkCheck()
  return OPTCheck(83994433)
  and HasID(OppMon(),83994433,true)
end

function DoubleUtopia()
  return (CardsMatchingFilter(AIExtra(),function(c) return c.id==84013237 end)>1
  and CardsMatchingFilter(AIExtra(),function (c) return c.id==56832966 end)>1)
  or (DoubleUtopiaActivated
  and (HasID(AIMon(),84013237,true)
  or HasID(AIMon(),56832966,true)))
  or (HasID(AIMon(),84013237,true)
  and HasID(AIExtra(),56832966,true)
  and HasID(AIExtra(),84013237,true))
end

function DoubleUtopiaTargetFilter(c)
  return FilterPosition(c,POS_FACEUP_ATTACK)
  and not FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
  and not FilterAffected(c,EFFECT_AVOID_BATTLE_DAMAGE)
  and not FilterAffected(c,EFFECT_REFLECT_BATTLE_DAMAGE)
end

function SpecterOppGetWeakestAttack()
  local cards=OppMon()
  local result=9999999
  ApplyATKBoosts(cards)
  if #cards==0 then return 0 end
  for i=1,#cards do
    if cards[i] and cards[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      if bit32.band(cards[i].position,POS_ATTACK)>0 and cards[i].attack<result then
        result=cards[i].attack-cards[i].bonus
		LightningMonitorAttack = result
	  end
	end
  end
 return result
end

function DoubleUtopiaAttackTargetFilter(c)
  return c.attack == SpecterOppGetWeakestAttack()
  and DoubleUtopiaTargetFilter(c)
end

function DoubleUtopiaConstantConditions()
  if EnemyHasStall() then return false end
  if EnemyHasBattleStallLightning() then return false end
  if CardsMatchingFilter(OppMon(),DoubleUtopiaTargetFilter)<2 then return false end
  if Duel.GetCurrentPhase() == PHASE_MAIN2 then return false end
  if not GlobalBPAllowed then return false end
  if CardsMatchingFilter(OppST(),OppDownBackrowFilter)>1 then return false end
  if #OppMon()<2 then return false end
  if AI.GetPlayerLP(2)==8000
  and OppGetStrongestAttack() <=1000 then
    return true
  end
  if AI.GetPlayerLP(2)<=7500 and AI.GetPlayerLP(2)>=6500
  and OppGetStrongestAttack() <=2000 and SpecterOppGetWeakestAttack() <=500 then
    return true
  end
  if AI.GetPlayerLP(2)<=7500 and AI.GetPlayerLP(2)>=7000
  and OppGetStrongestAttack() <=1500 and SpecterOppGetWeakestAttack() <=1000 then
    return true
  end
  if AI.GetPlayerLP(2)<=7000 and AI.GetPlayerLP(2)>=6500
  and OppGetStrongestAttack() <=2500 and SpecterOppGetWeakestAttack() <=500 then
    return true
  end
  if AI.GetPlayerLP(2)<=7000 and AI.GetPlayerLP(2)>=6500
  and OppGetStrongestAttack() <=2000 and SpecterOppGetWeakestAttack() <=1000 then
    return true
  end
  if AI.GetPlayerLP(2)<=6500 and AI.GetPlayerLP(2)>=6000
  and OppGetStrongestAttack() <=3000 and SpecterOppGetWeakestAttack() <=500 then
    return true
  end
  if AI.GetPlayerLP(2)<=6500 and AI.GetPlayerLP(2)>=6000
  and OppGetStrongestAttack() <=2500 and SpecterOppGetWeakestAttack() <=1000 then
    return true
  end
  if AI.GetPlayerLP(2)<=6500 and AI.GetPlayerLP(2)>=6000
  and OppGetStrongestAttack() <=2000 and SpecterOppGetWeakestAttack() <=1500 then
    return true
  end
  if AI.GetPlayerLP(2)<=6000 and AI.GetPlayerLP(2)>=5500
  and OppGetStrongestAttack() <=3500 and SpecterOppGetWeakestAttack() <=500 then
    return true
  end
  if AI.GetPlayerLP(2)<=6000 and AI.GetPlayerLP(2)>=5500
  and OppGetStrongestAttack() <=3000 and SpecterOppGetWeakestAttack() <=1000 then
    return true
  end
  if AI.GetPlayerLP(2)<=6000 and AI.GetPlayerLP(2)>=5500
  and OppGetStrongestAttack() <=2500 and SpecterOppGetWeakestAttack() <=1500 then
    return true
  end
  if AI.GetPlayerLP(2)<=5500 and AI.GetPlayerLP(2)>=5000
  and OppGetStrongestAttack() <=4000 and SpecterOppGetWeakestAttack() <=500 then
    return true
  end
  if AI.GetPlayerLP(2)<=5500 and AI.GetPlayerLP(2)>=5000
  and OppGetStrongestAttack() <=3500 and SpecterOppGetWeakestAttack() <=1000 then
    return true
  end
  if AI.GetPlayerLP(2)<=5500 and AI.GetPlayerLP(2)>=5000
  and OppGetStrongestAttack() <=3000 and SpecterOppGetWeakestAttack() <=1500 then
    return true
  end
  if AI.GetPlayerLP(2)<=5500 and AI.GetPlayerLP(2)>=5000
  and OppGetStrongestAttack() <=2500 and SpecterOppGetWeakestAttack() <=2000 then
    return true
  end
  if AI.GetPlayerLP(2)<=5000 and AI.GetPlayerLP(2)>=4500
  and OppGetStrongestAttack() <=4000 and SpecterOppGetWeakestAttack() <=1000 then
    return true
  end
  if AI.GetPlayerLP(2)<=5000 and AI.GetPlayerLP(2)>=4500
  and OppGetStrongestAttack() <=3500 and SpecterOppGetWeakestAttack() <=1500 then
    return true
  end
  if AI.GetPlayerLP(2)<=5000 and AI.GetPlayerLP(2)>=4500
  and OppGetStrongestAttack() <=3000 and SpecterOppGetWeakestAttack() <=2000 then
    return true
  end
  if AI.GetPlayerLP(2)<=4500 and AI.GetPlayerLP(2)>=4000
  and OppGetStrongestAttack() <=4000 and SpecterOppGetWeakestAttack() <=1500 then
    return true
  end
  if AI.GetPlayerLP(2)<=4500 and AI.GetPlayerLP(2)>=4000
  and OppGetStrongestAttack() <=3500 and SpecterOppGetWeakestAttack() <=2000 then
    return true
  end
  if AI.GetPlayerLP(2)<=4500 and AI.GetPlayerLP(2)>=4000
  and OppGetStrongestAttack() <=3000 and SpecterOppGetWeakestAttack() <=2500 then
    return true
  end
 return false
end

function SpecterDoubleUtopiaLightningMajestyConditions()
  if CardsMatchingFilter(AIMon(),LevelFourFieldCheck)<3 then return false end
--  or (HasID(AIMon(),84013237,true) or HasID(AIMon(),56832966,true))
--  and CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==0) then return false end
  if CardsMatchingFilter(AIMon(),LevelFourFieldCheck)>=4 then return false end
  if CardsMatchingFilter(AIMon(),NotLV4WindFilter)==0 then return false end
  if (CardsMatchingFilter(AIExtra(),function(c) return c.id==84013237 end)<2
  or CardsMatchingFilter(AIExtra(),function (c) return c.id==56832966 end)<2) then return false end
  if DoubleUtopiaConstantConditions() then
    return true
  end
 return false
end

function UseMajestyLightning()
  return SpecterDoubleUtopiaLightningMajestyConditions()
end

function SummonDoubleUtopiaLightning()
--  if CardsMatchingFilter(OppMon(),DoubleUtopiaTargetFilter)>2 then return false end
  if DoubleUtopiaActivated then return true end
  if (CardsMatchingFilter(AIMon(),LevelFourFieldCheck)<4 
  or (HasID(AIMon(),84013237,true) or HasID(AIMon(),56832966,true))
  and CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==0) then return false end
--  if #OppMon()>2 then return false end
  if not DoubleUtopia() then return false end
  if HasID(AIMon(),84013237,true) and DoubleUtopiaActivated then return true end
  if HasID(AIMon(),56832966,true) and DoubleUtopiaActivated then return true end
  if DoubleUtopiaConstantConditions() then
    return true
  end
 return false
end

function SpecterNormal(c)
  return FilterType(c,TYPE_NORMAL)
end

function SpecterDragonHornStall()
  return HasIDNotNegated(OppST(),21970285,true)
  and CardsMatchingFilter(OppMon(),SpecterNormal)>0
end

function SpecterBlackwing(c)
  return IsSetCode(c.setcode,0x33)
end

function SpecterBlackwingStall()
  return HasID(OppGrave(),16516630,true)
  and CardsMatchingFilter(OppMon(),SpecterBlackwing)>0
end

function SpecterGenericNoBattleDamage(c)
  return FilterAffected(c,EFFECT_AVOID_BATTLE_DAMAGE)
  and FilterAffected(c,EFFECT_REFLECT_BATTLE_DAMAGE)
end

function SpecterSpellCage(c)
  return c.id==25796442
  and FilterPosition(c,POS_FACEUP)
end

function SpecterRitual(c)
  return FilterType(c,TYPE_RITUAL)
end

function SpecterRitualCageStall()
  return CardsMatchingFilter(OppST(),SpecterSpellCage)>0
  and CardsMatchingFilter(OppMon(),SpecterRitual)>0
end

function SpecterBBarrier(c)
  return c.id==79777187
  and FilterPosition(c,POS_FACEUP)
end

function SpecterPMage(c)
  return IsSetCode(c.setcode,0xc6)
  and FilterPosition(c,POS_FACEUP)
end

function SpecterPPal(c)
  return IsSetCode(c.setcode,0x9f)
  and FilterPosition(c,POS_FACEUP)
end

function SpecterBarrierStall()
  return CardsMatchingFilter(OppST(),SpecterBBarrier)>0
  and (CardsMatchingFilter(OppMon(),SpecterPPal)>0
  or CardsMatchingFilter(OppMon(),SpecterPMage)>0)
end

function SpecterIntrigue(c)
  return c.id==23122036
  and FilterPosition(c,POS_FACEUP)
end

function SpecterTornadoWall(c)
  return c.id==18605135
  and FilterPosition(c,POS_FACEUP)
end

function SpecterSBarrier(c)
  return c.id==53239672
  and FilterPosition(c,POS_FACEUP)
end

function SpecterScrubbed(c)
  return c.id==79205581
  and FilterPosition(c,POS_FACEUP)
end

function SpecterBattleStallLightningTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and (e:GetHandler():GetCode()==36361633 or e:GetHandler():GetCode()==12607053 or e:GetHandler():GetCode()==35112613
	or e:GetHandler():GetCode()==46132282 or e:GetHandler():GetCode()==42776960 or e:GetHandler():GetCode()==21648584
	or e:GetHandler():GetCode()==23857661 or e:GetHandler():GetCode()==40591390 or e:GetHandler():GetCode()==16516630)
	and e:GetHandlerPlayer()==1-player_ai then
	OPTSet(86209650)
	 return true
	end
  end
 return false
end

function SpecterOneDayTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==33782437
	and e:GetHandlerPlayer()==1-player_ai then
	 return true
	end
  end
 return false
end

function EnemyHasBattleStallLightning()
  return not OPTCheck(86209650)
  or HasIDNotNegated(OppST(),67616300,true)
  or HasID(OppGrave(),21648584,true)
  or (HasID(OppGrave(),23857661,true) and #OppHand()>0)
  or SpecterDragonHornStall()
  or SpecterBlackwingStall()
  or HasID(OppMon(),93816465,true)
  or CardsMatchingFilter(OppMon(),SpecterGenericNoBattleDamage)>0
  or HasIDNotNegated(OppMon(),84988419,true)
  or HasIDNotNegated(OppMon(),69031175,true)
  or SpecterRitualCageStall()
  or SpecterBarrierStall()
  or CardsMatchingFilter(OppST(),SpecterIntrigue)>0
  or CardsMatchingFilter(OppST(),SpecterTornadoWall)>0
  or CardsMatchingFilter(OppST(),SpecterSBarrier)>0
  or HasID(OppGrave(),34710660,true)
  or CardsMatchingFilter(OppST(),SpecterScrubbed)>0
  or SpecterPeaceTurn
end

function SpecterSummonUtopiaLightningFinish(c)
  return Duel.GetCurrentPhase() == PHASE_MAIN1
  and GlobalBPAllowed
  and CardsMatchingFilter(OppMon(),LightningFinishFilter,c)>0
  and not EnemyHasStall()
  and not EnemyHasBattleStallLightning()
end

function NotLV4WindFilter(c)
  return c.id==14920218
  or c.id==31991800
  or c.id==05506791
end

function PendulumRaccoon()
  return EnemyHasSummonNegatorMon()
  and HasID(UseLists({AIExtra(),AIHand()}),31991800,true)
  and SummonRaccoon1()
  and SummonCrow1()
  and HasID(AIDeck(),68395509,true)
  and ((not HasID(AIHand(),68395509,true) or (HasID(AIHand(),68395509,true) and NormalSummonCheck(player_ai))))
  and HasScales()
  and ((HasID(AIDeck(),13972452,true) and CardsMatchingFilter(OppMon(),SStormFilter5)>0)
  or (HasID(AIDeck(),49366157,true) and CardsMatchingFilter(OppMon(),SpecterCycloneFilter5)>0))
  and not NormalSummonCheck(player_ai)
end

function PendulumCrow()
  return EnemyHasSummonNegatorMon()
  and SummonCrow1()
  and HasID(UseLists({AIExtra(),AIHand()}),68395509,true)
  and ((HasID(AIDeck(),13972452,true) and CardsMatchingFilter(OppMon(),SStormFilter5)>0)
  or (HasID(AIDeck(),49366157,true) and CardsMatchingFilter(OppMon(),SpecterCycloneFilter5)>0))
  and not PendulumRaccoon()
end

function PendulumFox()
  return EnemyHasSummonNegatorMon()
  and SummonFox1()
  and HasID(UseLists({AIExtra(),AIHand()}),94784213,true)
  and CardsMatchingFilter(AIDeck(),SpecterTrapFilter)>0
  and not PendulumRaccoon()
  and not PendulumCrow()
end

function PendulumToad()
  return EnemyHasSummonNegatorMon()
  and SummonToad1()
  and HasID(UseLists({AIExtra(),AIHand()}),00645794,true)
  and CardsMatchingFilter(AIDeck(),SpecterTrapFilter)>0
  and not PendulumRaccoon()
  and not PendulumCrow()
  and not PendulumFox()
end

function PendulumCat()
  return EnemyHasSummonNegatorMon()
  and OPTCheck(05506791)
  and HasID(UseLists({AIExtra(),AIHand()}),05506791,true)
  and not PendulumRaccoon()
  and not PendulumCrow()
  and not PendulumFox()
  and not PendulumToad()
end

function PendulumPeasant()
  return EnemyHasSummonNegatorMon()
  and HasID(UseLists({AIExtra(),AIHand()}),14920218,true)
  and HasID(AIST(),51531505,true)
  and not PendulumRaccoon()
  and not PendulumCrow()
  and not PendulumFox()
  and not PendulumToad()
  and not PendulumCat()
end

function MajestyTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==76473843
	and e:GetHandlerPlayer()==player_ai then
	 return true
	end
  end
 return false
end

function SpecterRafflesiaTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==06511113
	and e:GetHandlerPlayer()==1-player_ai then
	 OPTSet(06511113)
	 return true
	end
  end
 return false
end

function SpecterTimeSpaceCheck()
  return CardsMatchingFilter(UseLists({OppHand(),OppST(),OppDeck()}),EnemyTimeSpaceFilter)>0
  or (HasID(OppGrave(),02055403,true)
  and CardsMatchingFilter(OppGrave(),EnemyTimeSpaceFilter)<3)
end

function EnemySummoningRafflesiaFilter(c)
  return FilterStatus(c,STATUS_SUMMONING)
  and c.id==06511113
end

function EnemySummoningTimeRafflesia()
  return CardsMatchingFilter(OppMon(),EnemySummoningRafflesiaFilter)>0
  and SpecterTimeSpaceCheck()
end

function ChainTempestRafflesia()
  return EnemySummoningTimeRafflesia()
end

function EnemyTimeSpaceFilter(c)
  return c.id==02055403
end

function EnemyHasRafflesiaFilter(c)
  return c.id==06511113
  and FilterPosition(c,POS_FACEUP)
  and NotNegated(c)
  and c.xyz_material_count>0
end

function EnemyHasTimeRafflesia()
  return CardsMatchingFilter(OppMon(),EnemyHasRafflesiaFilter)>0
  and SpecterTimeSpaceCheck()
  and OPTCheck(06511113)
end

function SpecterRaigekiFilter(c)
  return Affected(c,TYPE_SPELL)
  and SpecterDestroyFilter(c)
end

function SpecterRaigekiExceptionFilter(c)
  if AmorphageOlgaCheck() then
    return SpecterRaigekiFilter(c)
	and AmorphageCheckFilter(c)
  end
  if EnemyHasGrysta() then
    return EnemyGrystaFilter(c)
	and SpecterRaigekiFilter(c)
  end
  if EnemyHasHerald() then
    return EnemyHeraldFilter(c)
	and SpecterRaigekiFilter(c)
  end
  if EnemyHasTimeRafflesia() then
    return EnemyHasRafflesiaFilter(c)
	and SpecterRaigekiFilter(c)
  end
  return (c.id==14309486
  or (c.id==74294676 and c.xyz_material_count>=2)
  or c.id==74892653)
  and FilterPosition(c,POS_FACEUP)
  and NotNegated(c)
  and SpecterRaigekiFilter(c)
end

function SpecterRaigekiException()
  return CardsMatchingFilter(OppMon(),SpecterRaigekiExceptionFilter)>0
end

function EnemyHasHammerBounzerFilter(c)
  return c.id==44790889
end

function EnemyHasHammerBounzer()
  return CardsMatchingFilter(OppMon(),EnemyHasHammerBounzerFilter)>0
  and #AIMon()>0
  and #OppST()==0
end

function EnemyHasGearKnightFilter(c)
  return c.id==39303359
end

function EnemyHasGearKnight()
  return CardsMatchingFilter(OppMon(),EnemyHasGearKnightFilter)>0
end

function EnemyHasFireflux()
  return HasIDNotNegated(OppMon(),12255007,true)
end

function EnemyHasPPalOrOddEyesFilter(c)
  return IsSetCode(c.setcode,0x9f)
  or IsSetCode(c.setcode,0x99)
end

function EnemyHasPPalOrOddEyes()
  return CardsMatchingFilter(OppMon(),EnemyHasPPalOrOddEyesFilter)>0
  and EnemyHasFireflux()
end

function EnemyHasReverseBuster()
  return HasIDNotNegated(OppMon(),90640901,true)
  and CardsMatchingFilter(AIMon(),SpecterFacedownFilter)>0
end

function SpecterFacedownFilter(c)
  return FilterPosition(c,POS_FACEDOWN_DEFENSE)
end

function EnemyHasStargazer()
  return HasIDNotNegated(OppST(),94415058,true)
  and UsableSCyclone()
  and CardsMatchingFilter(OppMon(),EnemyStargazerPendulumFilter)>0
end

function EnemyStargazerPendulumFilter(c)
  return FilterType(c,TYPE_PENDULUM)
end

function EnemyHasTimegazer()
  return HasIDNotNegated(OppST(),20409757,true)
  and (UsableSTornado()
  or HasID(AIST(),05650082,true))
  and CardsMatchingFilter(OppMon(),EnemyStargazerPendulumFilter)>0
end

function SpecterForceResonatorTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==40583194
	and e:GetHandlerPlayer()==1-player_ai then
	 OPTSet(40583194)
	 return true
	end
  end
 return false
end

function EnemyHasUltimateGolem()
  return HasIDNotNegated(OppMon(),12652643,true)
end

function EnemyHasCitrine()
  return HasIDNotNegated(OppMon(),67985943,true)
end

function EnemyHasStarEater()
  return HasIDNotNegated(OppMon(),41517789,true)
end

function EnemyHasGeargiagear()
  return HasIDNotNegated(OppMon(),19891310,true)
end

function SpecterTypicalUnaffectedAttackerConditions(c)
  return c.attack > SpecterAIGetWeakestAttDef()
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and NotNegated(c)
  and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
  and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
end

function SpecterGenexTriforceFilter(c)
  return FilterAttribute(c,ATTRIBUTE_LIGHT)
end

function SpecterGenexTriforceSlowRemoval()
  return HasIDNotNegated(OppMon(),52709508,true)
  and CardsMatchingFilter(OppGrave(),SpecterGenexTriforceFilter)==0
end

function SpecterArachnidFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,6)
  and FilterPosition(c,POS_FACEUP)
end

function SpecterArachnidSlowRemoval()
  return CardsMatchingFilter(AIMon(),SpecterArachnidFilter)==0
  and HasIDNotNegated(OppMon(),63465535,true)
end

function EnemyUtopiaTempestRemoval(c)
  return FilterStatus(c,STATUS_SUMMONING)
  and (c.id==84013237
  or c.id==56840427
  or c.id==86532744)
end

function EnemyUtopiaSlowRemoval()
  return (HasID(OppMon(),84013237,true)
  or HasID(OppMon(),56840427,true)
  or HasID(OppMon(),86532744,true))
  and not (HasID(OppST(),11705261,true)
  and HasID(OppST(),26493435,true))
end

function EnemyHasUnaffectedAttackerFilter(c) --Index cards that prevent effects from being activated when they attack, or are unaffected when they attack.
  if EnemyUtopiaSlowRemoval() then
    return (c.id==84013237
	or c.id==56840427
	or c.id==86532744)
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if SpecterArachnidSlowRemoval() then
    return c.id==63465535
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if SpecterGenexTriforceSlowRemoval() then
    return c.id==52709508
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if EnemyHasGeargiagear() then
    return c.id==19891310
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if EnemyHasStarEater() then
    return c.id==41517789
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if EnemyHasCitrine() then
    return c.id==67985943
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if EnemyHasUltimateGolem() then
    return c.id==12652643
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if not OPTCheck(40583194) then
    return FilterPosition(c,POS_FACEUP_ATTACK)
	and c.attack > SpecterAIGetWeakestAttDef()
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
  end
  if EnemyHasStargazer() or EnemyHasTimegazer() then
    return EnemyStargazerPendulumFilter(c)
	and FilterPosition(c,POS_FACEUP_ATTACK)
	and c.attack > SpecterAIGetWeakestAttDef()
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
  end
  if EnemyHasHammerBounzer() then
    return EnemyHasHammerBounzerFilter(c)
	and SpecterTypicalUnaffectedAttackerConditions(c)
  end
  if EnemyHasGearKnight() then
    return EnemyHasGearKnightFilter(c)
	and SpecterTypicalUnaffectedAttackerConditions(c)
	and FilterType(c,TYPE_EFFECT)
  end
  if EnemyHasFireflux() or EnemyHasPPalOrOddEyes() then
    return EnemyHasPPalOrOddEyesFilter(c)
	and FilterPosition(c,POS_FACEUP_ATTACK)
	and c.attack > SpecterAIGetWeakestAttDef()
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
  end
  if EnemyHasReverseBuster() then
    return c.id==90640901
	and NotNegated(c)
	and FilterPosition(c,POS_FACEUP_ATTACK)
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
	and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
  end
  return (c.id==56421754 --Mighty Slugger
  or c.original_id==45349196 --That level 9 Red Dragon Archfiend fusion thing
  or c.id==83866861 --Frightfur Mad Chimera
  or c.id==29357956 --Nerokius
  or c.id==57477163 --Frightfur Sheep
  or c.id==88033975 --Armades
  or c.id==56832966 --Utopia Lightning
  or c.id==07171149 --Toon AYYNCIEENT GEEEER GOLUMMMMM!
  or c.id==83104731 --REGULAH AYYNCIEEENT GEEEER GOLUMMMMM!
  or c.id==50933533 --AYYYUHHNCIENTUR GEERUUU Gadjitron Dragon
  or c.id==10509340 --Ancient Gear Beast
  or c.id==01953925 --Ancient Gear Engineer
  or c.id==56094445 --Ancient Gear Soldier
  or c.id==13293158 --Evil HERO Wild Cyclone
  or c.id==22858242 --Zeman
  or c.id==94515289 --Frozen Fitzgerald
  or c.id==87911394 --Utopia Ray Victory
  or c.id==25494711 --Deskbot 009 **IMPORTANT**
  or c.id==19700943 --Dododo Bot
  or c.id==86274272) --Apelio
  and SpecterTypicalUnaffectedAttackerConditions(c)
end

function EnemySummoningUnaffectedAttackerFilter(c)
  return FilterStatus(c,STATUS_SUMMONING)
  and (c.id==56421754
  or c.original_id==45349196
  or c.id==83866861
  or c.id==29357956
  or c.id==88033975
  or c.id==56832966
  or c.id==07171149
  or c.id==83104731
  or c.id==50933533
  or c.id==10509340
  or c.id==01953925
  or c.id==22858242
  or c.id==94515289
  or c.id==87911394
  or c.id==19700943
  or c.id==19891310
  or c.id==41517789
  or c.id==67985943
  or c.id==12652643
  or c.id==44790889
  or c.id==12255007)
end

function EnemySummoningUnaffectedAttackerFilter2(c)
  return EnemySummoningUnaffectedAttackerFilter(c)
  and c.attack > SpecterAIGetWeakestAttDef()
end

function SpecterCodedUnaffectedAttackers(c)
  return c.id==56421754 --Mighty Slugger
  or c.original_id==45349196 --That level 9 Red Dragon Archfiend fusion thing
  or c.id==83866861 --Frightfur Mad Chimera
  or c.id==29357956 --Nerokius
  or c.id==57477163 --Frightfur Sheep
  or c.id==88033975 --Armades
  or c.id==56832966 --Utopia Lightning
  or c.id==07171149 --Toon AYYNCIEENT GEEEER GOLUMMMMM!
  or c.id==83104731 --REGULAH AYYNCIEEENT GEEEER GOLUMMMMM!
  or c.id==50933533 --AYYYUHHNCIENTUR GEERUUU Gadjitron Dragon
  or c.id==10509340 --Ancient Gear Beast
  or c.id==01953925 --Ancient Gear Engineer
  or c.id==56094445 --Ancient Gear Soldier
  or c.id==13293158 --Evil HERO Wild Cyclone
  or c.id==22858242 --Zeman
  or c.id==94515289 --Frozen Fitzgerald
  or c.id==87911394 --Utopia Ray Victory
  or c.id==25494711 --Deskbot 009 **IMPORTANT**
  or c.id==19700943 --Dododo Bot
  or c.id==19891310 --Geargiagear
  or c.id==41517789 --Star Eater
  or c.id==67985943 --Citrine
  or c.id==12652643 --Ultimate Golem
  or c.id==44790889 --Hammer Bounzer
  or c.id==39303359 --Ancient Gear Knight
  or c.id==12255007 --Performapal Fireflux
end

function SpecterAIGetWeakestAttDef()
  local cards=AIMon()
  local result=9999999
  ApplyATKBoosts(cards)
  if #cards==0 then return 0 end
  for i=1,#cards do
    if cards[i] and cards[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      if bit32.band(cards[i].position,POS_ATTACK)>0 and cards[i].attack<result then
        result=cards[i].attack-cards[i].bonus
      elseif bit32.band(cards[i].position,POS_DEFENSE)>0 and cards[i].defense<result 
      and (bit32.band(cards[i].position,POS_FACEUP)>0 or FilterPublic(cards[i]))
      then
        result=cards[i].defense
      end
    end
  end
  return result
end

function SpecterUpstart()
  return true
end

function SpecterJokerAddInsight()
  return CardsMatchingFilter(AIHand(),MagicianPendulumFilter)>0
  and HasID(AIDeck(),72714461,true)
  and (CardsMatchingFilter(AIST(),AllPendulumFilter)==0 or (CardsMatchingFilter(AIST(),MagicianPendulumFilter)==1
  and CardsMatchingFilter(AIST(),AllPendulumFilter)==1))
end

function SpecterSummonJoker1()
  return ((NeedsScale5() and (HasID(AIDeck(),51531505,true) or HasID(AIDeck(),72714461,true)))
  or (NeedsScale2() and HasID(AIDeck(),14920218,true))
  or SpecterJokerAddInsight()
  or (not NeedsScale2() and HasID(AIDeck(),51531505,true))
  or (not NeedsScale5() and HasID(AIDeck(),14920218,true)))
  and OPTCheck(40318957)
--  and (CardsMatchingFilter(AIHand(),TrueSpecterMonsterFilter)==0
  and (not HasID(AIHand(),31991800,true) or not OPTCheck(31991800))
  and not MajestyCheck()
end

function SpecterSummonJoker2()
  return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==1 or CardsMatchingFilter(AIMon(),LevelFourFieldCheck)==3
  or ((AIGetStrongestAttack() > OppGetStrongestAttack() 
  or OppGetStrongestAttack()<1800)
  and Duel.GetTurnCount() ~= 1)
end

function SpecterReasoning()
  return true
end

function SpecterSummonCowboyDef()
  return AI.GetPlayerLP(2)<=800
end

function SpecterCowboyUseDef()
  return HasIDNotNegated(AIMon(),12014404,true)
end

function SpecterDaneFilter(c)
  return TrueSpecterMonsterFilter(c)
  and OPTCheck(c)
end

function SpecterSummonDane()
  return CardsMatchingFilter(AIMon(),SpecterDaneFilter)>3
  and ((CardsMatchingFilter(AIST(),MagicianPendulumFilter)>1
  and not OPTCheck(53208660))
  or (CardsMatchingFilter(AIHand(),ScaleHighFilter)>0
  and CardsMatchingFilter(AIHand(),ScaleLowFilter)>0))
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),TrueSpecterMonsterFilter)<4
  and CardsMatchingFilter(AIST(),SpecterBackrowFilter)<4
  and XYZSummonOkay()
  and HasID(AIExtra(),82697249,true)
  and OPTCheck(31437713)
  and not HasID(AIST(),78949372,true)
  and not HasID(AIST(),05851097,true)
end

function SpecterUseDane()
  return CardsMatchingFilter(AIMon(),SpecterDaneFilter)>1
  and ((CardsMatchingFilter(AIST(),MagicianPendulumFilter)>1
  and not OPTCheck(53208660))
  or (CardsMatchingFilter(AIHand(),ScaleHighFilter)>0
  and CardsMatchingFilter(AIHand(),ScaleLowFilter)>0))
  and Duel.GetTurnCount() ~= SpecterGlobalPendulum
  and CardsMatchingFilter(AIST(),SpecterBackrowFilter)<4
  and OPTCheck(31437713)
  and not HasID(AIST(),78949372,true)
  and not HasID(AIST(),05851097,true)
end

function KuribanditTrace()
  local e
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==16404809
	and e:GetHandlerPlayer()==1-player_ai then
	 return true
	end
  end
 return false
end

function SpecterSummonGranpulseSmart() --Beneficial targets to destroy. Fight the power!
  return CardsMatchingFilter(OppST(),SpecterMonsterVersusOppSTSmartFilter)>0
  and XYZSummonOkay()
  and HasID(AIExtra(),85252081,true)
end

function SpecterSummonGranpulseSmartRoom() --Beneficial targets to destroy. Fight the power!
  return CardsMatchingFilter(OppST(),SpecterMonsterVersusOppSTSmartFilter)>0
  and MakeRoom()
  and HasID(AIExtra(),85252081,true)
end

function EnemyHasEternalSoul()
  return HasID(OppST(),48680970,true)
  and #OppMon()>1
end

function EnemyHasDominionFilter(c)
  return c.id==84171830
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasDominionMonsterFilter(c)
  return bit32.band(c.summon_type,SUMMON_TYPE_NORMAL)>0
  and c.level>4
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasDominion()
  return CardsMatchingFilter(OppST(),EnemyHasDominionFilter)>0
  and CardsMatchingFilter(OppMon(),EnemyHasDominionMonsterFilter)>0
end

function EnemyHasNordicFilter(c)
  return c.id==50433147
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasNordicMonsterFilter(c)
  return IsSetCode(c.setcode,0x42)
  and FilterPosition(c,POS_FACEUP)
end

function EnemyHasNordic()
  return CardsMatchingFilter(OppST(),EnemyHasNordicFilter)>0
  and CardsMatchingFilter(OppMon(),EnemyHasNordicMonsterFilter)>1
end
  
function SpecterMonsterVersusOppSTSmartFilter(c)
  if EnemyHasEternalSoul() then
    return c.id==48680970
    and (FilterPosition(c,POS_FACEUP)
    or FilterPublic(c))
    and Targetable(c,TYPE_MONSTER)
    and Affected(c,TYPE_MONSTER)
  end
  if EnemyHasDominion() then
    return EnemyHasDominionFilter(c)
	and Targetable(c,TYPE_MONSTER)
    and Affected(c,TYPE_MONSTER)
  end
  if EnemyHasNordic() then
    return EnemyHasNordicFilter(c)
	and Targetable(c,TYPE_MONSTER)
	and Affected(c,TYPE_MONSTER)
  end
  if Duel.GetCurrentPhase() == PHASE_MAIN2 then
    return (c.id==36378044
	or c.id==79569173)
	and FilterPosition(c,POS_FACEUP)
	and Targetable(c,TYPE_MONSTER)
	and Affected(c,TYPE_MONSTER)
  end
 return (c.id==77565204
 or c.id==16278116)
 and (FilterPosition(c,POS_FACEUP)
 or FilterPublic(c))
 and Targetable(c,TYPE_MONSTER)
 and Affected(c,TYPE_MONSTER)
end

function SpecterUseDragonpitSmart()
  return CardsMatchingFilter(OppST(),SpecterSpellVersusOppSTSmartFilter)>0
  and OPTCheck(51531505)
  and not RaccoonHandCheck()
end

function SpecterSpellVersusOppSTSmartFilter(c)
  if EnemyHasEternalSoul() then
    return c.id==48680970
    and (FilterPosition(c,POS_FACEUP)
    or FilterPublic(c))
    and Targetable(c,TYPE_SPELL)
    and Affected(c,TYPE_SPELL)
  end
  if EnemyHasDominion() then
    return EnemyHasDominionFilter(c)
	and Targetable(c,TYPE_SPELL)
    and Affected(c,TYPE_SPELL)
  end
  if EnemyHasNordic() then
    return EnemyHasNordicFilter(c)
	and Targetable(c,TYPE_SPELL)
	and Affected(c,TYPE_SPELL)
  end
  if Duel.GetCurrentPhase() == PHASE_MAIN2 then
    return (c.id==36378044
	or c.id==79569173)
	and FilterPosition(c,POS_FACEUP)
	and Targetable(c,TYPE_SPELL)
	and Affected(c,TYPE_SPELL)
  end
 return (c.id==77565204
 or c.id==16278116)
 and (FilterPosition(c,POS_FACEUP)
 or FilterPublic(c))
 and Targetable(c,TYPE_SPELL)
 and Affected(c,TYPE_SPELL)
end

function SpecterChidoriFilter1(c)
  return FilterPosition(c,POS_FACEDOWN)
  and Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,4)
end

function SpecterChidoriFilter2(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,4)
  and FilterPosition(c,POS_FACEUP)
  and not SpecterCodedTargets2(c)
end

function SpecterSummonChidori()
  return CardsMatchingFilter(OppField(),SpecterChidoriFilter1)>0
  and CardsMatchingFilter(OppField(),SpecterChidoriFilter2)>0
  and XYZSummonOkayWind()
end

function SpecterUseChidori()
  return CardsMatchingFilter(OppField(),SpecterChidoriFilter2)>0
end

function SpecterSummonAbyssArchetypesMP1()
  return (AIGetStrongestAttack() > OppGetStrongestAttack() or OppGetStrongestAttack() < 1700)
  and XYZSummonOkay()
  and Duel.GetCurrentPhase() == PHASE_MAIN1
  and ((EnableArtifactFunctions() and OppDownBackrow())
  or (CardsMatchingFilter(OppMon(),SpecterGraveyardEffectBattleFilter)>1 and GlobalBPAllowed))
end

function SpecterSummonAbyssArchetypesMP2()
  return (AIGetStrongestAttack() > OppGetStrongestAttack() or OppGetStrongestAttack() < 1700)
  and XYZSummonOkay()
  and (Duel.GetCurrentPhase() == PHASE_MAIN2 or (Duel.GetCurrentPhase() == PHASE_MAIN1 and not GlobalBPAllowed))
  and (EnableHieraticFunctions()
  or EnableLightswornFunctions()
  or EnableZombieFunctions()
  or EnableBlueEyesAbyssFunctions())
end

function EnableLightswornFunctionsFilter(c)
  return IsSetCode(c.setcode,0x38)
end

function EnableLightswornFunctions()
  return CardsMatchingFilter(UseLists({OppMon(),OppDeck(),OppGrave(),OppBanish()}),EnableLightswornFunctionsFilter)>=10
end

function EnableZombieFunctionsFilter(c)
  return FilterRace(c,RACE_ZOMBIE)
end

function EnableZombieFunctions()
  return CardsMatchingFilter(UseLists({OppMon(),OppDeck(),OppGrave(),OppBanish()}),EnableZombieFunctionsFilter)>=10
end

function EnableBlueEyesAbyssFunctionsFilter(c)
  return c.id==36734924
  or c.id==71039903
  or c.id==45644898
  or c.id==56532353
end

function EnableBlueEyesAbyssFunctions()
  return CardsMatchingFilter(OppGrave(),EnableBlueEyesAbyssFunctionsFilter)>0
end

function EnableArtifactFunctionsFilter(c) --Can't read setcode?
  return c.id==20292186
  or c.id==85103922
  or c.id==12697630
  or c.id==12444060
  or c.id==29223325
  or c.id==69840739
  or c.id==69304426
  or c.id==84268896
  or c.id==85080444
  or c.id==56611470
  or c.id==11475049
  or c.id==34267821
  or c.id==08873112
  or c.id==48086335
  or c.id==47863787
end

function EnableArtifactFunctions()
  return CardsMatchingFilter(UseLists({OppMon(),OppDeck(),OppGrave(),OppBanish()}),EnableArtifactFunctionsFilter)>=5
end

--Verserion when it gets an id.
--ABC unions when they get ids.
--Silent Swordsman when it gets an id.
--Starve Venom Fusion Dragon when it gets an id.

function SpecterGraveyardEffectBattleFilter(c) --Anything always above 2000, assume Utopia Lightning will be on the field.
  return SpecterLightningFilter(c)
  and (FilterPosition(c,POS_FACEUP)
  or FilterPublic(c))
  and (c.id==58604027
  or c.id==72677437
  or c.id==17286057
  or c.id==85991529
  or c.id==08062132
  or c.id==64063868
  or c.id==85771019
  or c.id==55885348
  or c.id==23015896
  or c.id==18175965
  or c.id==27103517
  or c.id==31829185
  or c.id==20849090
  or c.id==71703785
  or c.id==05556499
  or c.id==68299524
  or c.id==12624008
  or c.id==13846680
  or c.id==50957346
  or c.id==59235795
  or c.id==86229493
  or c.id==86442081
  or c.id==31986288
  or c.id==52824910
  or c.id==59496924
  or c.id==29491334
  or c.id==34294855
  or c.id==07602840
  or c.id==58990362
  or c.id==69838592
  or c.id==80887952
  or c.id==94454495
  or c.id==99946920
  or c.id==37679169
  or c.id==93927067
  or c.id==97904474
  or c.id==32146097
  or c.id==33656832
  or c.id==47606319
  or c.id==99348756
  or c.id==30106950
  or c.id==51987571
  or c.id==75252099
  or c.id==85399281
  or c.id==98719226
  or c.id==86062400
  or c.id==70074904
  or c.id==39091951
  or c.id==29687169
  or c.id==67922702
  or c.id==59312550
  or c.id==91438994
  or c.id==55010259
  or c.id==98301564
  or c.id==81354330
  or c.id==11439455
  or c.id==14763299
  or c.id==02584136
  or c.id==67483216
  or c.id==76066541
  or c.id==29654737
  or c.id==02671330
  or c.id==29021114
  or c.id==40320754
  or c.id==27655513
  or c.id==40894584
  or c.id==14541657
  or c.id==97017120
  or c.id==60806437
  or c.id==83011277
  or (c.id==02250266 and FilterPosition(c,POS_FACEUP_ATTACK))
  or c.id==57839750
  or c.id==03070049
  or c.id==84834865
  or c.id==48783998
  or c.id==95956346
  or c.id==03846170
  or c.id==03370104
  or c.id==70089580
  or c.id==77044671
  or c.id==06320631
  or c.id==75733063
  or c.id==86174055
  or c.id==04335645
  or c.id==72714226
  or c.id==16480084
  or c.id==69572169
  or c.id==66762372
  or c.id==05438492
  or c.id==62379337
  or c.id==44364207
  or c.id==07563579
  or c.id==34680482
  or c.id==60508057
  or c.id==94667532
  or c.id==44481227
  or c.id==24025620
  or (c.id==70271583 and FilterPosition(c,POS_FACEUP_DEFENSE))
  or c.id==66500065
  or c.id==45045866
  or c.id==29834183
  or c.id==41386308
  or c.id==63223467
  or c.id==24218047
  or c.id==39191307
  or c.id==81035362
  or c.id==71519605
  or c.id==42737833
  or c.id==89731911
  or c.id==93107608
  or c.id==15394083
  or c.id==56132807
  or c.id==83190280
  or c.id==37984162
  or c.id==76321376
  or c.id==17559367
  or c.id==85646474
  or c.id==93445074
  or c.id==20586572
  or c.id==66540884
  or c.id==06480253
  or c.id==02377034
  or c.id==78275321
  or c.id==24103628
  or c.id==66451379
  or c.id==56675280
  or c.id==36625827
  or c.id==89893715
  or c.id==20797524
  or c.id==07914843
  or c.id==83982270
  or c.id==83135907
  or c.id==43332022
  or c.id==51925772
  or c.id==68226653
  or c.id==54490275
  or c.id==54455435
  or c.id==02843014
  or c.id==22567609
  or c.id==95178994
  or c.id==14472500
  or (c.id==28124263 and FilterPosition(c,POS_FACEUP_ATTACK))
  or c.id==10110717
  or c.id==57844634
  or c.id==32271987
  or c.id==00525110
  or c.id==03030892
  or c.id==99675356
  or c.id==72291078
  or c.id==48588176
  or c.id==05498296
  or c.id==48411996
  or c.id==68366996
  or c.id==88845345
  or c.id==09156135
  or c.id==82994509
  or c.id==59482302
  or c.id==62437709
  or c.id==00131182
  or c.id==83392426
  or (c.id==56840658 and FilterPosition(c,POS_FACEUP))
  or c.id==02095764
  or c.id==25935625
  or c.id==64627453
  or c.id==73702909
  or c.id==35050257
  or c.id==60161788
  or c.id==55488859
  or c.id==91662792
  or c.id==18489208
  or c.id==28332833
  or (c.id==76865611 and FilterPosition(c,POS_FACEUP_DEFENSE))
  or c.id==93749093
  or c.id==50732780
  or c.id==93451636
  or c.id==00135598
  or c.id==22171591
  or c.id==56839613
  or c.id==81752019
  or c.id==94878265
  or c.id==35089369
  or c.id==10456559
  or c.id==31034919
  or c.id==48343627
  or c.id==56597272
  or c.id==61488417
  or (c.id==70546737 and FilterPosition(c,POS_FACEUP_ATTACK))
  or c.id==80244114
  or c.id==83604828
  or c.id==36021814
  or c.id==53315891
  or c.id==18386170
  or c.id==74583607
  or (c.id==57477163 and c.attack<2500)
  or c.id==74009824
  or c.id==54484652
  or c.id==74892653
  or c.id==19048328
  or c.id==26949946
  or c.id==39823987
  or c.id==52145422
  or c.id==83283063
  or c.id==44852429
  or c.id==23693634
  or c.id==43202238
  or c.id==53451824
  or (c.id==25958491 and c.attack<5000)
  or c.id==00601193
  or c.id==25373678
  or c.id==29143726
  or c.id==85551711
  or c.id==37279508
  or c.id==17016362
  or c.id==30100551
  or c.id==93730230
  or c.id==50789693
  or (c.id==54366836 and FilterPosition(c,POS_FACEUP_ATTACK))
  or c.id==31766317
  or c.id==85066822
  or c.id==34004470
  or c.id==38525760
  or c.id==46037213
  or c.id==47754278
  or c.id==06903857
  or c.id==66413481
  or c.id==12694768
  or c.id==73001017
  or c.id==97396380
  or c.id==98884569
  or c.id==16135253
  or c.id==36569343
  or c.id==36733451
  or c.id==80441106
  or c.id==50916353
  or c.id==78243409
  or c.id==39892082
  or c.id==59965151
  or c.id==64379430
  or c.id==81020140
  or c.id==96594609
  or c.id==51534754
  or c.id==89113320
  or c.id==16751086
  or c.id==98263709
  or c.id==07736719
  or c.id==97885363
  or c.id==45801022
  or c.id==46897277
  or c.id==55013285
  or c.id==81587028
  or c.id==12652643
  or c.id==95486586
  or c.id==75380687
  or c.id==13722870
  or c.id==04796100
  or c.id==41517968
  or c.id==72959823
  or c.id==92361635
  or c.id==50278554
  or c.id==96029574
  or c.id==95453143
  or c.id==49389523
  or c.id==76774528
  or c.id==67904682
  or c.id==04779823
  or c.id==23338098
  or c.id==13995824
  or c.id==77799846
  or c.id==20785975
  or c.id==12744567
  or c.id==71921856
  or c.id==59170782
  or c.id==79852326
  or c.id==37169670
  or c.id==69831560
  or c.id==77336644
  or c.id==38898779
  or c.id==61257789
  or (c.id==57793869 and c.attack<=5000)
  or c.id==14553285
  or c.id==34079868
  or c.id==14462257
  or c.id==01764972
  or c.id==23558733
  or c.id==17189532
  or c.id==00123709
  or c.id==42280216
  or c.id==74641045
  or c.id==59911557
  or c.id==09418365
  or c.id==18426196
  or c.id==50903514
  or c.id==46572756
  or c.id==41158734
  or c.id==75363626
  or c.id==52404456
  or c.id==68535320
  or c.id==65472618
  or c.id==48252330
  or c.id==94283662
  or c.id==95929069
  or c.id==11868731
  or c.id==26016357
  or c.id==43002864
  or c.id==23899727
  or c.id==89521713
  or c.id==91350799
  or c.id==98358303
  or c.id==71341529
  or c.id==26570480
  or c.id==54149433
  or c.id==12980373
  or c.id==47077318
  or c.id==85087012
  or c.id==17475251
  or c.id==49374988
  or c.id==27971137
  or c.id==41952656
  or c.id==09861795
  or c.id==28139785
  or c.id==78349103
  or c.id==87535691
  or c.id==57116033
  or c.id==20855340
  or c.id==87340664
  or c.id==40343749
  or c.id==70054514
  or c.id==62242678
  or c.id==89474727
  or c.id==39477584
  or c.id==37910722
  or c.id==66818682
  or c.id==32995007
  or c.id==24943456
  or c.id==98558751
  or c.id==27552504
  or c.id==66970002
  or c.id==58712976
  or c.id==61344030
  or c.id==62709239
  or c.id==82962242
  or c.id==50287060
  or c.id==59975920
  or c.id==82293134
  or c.id==05361647
  or c.id==89609515
  or c.id==45547649
  or c.id==85374678
  or c.id==21593977
  or c.id==67696066
  or c.id==51858306
  or c.id==12467005
  or c.id==31709826
  or c.id==82642348
  or c.id==50720316
  or c.id==26185991
  or c.id==24701235
  or c.id==05929801
  or c.id==64306248
  or c.id==95401059
  or c.id==81992475
  or c.id==57143342
  or c.id==45010690
  or c.id==09342162
  or c.id==56223084
  or c.id==73213494
  or c.id==62957424
  or c.id==96682430
  or c.id==12369277
  or c.id==47728740
  or c.id==45593826
  or c.id==36553319
  or c.id==20758643
  or c.id==01102515
  or c.id==52823314
  or c.id==22873798
  or c.id==66540884
  or c.id==09418534
  or c.id==15341821
  or c.id==35629124
  or c.id==35429292
  or c.id==76614003
  or c.id==17932494
  or c.id==58016954
  or c.id==58551308
  or c.id==69750546
  or c.id==73146473
  or c.id==75673220
  or c.id==95457011
  or c.id==09742784
  or c.id==79814787
  or c.id==54359696
  or c.id==13455953
  or c.id==02407147
  or c.id==51275027
  or c.id==57473560
  or c.id==60990740
  or c.id==80532587
  or c.id==42566602
  or c.id==42110604
  or c.id==79606837
  or c.id==84025439
  or c.id==16691074
  or c.id==10613952
  or c.id==23649496
  or (c.id==42589641 and c.xyz_material_count>0)
  or c.id==75367227
  or c.id==83531441
  or c.id==46895036
  or c.id==04904633
  or c.id==63804806
  or c.id==48948935
  or c.id==94689206
  or c.id==99365553
  or c.id==31038159
  or c.id==91250514
  or c.id==36352429
  or c.id==93298460
  or c.id==62950604
  or c.id==61901281
  or c.id==58324930
  or c.id==99234526
  or c.id==86559484
  or c.id==22134079
  or c.id==75043725
  or c.id==54629413
  or c.id==33866130
  or c.id==55969226
  or c.id==06351548
  or c.id==47030842
  or c.id==25280974
  or c.id==76543119
  or c.id==16366944
  or c.id==90361010
  or c.id==78010363
  or c.id==63665875
  or c.id==96938986
  or c.id==97064649
  or c.id==84824601
  or c.id==26202165
  or c.id==58616392
  or c.id==65277087
  or c.id==25343017
  or c.id==37349495
  or c.id==99070951
  or c.id==15169262
  or c.id==46239604
  or c.id==93969023
  or c.id==13314457
  or c.id==76442347
  or c.id==60668166
  or c.id==77360173
  or c.id==28016193
  or c.id==22061412
  or c.id==71616908
  or c.id==13108445
  or c.id==35330871
  or c.id==97836203
  or c.id==24221808
  or c.id==37993923
  or c.id==37038993
  or c.id==23454876
  or c.id==71612253
  or c.id==56638325
  or c.id==03758046
  or c.id==96381979
  or c.id==16259549)
end

function SpecterUseSummoners()
  return true
end

function SpecterInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  
  GlobalMaterial = false
  SpecterGlobalMaterial = false
  
  if HasIDNotNegated(Act,22653490,SpecterUseChidori) then
    GlobalCardMode = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,12580477,SpecterRaigekiException) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,85252081,SpecterUseGranpulse) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,79816536,SpecterUseSummoners) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,70368879,SpecterUpstart) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,58577036,SpecterReasoning) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(SpSum,62709239,InsightfulPhantomSummon) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(Act,62709239,InsightfulPhantomUse) then
	GlobalCardMode = 7
   return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Sum,94784213,InsightfulFodderSummon) then  --Fox
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,68395509,InsightfulFodderSummon) then  --Crow
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,00645794,InsightfulFodderSummon) then  --Toad
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Act,76473843,InsightfulMajesty,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(76473843)
	GlobalCardMode = 1
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Sum,31991800,InsightfulRaccoonSummon) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,05506791,InsightfulCatSummon) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Act,14920218,UsePeasantPendulum,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(14920218)
	GlobalCardMode = 1
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,UseDragonpitSkillDrain,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 9
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,UseDragonpitASF,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 11
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,UseDragonpitSpecterCounterCardST,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 13
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,SpecterUseDragonpit,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 1
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,SpecterUseDragonpitSmart,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 15
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,UseDragonpitVanitys,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 3
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,UseDragonpitStall,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 5
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,51531505,UseDragonpitDestiny,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(51531505)
	GlobalCardMode = 7
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,82633039,SpecterUseCastel,1322128625) then
    OPTSet(82633039)
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,62709239,SpecterUsePhantom) then
    GlobalCardMode = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,62709239,SpecterUsePhantom3) then
    GlobalCardMode = 5
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,62709239,SpecterUsePhantom2) then
     GlobalCardMode = 3
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,93568288,SpecterUseRhapsody,1497092609) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,93568288,SpecterUseRhapsody,1497092608) then
    GlobalCardMode = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,12014404,SpecterUseCowboyDef,nil,LOCATION_MZONE,POS_FACEUP_DEFENSE) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(SpSum,12014404,SpecterSummonCowboyDef) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,56832966,SpecterSummonUtopiaLightningFinish) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SpecterSummonUtopiaLightningFinish) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,31437713,SpecterSummonHeartlandFinish) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(Act,31437713,SpecterActivateHeartlandFinish) then
    OPTSet(31437713)
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,76473843,PlayMajesty,nil,LOCATION_HAND) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,76473843,ReplayMajesty,nil,LOCATION_SZONE,POS_FACEDOWN) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,13972452,UseSStorm6) then
	GlobalCardMode = 9
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,13972452,UseSStorm5) then
    GlobalCardMode = 7
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,13972452,UseSStorm4) then
    GlobalCardMode = 5
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,13972452,UseSStorm2) then
    GlobalCardMode = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,13972452,UseSStorm3) then
    GlobalCardMode = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,13972452,UseSStorm1) then
    GlobalCardMode = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,13972452,UseSStormDante) then
    GlobalCardMode = 3
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,76473843,UseMajestyLightning,nil,LOCATION_SZONE,POS_FACEUP) then
	GlobalCardMode = 2
	OPTSet(76473843)
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,76473843,UseMajesty,nil,LOCATION_SZONE,POS_FACEUP) then
    OPTSet(76473843)
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SetST,76473843,SetMajesty,nil,LOCATION_HAND) then
    return COMMAND_SET_ST,CurrentIndex
  end
--[[  if HasID(SetST,76473843,SetMajesty,nil,LOCATION_HAND) and MaleficTrashTalk then
    MaleficTrashTalk2 = true
    AITrashTalk("I really wanted to call this Destati.")
	AITrashTalk("Alas, that is now but a work of Malefiction.")
    return COMMAND_SET_ST,IndexByID(SetST,76473843)
  end
  if HasID(SetST,76473843,SetMajesty,nil,LOCATION_HAND) then
    MaleficTrashTalk = true
    AITrashTalk("I should be renamed to [AI]Maleficent!")
    return COMMAND_SET_ST,IndexByID(SetST,76473843)
  end]]
  
  if HasIDNotNegated(SpSum,56832966,SummonDoubleUtopiaLightning) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SummonDoubleUtopiaLightning) then
    AITrashTalk("Ready for enlightningment?")
    DoubleUtopiaActivated = true
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,56832966,SummonUtopiaLightningFalcon) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SummonUtopiaLightningFalcon) then
    return SpecterXYZSummon()
  end
  
  if HasIDNotNegated(SpSum,22653490,SpecterSummonChidori2) then
    return SpecterXYZSummon()
  end
  
  if HasIDNotNegated(SpSum,85252081,SpecterSummonGranpulse) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,85252081,SpecterSummonGranpulse2) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,85252081,SpecterSummonGranpulseASF) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,85252081,SpecterSummonGranpulseSpecterCounterCardST) then
    return SpecterXYZSummon()
  end
  --[[if HasIDNotNegated(SpSum,62709239,SpecterSummonPhantom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SpecterSummonPhantom2) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SpecterSummonPhantom3) then
    return SpecterXYZSummon()
  end]]
  if HasIDNotNegated(SpSum,85252081,SpecterSummonGranpulse3) then
    return SpecterXYZSummon()
  end
  
  if HasIDNotNegated(Act,72714461,UseInsight,nil,LOCATION_SZONE,nil) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasIDNotNegated(SpSum,82697249,SpecterSummonDane) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(Act,82697249,SpecterUseDane) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasID(Sum,31991800,SummonRaccoon5) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,68395509,SummonCrow4) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,94784213,SummonFox4) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,05506791,SummonCat4) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,00645794,SummonToad4) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,31991800,SummonRaccoon4) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,31991800,SummonRaccoon3) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,40318957,SpecterSummonJoker1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,94784213,SummonFox3) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,05506791,SummonCat3) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,68395509,SummonCrow3) then
    return COMMAND_SUMMON,CurrentIndex
  end

  if HasID(Sum,00645794,SummonToad3) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasIDNotNegated(SpSum,85252081,SpecterSummonGranpulseSmartRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SpecterKozmoSummonUtopiaLightningRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SpecterSummonUtopiaLightningRoom) then --I'm sure this won't be a problem in the slightest.
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterMiscSummonAbyssMP2Room) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterShadollSummonAbyssRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SummonUtopiaLightningFalconRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterBASummonAbyssRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,82633039,SpecterBASummonCastelRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,71068247,SummonTotemBirdRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,82633039,SpecterSummonCastelRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterMiscSummonAbyssMP1Room) then 
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,93568228,SpecterSummonRhapsodyRoom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,88722973,SpecterSummonMajesterRoom) then
    return SpecterXYZSummon()
  end
  
  for i=1,#SpSum do
    if PendulumCheck(SpSum[i]) and SpecterPendulumSummon() and WorthPendulumSummoning() then
      GlobalPendulumSummoningSpecter = true
      SpecterGlobalPendulum=Duel.GetTurnCount()
      return {COMMAND_SPECIAL_SUMMON,i}
    end
  end
  
  if HasID(Act,53208660,UsePendulumCallSpecter) then
    OPTSet(53208660)
	GlobalCardMode = 1
	return COMMAND_ACTIVATE,CurrentIndex
  end
  
  if HasID(Act,53208660,UsePendulumCallScaleReplaceSpecter) then
    OPTSet(53208660)
	GlobalCardMode = 1
    return COMMAND_ACTIVATE,CurrentIndex
  end
  
  --Pendulum activations
  if WorthPendulumActivation() then
    if HasID(Act,72714461,PlayInsight4,nil,LOCATION_HAND) then
	  return COMMAND_ACTIVATE,CurrentIndex
	elseif HasID(Act,51531505,PlayDragonpit2,nil,LOCATION_HAND) then
	  return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,72714461,PlayInsight3,nil,LOCATION_HAND) then
	  return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,72714461,PlayInsight1,nil,LOCATION_HAND) then
	  return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,51531505,PlayDragonpit,nil,LOCATION_HAND) then
      return COMMAND_ACTIVATE,CurrentIndex
	elseif HasID(Act,72714461,PlayInsight2,nil,LOCATION_HAND) then
	  return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,00645794,PlayToad,nil,LOCATION_HAND) then
      return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,68395509,PlayCrow,nil,LOCATION_HAND) then
      return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,31991800,PlayRaccoon,nil,LOCATION_HAND) then
      return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,15146890,PlayDragonpulse,nil,LOCATION_HAND) then
      return COMMAND_ACTIVATE,CurrentIndex
	elseif HasID(Act,14920218,PlayPeasant,nil,LOCATION_HAND) then
	  return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,05506791,PlayCat,nil,LOCATION_HAND) then
      return COMMAND_ACTIVATE,CurrentIndex
    elseif HasID(Act,94784213,PlayFox,nil,LOCATION_HAND) then
      return COMMAND_ACTIVATE,CurrentIndex
    end
  end
  
  if HasID(Sum,31991800,SummonRaccoon1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,40318957,SpecterSummonJoker1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,94784213,SummonFox1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,05506791,SummonCat1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,68395509,SummonCrow1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,00645794,SummonToad1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(Sum,40318957,SpecterSummonJoker2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,31991800,SummonRaccoon2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,94784213,SummonFox2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,05506791,SummonCat2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,68395509,SummonCrow2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,00645794,SummonToad2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,15146890,SummonDragonpulse) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,72714461,SummonInsight) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(SetMon,72714461,SetInsight) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  
  if HasIDNotNegated(SpSum,21044178,SpecterRaidraptorSummonAbyss) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,31437713,SpecterRaidraptorSummonHeartland) then
    AITrashTalk("Don't misunderstand my feelings due to all of this wisecrack; you are killing me right now.")
	return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,18326736,SpecterPtolemaeusSummon) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,22653490,SpecterBASummonChidori) then
--    AITrashTalk("This is the chi to victory!")
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,82633039,SpecterBASummonCastel) then
--    AITrashTalk("I will Castel you into the abyss!")
	return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterBASummonAbyss) then
    AITrashTalk("This Abyss will not be Burning for a while.")
	return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterBASummonAbyss2) then
    AITrashTalk("This Abyss will not be Burning for a while.")
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterMiscSummonAbyssMP2) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterStardustSummonAbyss) then
    AITrashTalk("Time to leave that monster in the Stardust.")
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,93568288,SpecterStardustSummonRhapsody) then
    AITrashTalk("Time to leave that monster in the Stardust.")
	return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,85252081,SpecterSummonGranpulseSmart) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterSummonAbyssArchetypesMP2) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterSummonAbyssArchetypesMP1) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,71068247,SummonTotemBird) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,56832966,SpecterKozmoSummonUtopiaLightning) then
    AITrashTalk("I see that your monsters are made up of Kozmolecules.")
	return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SpecterKozmoSummonUtopiaLightning) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,52558805,SpecterSummonTemtempo) then
    AITrashTalk("Now try to keep up with this Temtemporary summon!")
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,22653490,SpecterSummonChidori) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,82633039,SpecterSummonCastel) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,56832966) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,56832966,SpecterSummonUtopiaLightning) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SpecterSummonUtopiaLightning) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,56832966,SpecterSummonUtopiaLightningSmart) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SpecterSummonUtopiaLightningSmart) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SpecterSummonPhantom) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SpecterSummonPhantom2) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SpecterSummonPhantom3) then
    return SpecterXYZSummon()
  end
--[[  if HasIDNotNegated(SpSum,21044178,SpecterBlueSummonAbyss) then
    AITrashTalk("You're looking a little Blue-Eyes there. Want to talk about it?")
    AITrashTalk("Well, too bad. I'm the equivalent of talking to a Wall-E.")
    return SpecterXYZSummon()
  end]]
  if HasIDNotNegated(SpSum,21044178,SpecterShadollSummonAbyss) then
    AITrashTalk("I will send you to The Shadoll Realm.")
	return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SpecterMiscSummonAbyssMP1) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,88722973,SpecterSummonMajester1) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,88722973,SpecterSummonMajester2) then
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,93568288,SpecterSummonRhapsodyMP1) then
    AITrashTalk("I always enjoy a good Rhapsoda in the morning.")
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,93568288,SpecterSummonRhapsodyMP2) then
    AITrashTalk("I always enjoy a good Rhapsoda in the morning.")
    return SpecterXYZSummon()
  end
  if HasIDNotNegated(SpSum,31437713,SpecterSummonHeartland) then
    return SpecterXYZSummon()
  end
  
  if HasIDNotNegated(Rep,68395509,CrowChangeToDefence,nil,LOCATION_MZONE,POS_FACEUP_ATTACK) then
    return COMMAND_CHANGE_POS,CurrentIndex
  end
  if HasIDNotNegated(Rep,68395509,CrowChangeToAttack,nil,LOCATION_MZONE,POS_FACEUP_DEFENSE) then
    return COMMAND_CHANGE_POS,CurrentIndex
  end
  if HasIDNotNegated(Rep,88722973,MajesterChangeToDefence,nil,LOCATION_MZONE,POS_FACEUP_ATTACK) then
    return COMMAND_CHANGE_POS,CurrentIndex
  end
  if HasIDNotNegated(Rep,88722973,MajesterChangeToAttack,nil,LOCATION_MZONE,POS_FACEUP_DEFENSE) then
    return COMMAND_CHANGE_POS,CurrentIndex
  end
  if HasIDNotNegated(Rep,05506791,CatChangeToDefence,nil,LOCATION_MZONE,POS_FACEUP_ATTACK) then
    return COMMAND_CHANGE_POS,CurrentIndex
  end
  
  if HasID(SetST,53208660,SetPendulumCall) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,79816536,SpecterSetSummoners) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,43898403,SetTwinTwister) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,13972452,SetSStorm) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,49366157,SetSCyclone) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,36183881,SetSTornado) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,05650082,SetStormingMirror) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,05851097,SetVanity) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,02572890,SetSTempest) then
    return COMMAND_SET_ST,CurrentIndex
  end
  if HasID(SetST,78949372,SetSCell) then
    return COMMAND_SET_ST,CurrentIndex
  end
  
  if HasIDNotNegated(Act,31437713,SpecterRaidraptorActivateHeartland) and HeartlandTalk and not HeartlandTalk2 then
    HeartlandTalk2 = true
	OPTSet(31437713)
	AITrashTalk("Hey buddy, did you let this live just so you could hear another pun?")
	AITrashTalk("Alright, here's my last one: that card is Falcondescending.")
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,31437713,SpecterRaidraptorActivateHeartland) and not HeartlandTalk then
    HeartlandTalk = true
	OPTSet(31437713)
    AITrashTalk("If you keep this up, I will eventually run out of puns.")
	AITrashTalk("That wouldn't be good for the Falconomy, would it?")
	return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,31437713,SpecterActivateHeartland) then
    OPTSet(31437713)
    return COMMAND_ACTIVATE,CurrentIndex
  end
end

--You've gotta BE the targeting, Squidward!

function SpecterRhapsodyTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
	return BestTargets(cards) 
  elseif Duel.GetCurrentPhase() == PHASE_MAIN1 then
    return BestTargets(cards,1,PRIO_BANISH,SpecterRhapsodyMP1Filter)
  elseif Duel.GetCurrentPhase() == PHASE_MAIN2 then
    return BestTargets(cards,1,PRIO_BANISH,SpecterRhapsodyMP2Filter)
  end
 return BestTargets(cards)
end

function InsightfulMajestyTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return BestTargets(cards,1,PRIO_TOFIELD,InsightfulLevel3Filter)
  end
 return BestTargets(cards,1,PRIO_BANISH,InsightfulMajestyFilter)
end

function LightningMajestyTarget(cards)
 if LocCheck(cards,LOCATION_DECK) then
   if HasID(AIDeck(),94784213,true) and OPTCheck(94784213) then
     return FindID(94784213,cards,true)
   end
   if HasID(AIDeck(),00645794,true) and OPTCheck(00645794) then
     return FindID(00645794,cards,true)
   end
   if HasID(AIDeck(),68395509,true) and OPTCheck(68395509) then
     return FindID(68395509,cards,true)
   end
   return BestTargets(cards,1,PRIO_TOFIELD,LevelFourSpecterFilter)
 end   
 return BestTargets(cards,1,true,NotLV4WindFilter)
end

function MajestyTarget(cards)
  if GlobalCardMode == 2 then
    GlobalCardMode = nil
   return LightningMajestyTarget(cards)
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
   return InsightfulMajestyTarget(cards)
  end
  if LocCheck(cards,LOCATION_DECK) then
    if MajestyCrow() then
	  return FindID(68395509,cards,true)
	end
	if SpecterSummonGranpulseASF() and HasID(AIDeck(),31991800,true) and OPTCheck(31991800) then
	  return FindID(31991800,cards,true)
	end
	if SpecterSummonGranpulseASF() and HasID(AIDeck(),05506791,true) then
	  return FindID(05506791,cards,true)
	end
	if SpecterSummonGranpulseASF() and HasID(AIDeck(),31991800,true) then
	  return FindID(31991800,cards,true)
	end
	return Add(cards,PRIO_TOFIELD)
  end
 return Add(cards,PRIO_BANISH)
end

function SpecterPtolemaeusTarget(cards)
  if EndPhasePtolemaeus() then
   return FindID(09272381,cards,true)
  else
   return FindID(34945480,cards,true)
 end
end

function RaccoonTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return RaccoonAdd(cards,1)
  elseif RaccoonAddCrow() then
    return FindID(68395509,cards,true)
  else
   return Add(cards,PRIO_TOHAND)
  end
end

function CatTarget(cards)
  if (NeedsScale2() or NeedsScale5()) and HasID(AIDeck(),31991800,true) then
    return FindID(31991800,cards,true)
  elseif HasScales() and NeedsRaccoon() and HasID(AIDeck(),31991800,true) then
    return FindID(31991800,cards,true)
  elseif NeedsRaccoon() and HasID(AIDeck(),31991800,true) then
    return FindID(31991800,cards,true)
  elseif SpecterPriorityCheck(AIDeck(),PRIO_TOHAND,1,SpecterTrapPriorityFilter)>1
  and HasID(AIDeck(),94784213,true) then
    return FindID(94784213,cards,true)
  elseif ((NeedsSStormOverSCyclone() and HasID(AIDeck(),13972452,true)) or SpecterPriorityCheck(AIDeck(),PRIO_TOHAND,1,SpecterSpellPriorityFilter)>1)
  and HasID(AIDeck(),68395509,true) then
    return FindID(68395509,cards,true)
  elseif HasScales() then
    return BestTargets(cards,1,PRIO_TOHAND,SpecterMonsterFilter)
  else
    return BestTargets(cards,1,PRIO_TOHAND,SpecterMonsterFilter)
  end
end

function InsightTarget(cards)
  if HasID(AIST(),15146890,true) and not HasID(AIST(),51531505,true) and HasID(AIDeck(),51531505,true) then
    return FindID(51531505,cards,true)
  elseif HasID(AIST(),51531505,true) and not HasID(AIST(),15146890,true) and HasID(AIDeck(),15146890,true) then
    return FindID(15146890,cards,true)
  elseif HasID(AIST(),51531505,true) and not HasID(AIST(),14920218,true) and HasID(AIDeck(),14920218,true) then
    return FindID(14920218,cards,true)
  elseif HasID(AIST(),14920218,true) and not HasID(AIST(),51531505,true) and HasID(AIDeck(),14920218,true) then
    return FindID(51531505,cards,true)
  end
 return {math.random(#cards)}
end

function SCellTarget(cards,min,max)
  return Add(cards,PRIO_TOHAND,math.max(min,math.min(5,max)))
end

function SCycloneTarget(cards)
  if GlobalCardMode == 17 then
    GlobalCardMode = 16
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 16 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY) --SpecterCycloneFilter4
  elseif GlobalCardMode == 15 then
    GlobalCardMode = 14
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 14 then
    GlobalCardMode = nil
	return BestTargets(cards,1,true,SpecterCycloneFilter3)
  elseif GlobalCardMode == 13 then
    GlobalCardMode = 12
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 12 then
    GlobalCardMode = nil
	return FindID(83531441,cards,true)
  elseif GlobalCardMode == 11 then
    GlobalCardMode = 10
    return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 10 then
    GlobalCardMode = nil
	return FindID(97219708,cards,true)
  elseif GlobalCardMode == 9 then
    GlobalCardMode = 8
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 8 then
    GlobalCardMode = nil
	return FindID(70791313,cards,true)
  elseif GlobalCardMode == 7 then
    GlobalCardMode = 6
    return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 6 then
    GlobalCardMode = nil
    return BestTargets(cards,1,TARGET_DESTROY,SpecterCycloneFilter6)
  elseif GlobalCardMode == 5 then
     GlobalCardMode = 4
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 4 then
     GlobalCardMode = nil
	return FindID(50720316,cards,true)
  elseif GlobalCardMode == 3 then
     GlobalCardMode = 2
    return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 2 then
     GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,SpecterCycloneFilter2)
  elseif GlobalCardMode == 1 then
     GlobalCardMode = nil
	return BestTargets(cards,1,PRIO_BANISH)
  else
    return BestTargets(cards,1,TARGET_DESTROY,SpecterCycloneFilter)
  end
end

function STornadoTarget(cards)
  if GlobalCardMode == 17 then
    GlobalCardMode = 16
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 16 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_BANISH) --SpecterTornadoFilter4
  elseif GlobalCardMode == 15 then
    GlobalCardMode = 14
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 14 then
    GlobalCardMode = nil
	return BestTargets(cards,1,true,SpecterTornadoFilter3)
  elseif GlobalCardMode == 13 then
    GlobalCardMode = 12
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 12 then
    GlobalCardMode = nil
	return FindID(83531441,cards,true)
  elseif GlobalCardMode == 11 then
    GlobalCardMode = 10
    return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 10 then
    GlobalCardMode = nil
	return FindID(97219708,cards,true)
  elseif GlobalCardMode == 9 then
    GlobalCardMode = 8
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 8 then
    GlobalCardMode = nil
	return FindID(70791313,cards,true)
  elseif GlobalCardMode == 7 then
    GlobalCardMode = 6
    return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 6 then
    GlobalCardMode = nil
    return BestTargets(cards,1,TARGET_BANISH,SpecterTornadoFilter6)
  elseif GlobalCardMode == 5 then
     GlobalCardMode = 4
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 4 then
     GlobalCardMode = nil
	return FindID(50720316,cards,true)
  elseif GlobalCardMode == 3 then
     GlobalCardMode = 2
    return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 2 then
     GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_BANISH,SpecterTornadoFilter2)
  elseif GlobalCardMode == 1 then
     GlobalCardMode = nil
	return BestTargets(cards,1,PRIO_BANISH)
  else
    return BestTargets(cards,1,TARGET_BANISH,SpecterTornadoFilter)
  end
end

function SStormTarget(cards)
  if GlobalCardMode == 9 then
    GlobalCardMode = 8
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 8 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_TODECK) --SStormFilter6
  elseif GlobalCardMode == 7 then
    GlobalCardMode = 6
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 6 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_TODECK,SStormFilter5)
  elseif GlobalCardMode == 5 then
    GlobalCardMode = 4
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 4 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_TODECK,SStormFilter4)
  elseif GlobalCardMode == 3 then
    GlobalCardMode = 2
	return BestTargets(cards,1,PRIO_BANISH)
  elseif GlobalCardMode == 2 then
    GlobalCardMode = nil
    return FindID(83531443,cards,true)
  elseif GlobalCardMode == 1 then
     GlobalCardMode = nil
	return BestTargets(cards,1,PRIO_BANISH)
  end
 return BestTargets(cards,1,TARGET_TODECK)
end

function SpecterTemtempoTarget(cards)
  if GlobalCardMode == 10 then
     GlobalCardMode = 9
	return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 9 then
     GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_OTHER)
  elseif GlobalCardMode == 8 then
     GlobalCardMode = 7
	return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 7 then
     GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_OTHER,SpecterTemtempoFilter4)
  elseif GlobalCardMode == 6 then
     GlobalCardMode = 5
	return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 5 then
     GlobalCardMode = nil
    return BestTargets(cards,1,TARGET_OTHER,SpecterTemtempoFilter3)
  elseif GlobalCardMode == 4 then
     GlobalCardMode = 3
	return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 3 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_OTHER,SpecterTemtempoFilter2)
  elseif GlobalCardMode == 2 then
     GlobalCardMode = 1
	return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 1 then
     GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_OTHER,SpecterTemtempoFilter1)
  end
 return BestTargets(cards,1,TARGET_TOGRAVE)
end

function SpecterPhantomTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 7 then
    GlobalCardMode = 6
    return BestTargets(cards,1,PRIO_BANISH,InsightfulPhantomAllyFilter)
  elseif GlobalCardMode == 6 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,InsightfulPhantomEnemyFilter)
  elseif GlobalCardMode == 5 then
    GlobalCardMode = 4
	return BestTargets(cards,1,PRIO_BANISH,AllyPhantomFilter3)
  elseif GlobalCardMode == 4 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,SpecterPhantomFilter2)
  elseif GlobalCardMode == 3 then
    GlobalCardMode = 2
	return BestTargets(cards,1,PRIO_BANISH,AllyPhantomFilter2)
  elseif GlobalCardMode == 2 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,SpecterPhantomFilter2)
  elseif GlobalCardMode == 1 then
     GlobalCardMode = nil
	return BestTargets(cards,1,PRIO_BANISH,AllyPhantomFilter)
  else
    return BestTargets(cards,1,TARGET_DESTROY,SpecterPhantomFilter)
  end
end

function SpecterMajesterTarget(cards)
  if MajesterAddInsight() then
    return FindID(72714461,cards,true)
  elseif NeedsRaccoon() or (NeedsScale5() and not NeedsScale2()) or (NeedsScale2() and not NeedsScale5()) then
    return FindID(31991800,cards,true)
  elseif NeedsSStormOverSCyclone() and HasID(AIDeck(),68395509,true) and not HasID(AIST(),36183881,true) then
    return FindID(68395509,cards,true)
  elseif NeedsFox() then
    return FindID(94784213,cards,true)
  elseif MajesterAddPeasant() then
    return FindID(14920218,cards,true)
  else
    return BestTargets(cards,1,PRIO_BANISH,SpecterMonsterFilter)
  end
end
  

function SpecterGranpulseTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  elseif EnemyHasSpecterCounterCardST() then
    return BestTargets(cards,1,TARGET_DESTROY,EnemyHasSpecterCounterCardSTFilter)
  elseif CardsMatchingFilter(OppST(),SpecterMonsterVersusOppSTSmartFilter)>0 then
    return BestTargets(cards,1,TARGET_DESTROY,SpecterMonsterVersusOppSTSmartFilter)
  elseif EnemyHasSkillDrain() then
    return BestTargets(cards,1,TARGET_DESTROY,EnemyHasSkillDrainFilter)
  elseif SpecterGranpulseTargetASF() then
    return BestTargets(cards,1,TARGET_DESTROY,EnemyASF)
  elseif CardsMatchingFilter(OppST(),OppDownBackrowFilter)>0 and Duel.GetTurnCount() ~= SpecterGlobalPendulum and HasScales() then
    return BestTargets(cards,1,TARGET_DESTROY,OppDownBackrowFilter)
  elseif CardsMatchingFilter(OppST(),SpecterGranpulseFilter)>0 and Duel.GetTurnCount() == SpecterGlobalPendulum and OppHasScales() then
    return BestTargets(cards,1,TARGET_DESTROY,SpecterGranpulseFilter)
  elseif EnemyHasDestinyBoard() then
    return BestTargets(cards,1,TARGET_DESTROY,EnemyHasDestinyBoardFilter)
  elseif EnemyHasStall() then
    return BestTargets(cards,1,TARGET_DESTROY,EnemyHasStallFilter)
  elseif CardsMatchingFilter(OppST(),OppBackrowFilter)>0 and Duel.GetTurnCount() == SpecterGlobalPendulum then
    return BestTargets(cards,1,TARGET_DESTROY,OppBackrowFilter)
  end
 return BestTargets(cards,1,TARGET_DESTROY)
end

function SpecterDragonpitTarget(cards)
  if GlobalCardMode == 15 then
    GlobalCardMode = 14
	return DragonpitDiscardLogic(cards)
  elseif GlobalCardMode == 14 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,SpecterSpellVersusOppSTSmartFilter)
  elseif GlobalCardMode == 13 then
    GlobalCardMode = 12
	return DragonpitDiscardLogic(cards)
  elseif GlobalCardMode == 12 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,EnemyHasSpecterCounterCardSTFilter)
  elseif GlobalCardMode == 11 then
    GlobalCardMode = 10
	return DragonpitDiscardLogic(cards)
  elseif GlobalCardMode == 10 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,EnemyASF)
  elseif GlobalCardMode == 9 then
    GlobalCardMode = 8
	return DragonpitDiscardLogic(cards)
  elseif GlobalCardMode == 8 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,EnemyHasSkillDrainFilter)
  elseif GlobalCardMode == 7 then
    GlobalCardMode = 6
	return DragonpitDiscardLogic(cards)
  elseif GlobalCardMode == 6 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,EnemyHasDestinyBoardFilter)
  elseif GlobalCardMode == 5 then
    GlobalCardMode = 4
	return DragonpitDiscardLogic(cards)
  elseif GlobalCardMode == 4 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_DESTROY,EnemyHasStallFilter)
  elseif GlobalCardMode == 3 then
    GlobalCardMode = 2
   return DragonpitDiscardLogic(cards)
  elseif GlobalCardMode == 2 then
    GlobalCardMode = nil
   return BestTargets(cards,1,TARGET_DESTROY,DragonpitVanitysTargetFilter)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
   return DragonpitDiscardLogic(cards)
  end
 return BestTargets(cards,1,TARGET_DESTROY,OppDownBackrowFilter)
end

function DragonpitDiscardLogic(cards)
  if CardsMatchingFilter(AIHand(),MagicianPendulumFilter)>0 then
    return Add(cards,PRIO_TOGRAVE)
  elseif HasID(AIHand(),00645794,true) then
    return BestTargets(cards,1,true,function(c) return c.id==00645794 end)
  elseif HasID(AIHand(),05506791,true) then
    return BestTargets(cards,1,true,function(c) return c.id==05506791 end)
  elseif HasID(AIHand(),68395509,true) then
    return BestTargets(cards,1,true,function(c) return c.id==68395509 end)
  else
    return Add(cards,PRIO_TOGRAVE)
  end
end


function FoxTarget(cards) --Fox just really wants to give a targeting error. What better solution than to force targets?
  if EnableKozmoFunctions() and HasID(AIDeck(),02572890,true) then
    return FindID(02572890,cards,true)
--[[  elseif not HasSTempest() then
    return FindID(02572890,cards,true)
  elseif not HasSTornado() then
    return FindID(36183881,cards,true)
  elseif not HasSCell() then
    return FindID(78949372,cards,true)]]
  elseif SpecterPriorityCheck(AIDeck(),PRIO_TOHAND,1,SpecterTrapPriorityFilter)>1 then
    return Add(cards,PRIO_TOHAND)
  end
 return {math.random(#cards)}
end

function CrowTarget(cards)
  if NeedsSStormOverSCyclone() then
    return FindID(13972452,cards,true)
  elseif SpecterPriorityCheck(AIDeck(),PRIO_TOHAND,1,SpecterSpellPriorityFilter)>1 then
    return Add(cards,PRIO_TOHAND)
  end
 return {math.random(#cards)}
end

function ToadTarget(cards)
  if EnableKozmoFunctions() and HasID(AIDeck(),02572890,true) then
    return FindID(02572890,cards,true)
  elseif EnemyHasTimeRafflesia() and HasID(AIDeck(),49366157,true) and not UsableSStorm() and not HasID(AIHand(),12580477,true) then
    return FindID(49366157,cards,true)
  elseif EnemyHasTimeRafflesia() and HasID(AIDeck(),13972452,true) and not UsableSCyclone() and not HasID(AIHand(),12580477,true) then
    return FindID(13972452,cards,true)
--[[  elseif not HasSTempest() then
    return FindID(02572890,cards,true)
  elseif not HasSTornado() then
    return FindID(36183881,cards,true)
  elseif not HasSCell() then
    return FindID(78949372,cards,true)]]
  elseif SpecterPriorityCheck(AIDeck(),PRIO_TOFIELD,1,SpecterTrapPriorityFilter)>1 then
    return Add(cards,PRIO_TOFIELD)
  elseif SpecterPriorityCheck(AIDeck(),PRIO_TOFIELD,1,SpecterSpellPriorityFilter)>1 then
    return Add(cards,PRIO_TOFIELD)
  end
 return {math.random(#cards)}
end

function SpecterChidoriTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
	return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
	return BestTargets(cards,1,TARGET_TODECK,SpecterChidoriFilter2)
  elseif CardsMatchingFilter(OppST(),OppDownBackrowFilter)>0 then
    return BestTargets(cards,1,TARGET_TODECK,OppDownBackrowFilter)
  end
 return BestTargets(cards,1,TARGET_TODECK,SpecterChidoriFilter1)
end

function SpecterCastelTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,math.max(min,math.min(2,max)))
  end
 return BestTargets(cards,1,TARGET_TODECK,SpecterCastelFilter)
end

function SpecterCallToGravePriority(card) --Choose which card is best for Pendulum Call's discard effect.
  local id=card.id
  if id==53208660 then --Pendulum Call duplicate
    return 13
  end
  if id==76473843 and MajestyDiscardAvailable() then --Field Spell duplicate
    return 14
  end
  if id==51531505 then --Dragonpit 8
    return 12
  end
  if id==15146890 then --Dragonpulse 1
    return 8
  end
  if id==14920218 then --Peasant 2
    return 6
  end
  if id==13972452 then --Specter Storm
    return 10
  end
  if id==19665973 then --Fader
    return 7
  end
  if id==02572890 then --Tempest
    return 5
  end
  if id==36183881 then --Tornado
    return 9
  end
  if id==49366157 then --SCyclone
    return 11
  end
  if id==72714461 then --Insight
    return 8
  end
  if id==40318957 then --Joker
    return 4
  end
  if id==68395509 then --Crow
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==68395509 end)>1 then
	  return 4
	else
	  return 3
	end
  end
  if id==00645794 then --Crow
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==00645794 end)>1 then
	  return 4
	else
	  return 2
	end
  end
  if id==05506791 then --Crow
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==05506791 end)>1 then
	  return 4
	else
	  return 1
	end
  end
 return GetPriority(card,PRIO_TOGRAVE)
end
  
function SpecterCallDiscardAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_GRAVE then
    func = SpecterCallToGravePriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end

function SpecterCallDiscardToGrave(cards,amount) --Discard for Pendulum Call
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  SpecterCallDiscardAssignPriority(cards,LOCATION_GRAVE)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  if result == nil then result = Add(cards,PRIO_TOGRAVE) end
  return result
end

function SpecterPendulumCallTarget(cards) --Xaddgx
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return SpecterCallDiscardToGrave(cards,1)
  else
   return Add(cards,PRIO_TOHAND)
  end
end

function RaccoonAddPriority(card) --Choose which card is best for Raccoon's add effect.
  local id=card.id
  if NeedsScale5() then
    if id==00645794 then --Toad
      return 10
    elseif id==68395509 then --Crow
	  return 9
	elseif id==31991800 then --Raccoon
	  return 8
	end
  end
  if NeedsScale2() then
    if id==05506791 then --Cat
	  return 10
	elseif id==94784213 then --Fox
	  return 9
	end
  end
 return GetPriority(card,PRIO_TOHAND)
end
  
function RaccoonAddAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_HAND then
    func = RaccoonAddPriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end

function RaccoonAdd(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  RaccoonAddAssignPriority(cards,LOCATION_HAND)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end

function InsightMagicianPriority(card) --Choose which card is best for Insight's effect.
  local id=card.id
  if id==51531505 then 
    if (HasID(AIST(),15146890,true) or HasID(AIST(),14920218,true)) then
    return 10
   else
    return 2
	end
  end
  if id==15146890 then
    if HasID(AIST(),51531505,true) then
    return 8
   else
    return 3
	end
  end
  if id==14920218 then
    if HasID(AIST(),51531505,true) then
	return 9
   else
    return 4
   end
 end
 return GetPriority(card,PRIO_TOGRAVE)
end
  
function InsightMagicianAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_GRAVE then
    func = InsightMagicianPriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end

function InsightMagicianTargeting(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  InsightMagicianPriority(cards,LOCATION_GRAVE)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end

function SpecterPeasantTargeting(cards)
  if GlobalCardMode == 2 then
    GlobalCardMode = nil
	return SpecterPeasantTargetGrave(cards)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
	return SpecterPeasantTargetExtra(cards)
  end
 return Add(cards,PRIO_TOHAND)
end
	

function SpecterPeasantTargetGrave(cards) --Applies to both effects
  if HasID(AIGrave(),72714461,true) and Duel.GetTurnCount() == SpecterGlobalPendulum then
    return FindID(72714461,cards,true)
  elseif HasID(AIGrave(),51531505,true) and OPTCheck(51531505) and HasID(AIST(),51531505,true) then
    return FindID(51531505,cards,true)
  elseif HasID(AIGrave(),15146890,true) then
    return FindID(15146890,cards,true)
  end
 return Add(cards,PRIO_TOHAND)
end

function SpecterPeasantTargetExtra(cards)
  if HasID(AIExtra(),72714461,true) and Duel.GetTurnCount() == SpecterGlobalPendulum then
    return FindID(72714461,cards,true)
  elseif HasID(AIExtra(),51531505,true) and OPTCheck(51531505) and HasID(AIST(),51531505,true) then
    return FindID(51531505,cards,true)
  elseif HasID(AIExtra(),15146890,true) then
    return FindID(15146890,cards,true)
  end
 return Add(cards,PRIO_TOHAND)
end

function SpecterJokerTarget(cards) --Choose which target is best for Joker's effect.
  if MajesterAddInsight() then
    return FindID(72714461,cards,true)
  elseif SpecterJokerAddInsight() then
    return FindID(72714461,cards,true)
  elseif NeedsScale5() then
    return FindID(51531505,cards,true)
  elseif NeedsScale2() then
	return FindID(14920218,cards,true)
  elseif CardsMatchingFilter(AIST(),ScaleHighFilter)==0 and not NeedsScale2() and not NeedsScale5() then
    return FindID(51531505,cards,true)
  end
 return Add(cards,PRIO_TOHAND)
end

function SpecterMiscToGravePriority(card) --Choose which card is best for Pendulum Call's discard effect.
  local id=card.id
  if id==53208660 then --Pendulum Call
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==53208660 end)>1 then
	  return 13
	elseif HasScales() then
	  return 8
	else
	  return 0
	end
  end
  if id==76473843 then 
    if MajestyDiscardAvailable() then
      return 14
	else
	  return 3
	end
  end
  if id==51531505 then --Dragonpit 8
    return 12
  end
  if id==15146890 then --Dragonpulse 1
    return 8
  end
  if id==14920218 then --Peasant 2
    return 6
  end
  if id==13972452 then --Specter Storm
    return 10
  end
  if id==19665973 then --Fader
    return 7
  end
  if id==02572890 then --Tempest
    return 5
  end
  if id==36183881 then --Tornado
    return 9
  end
  if id==49366157 then --SCyclone
    return 11
  end
  if id==72714461 then --Insight
    return 8
  end
  if id==40318957 then --Joker
    return 4
  end
  if id==05650082 then --Storming Mirror
    return 3
  end
  if id==05851097 then --Vanity's
    return 1
  end
  if id==68395509 then --Crow
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==68395509 end)>1 then
	  return 4
	else
	  return 3
	end
  end
  if id==00645794 then --Toad
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==00645794 end)>1 then
	  return 4
	else
	  return 2
	end
  end
  if id==05506791 then --Cat
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==05506791 end)>1 then
	  return 4
	else
	  return 1
	end
  end
  if id==94784213 then --Fox
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==94784213 end)>1 then
	  return 4
	else
	  return 1
	end
  end
  if id==05506791 then --Raccoon
    if CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),function(c) return c.id==31991800 end)>1 then
	  return 4
	else
	  return 0
	end
  end
 return GetPriority(card,PRIO_TOGRAVE)
end
  
function SpecterMiscDiscardAssignPriority(cards,toLocation)
  local func = SpecterMiscToGravePriority
--[[  if toLocation==LOCATION_HAND then
    func = SpecterMiscToGravePriority
  end]]
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end

function SpecterMiscDiscardToGrave(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  SpecterMiscDiscardAssignPriority(cards,LOCATION_HAND)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  if result == nil then result = Add(cards,PRIO_TOGRAVE) end
  return result
end

function SpecterMiscDiscardTarget(cards)
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and (e:GetHandler():GetCode()==74519184 or e:GetHandler():GetCode()==69402394) then
      return SpecterMiscDiscardToGrave(cards,2)
	end
  end
 return SpecterMiscDiscardToGrave(cards,1)
end

function SpecterCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard)
  if GlobalPendulumSummoningSpecter and Duel.GetCurrentChain()==0 then
	GlobalPendulumSummoningSpecter = nil
	local x = CardsMatchingFilter(cards,NotJokerMonsterFilter)
	if (CardsMatchingFilter(OppMon(),EnemySummonNegatorMonFilter)>0 and not UsableSTempest()) or EnemyHasTimeRafflesia() then
	AITrashTalk("Hmm...")
	x = math.min(x,1)
	  if PendulumRaccoon() then
	    return FindID(31991800,cards,true)
	  elseif PendulumCrow() then
	    return FindID(68395509,cards,true)
	  elseif PendulumFox() then
	    return FindID(94784213,cards,true)
	  elseif PendulumToad() then 
	    return FindID(00645794,cards,true)
	  elseif PendulumCat() then
	    return FindID(05506791,cards,true)
	  elseif PendulumPeasant() then
	    return FindID(14920218,cards,true)
	  else
	    return Add(cards,PRIO_TOFIELD,x)
	  end
	end
	if not HasID(AIHand(),40318957,true) then
	  local x = CardsMatchingFilter(cards,AllMonsterFilter)
	end
	x = math.min(x,max)
	return Add(cards,PRIO_TOFIELD,x)
  end
  if id == 31991800 then --Raccoon
    return RaccoonTarget(cards)
  end
  if id == 94784213 then --Fox
    return FoxTarget(cards)
  end
  if id == 18326736 then --Ptolemaeus
    return SpecterPtolemaeusTarget(cards)
  end
  if GlobalPaladinOverride and AI.GetCurrentPhase() == PHASE_END then --Majester Paladin
     GlobalPaladinOverride = nil
    return SpecterMajesterTarget(cards)
  end
  if GlobalCatOverride and AI.GetCurrentPhase() == PHASE_END and not OPTCheck(05506791) then --Cat
    GlobalCatOverride = nil
    return CatTarget(cards)
  end
  if id == 76473843 then --Field Spell
    return MajestyTarget(cards)
  end
  if id == 53208660 then --Pendulum Call
    return SpecterPendulumCallTarget(cards)
  end
  if id == 72714461 then --Insight
    return InsightTarget(cards)
  end
  if id == 02572890 then --Specter Tempest
    return Add(cards,PRIO_BANISH)
  end
  if id == 78949372 then --Specter Supercell
    return SCellTarget(cards,min,max)
  end
  if id == 85252081 then --Granpulse
    return SpecterGranpulseTarget(cards)
  end
  if id == 00645794 then --Toad
    return ToadTarget(cards)
  end
  if id == 68395509 then --Crow
    return CrowTarget(cards)
  end
  if id == 62709239 then --Phantom Knights XYZ
    return SpecterPhantomTarget(cards)
  end
  if id == 36183881 then --Specter Tornado
    return STornadoTarget(cards)
  end
  if id == 49366157 then --Specter Cyclone
    return SCycloneTarget(cards)
  end
  if id == 52558805 then --Temtempo
    return SpecterTemtempoTarget(cards)
  end
  if id == 13972452 then --Specter Storm
    return SStormTarget(cards)
  end
  if id == 51531505 then --Dragonpit
    return SpecterDragonpitTarget(cards)
  end
  if id == 14920218 then --Peasant
    return SpecterPeasantTargeting(cards)
  end
  if id == 93568288 then --Number 80: Rhapsody in Berserk
    return SpecterRhapsodyTarget(cards)
  end
  if id == 40318957 then --Joker
    return SpecterJokerTarget(cards)
  end
  if id == 22653490 then --Chidori
    return SpecterChidoriTarget(cards)
  end
  if id == 82633039 then --Castel
    return SpecterCastelTarget(cards,min,max)
  end
  if SpecterGlobalMaterial then
     SpecterGlobalMaterial = nil
    return SpecterOnSelectMaterial(cards,min,max)
  end
--[[  if Duel.GetCurrentPhase() == PHASE_END then
    for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
      if Duel.GetOperationInfo(i,CATEGORY_SEARCH) then
	    if not OPTCheck(88722973) then
	      return SpecterMajesterTarget(cards)
	    elseif not OPTCheck(05506791) then
	      return CatTarget(cards)
	    end
	  end
	end
  end]]
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if (Duel.GetOperationInfo(i,CATEGORY_TOGRAVE)
    or Duel.GetOperationInfo(i,CATEGORY_HANDES)
	or Duel.GetOperationInfo(i,CATEGORY_DRAW)) 
	and e:GetHandlerPlayer()==1-player_ai then
	  return SpecterMiscDiscardTarget(cards)
	end
  end
  return nil
end

SpecterAtt={
15146890,
94784213,
00645794,
31991800,
34945480,
16195942,
84013237,
56832966,
31437713,
62709239,
71068247,
52558805,
21044178,
14920218,
40318957,
}
--Dragonpulse, Fox, Toad
--Raccoon, Azathoth, Rebellion XYZ
--Utopia, Utopia Lightning, Heartlanddraco
--Phantom XYZ, Totem Bird, Temtempo, Abyss Dweller,
--Peasant, Joker
SpecterDef={
51531505,
05506791,
19665973,
18326736,
85252081,
93568288,
12014404,
}
--Dragonpit, Cat, Fader,
--Ptolemaeus, Granpulse, Rhapsody,
--Cowboy
function SpecterPosition(id,available)
  local result
  for i=1,#SpecterAtt do
    if SpecterAtt[i]==id
    then
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#SpecterDef do
    if SpecterDef[i]==id
    then
      result=POS_FACEUP_DEFENSE
    end
  end
  if id == 68395509 then
    if CrowAttack() then
	  result=POS_FACEUP_ATTACK
	else
	  result=POS_FACEUP_DEFENSE
	end
  end
  if id == 88722973 then
    if MajesterAttack() then
	  result=POS_FACEUP_ATTACK
	else
	  result=POS_FACEUP_DEFENSE
	end
  end
 return result
end

function UseRaccoon()
  return OPTCheck(31991800)
end

function UseFox()
  return OPTCheck(94784213)
end

function UseCrow()
  return OPTCheck(68395509)
end

function UseCat()
  return OPTCheck(05506791)
end

function UseToad()
  return OPTCheck(00645794)
end

function UseMajester()
  return true
end

function UsePeasantMon()
  return true
end

function UseJoker()
  return true
end

function SpecterEffectYesNo(id,card)
  local result
  if id == 31991800 and (NeedsScale5() or NeedsScale2()) and not HasID(AIHand(),53208660,true) then --Add based on the last needed Pendulum Scale
    OPTSet(31991800)
	GlobalCardMode = 1
	result = 1
  end
  if id == 31991800 and UseRaccoon() then --Add based on priority
    OPTSet(31991800)
    result = 1
  end
  if id == 68395509 and UseCrow() then
    OPTSet(68395509)
    result = 1
  end
  if id == 94784213 and UseFox() then
    OPTSet(94784213)
    result = 1
  end
  if id == 00645794 and UseToad() then
    OPTSet(00645794)
    result = 1
  end
  if id == 05506791 and UseCat() then
    OPTSet(05506791)
	GlobalCatOverride = true
    result = 1
  end
  if id == 78949372 then --Specter Supercell
    result = 1
  end
  if id == 14920218 and UsePeasantMon() then --Peasant
    GlobalCardMode = 2
    result = 1
  end
  if id == 88722973 then --Majester Paladin
    OPTSet(88722973)
    GlobalPaladinOverride = true
    result = 1
  end
  if id == 40318957 and UseJoker() then --Joker
    OPTSet(40318957)
    result = 1
  end
 return result
end

function SpecterChain(cards)
  if HasIDNotNegated(cards,18326736,EndPhasePtolemaeus) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,18326736,PtolemaeusAzathoth) then --Summon Azathoth on opponent's turn
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,78949372,UseSCell) then --Specter Supercell
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,02572890,SpecterChainNegationTempest) and not TasukeOpponentCheck() then --Specter Tempest
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,02572890,ChainTempestLastStrix) then --Versus Raidraptors
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,02572890,ChainTempestKozmo) then --Versus Kozmos
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,02572890,ChainTempestRafflesia) then --Versus Traptrix Rafflesia
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,71068247,SpecterChainNegationTempest) then --Totem Bird
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,05650082,ChainStormingMirror) then --Storming Mirror Force
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,56832966,SpecterChainUtopiaLightning) then --Utopia Lightning
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSpecterCyclone8) then --Versus monsters that cannot be killed through battle
    GlobalCardMode = 1
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSpecterTornado8) then --Versus monsters that cannot be killed through battle
    GlobalCardMode = 1
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSpecterCyclone7) then --Versus useless monsters
	GlobalCardMode = 17
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSpecterTornado7) then --Versus useless monsters
	GlobalCardMode = 17
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSpecterCyclone6) then --Versus unaffected attackers
	GlobalCardMode = 17
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSpecterTornado6) then --Versus unaffected attackers
	GlobalCardMode = 17
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSpecterCyclone5) then --Versus Summon negators
    GlobalCardMode = 15
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSpecterTornado5) then --Versus Summon negators
    GlobalCardMode = 15
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,02572890,ChainSTempestBA) then --Versus Burning Abyss
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSTornadoDante) then --Versus Burning Abyss
    GlobalCardMode = 13
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSCycloneDante) then --Versus Burning Abyss
    GlobalCardMode = 13
--	GlobalMurderDante = true
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSCycloneLastStrix) then --Versus Raidraptors
	GlobalCardMode = 11
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSTornadoLastStrix) then --Versus Raidraptors
	GlobalCardMode = 11
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSCycloneLibrary) and GlobalExodiaTrashTalked then --Reading rainbow
	AITrashTalk("In life, learning from your mistakes will go a long way. Have you learned yet?")
	GlobalCardMode = 9
   return {1,IndexByID(cards,49366157)}
  end
  if HasIDNotNegated(cards,36183881,ChainSTornadoLibrary) and GlobalExodiaTrashTalked then --Reading rainbow
	AITrashTalk("In life, learning from your mistakes will go a long way. Have you learned yet?")
	GlobalCardMode = 9
   return {1,IndexByID(cards,36183881)}
  end
  if HasIDNotNegated(cards,49366157,ChainSCycloneLibrary) and not GlobalExodiaTrashTalked then --Reading rainbow
    GlobalExodiaTrashTalk = true
	AITrashTalk("Exodiuhhh...")
	GlobalCardMode = 9
   return {1,IndexByID(cards,49366157)}
  end
  if HasIDNotNegated(cards,36183881,ChainSTornadoLibrary) and not GlobalExodiaTrashTalked then --Reading rainbow
    GlobalExodiaTrashTalk = true
	AITrashTalk("Exodiuhhh...")
	GlobalCardMode = 9
   return {1,IndexByID(cards,36183881)}
  end
  if HasIDNotNegated(cards,36183881,TornadoShadowMist) and GlobalHeroTrashTalk then --End Phase, HERO trash talk.
    GlobalHeroTrashTalk = nil
	GlobalCardMode = 5
	AITrashTalk("My favorite Harry Potter character was HERO-N WEASLEY.")
	return {1,IndexByID(cards,36183881)}
  end
  if HasIDNotNegated(cards,49366157,CycloneShadowMist) and GlobalHeroTrashTalk then --End Phase, HERO trash talk.
    GlobalHeroTrashTalk = nil
	GlobalCardMode = 5
	AITrashTalk("My favorite Harry Potter character was HERO-N WEASLEY.")
	return {1,IndexByID(cards,49366157)}
  end
  if HasIDNotNegated(cards,36183881,ChainSpecterTornado2) then --Specter Tornado
	GlobalCardMode = 3
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSpecterTornado) or HasIDNotNegated(cards,36183881,ChainSpecterTornado3) then --Specter Tornado
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSpecterCyclone2) then --Specter Cyclone
	GlobalCardMode = 3
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSpecterCyclone) or HasIDNotNegated(cards,36183881,ChainSpecterCyclone3) then --Specter Cyclone
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,49366157,ChainSpecterCyclone4) then --Specter Cyclone
    GlobalCardMode = 7
   return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,36183881,ChainSpecterTornado4) then --Specter Tornado
    GlobalCardMode = 7
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,21044178,ChainSpecterAbyss) then --Abyss Dweller
    OPTSet(21044178)
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,02572890,ChainTempestLibrary) and GlobalExodiaTrashTalked then
    AITrashTalk("In life, learning from your mistakes will go a long way. Have you learned yet?")
	return {1,IndexByID(cards,02572890)}
  end
  if HasIDNotNegated(cards,02572890,ChainTempestLibrary) and not GlobalExodiaTrashTalked then
    GlobalExodiaTrashTalk = true
    AITrashTalk("Exodiuhhh...")
	return {1,IndexByID(cards,02572890)}
  end
  if SpecterHeroTrashTalk() then
    GlobalHeroTrashTalk = true
--	AITrashTalk("Do you really see nothing wrong with what you just did?")
--  AITrashTalk("...Sure.")
    AITrashTalk("You must have some intense plan lined up for me.")
  end
  if HasIDNotNegated(cards,02572890) and DetectShadowMist() and GlobalHeroTrashTalk then
    GlobalHeroTrashTalk = nil
	AITrashTalk("My favorite Harry Potter character was HERO-N WEASLEY.")
	return {1,CurrentIndex}
  end
  if GlobalHeroTrashTalk and Duel.GetTurnCount() == 3 then
     GlobalHeroTrashTalk = nil
     AITrashTalk("My favorite Harry Potter character was HERO-N WEASLEY.")
  end
  if GlobalExodiaTrashTalk and LibraryRemoved() and not GlobalExodiaTrashTalked then
     GlobalExodiaTrashTalk = nil
	 GlobalExodiaTrashTalked = true
	 AITrashTalk("Don't worry, you can just surrender and try Exodia Library again.")
	 AITrashTalk("Not like I'll remember that you've done this before, anyways.")
  end
  if #OppDeck()<=10 and not GlobalExodiaLoss and HasID(OppMon(),70791313,true) then
    GlobalExodiaLoss = true
    AITrashTalk("I always knew you librarians were evil.")
  end
  if HasIDNotNegated(cards,52558805,SpecterChainTemtempo1) then --Temtempo 1, chain to single materials.
     GlobalCardMode = 2
	 AITrashTalk("Take a vote on whether or not you like this on a Temtempoll.")
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,52558805,SpecterChainTemtempo2) then --Temtempo 2, chain to double materials.
     GlobalCardMode = 4
	 AITrashTalk("Take a vote on whether or not you like this on a Temtempoll.")
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,52558805,SpecterChainTemtempo3) then --Temtempo 3, chain on opponent's turn to double materials.
     GlobalCardMode = 6
	 AITrashTalk("Look buddy, there's not a lot of puns I can make out of Temtempo.")
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,52558805,SpecterChainTemtempo4) then --Temtempo 4, chain on opponent's turn to triple materials (only Utopia Lightning currently)
     GlobalCardMode = 8
	 AITrashTalk("Utopia Lightning? Then check out this ELECTRIFYING maneuver!")
	return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,52558805,SpecterChainTemtempo5) then --Temtempo 5, chain instantly for all other cards that don't meet the other conditions
     GlobalCardMode = 10
--	 AITrashTalk("I have no witty comment here. Why don't you submit one on the forums for me?")
	return {1,CurrentIndex}
  end
  if EnemyUltimateFalconFirstTurn() and not FalconFirstTurnTalk then
    FalconFirstTurnTalk = true
	AITrashTalk("On the first turn? Buddy. Pal. Friend. Do you truly hate me this much, Raidraptor guy?")
  end
  if EnemyUltimateFalcon() and Duel.GetTurnCount() ~= 1 and not FalconGeneralTalk and not FalconFirstTurnTalk then
    FalconGeneralTalk = true
	AITrashTalk("You got that card against Majespecters? Bravo. I have no idea how I let you get that, Raidraptor guy.")
  end
  if UsedUtopiaLightning() and HasID(OppGrave(),86221741,true) and not EnemyUltimateFalcon() and not FalconDestroyTalk then
    FalconDestroyTalk = true
	AITrashTalk("Looks like your Ultimate Falcon... just paid the Ultimate Price.")
  end
  if UsedUtopiaLightning2() and HasID(OppGrave(),86221741,true) and not EnemyUltimateFalcon() and not FalconDestroyTalk2 then
    FalconDestroyTalk2 = true
--	AITrashTalk("You know you smirked, don't try to cover it up.")
  end
  if EnemyUltimateFalcon() and FalconDestroyTalk and not FalconReviveTalk then
    FalconReviveTalk = true
	AITrashTalk("Let's start a petition, you and me. We'll rename that card to Ultimate Falcongress.")
	AITrashTalk("Why? Because it dictates everything.")
  end
  if TasukeOpponentCheck() then
    TasukeOpponentActivated = true
	AITrashTalk("The legendary Tasuke Samurai #420 has arrived.")
  end
  if SpecterStardustSparkTrace() and not StardustSparkTalk then
    StardustSparkTalk = true
    AITrashTalk("The Stardust Spark that lights the fire!?")
  end
  if RemovalCheck(84013237) and DoubleUtopiaActivated then
    AITrashTalk("Excellent save. Surely you have forged a Utopia for yourself.")
    DoubleUtopiaActivated = false
  end
  if RemovalCheck(56832966) and DoubleUtopiaActivated then
    AITrashTalk("Excellent save. Surely you have forged a Utopia for yourself.")
	DoubleUtopiaActivated = false
  end
  if SpecterOneDayTrace() and not SpecterPeaceTalk then
    AITrashTalk("Sheriff, I ain't exactly a peaceful robot.")
	SpecterPeaceTalk = true
  end
  if SpecterPeaceTalk and Duel.GetTurnPlayer()==player_ai and not SpecterPeaceTurn then
	SpecterPeaceTurn = true
	SpecterPeaceTalk = false
  end
  if SpecterPeaceTurn and Duel.GetTurnPlayer()==1-player_ai then
	SpecterPeaceTurn = false
  end
  return nil
end

function SpecterLightningAttackTarget(cards,source,ignorebonus,filter,opt)
  local atk = source.attack
  if ignorebonus and source.bonus and source.bonus > 0 then
    atk = math.max(0,atk - source.bonus)
  end
  local result = nil
  for i=1,#cards do
    local c = cards[i]
    c.index = i
    if FilterPosition(c,POS_FACEUP_ATTACK) then
      if c.attack<atk or CrashCheck(source) and c.attack==atk then 
        c.prio = c.attack
      else
        c.prio = c.attack * -1
      end
    end
    if FilterPosition(c,POS_DEFENSE) then
      c.prio = -99999
    end
    if filter and (opt and not filter(c,opt) or opt==nil and  not filter(c)) 
    then
      c.prio = (c.prio or 0)-99999
    end
    if c.prio and c.prio>0 and not BattleTargetCheck(c,source) then
      c.prio = -4
    end
    if not AttackBlacklistCheck(c,source) then
      c.prio = (c.prio or 0)-99999
    end
    if CanFinishGame(source,c) then
      c.prio=99999
    end
    if c.prio and c.prio>0 and FilterPublic(c) then
      if FilterType(c,TYPE_SYNCHRO+TYPE_RITUAL+TYPE_XYZ+TYPE_FUSION) then
        c.prio = c.prio + 1
      end
      if FilterType(c,TYPE_EFFECT) then
        c.prio = c.prio + 1
      end
      if c.level>4 then
        c.prio = c.prio + 1
      end
    end
    if CurrentOwner(c)==1 then
      c.prio = -1*c.prio
    end
  end
  table.sort(cards,function(a,b) return a.prio > b.prio end)
  result={cards[1].index}
  return result
end

function SpecterAttackTarget(cards,attacker)
  local id = attacker.id
  local result ={attacker}
  ApplyATKBoosts(result)
  ApplyATKBoosts(cards)
  result = {}
  local atk = attacker.attack
  if NotNegated(attacker) then
    -- Double Utopia Lightning
    if id == 56832966 and DoubleUtopiaActivated and CanWinBattle(attacker,cards,true,false,DoubleUtopiaAttackTargetFilter) then
      return SpecterLightningAttackTarget(cards,attacker,false,DoubleUtopiaAttackTargetFilter)
    end
  end
 return nil
end

function SpecterBattleCommand(cards,activatable)
  ApplyATKBoosts(cards)
  for i=1,#cards do
    cards[i].index = i
  end
  -- check for monsters, that cannot be attacked, or have to be attacked first.
  local targets = OppMon()
  local attackable = {}
  local mustattack = {}
  local lightning = {}
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
	if targets[i].attack == LightningMonitorAttack
    and bit32.band(targets[i].position,POS_ATTACK)>0 then
	  lightning[#lightning+1]=targets[i]
	end
  end
  if #mustattack>0 then
    targets = mustattack
  elseif DoubleUtopiaActivated then
    targets = lightning
  else
    targets = attackable
  end
  ApplyATKBoosts(targets)
  -- Double Utopia Lightning
  if HasIDNotNegated(cards,56832966) and CanWinBattle(cards[CurrentIndex],targets,true,false,DoubleUtopiaAttackTargetFilter) and DoubleUtopiaActivated then 
    return Attack(IndexByID(cards,56832966))
  end
 return nil
end

function SpecterYesNo(description_id)
  local result = nil
  if description_id == 30 then
    local cards = nil
    local attacker = GetAttacker()
    local attack = 0
    if attacker then
      cards = {attacker}
      ApplyATKBoosts(cards)
      attacker = cards[1]
      attack = attacker.attack
    end
    cards=OppMon()
    if #cards == 0 then
      --return 1
    end
    if FilterAffected(attacker,EFFECT_DIRECT_ATTACK) then
      return 1
    end
    ApplyATKBoosts(cards)
    if CanWinBattle(attacker,cards) then 
      GlobalCurrentAttacker = attacker.cardid
      GlobalAIIsAttacking = true
      return 1
    else
      return 0
    end
  end
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==69402394 then
      return 0
	end
  end
  return nil
end

SpecterPriorityList={
-- Priority list for your cards. You want to add all cards in your deck here,
-- or at least all cards you want to enable the Add function for.

--PRIO_HAND = 1
--PRIO_FIELD = 3
--PRIO_GRAVE = 5
--PRIO_SOMETHING = 7
--PRIO_BANISH = 9
 [31991800] = {7,1,8,2,0,0,1,1,9,3,RaccoonCond},             --Specter Raccoon
 [94784213] = {6,2,6,2,1,1,1,1,6,1,FoxCond},                 --Specter Fox
 [05506791] = {5,2,5,2,1,1,1,1,8,2,CatCond},                 --Specter Cat
 [00645794] = {3,1,3,1,1,1,1,1,3,1,ToadCond},                --Specter Toad
 [68395509] = {4,1,4,1,1,1,1,1,4,1,CrowCond},                --Specter Crow
 [51531505] = {3,1,0,0,9,1,1,1,1,1,DragonpitCond},           --Dragonpit Scale 8
 [15146890] = {5,2,1,1,7,1,1,1,1,1,DragonpulseCond},         --Dragonpulse Scale 1
 [19665973] = {1,1,1,1,1,1,1,1,1,1,nil},                     --Fader
 [72714461] = {4,2,1,1,8,1,1,1,1,1,InsightCond},             --Insight Scale 5
 [14920218] = {5,2,1,1,7,1,1,1,1,1,SpecterPeasantCond},      --Peasant Scale 2
 [40318957] = {1,1,1,1,6,1,1,1,1,1,nil},                     --Joker
 
 [36183881] = {8,2,8,2,1,1,1,1,1,1,STornadoCond},            --Specter Tornado
 [02572890] = {9,3,9,3,1,1,1,1,1,1,STempestCond},            --Specter Tempest
 [49366157] = {6,2,6,2,1,1,1,1,1,1,SCycloneCond},            --Specter Cyclone
 [13972452] = {5,1,5,1,1,1,1,1,1,1,SStormCond},              --Specter Storm
 [78949372] = {7,4,7,4,1,1,1,1,1,1,SCellCond},               --Specter Supercell
 }