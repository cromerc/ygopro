--
--        X-Saber AI 
--        by rothayz
--
--

--[[ TO DO list
TODO faultroll effect choose fulhelm principalmente
TODO ativar trap stun
TODO quando tiver emergency call setada e não tiver monstro em campo, invocar qualquer monstro
]]

function XSaberStartup(deck)
  -- function called at the start of the duel, if the AI was detected playing your deck.
    --Reveal opponent Hand
    -- local e1=Effect.GlobalEffect()
    -- e1:SetType(EFFECT_TYPE_FIELD)
    -- e1:SetCode(EFFECT_PUBLIC)
    -- e1:SetRange(LOCATION_MZONE)
    -- e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
    -- Duel.RegisterEffect(e1,0)

  -- Your links to the important AI functions. If you don't specify a function,
  -- or your function returns nil, the default logic will be used as a fallback.
  deck.Init                 = XSaberInit
  deck.Card                 = XSaberCard
  deck.Chain                = XSaberChain
  deck.EffectYesNo          = XSaberEffectYesNo
  deck.Position             = XSaberPosition
  deck.BattleCommand        = XSaberBattleCommand
  deck.AttackTarget         = XSaberAttackTarget

  --[[
  Other, more obscure functions, in case you need them. Same as before,
  not defining a function or returning nil causes default logic to take over

  deck.YesNo
  deck.Option
  deck.Sum
  deck.Tribute
  deck.BattleCommand
  deck.AttackTarget
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]

  -- Blacklists to disallow default logic or other decks to handle specific cards
  -- Only used, if your deck was detected

  deck.ActivateBlacklist    = XSaberActivateBlacklist
  deck.SummonBlacklist      = XSaberSummonBlacklist
  deck.SetBlacklist         = XSaberSetBlacklist
  deck.RepositionBlacklist  = XSaberRepoBlacklist
  deck.Unchainable          = XSaberUnchainable

  -- Priority list for your deck. May override priorities used by the default logic,
  -- but this will only apply, if your deck was detected.

  deck.PriorityList         = XSaberPriorityList

  --[[
  -- Monsters
  bogg_05998840
  fulh_78422252
  faul_51808422
  pash_23093604
  emme_42737833
  dark_31383545
  ragi_87292536

  -- Spells
  refl_35037880
  slas_11052544
  tenk_57103969
  rota_32807846
  pod_98645731
  mst_05318639

  -- Trap
  call_13504844
  rein_10118318
  tstu_59616123
  sabh_44901281
  fien_50078509



  --extra
  gott_52352005
  hyun_02203790
  souz_63612442
  boun_92661479
  invo_04423206
  cowb_12014404
  nbea_33198873
    ]]
  --turn = 1
  --stun = false

end

-- Your deck. The startup function must be on top of this line.
-- 3 required parameters.
-- First one: Your deck's name, as a string. Will be displayed in debug mode.
-- 2nd: The deck identifier. Can be a card ID (as a number) or a list of IDs.
--   Use a card or a combination of cards, that identifies your deck from others.
-- 3rd: The Startup function. Must be defined here, so it can be called at the start of the duel.
--  Technically not required, but doesn't make a lot of sense to leave it out, it would prevent
--  you from setting up all your functions and blacklists.

DECK_BLUEEYES = NewDeck("X-Saber",{51808422,13504844},XSaberStartup)
-- BlueEyes White Dragon and BlueEyes Maiden. BEWD is used in the Exodia deck as well,
-- so we use a 2nd card to identify the deck 100%. Could just use Maiden as well.

XSaberActivateBlacklist={
-- Blacklist of cards to never activate or chain their effects by the default AI logic
-- Anything you add here should be handled by your script, otherwise the cards will never activate
02203790, -- hyunlei
52352005, -- gottoms
59616123, -- trapstun
51808422, -- faultroll
--05318639,
32807846, -- rota
13504844, -- emergency call
57103969,
--50078509, -- fiendish
11052544, -- saber SlashTarget
44901281, -- saber hole
10118318, 
}
XSaberSummonBlacklist={
-- Blacklist of cards to never be normal summoned or set by the default AI logic
05998840, -- boggart
31383545, -- darksoul
42737833, -- emmersblade
23093604, -- pashuul
33198873, -- darksoul
78422252, -- fulhelmknight
02203790, -- hyunlei
92661479, -- CRIAR INVOCAO PRO BOUNZER

}
XSaberSetBlacklist={
-- Blacklist for cards to never set to the S/T Zone to chain or as a bluff

}
XSaberRepoBlacklist={
-- Blacklist for cards to never be repositioned
31383545, -- darksoul
23093604, -- pashuul

}
XSaberUnchainable={
-- Blacklist for cards to not chain multiple copies in the same chain
--59616123, -- trapstun
-- don't chain Maiden to herself. Sounds pointless because she is once per turn,
-- but this will also prevent chaining from other unchainable cards, like chaining
-- DPrison on something attacking Maiden, even though she would negate the attack anyways
}
--[[
Reminder: Useable priority constants
PRIO_TOHAND
PRIO_TOFIELD
PRIO_TOGRAVE
PRIO_DISCARD=PRIO_TODECK=PRIO_EXTRA, use depending on your needs
PRIO_BANISH
]]


function PashuulCond(prio, c)
    if prio == PRIO_TOHAND then 
      return not HasID(AIHand(), 23093604,true) and not HasID(AIDeck(), 78422252,true) 
      or #AIHand() < 2
    end
    if prio == PRIO_TOFIELD then
      return HasID(AIMon(), 05998840,true) or HasID(AIMon(), 87292536,true) 
      or AI.GetPlayerLP(1) < 1500
    end
end

function FulhelmCond(prio, c)
    if prio == PRIO_TOHAND then
      return not HasID(AIHand(), 78422252,true) 
    end
    if prio == PRIO_TOFIELD then
      return not HasID(AIMon(), 78422252,true) and #AIMon() > 1 
    end
end

function BoggartCond(prio, c)
    if prio == PRIO_TOHAND then
      return not HasID(AIHand(), 05998840,true)
      and HasID(AICards(), 78422252,true) or HasID(AICards(), 23093604,true)
    end
    if prio == PRIO_TOFIELD then
      return not HasID(AIMon(), 05998840,true) 
      or HasID(AIHand(), 51808422,true) 
    end
end

function FaultrollCond(prio, c)
    if prio == PRIO_TOHAND then
      return not HasID(AIHand(), 51808422,true) 
      and (#AIHand() > 1 or #AIMon() > 1)
      or HasID(AIHand(), 05998840,true)  
      or #AIMon() > 0 and #AIHand() > 2
      or HasID(AIST(), 13504844,true) and #AIMon() > 0  
    end
end

function GottCond(prio, c)
    if prio == PRIO_TOGRAVE then
      return false
    end
end

XSaberPriorityList={
-- Priority list for your cards. You want to add all cards in your deck here,
-- or at least all cards you want to enable the Add function for.

--               Field  Other
--          Hand  | Grave | Banish
-- BlueEyes     |   |   |   |   |
--[89631139] = {2,1,8,4,7,3,1,1,0,0,BEWDCond},
 -- BEWDs like to be summoned to the field or dumped to the graveyard,
 -- not added to the hand or banished.
--[88241506] = {8,1,7,518084221,2,1,1,1,3,1,nil},
 -- You want to add Maiden to hand or field, not dump her to the grave.
 [31383545] = {2,1,8,4,8,3,1,1,0,0,DarkCond},            --darksoul
 [42737833] = {2,1,4,4,7,3,1,1,0,0,EmmerCond},      --emmersblade
 [23093604] = {4,1,4,4,7,3,1,1,0,0,PashuulCond},    --pashuul
 [78422252] = {6,4,9,4,7,3,1,1,0,0,FulhelmCond},    --fulhelmknight
 [05998840] = {7,4,6,4,7,3,1,1,0,0,BoggartCond},    --boggart
 [51808422] = {8,5,7,4,7,3,1,1,0,0,FaultrollCond},  --faultroll
 [02203790] = {2,1,7,4,4,3,1,1,0,0,nil},            --hyunlei
 [52352005] = {5,1,9,8,1,1,1,1,1,1,GottCond},       --gottoms
}

function HasXSaber(cards)
    for i=1,#cards do
      return cards[i].id == 31383545
      or cards[i] == 23093604
      or cards[i] == 42737833
      or cards[i] == 78422252
      or cards[i] == 51808422
      or cards[i] == 05998840
      or cards[i] == 02203790
      or cards[i] == 52352005
    end
end

function SummonForCall()
    return HasID(AIST(), 13504844,true) 
    and #AIMon() < 1 
    and OppGetStrongestAttDef() > 2200
end

function SummonBoggart(c)
  return Duel.GetTurnCount() ~= 1
    and (HasID(AICards(), 78422252,true) 
    or HasID(AIMon(), 23093604, true) 
    and #OppST() > 0
    or HasID(AIMon(), 23093604, true) 
    and (HasID(AIHand(), 42737833,true) or HasID(AIHand(), 31383545,true))
    and Get_Card_Att_Def_Pos(OppMon()) <= 3100
    or HasID(AIHand(), 23093604, true) 
    and (HasID(AIMon(), 42737833,true) or HasID(AIMon(), 31383545,true))
    or HasID(AIHand(), 51808422,true) and (HasID(AIGrave(), 78422252,true) or HasID(AIGrave(), 23093604,true)) and #AIHand() > 2 -- aqui verificar se sao 2 monstros
    or OppGetStrongestAttDef()<1900
    or OppGetStrongestAttDef()<2400
    and HasID(AIHand(), 51808422,true)
    and #AIHand() > 1)
    or Duel.GetTurnCount() == 1
    and not HasID(AIHand(), 42737833,true) 
    and not HasID(AIHand(), 31383545,true)
    and not HasID(AIHand(), 23093604,true)
    or OppHasStrongestMonster()
    and HasID(AICards(), 11052544,true) 
    or SummonForCall()
end

function SummonEmmer(c)
    return true
    --[[HasID(AIMon(), 23093604,true)
    and not HasID(AIMon(), 33198873,true) 
    and OppGetStrongestAttDef() < 2200
    or HasID(AIMon(), 78422252,true) 
    and OppGetStrongestAttDef() < 2200
    or #AIMon() > 0 
    and not OppHasStrongestMonster() 
    and #OppMon() < 2
    or OppHasStrongestMonster()
    and HasID(AICards(), 11052544,true) 
    or SummonForCall()
    or #AIMon() == 1
    and HasID(AIHand(), 51808422,true) 
    and HasID(AIGrave(), 8422252,true)
    or OppGetStrongestAttDef() < 1300
    and Duel.GetTurnCount() ~= 1]]
end

function SummonFulhelm()
    return HasID(AIMon(), 51808422, true)
    or OppGetStrongestAttDef() < 2200
    and (HasID(AIMon(), 42737833,true) 
    or HasID(AIMon(), 31383545,true))
    or OppGetStrongestAttDef() < 1300 
    and not HasID(AIHand(), 42737833,true) 
    and not HasID(AIHand(), 31383545,true)
    or HasID(AIMon(), 02203790,true) 
    and OppHasStrongestMonster()
    or OppHasStrongestMonster()
    and HasID(AICards(), 11052544,true) 
    or HasID(AIHand(), 51808422, true)
    and HasXSaber(AIMon())
    or SummonForCall()
    or OppGetStrongestAttDef() < 1300
    and Duel.GetTurnCount() ~= 1

end

function SummonPashuul(c)
    return Get_Card_Att_Def_Pos(OppMon()) <=2200 
    and (HasID(AIMon(), 42737833,true) 
    or HasID(AIMon(), 31383545,true))
    or HasXSaber(AIMon())
    and HasID(AIHand(), 51808422,true) 
    or SummonForCall()
    or #AIMon() == 1
    and HasID(AIHand(), 51808422,true) 
    and (HasID(AIGrave(), 78422252,true) or HasID(AIMon(), 78422252,true))
end

function SummonDarksoul(c)
    return HasID(AIMon(), 23093604,true) 
    or HasID(AIMon(), 78422252,true) 
    or SummonForCall()
    or #AIMon() == 1
    and HasID(AIHand(), 51808422,true) 
    and (HasID(AIGrave(), 78422252,true) or HasID(AIMon(), 78422252,true))
end

function SummonRagi(c)
    return HasID(AIGrave(), 51808422,true)
    and HasID(AIMon(), 52352005, true)
    or HasID(AIHand(), 51808422, true)
    and #AIMon() > 0
    and (CardsMatchingFilter(AIGrave(),TunerFilter)>0
    or CardsMatchingFilter(AIMon(),TunerFilter)>0)
end

function RepoPashuulCond()
    return HasID(AIMon(), 42737833,true) --and not HasID(AIMon(), 33198873,true) --emmersblade
    or HasID(AIMon(), 31383545,true) --and not HasID(AIMon(), 33198873,true) -- darksoul
    or HasID(AIMon(), 05998840,true) 
    and OppGetStrongestAttDef()<2200
    or HasID(AIMon(), 05998840,true)
    and (HasID(AIMon(), 42737833,true) --and not HasID(AIMon(), 33198873,true) --emmersblade
    or HasID(AIMon(), 31383545,true))
    or #AIMon() > 1 and HasID(AIHand(), 51808422,true) 
    or HasID(AIST(), 13504844,true) 
    and OppGetStrongestAttDef() > 2200
    or #AIMon() > 1
    and HasID(AIHand(), 51808422,true) 
    and (HasID(AIGrave(), 78422252,true) or HasID(AIMon(), 78422252,true))
end

function RepoEmmerCond()
    return HasID(AIMon(), 23093604,true,nil,nil,POS_FACEUP_ATTACK) 
    or HasID(AIMon(), 78422252,true,nil,nil,POS_FACEUP_ATTACK) 
    or (#AIMon() > 1 
    and HasID(AIHand(), 51808422,true)
    and OppGetStrongestAttDef() <2400)
    or HasID(AIST(), 13504844,true) 
    and OppGetStrongestAttDef() > 2200
    or #AIMon() > 1
    and HasID(AIHand(), 51808422,true) 
    and (HasID(AIGrave(), 78422252,true) or HasID(AIMon(), 78422252,true))
end

function RepoDarkCond()
    return HasID(AIMon(), 23093604,true,nil,nil,POS_FACEUP_ATTACK)  
    or HasID(AIMon(), 78422252,true,nil,nil,POS_FACEUP_ATTACK) 
    or #AIMon() > 1 
    and HasID(AIHand(), 51808422,true)
    and OppGetStrongestAttDef() <2400
    or HasID(AIST(), 13504844,true) 
    and OppGetStrongestAttDef() > 2200
    or #AIMon() > 1
    and HasID(AIHand(), 51808422,true) 
    and (HasID(AIGrave(), 78422252,true) or HasID(AIMon(), 78422252,true))
end


function SummonHyunley(c)
    return not HasID(AIMon(), 02203790, true) 
    and #OppST() > 0
    or Get_Card_Att_Def_Pos(OppMon()) < 2200
end

function SummonGottoms(c)
    return OppHasStrongestMonster()
    or AI.GetCurrentPhase() == PHASE_MAIN2 and #AIMon() > 2
end

function UseGottoms()
    return (#AIMon() > 1 
    and not HasID(AIMon(), 92661479,true) 
    or #AIMon() > 2)
    and (AI.GetCurrentPhase() == PHASE_MAIN2
    or HasID(AIMon(), 87292536, true) 
    and HasID(AIMon(), 51808422, true))
end

function SummonNaturiaBeast(c)
    return OppGetStrongestAttDef()<=2200
end

function SummonBounzer(c)
    return AI.GetCurrentPhase() == PHASE_MAIN2
    or not HasID(AIMon(), 52352005,true) 
    and OppGetStrongestAttDef() >= 2400
    and OppGetStrongestAttDef() <= 2700
end

function UseFaultroll(c)
    return HasID(AIGrave(), 78422252,true) 
    or HasID(AIGrave(), 23093604,true) 
    and not HasID(AIMon(), 78422252,true)
    or HasID(AIGrave(), 31383545,true)  
end

function TunerFilter(c)
  return bit32.band(c.type,TYPE_TUNER)>0
end

function UseEmergencyCall(c)
    return HasID(AIMon(), 52352005,true) 
    or HasID(AIGrave(), 52352005,true) 
    or CardsMatchingFilter(AIGrave(),TunerFilter)>0
    or CardsMatchingFilter(AIMon(),TunerFilter)>0

end

function UseArmy(c)
    return not HasID(AIHand(), 78422252,true) 
    or not HasID(AIHand(), 23093604,true) 
    and not HasID(AIDeck(), 78422252,true) 
end

function UseTenki(c)
    return not HasID(AIHand(), 05998840,true) 
end

function SetDark(c)
    return Get_Card_Count_Pos(OppMon(),POS_FACEUP_ATTACK) < 2
    or #AIMon() > 0 and OppHasStrongestMonster()
end

function SetEmme(c)
    return Get_Card_Count_Pos(OppMon(),POS_FACEUP_ATTACK) > 1
    and Get_Card_Count_Pos(OppMon(),POS_FACEUP_ATTACK) < 4
    or Get_Card_Count_Pos(OppMon(),POS_FACEUP_ATTACK) > 0 
    and not HasID(AIHand(), 31383545,true) 
    or not HasID(AIHand(), 23093604,true) 
    and not HasID(AIHand(), 31383545,true) -- pashuul and darksoul
    or Duel.GetTurnCount() == 1 
    and not HasID(AIHand(), 31383545,true) 
end

function SetPash(c)
    return Get_Card_Count_Pos(OppMon(),POS_FACEUP_ATTACK) > 3
    or not HasID(AIHand(), 42737833,true) -- emmersblade and darksoul
    or Duel.GetTurnCount() == 1 and not HasID(AIHand(), 31383545,true) 
end

-- function SwarmCond()
--     return #AIMon() > 2
--     and CardsMatchingFilter(AICards(),TunerFilter)>0
-- end

function UseTrapStun(c)
    return #OppST() > 0
    and (
    AI.GetPlayerLP(1) < 1500
    and Get_Card_Count_Pos(AIMon(), POS_FACEUP) > 0
    or HasID(AIHand(), 51808422, true)
    and Get_Card_Count_Pos(AIMon(), POS_FACEUP) > 0
    and (CardsMatchingFilter(AIGrave(), TunerFilter) > 0 or CardsMatchingFilter(AIMon(), TunerFilter))
    )
    -- and SwarmCond()
end

function UseSaberSlash(c)
    return CardsMatchingFilter(OppField(),SaberSlashFilter)>0 
    and OppHasStrongestMonster()
end

function UsePOD(c)
    return AI.GetCurrentPhase() == PHASE_MAIN2
    or Duel.GetTurnCount() == 1
    or #AIHand() < 2 and #AIMon() < 1
end
--[[
Reminder: Useable commands
COMMAND_LET_AI_DECIDE
COMMAND_SUMMON
COMMAND_SPECIAL_SUMMON
COMMAND_CHANGE_POS
COMMAND_SET_MONSTER
COMMAND_SET_ST
COMMAND_ACTIVATE
COMMAND_TO_NEXT_PHASE
COMMAND_TO_END_PHASE
]]
function XSaberInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards

  if HasIDNotNegated(Act, 98645731, UsePOD)  then
    return COMMAND_ACTIVATE, CurrentIndex
  end

  if HasIDNotNegated(Act, 57103969, UseTenki)  then -- Tenki
    return COMMAND_ACTIVATE, CurrentIndex
  end

  if HasIDNotNegated(Act, 11052544, UseSaberSlash) then -- Saber Slash
    return COMMAND_ACTIVATE, CurrentIndex
  end

  if HasIDNotNegated(Act, 13504844, UseEmergencyCall)  then -- Emergency call
    return COMMAND_ACTIVATE, CurrentIndex
  end

  if HasIDNotNegated(Act, 59616123, UseTrapStun)  then -- Trap Stun
    return COMMAND_ACTIVATE, CurrentIndex
  end

  if HasIDNotNegated(Act, 32807846, UseArmy)  then -- RotA
    return COMMAND_ACTIVATE, CurrentIndex
  end

  if HasIDNotNegated(Act, 52352005, UseGottoms) then
    return COMMAND_ACTIVATE, CurrentIndex
  end

  if HasID(Sum, 87292536, SummonRagi) then -- ragigura
  return COMMAND_SUMMON, CurrentIndex
  end
  if HasID(Sum, 05998840, SummonBoggart)  then -- boggart
  return COMMAND_SUMMON, CurrentIndex
end

  if HasID(Sum, 78422252, SummonFulhelm)  then -- fulhelm
  return COMMAND_SUMMON, CurrentIndex
end

  if HasID(Sum, 42737833,SummonEmmer) then -- emmersblade
  return COMMAND_SUMMON, CurrentIndex
end

  if HasID(Sum, 23093604,SummonPashuul) then -- pashuul
  return COMMAND_SUMMON, CurrentIndex
end

  if HasID(Sum, 31383545,SummonDarksoul) then -- darksoul
  return COMMAND_SUMMON, CurrentIndex
end


  if HasID(Rep,42737833,FilterPosition,POS_DEFENSE) and RepoEmmerCond() then
    return COMMAND_CHANGE_POS,CurrentIndex
  end

  if HasID(Rep,23093604,FilterPosition,POS_DEFENSE) and RepoPashuulCond() then
    return COMMAND_CHANGE_POS,CurrentIndex
  end

  if HasID(Rep,31383545,FilterPosition,POS_DEFENSE) and RepoDarkCond() then
    return COMMAND_CHANGE_POS,CurrentIndex
  end

  if HasID(SetMon, 31383545, SetDark) then -- darksoul
    return COMMAND_SET_MONSTER,CurrentIndex
  end

  if  HasID(SetMon, 42737833, SetEmme)  then  -- emmersblade
    return COMMAND_SET_MONSTER,CurrentIndex
  end

  if HasID(SetMon, 23093604, SetPash)  then -- pashuul
    return COMMAND_SET_MONSTER,CurrentIndex
  end

  if HasID(SpSum, 51808422)  then 
    return COMMAND_SPECIAL_SUMMON, CurrentIndex
  end

  if HasID(SpSum, 02203790,SummonHyunley) then -- Hyunlei
    return COMMAND_SPECIAL_SUMMON, CurrentIndex
  end

  if HasID(SpSum, 52352005,SummonGottoms) then -- Gottoms
    return COMMAND_SPECIAL_SUMMON, CurrentIndex
  end

  if HasID(SpSum, 33198873,SummonNaturiaBeast) then -- Naturia Beast
    return COMMAND_SPECIAL_SUMMON, CurrentIndex
  end

  if HasID(SpSum, 92661479,SummonBounzer) then -- bounzer
    return COMMAND_SPECIAL_SUMMON, CurrentIndex
  end

  if HasIDNotNegated(Act, 51808422, UseFaultroll)  then -- faultroll
      return COMMAND_ACTIVATE, CurrentIndex
  end
end


function HyunleyTarget(cards)
  local result = {}
  local qtd = #OppST()
  if qtd > 3 then qtd = 3 end
  local i = 1
  while #result ~= qtd do
      if cards[i].owner == 2 then table.insert(result, i) end
      i = i+1
  end
  return result
end

-- function SlashTarget(cards, qtd)
--   local result = {}
--   local i = 1
--   while #result ~= qtd do
--       local index = Get_Card_Index(cards,2,"Highest",TYPE_MONSTER,POS_FACEUP_ATTACK)
--       table.insert(result, index) 
--       i = i+1
--   end
--   return result
-- end

function SaberSlashFilter(c)
  return DestroyCheck(c,true) 
  and CurrentOwner(c)==2 
  and Affected(c,TYPE_SPELL) 
  and FilterPosition(c,POS_FACEUP) 
end

function SaberSlashTarget(cards,max) -- passed from OnSelectCard. cards=cards, max=maxTargets
  --print('vai selecionar '..max)
  local count = CardsMatchingFilter(cards,SaberSlashFilter) -- check, how many of your opponent's card are matching the filter
  --print(count)
  count = math.max(1,math.min(count,max)) -- fix the count to be within the parameters of your saber slash targets.
  --print('fixed number: '..count)
  return BestTargets(cards,count,TARGET_DESTROY) -- pick the best available targets to destroy,
  -- check for the filter again just in case
end
    

function XSaberCard(cards,min,max,id,c)

  if id == 05998840 then
    return Add(cards,PRIO_TOFIELD)
  end

  if id == 02203790 then -- Hyunlei 
    return HyunleyTarget(cards)
  end

  if id == 52352005 then
    return Add(cards,PRIO_TOGRAVE)
  end

  if id == 51808422 then 
    return Add(cards,PRIO_TOFIELD)
  end

  if id == 42737833 then 
    return Add(cards,PRIO_TOFIELD)
  end

  if id == 31383545 then 
    return Add(cards,PRIO_TOHAND)
  end

  if id == 13504844 then
    return Add(cards,PRIO_TOFIELD, 2)
  end

  if id == 11052544 then
    return SaberSlashTarget(cards, max)
  end

  if id == 98645731 then 
    return Add(cards,PRIO_TOHAND)
  end
  
  
  return nil
end

function ChainSaberHole(c)
  for i=1,#AI.GetOppMonsterZones() do
    local c = AI.GetOppMonsterZones()[i]
    if c and bit32.band(c.status,STATUS_SUMMONING)>0 then
      if c.attack>=1700 then
        return true
      end
    end
  end
  return false
end

function ChainSevenTools(c)
    --print('vai ativar seven tools')
    for i=1,#AI.GetOppSpellTrapZones() do
        local c = AI.GetOppSpellTrapZones()[i]
        if c then
            if c.owner == 2 and bit32.band(c.status,STATUS_CHAINING)>0 then
                return true
            end
        end
    end
  return false
end

function ChainReinTruth(c)
    --print('vai ativar reinforce truth')
    return #AIMon() < 1
end

function XSaberChain(cards)
  if HasID(cards,44901281, ChainSaberHole) then
    return {1,CurrentIndex}
  end

  if HasID(cards, 10118318, ChainReinTruth)  then
    return {1,CurrentIndex}
  end

  if HasID(cards, 03819470, ChainSevenTools) then
    --return {1,CurrentIndex}
  end
  return nil
end

function UseHyunlei()
    return #OppST() > 0
end

function XSaberEffectYesNo(id,card)
  local result
  if id == 02203790 and UseHyunlei() then
    result = 1
  end
  return result
end


XSaberAtt={
05998840,
78422252,
52352005,
02203790,
51808422,
92661479,
63612442,
33198837,
04423206,
33198873,
}
XSaberDef={
31383545,
23093604,
42737833,
87292536,
12014404,
}
function XSaberPosition(id,available)
  local result
  for i=1,#XSaberAtt do
    if XSaberAtt[i]==id
    then
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#XSaberDef do
    if XSaberDef[i]==id
    then
      result=POS_FACEUP_DEFENSE
    end
  end
  return result
end

function ReflectFilter(c,atk)
  -- checks, if the target has valid conditions, like enough attack or defense, but not too much that the AI would die
  return BattleTargetCheck(c) -- valid target to battle. Checks for a battle blacklist and untargetable by attacks etc
  and (FilterPosition(c,POS_FACEUP_ATTACK)
  and FilterAttackMin(c,atk)
  and AI.GetPlayerLP(1)-c.attack+atk>0
  or FilterPosition(c,POS_DEFENSE)
  and FilterPublic(c)
  and FilterDefenseMin(c,atk)
  and AI.GetPlayerLP(1)-c.defense+atk>0
  or FilterPosition(c,POS_DEFENSE)
  and FilterPrivate(c)
  and AI.GetPlayerLP(1)>1000)
end
function XSaberBattleCommand(cards,targets,act)
  --SortByATK(cards)
  if HasIDNotNegated(cards, 42737833) -- if emmersblade can attack
  and HasID(AICards(),35037880,true) -- and the AI has an activatable saber reflect in hand
  and CardsMatchingFilter(targets,ReflectFilter,cards[CurrentIndex].attack)>0 -- and the opponent has valid targets to attack into
  then
    return Attack(CurrentIndex) -- then attack with Veil
  end
end
function XSaberAttackTarget(cards,attacker)
  if attacker.id == 42737833 -- if the attacker is emmersblade
  and HasID(AIHand(),35037880,true) -- and again, AI has useable reflect in hand
  and CardsMatchingFilter(cards,ReflectFilter,cards[CurrentIndex].attack)>0 -- and the opponent has valid targets
  then
    return BestAttackTarget(cards,attacker,false,ReflectFilter,attacker.attack) -- then return the best possible card to attack
    -- considering the Veil filter. BestAttackTarget handles stuff like attack blacklist, lowest ATK below the threshold defined in the filter etc
  end
end
