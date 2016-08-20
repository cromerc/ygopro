function HEROStartup(deck)
  deck.Init                 = HEROInit
  
  deck.Position             = HEROPosition
  deck.Material             = HEROMaterial
  deck.YesNo                = HEROYesNo
  
  deck.ActivateBlacklist    = HEROActivateBlacklist
  deck.SummonBlacklist      = HEROSummonBlacklist
  deck.RepoBlacklist        = HERORepoBlacklist
  deck.PriorityList         = HEROPriorityList
end

HEROIdentifier = 50720316 -- Shadow Mist

DECK_HERO = NewDeck("HERO",HEROIdentifier,HEROStartup) 

HEROActivateBlacklist={
70368879, -- Upstart
00213326, -- Ecall
32807846, -- RotA
87819421, -- Mask Charge
--05318639, -- MST
}
HEROSummonBlacklist={
58069384, -- Nova
56638325, -- Delteros
84013237, -- Utopia
21501505, -- Cairngorgon
82633039, -- Castel
18326736, -- Ptolemaios
06511113, -- Rafflesia
}
HERORepoBlacklist={
50720316 -- Shadow Mist
}
function HEROFilter(c,exclude)
  c = GetCardFromScript(c)
  local id = c.id
  if exclude and type(exclude)=="table" then 
    id = c.cardid
    exclude = exclude.cardid
  end
  return IsSetCode(c.setcode,0x8) and (exclude == nil or id~=exclude)
end
function ChangeFilter(c,exclude)
  local id = c.id
  if exclude and type(exclude)=="table" then 
    id = c.cardid
    exclude = exclude.cardid
  end
  return IsSetCode(c.setcode,0xa5) 
  and FilterType(c,TYPE_QUICKPLAY)
  and (exclude == nil or id~=exclude)
end
function EHEROFilter(c,exclude)
  return IsSetCode(c.setcode,0x3008) and HEROFilter(c,exclude)
end
function MHEROFilter(c,exclude)
  return IsSetCode(c.setcode,0xa008) and HEROFilter(c,exclude)
end
OHero={
03642509, -- Great Tornado
01945387, -- Nova Master
22061412, -- The Shining
33574806, -- Escuridao
40854197, -- Absolute Zero
16304628, -- Gaia
}
function OmniHEROFilter(c,exclude) -- the Omni heroes, fusions which require 1 HERO and 1 attribute
  if not HEROFilter(c,exclude) then return false end
  for i=1,#OHero do
    if c.id == OHero[i] then
      return true
    end
  end
  return false
end

function MistCond(loc,c)
  if loc == PRIO_TOFIELD then
    return OPTCheck(50720316) and CardsMatchingFilter(AIDeck(),ChangeFilter)>0
  elseif loc == PRIO_TOGRAVE then
    return OPTCheck(50720316) and CardsMatchingFilter(AIDeck(),HEROFilter,50720316)>0
  end
  return true
end
function BubbleFilter(c)
  return FilterPosition(c,POS_FACEUP)
  and (c.id == 32807846 or c.id == 00213326
  or c.id == 08949584)
  or FilterLocation(c,LOCATION_HAND) and c.id == 79979666
end
function BubblemanCheck(mode)
  local count = #AICards()
  local check = (mode == 2 
  or Duel.GetTurnPlayer()==player_ai 
  and Duel.GetCurrentPhase()~=PHASE_END 
  and (DualityCheck() or not NormalSummonCheck()))
  if count == 0 and check
  then
    return true
  end
  if count == 1 and BubbleFilter(AICards()[1]) and check then
    return true
  end
  return false
end
function BubbleCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AIHand(),FilterType,TYPE_MONSTER)<2 then
      return 5
    end
    return BubblemanCheck(1)
  elseif loc == PRIO_TOFIELD then
    return BubblemanCheck(2)
  end
  return true
end
function DarkLawCond(loc,c)
  if loc == PRIO_TOFIELD then
    local bonus = 0
    if HasID(AIHand(),50720316,true) 
    and NormalSummonCheck()
    then 
      bonus = 1000
    end
    if SummonDarkLaw(nil,{c},1,bonus) then
      return 7
    end
    return SummonDarkLaw(nil,{c},2)
  end
  return true
end
function AnkiCond(loc,c)
  if loc == PRIO_TOFIELD then
    local bonus = 0
    if HasID(AIHand(),50720316,true) 
    and NormalSummonCheck()
    then 
      bonus = 1000
    end
    return SummonAnki(nil,{c},1,bonus)
    or SummonAnki(nil,{c},2)
  end
  return true
end

HEROPriorityList={
-- HERO

[69884162] = {3,1,1,1,1,1,1,1,1,1,AliusCond},   -- Neos Alius
[25259669] = {4,1,1,1,1,1,1,1,1,1,GoblinCond},  -- Goblindbergh
[63060238] = {1,1,1,1,1,1,1,1,1,1,BlazeCond},   -- Blazeman
[50720316] = {7,1,7,1,1,1,1,1,1,1,MistCond},    -- Shadow Mist
[18063928] = {5,1,1,1,1,1,1,1,1,1,GoldfishCond},-- Tin Goldfish
[00423585] = {4,1,1,1,1,1,1,1,1,1,MonkCond},    -- Summoner Monk
[79979666] = {8,1,8,1,1,1,1,1,1,1,BubbleCond},  -- Bubbleman

[00213326] = {1,1,1,1,8,1,1,1,1,1,nil},         -- E-Call
[08949584] = {1,1,1,1,6,1,1,1,1,1,nil},         -- AHL
[18511384] = {1,1,1,1,4,1,1,1,1,1,nil},         -- Fusion Recovery
[24094653] = {1,1,1,1,4,1,1,1,1,1,nil},         -- Polymerization
[45906428] = {1,1,1,1,4,1,1,1,1,1,nil},         -- Miracle Fusion
[55428811] = {1,1,1,1,4,1,1,1,1,1,nil},         -- Fifth Hope
[21143940] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Mask Change
[87819421] = {1,1,1,1,3,1,1,1,1,1,nil},         -- Mask Charge
[70368879] = {1,1,1,1,9,1,1,1,1,1,nil},         -- Upstart
[84536654] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Form Change
[27243130] = {1,1,1,1,4,1,1,1,1,1,nil},         -- Forbidden Lance
[12580477] = {1,1,1,1,2,1,1,1,1,1,nil},         -- Raigeki
[05318639] = {1,1,1,1,3,1,1,1,1,1,nil},         -- MST
[14087893] = {1,1,1,1,2,1,1,1,1,1,nil},         -- Book of Moon

[95486586] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Core
[03642509] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Great Tornado
[22093873] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Divine Wind
[01945387] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Nova Master
[22061412] = {1,1,1,1,1,1,1,1,1,1,nil},         -- The Shining
[29095552] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Acid
[33574806] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Escuridao
[40854197] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Absolute Zero
[50608164] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Koga
[58481572] = {1,1,5,1,1,1,1,1,1,1,DarkLawCond}, -- Dark Law
[16304628] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Gaia
[59642500] = {1,1,6,1,1,1,1,1,1,1,AnkiCond},    -- Anki
}

--})
function HEROChainOrder(cards)
  result = {}
  if HasID(cards,58481572,true) and HasID(cards,50720316,true) then
    for i=1,#cards do
      if cards[i].id == 58481572 then
        for j=1,#cards do
          if cards[j].id == 50720316 then
            result[i]=j
            result[j]=i
          end
        end
      else
        result[i]=i
      end
    end
    return result
  end
  return nil
end

function FusionMaterialCheck(fusion,cards)
  if OmniHEROFilter(fusion) then
    for i=1,#cards do
      local c = cards[i]
      if FilterAttribute(c,fusion.attribute) 
      and CardsMatchingFilter(cards,HEROFilter,c)>0
      then
        return true
      end
    end
  end
  if fusion.id == 95486586 then
    return CardsMatchingFilter(cards,HEROFilter)>2
  end
  return false
end
function SummonCount(sum) 
-- checks, how many level 4s the AI can probably bring out this turn
  local cards = SubGroup(AICards(),NotNegated)
  local result = 0
  local normal = not NormalSummonCheck()
  local ahl = 0
  local rota = CardsMatchingFilter(cards,FilterID,32807846)
  local ecall = CardsMatchingFilter(cards,FilterID,00213326)
  local stspace = SpaceCheck(LOCATION_SZONE)
  local mspace = SpaceCheck()
  if not sum then sum = AIHand() end
  if #AIMon()==0 and HasIDNotNegated(AICards(),08949584,true,UseAHL) then
    result = result+1
    ahl = 1
  end
  if normal then
    if CardsMatchingFilter(sum,FilterLevel,4)>0 
    then
      result = result+1
    elseif CardsMatchingFilter(SubGroup(AIDeck(),HEROFilter),FilterLevel,4)>0 and ecall>0 
    then
      result = result+1
    elseif CardsMatchingFilter(SubGroup(AIDeck(),FilterRace,RACE_WARRIOR),FilterLevel,4)>0 and rota>0
    then
      result = result+1
    end
    if HasIDNotNegated(sum,00423585,true) 
    and CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>ahl
    and CardsMatchingFilter(AIDeck(),FilterLevel,4)>0
    then
      result = result+1 
    end
    if HasIDNotNegated(sum,00423585,true) 
    and HasIDNotNegated(AIDeck(),00423585,true) 
    and CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>ahl+1
    and CardsMatchingFilter(AIDeck(),FilterLevel,4)>1
    then
      result = result+1 
    end
    --if TODO ?
    
    
    if (HasIDNotNegated(sum,18063928,true)
    or HasIDNotNegated(sum,25259669,true)
    or rota>0 and HasIDNotNegated(AIDeck(),25259669,true))
    and (CardsMatchingFilter(AIHand(),FilterLevel,4)>0
    or CardsMatchingFilter(SubGroup(AIDeck(),HEROFilter),FilterLevel,4)>0 
    and HasIDNotNegated(AICards(),00213326,true)
    or CardsMatchingFilter(SubGroup(AIDeck(),FilterRace,RACE_WARRIOR),FilterLevel,4)>0 
    and rota>0)
    then
      if HandCheck(4)>0 or CardsMatchingFilter(AICards(),FilterID,00213326)
      +CardsMatchingFilter(AICards(),FilterID,32807846)>1
      then
        result = result+1
      end
    end
  end
  if (HasID(AIHand(),79979666,true) 
  or (rota>0 or ecall>0) and HasID(AIDeck(),79979666,true))
  and CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL+TYPE_TRAP)<=stspace
  then
    result = result+1
  end
  result = math.min(result,mspace)
  return result
end
function SummonAbZero(c,cards)
  return FusionMaterialCheck(c,cards)
end
function UsePoly(c)
  if HasID(AIExtra(),40854197,true,SummonAbZero,AICards()) 
  and not HasID(AIMon(),40854197,true)
  and OverExtendCheck(6,2)
  then
    return true
  end
  return false
end


GlobalWaveMotionTurn={}
function WaveMotionDamage()
  local result = 0
  for i=1,#AIST() do
    local c = AIST()[i]
    if c.id == 38992735 
    and NotNegated(c)
    and FilterPosition(c,POS_FACEUP)
    and GlobalWaveMotionTurn[c.cardid]
    then
      result = result + 500 * (Duel.GetTurnCount() - GlobalWaveMotionTurn[c.cardid])
    end
  end
  return result
end
function UseWaveMotionCannon(c)
  if FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN) then
    GlobalWaveMotionTurn[c.cardid]=Duel.GetTurnCount()
    return true
  else
    return WaveMotionDamage()>=AI.GetPlayerLP(2)
  end
  return false
end
function UseShardOfGreed(c)
  if FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN) then
    return true
  end
  return c:get_counter(0xd)>=2
end
function UseSixSamUnited(c)
  if FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN) then
    return true
  end
  return c:get_counter(0x3003)>=2
end
function MistCheck(cards)
  return HasIDNotNegated(cards,50720316,true,FilterOPT,true)
  and CardsMatchingFilter(AIDeck(),FilterSet,0xa5)>0
end
function UseAHL(c,mode)
  if not mode then
    return DualityCheck()
    and #AIMon()==0
  end
  if mode == 1 then
    return MistCheck(AIDeck())
    or HasIDNotNegated(AIDeck(),79979666,true,BubblemanCheck,c)
  end
  if mode == 2 then
    local count = SummonCount()
    return count>2 and count<5
    and (not HasIDNotNegated(AIHand(),00423585,true)
    or CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>2)
  end
end
function UseRotaHero(c,mode)
  if mode == 1 then
    if MistCheck(AIHand()) and not (HasID(AIHand(),18063928,true) or HasID(AIHand(),25259669,true)) 
    and HasID(AIDeck(),25259669,true) and not NormalSummonCheck()
    then
      GlobalRotaTarget = 25259669
      return true
    end
    if HasIDNotNegated(AIHand(),00423585,true) and not NormalSummonCheck()
    and CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>1
    and FieldCheck(4)==0
    then
      GlobalRotaTarget = 25259669
      return true
    end
    if MistCheck(AIDeck()) and (HasID(AIHand(),18063928,true) or HasID(AIHand(),25259669,true))
    and not (HasID(AICards(),50720316,true) or NormalSummonCheck())
    then
      GlobalRotaTarget = 50720316
      return true
    end
  end
  if mode == 2 then
    if #AIHand()==0
    and SummonBubbleCheck()
    then
      if NormalSummonCheck() then
        GlobalRotaTarget = 79979666
      end
      return true
    end
  end
  if mode == 3 then
    if HasID(AICards(),21143940,true)
    and not HasID(AICards(),50720316,true)
    and not HasID(AICards(),58481572,true)
    and not NormalSummonCheck()
    then
      GlobalRotaTarget = 50720316
      return true
    end
  end
  if mode == 4 then
    if CardsMatchingFilter(AIDeck(),SummonHERO,1)>0 
    and not NormalSummonCheck()
    then
      return true
    end
  end
  if mode == 5 then
    if HandCheck(4)==0 and FieldCheck(4)==0
    and not NormalSummonCheck()
    then
      return true
    end
  end
  return false
end
function UseEcall(c,mode)
  if mode == 1 then
    if MistCheck(AIDeck()) 
    and (HasID(AIHand(),18063928,true) 
    or HasID(AIHand(),25259669,true)
    or HasIDNotNegated(AICards(),32807846,true))
    and not (HasID(AICards(),50720316,true) 
    or NormalSummonCheck())
    and not (HasIDNotNegated(AICards(),00423585,true)
    and CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>0 )
    then
      GlobalEcallTarget = 50720316
      return true
    end
  end
  if mode == 2 then
    if #AIHand()==0
    and SummonBubbleCheck()
    then
      if NormalSummonCheck() then
        GlobalEcallTarget = 79979666
      end
      return true
    end
  end
  if mode == 3 then
    if HasID(AICards(),21143940,true)
    and not HasID(AICards(),50720316,true)
    and not HasID(AICards(),58481572,true)
    and not NormalSummonCheck()
    then
      GlobalEcallTarget = 50720316
      return true
    end
  end
  if mode == 4 then
    if CardsMatchingFilter(AIDeck(),SummonHERO,1)>0 
    and not NormalSummonCheck()
    then
      return true
    end
  end
  if mode == 5 then
    if HandCheck(4)==0 and FieldCheck(4)==0
    and not NormalSummonCheck()
    then
      return true
    end
  end
  return false
end
function AcidFilter(c)
  return HEROFilter(c) and FilterAttribute(c,ATTRIBUTE_WATER)
  and FilterPosition(c,POS_FACEUP)
end
function KogaFilter(c)
  return HEROFilter(c) and FilterAttribute(c,ATTRIBUTE_LIGHT)
  and FilterPosition(c,POS_FACEUP)
end
function SummonBubble(c,mode)
  if mode == 1 then
    return NotNegated(c) and BubblemanCheck(2)
  end
  if mode == 2 then
    return CardsMatchingFilter(AIMon(),AcidFilter)==0 
    and DestroyCheck(OppST())>2
    and HasID(AICards(),21143940,true)
    and HasIDNotNegated(AIExtra(),29095552,true)
    and DualityCheck()
  end
  return false
end
function SummonAlius(c,mode)
  if mode == 1 then
    return CardsMatchingFilter(AIMon(),KogaFilter)==0 
    and SummonKoga(nil,{c},1)
    and HasIDNotNegated(AICards(),21143940,true)
    and HasIDNotNegated(AIExtra(),50608164,true)
    and DualityCheck()
    and BattlePhaseCheck()
  end
  if mode == 2 then
    return true
  end
  return false
end
function UseMonk(c,mode)
  if not mode then
    return CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>0
    and SpaceCheck()>1
    and DualityCheck()
    and NotNegated(c)
  end
  if mode == 1 then
    if MistCheck(AIDeck())
    and CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>0
    and not ((HasID(AIMon(),50720316,true) or HasID(AIHand(),50720316,true) 
    and not NormalSummonCheck()) and HasID(AICards(),21143940,true))
    and DualityCheck()
    and NotNegated(c)
    then
      GlobalMonkTarget = 50720316
      return true
    end
  end
  if mode == 2 then
    if FieldCheck(4)<4 
    and HasID(AIDeck(),00423585,true)  
    and CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL)>1
    and SpaceCheck()>1
    and DualityCheck()
    and NotNegated(c)
    then
      GlobalMonkTarget = 00423585
      return true
    end
  end
  if mode == 3 then
    if FieldCheck(4)<4 
    and CardsMatchingFilter(AIHand(),function(c) 
      return FilterType(c,TYPE_SPELL) and not FilterID(c,21143940) end)>0
    and SpaceCheck()>0
    and DualityCheck()
    and NotNegated(c)
    then
      GlobalMonkTarget = 00423585
      return true
    end
  end
  return false
end
function SummonMonk(c,mode)
  return UseMonk(c,mode) 
end
function SummonGoblindbergh(c,mode)
  if mode == 1 then
    if MistCheck(AIHand()) and not NormalSummonCheck()
    and DualityCheck()
    and NotNegated(c)
    then
      GlobalGoblindberghTarget = 50720316
      return true
    end
  end
  if mode == 2 then
    if not NormalSummonCheck()
    and HasID(AIHand(),00423585,true,SummonMonk)
    and DualityCheck()
    and NotNegated(c)
    then
      GlobalGoblindberghTarget = 00423585
      return true
    end
  end
  if mode == 3 then
    if not NormalSummonCheck()
    and CardsMatchingFilter(AIHand(),FilterLevel,4)>1
    and DualityCheck()
    and NotNegated(c)
    and FieldCheck(4)==0
    and OverExtendCheck(3)
    then
      return true
    end
  end
  return false
end
function SummonTinGoldfishHERO(c,mode)
  return SummonGoblindbergh(c,mode)
end
function CanSummonDarkLaw()
  return HasID(AICards(),21143940,true)
  and HasID(AIMon(),50720316,true,FilterPosition,POS_FACEUP)
  and HasIDNotNegated(AIExtra(),58481572,true)
  and DualityCheck()
end
function DarkLawXYZCheck(count)
  if not count then count = 2 end
  return FieldCheck(4)>count 
  or not CanSummonDarkLaw()
  or HasIDNotNegated(AIMon(),58481572,true)
  or OppGetStrongestAttDef()>=2400
end
function SummonRafflesiaHERO(c)
  return DarkLawXYZCheck()
  and SummonRafflesia(c)
end
function SummonPtolemaeusHERO(c)
  if not DeckCheck(DECK_HERO) then return false end
  if DarkLawXYZCheck(3) and InfinityCheck(4)
  or not CanSummonDarkLaw() and InfinityCheck()
  then
    GlobalPtolemaiosID = 10443957
    return true
  end
end
function SummonCairngorgonHERO(c,mode)
  if mode == 1
  and DarkLawXYZCheck()
  and SummonCairngorgon(c)
  and BattlePhaseCheck()
  then
    return true
  end
  if mode == 2 
  and DarkLawXYZCheck()
  and SummonCairngorgon(c)
  then
    return true
  end
  return false
end
function SummonCastelHERO(c)
  return DarkLawXYZCheck()
  and SummonSkyblaster(c)
end
function SummonUtopiaHERO(c,mode)
  if mode == 1 then
    return SummonUtopiaLightningFinish(c,1)
  end
  if mode == 2 then
    return DarkLawXYZCheck()
    and SummonUtopiaLightning(c,2)
  end
  if mode == 3 then
    return DarkLawXYZCheck()
    and SummonUtopiaLightning(c,3)
  end
end

function UseUpstart(c,mode)
  if (CardsMatchingFilter(AIMon(),FinishGameFilter)>0
  or #OppMon()==0 and ExpectedDamage()>AI.GetPlayerLP(2))
  and BattlePhaseCheck()
  then
    return false
  end
  if mode == 1 then
    --print(SummonBubbleCheck())
    return not (HasIDNotNegated(AICards(),00423585,true)
    or SummonBubbleCheck() or not NormalSummonCheck())
  end
  if mode == 2 then
    return true
  end
  return false
end
function SummonShadowMist(c,mode)
  if mode == 1 
  and HasID(AICards(),21143940,true) 
  and not HasID(AIMon(),50720316,true)
  then
    return true
  end
  if mode == 2
  and HasID(AICards(),21143940,true) 
  and not HasID(AIMon(),50720316,true)
  and SummonAnki(nil,{c},1)
  then
    return true
  end
  return false
end
function RepoShadowMist(c)
  if FilterPosition(c,POS_FACEDOWN_DEFENSE)
  and HasID(AICards(),21143940,true)
  then
    return true
  end
  if FilterPosition(c,POS_FACEUP_DEFENSE)
  and HasID(AICards(),21143940,true)
  and BattlePhaseCheck()
  and (CanWinBattle(c,OppMon())
  or #OppMon()==0)
  then
    return true
  end
  if FilterPosition(c,POS_FACEUP_ATTACK)
  and (not HasID(AICards(),21143940,true)
  or #OppMon()>0 and not CanWinBattle(c,OppMon())
  or TurnEndCheck())
  then
    return true
  end
  return false
end
function HasBubble(c,ahl)
  local filter = ExcludeCard
  if not c then filter = nil end
  return HasID(AIHand(),79979666,true,filter,c)
  or HasID(AIDeck(),79979666,true)
  and (HasID(AICards(),00213326,true,filter,c) 
  or HasID(AICards(),32807846,true,filter,c)
  or ahl and HasID(AICards(),08949584,true,filter,c))
end
function BubbleCheckFilter(c)
  return (FilterType(c,TYPE_MONSTER)
  and c.level == 4
  or c.id == 00213326
  or c.id == 32807846)
  and HasBubble(c)
end
function NotBubbleFilter(c)
  return FilterType(c,TYPE_MONSTER)
  and FilterLevel(c,4)
  and c.id~=79979666
end
function SummonBubbleCheck()
  --print("bubble check")
  local count=2
  local summons = 1
  if NormalSummonCheck() then 
    --print("alreadys normal summoned, reducing count")
    count=1 
  end
  if not HasBubble() then 
    --print("no bubble available, abort")
    return false 
  end
  if CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL+TYPE_TRAP)>SpaceCheck(LOCATION_SZONE)
  then 
    --print("not enough S/T space, abort")
    return false
  end
  if NormalSummonCheck() 
  and CardsMatchingFilter(AIHand(),NotBubbleFilter)>0
  or CardsMatchingFilter(AIHand(),NotBubbleFilter)>1
  then 
    --print("too many monsters in hand, abort")
    return false 
  end
  if not NormalSummonCheck() 
  and CardsMatchingFilter(UseLists(AIHand(),AIST()),BubbleCheckFilter)>0 
  then 
    --print("bubble + another monster available, summons +1")
    summons = 2 
  end
  if FieldCheck(4)+summons<=4 
  and (FieldCheck(4)+summons>2
  or FieldCheck(4)+summons>1 
  and not CanSummonDarkLaw())
  then  
    --print("bubble okay")
    return true
  end
  --print("don't summon bubble")
  return false
end
function SetShadowMist(c)
  return #AIMon()==0
end
function SummonHERO(c,mode)
  if mode == 1 then
    if c.level == 4
    and (FieldCheck(4)==1 
    and not CanSummonDarkLaw()
    or FieldCheck(4)==2 
    and CanSummonDarkLaw())
    and DualityCheck()
    then
      return true
    end
  end
  if mode == 2 then
    if c.level == 4
    and NotBubbleFilter(c)
    and SummonBubbleCheck()
    then
      return true
    end
  end
end
function UseMaskCharge(c,mode)
  if mode == 1 then
    return true
  end
end
function UseMSTHero(card)
  local filter = function(c) return FilterID(c,card.id) and NotNegated(c) end
  if HasBubble(nil,true)
  and DestroyCheck(OppST(),nil,true)>=CardsMatchingFilter(AICards(),filter)
  and #AICards()-CardsMatchingFilter(AICards(),filter)==1
  and UnchainableCheck(card.id)
  then
    return true
  end
  return UseMST(card)
end
function UseMaskChange(c)
  if CanSummonDarkLaw() 
  and not HasIDNotNegated(AIMon(),58481572,true)
  and OppGetStrongestAttDef()<2400
  and OppHasStrongestMonster()
  and (BattlePhaseCheck() or OPTCheck(50720316))
  then
    GlobalTargetSet(FindID(50720316,darkheroes))
    GlobalCardMode = 1
    return true
  end
  if CanSummonDarkLaw() 
  and not HasIDNotNegated(AIMon(),58481572,true)
  and OppGetStrongestAttDef()<2400
  and OppHasStrongestMonster()
  and (BattlePhaseCheck() or OPTCheck(50720316))
  then
    GlobalTargetSet(FindID(50720316,darkheroes))
    GlobalCardMode = 1
    return true
  end
  return false
end
function UseCotHHERO(c,mode)
  if mode == 1
  and HasIDNotNegated(AIGrave(),50720316,true,FilterOPT,true)
  and CardsMatchingFilter(AIDeck(),ChangeFilter)>0
  and OverExtendCheck(3)
  then
    return true
  end
  if mode == 2
  and (FieldCheck(4)==1 
  and not CanSummonDarkLaw()
  or FieldCheck(4)==2 
  and CanSummonDarkLaw())
  then
    return true
  end
  if mode == 3
  and TurnEndCheck()
  and #AIMon()==0
  then
    return true
  end
end
function HEROInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasID(Act,05318639,UseMSTHero) then
    return Activate()
  end
  if HasID(SpSum,84013237,SummonUtopiaHERO,1) then
    return XYZSummon()
  end
  if HasID(Sum,50720316,SummonShadowMist,2) then
    return Summon()
  end
  if HasID(Sum,69884162,SummonAlius,1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,79979666,SummonBubble,1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Sum,79979666,SummonBubble,1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,79979666,SummonBubble,2) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Sum,79979666,SummonBubble,2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,79979666,SummonBubble,3) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Rep,50720316,RepoShadowMist) then
    return Repo()
  end
  if HasIDNotNegated(Act,97077563,UseCotHHERO,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,00213326,UseEcall,5) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,32807846,UseRotaHero,5) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,87819421,UseMaskCharge,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,70368879,UseUpstart,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,08949584,UseAHL,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00213326,UseEcall,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,32807846,UseRotaHero,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,38992735,UseWaveMotionCannon) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,33904024,UseShardOfGreed) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,72345736,UseSixSamUnited) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Sum,18063928,SummonTinGoldfishHERO,2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,25259669,SummonGoblindbergh,2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,18063928,SummonTinGoldfishHERO,1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,25259669,SummonGoblindbergh,1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,00423585,UseMonk,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00423585,UseMonk,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00423585,UseMonk,3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Sum,00423585,SummonMonk,1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,69884162,SummonAlius,2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,24094653,UsePoly) then -- Polymerization
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00213326,UseEcall,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,32807846,UseRotaHero,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  for i=1,#Sum do
    if SummonHERO(Sum[i],2) then
      return Summon(i)
    end
  end
  if SummonBubbleCheck() then
    if HasID(SpSum,79979666) then
      return SpSummon()
    end
    if #SetST>0 then
      return SetSpell(1)
    end
  end
  if HasIDNotNegated(Act,97077563,UseCotHHERO,2) then
    return Activate()
  end
  --if HasIDNotNegated(Act,32807846,UseRotaHero,1) then?
    --return {COMMAND_ACTIVATE,CurrentIndex}
  --end
  if HasID(Act,21143940,UseMaskChange) then
    return Activate()
  end
  if HasID(SpSum,18326736,SummonPtolemaeusHERO) then
    return XYZSummon(nil,18326736)
  end
  if HasID(SpSum,84013237,SummonUtopiaHERO,2) then
    return XYZSummon()
  end
  if HasID(SpSum,21501505,SummonCairngorgonHERO,1) then
    return XYZSummon()
  end
  if HasID(SpSum,82633039,SummonCastelHERO) then
    return XYZSummon()
  end
  if HasID(SpSum,06511113,SummonRafflesiaHERO) then
    return XYZSummon()
  end
  if HasID(SpSum,21501505,SummonCairngorgonHERO,2) then
    return XYZSummon()
  end
  if HasID(SpSum,84013237,SummonUtopiaHERO,3) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,00213326,UseEcall,3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,32807846,UseRotaHero,3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,08949584,UseAHL,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,70368879,UseUpstart,2) then
    return Activate()
  end
  if HasID(Sum,50720316,SummonShadowMist,1) then
    return Summon()
  end
  if HasIDNotNegated(Sum,18063928,SummonTinGoldfishHERO,3) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,25259669,SummonGoblindbergh,3) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  for i=1,#Sum do
    if SummonHERO(Sum[i],1) then
      return Summon(i)
    end
  end
  if HasIDNotNegated(Act,00213326,UseEcall,4) then
    return Activate()
  end
  if HasIDNotNegated(Act,32807846,UseRotaHero,4) then
    return Activate()
  end
  if HasIDNotNegated(Act,97077563,UseCotHHERO,3) then
    return Activate()
  end
  if HasID(SetMon,50720316,SetShadowMist) then
    return Set()
  end
  return nil
end
function RotaTarget(cards)
  if GlobalRotaTarget then
    local result = Add(cards,PRIO_TOHAND,1,FilterID,GlobalRotaTarget)
    GlobalRotaTarget = nil
    return result
  end
  return Add(cards)
end
function RoDTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return GlobalTargetGet(cards,true)
  end
  return BestTargets(cards,1,TARGET_DESTROY,RoDFilter)
end
function CCVTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return GlobalTargetGet(cards,true)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function AHLTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
function EcallTarget(cards)
  if GlobalEcallTarget then
    local result = Add(cards,PRIO_TOHAND,1,FilterID,GlobalEcallTarget)
    GlobalEcallTarget = nil
    return result
  end
  return Add(cards)
end
function MistTarget(cards)
  return Add(cards)
end
GlobalMaskChangeId = nil
function MaskChangeTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  if LocCheck(cards,LOCATION_EXTRA) then
    local id = GlobalMaskChangeId
    if id then
      GlobalMaskChangeId=nil
      return Add(cards,PRIO_TOFIELD,1,FilterID,id)
    end
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function MonkTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_DECK) and GlobalMonkTarget then
    result = Add(cards,PRIO_TOFIELD,1,FilterID,GlobalMonkTarget)
    GlobalMonkTarget = nil
    return result
  end
  return Add(cards,PRIO_TOFIELD)
end
function GoblindberghTarget(cards)
  if LocCheck(cards,LOCATION_HAND) and GlobalGoblindberghTarget then
    result = Add(cards,PRIO_TOFIELD,1,FilterID,GlobalGoblindberghTarget)
    GlobalGoblindberghTarget = nil
    return result
  end
  return Add(cards,PRIO_TOFIELD)
end
function KogaTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return BestTargets(cards,TARGET_PROTECT)
  end
  return GlobalTargetGet(cards,true)
end
function MaskChargeTarget(cards,min)
  return Add(cards,PRIO_TOHAND,min)
end
function HEROCard(cards,min,max,id,c)
  if id == 00423585 then
    return MonkTarget(cards)
  end
  if id == 25259669 then
    return GoblindberghTarget(cards)
  end
  if id == 83555666 then
    return RoDTarget(cards)
  end
  if id == 57728570 then
    return CCVTarget(cards)
  end
  if id == 08949584 then
    return AHLTarget(cards)
  end
  if id == 00213326 then
    return EcallTarget(cards)
  end
  if id == 50720316 then
    return MistTarget(cards)
  end
  if id == 21143940 then
    return MaskChangeTarget(cards,min)
  end
  if id == 87819421 then
    return MaskChargeTarget(cards,min)
  end
  return nil
end

function RoDFilter(c)
  if c.GetCode then
    atk = c:GetAttack()
    textatk = c:GetTextAttack()
  else
    atk = c.attack
    textatk = c.text_attack
  end
  return DestroyFilter(c)
  and FilterPosition(c,POS_FACEUP)
  and Targetable(c,TYPE_TRAP)
  and Affected(c,TYPE_TRAP)
  and textatk<AI.GetPlayerLP(1)
  and atk<=AI.GetPlayerLP(2)
end
function RoDFinishFilter(c)
  if c.GetCode then
    atk = c:GetAttack()
    textatk = c:GetTextAttack()
  else
    atk = c.attack
    textatk = c.text_attack
  end
  return RoDFilter(c)
  and textatk>=AI.GetPlayerLP(2)
end
function ChainRoD(c)
  local targets = SubGroup(OppMon(),RoDFilter)
  local targets2 = SubGroup(targets,PriorityTarget,true)
  local targets3 = SubGroup(targets,RoDFinishFilter,true)
  if RemovalCheckCard(c) and #targets>0 then
    return true
  end
  if #targets3>0 and UnchainableCheck(83555666) then
    BestTargets(targets3,1,TARGET_DESTROY)
    GlobalTargetSet(targets3[1])
    GlobalCardMode = 1
    return true
  end
  if #targets2>0 and UnchainableCheck(83555666) then
    BestTargets(targets2,1,TARGET_DESTROY)
    GlobalTargetSet(targets2[1])
    GlobalCardMode = 1
    return true
  end
  if IsBattlePhase() then
    local aimon,oppmon = GetBattlingMons()
    if WinsBattle(oppmon,aimon) 
    and RoDFilter(oppmon)
    and UnchainableCheck(83555666) 
    then
      GlobalTargetSet(oppmon)
      GlobalCardMode = 1
      return true
    end
  end
  if #OppMon()==1 and #targets==1 
  and Duel.GetCurrentPhase()==PHASE_END
  and ExpectedDamage(2)+targets[1].text_attack>AI.GetPlayerLP(2)
  and UnchainableCheck(83555666) 
  then
    return true
  end
  return false
end
function CCVFilter(c)
  local atk
  if c.GetCode then
    atk = c:GetAttack()
  else
    atk = c.attack
  end
  return FilterAttribute(c,ATTRIBUTE_DARK) and atk<=1000
end
function ChainCCV(card)
  local c = nil
  local targets = RemovalCheckList(AIMon(),nil,nil,nil,nil,CCVFilter)
  if targets and #targets == 1 then
    GlobalTargetSet(targets[1])
    GlobalCardMode = 1
    return true
  elseif targets and #targets > 1 then
    return true
  end
  if RemovalCheckCard(card) then
    return true
  end
  if IsBattlePhase() then
    local aimon,oppmon=GetBattlingMons()
    if WinsBattle(oppmon,aimon) 
    and CCVFilter(aimon) 
    then
      GlobalTargetSet(aimon)
      GlobalCardMode = 1
      return true
    end
  end
  local count = 0
  for i=1,#OppMon() do
    local c = OppMon()[i]
    if DestroyFilter(c)
    and c.attack>=1500
    and (FilterPosition(c,POS_FACEUP)
    or FilterPublic(c))
    then
      count=count+1
    end
  end
  if count>2 or count>1 and #OppMon()+#OppHand()>3 then
    return true
  end
  return false
end
function MaskChangeFilter(c,attribute)
  return HEROFilter(c)
  and FilterPosition(c,POS_FACEUP)
  and (not attribute or FilterAttribute(c,attribute))
end
function SummonDarkLaw(c,darkheroes,mode,bonus)
  local card = FindID(58481572,AIExtra())
  if not card then return false end
  if c or not bonus then bonus = 0 end
  --print("checking for Dark Law summon")
  local g = RemovalCheckList(darkheroes,nil,nil,true)
  if g and mode == 2 then 
    --print("dark hero about to be removed, chaining")
    BestTargets(g,1,TARGET_PROTECT)
    GlobalMaskChangeId = 58481572
    GlobalTargetSet(g[1])
    GlobalCardMode = 1
    return true
  end
  if (c and IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  or not c and BattlePhaseCheck())
  and CanFinishGame(card,nil,nil,bonus)
  and #OppMon()==0
  and mode == 1
  and ExpectedDamage(2)==0
  then
    --print("Dark Law can attack for game, chaining")
    if c then
      Add(darkheroes,PRIO_TOGRAVE,1,FilterID,50720316)
      GlobalMaskChangeId = 58481572
      GlobalTargetSet(darkheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  for i=1,Duel.GetCurrentChain() do
	local e = Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
    if e and Duel.GetChainInfo(i,CHAININFO_TRIGGERING_PLAYER)==1-player_ai
    and not HasIDNotNegated(AIMon(),58481572,true,FilterPosition,POS_FACEUP)
    and mode == 2
    then
      local ec = e:GetHandler()
      if bit32.band(e:GetCategory(),CATEGORY_SEARCH)>0
      and bit32.band(e:GetCategory(),CATEGORY_TOHAND)>0
      or Duel.GetOperationInfo(i,CATEGORY_DRAW)
      or Duel.GetOperationInfo(i,CATEGORY_TOGRAVE)
      or Duel.GetOperationInfo(i,CATEGORY_DECKDES)
      then
        --print("search, draw or dump effect activated, chaining")
        if c then
          GlobalMaskChangeId = 58481572
          GlobalTargetSet(darkheroes[1])
          GlobalCardMode = 1
        end
        return true
      end
      if Duel.GetOperationInfo(i,CATEGORY_SPECIAL_SUMMON)
      and FilterType(ec,TYPE_SPELL+TYPE_TRAP) 
      and (FilterType(ec,TYPE_RITUAL)
      or FilterSet(ec,0x46))
      and not ec:IsCode(01845204) -- Instant Fusion
      then
        --print("ritual or fusion summon, chaining")
        if c then
          GlobalMaskChangeId = 58481572
          GlobalTargetSet(darkheroes[1])
          GlobalCardMode = 1
        end
        return true
      end
    end
  end
  if IsBattlePhase() 
  and Duel.GetTurnPlayer()==1-player_ai
  and UnchainableCheck(21143940)
  and mode == 2
  then
    local aimon,oppmon = GetBattlingMons()
    if WinsBattle(oppmon,aimon) 
    and MaskChangeFilter(aimon,ATTRIBUTE_DARK)
    and oppmon:GetAttack()<2400
    then
      --print("dark hero about to be destroyed in battle, chaining")
      if c then
        GlobalMaskChangeId = 58481572
        GlobalTargetSet(aimon)
        GlobalCardMode = 1
      end
      return true
    end
  end
  local filter = function(tc)
    return CanWinBattle(tc,OppMon())
    and CanAttack(tc)
  end
  if (c and IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  or not c and BattlePhaseCheck())
  and CanWinBattle(card,OppMon())
  and mode == 2
  and #OppMon()>0
  and CardsMatchingFilter(AIMon(),filter)==0
  and (OppHasStrongestMonster() or HasID(AIMon(),50720316,true,FilterOPT,true))
  then
    --print("Dark Law can destroy something, chaining")
    if c then
      Add(darkheroes,PRIO_TOGRAVE,1,FilterID,50720316)
      GlobalMaskChangeId = 58481572
      GlobalTargetSet(darkheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  if Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetTurnPlayer()==1-player_ai 
  and HasID(darkheroes,50720316,true,FilterOPT,true)
  and MacroCheck()
  and Duel.GetCurrentChain()==0
  and mode == 2
  then
    --print("end phase, can trigger Shadow Mist, chaining")
    if c then
      Add(darkheroes,PRIO_TOGRAVE,1,FilterID,50720316)
      GlobalMaskChangeId = 58481572
      GlobalTargetSet(darkheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  return false
end
function SummonAcid(c,waterheroes,mode)
  local card = FindID(29095552,AIExtra())
  if not card then return false end
  local g = RemovalCheckList(waterheroes)
  if g and mode == 2 then 
    --print("water hero about to be removed, chaining")
    if c then
      BestTargets(g,1,TARGET_PROTECT)
      GlobalTargetSet(g[1])
      GlobalCardMode = 1
    end
    return true
  end
  if DestroyCheck(OppST())>2 and mode == 2 then
    --print("opponent has lots of S/T, can summon Acid, chaining")
    if c then
      BestTargets(waterheroes,1,TARGET_TOGRAVE)
      GlobalTargetSet(waterheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  if (c and IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  and ExpectedDamage(2)==0
  or not c and BattlePhaseCheck())
  and CanFinishGame(card,nil,nil,bonus)
  and #OppMon()==0
  and mode == 1
  then
    --print("Acid can attack for game, chaining")
    if c then
      GlobalTargetSet(waterheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  return false
end
function KogaTargetFilter(c,atk)
  local KogaAtk = 2500+500*#OppMon()
  local OppAtk = c.attack
  local Heroes = SubGroup(AIGrave(),HEROFilter)
  if Heroes and #Heroes>0 then
    SortByATK(Heroes,true)
    atk = math.min(atk,Heroes[1].attack)
  end
  if Affected(c,TYPE_MONSTER,8) and Targetable(c,TYPE_MONSTER) 
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and BattleDamageCheck(c,FindID(50608164,AIExtra()))
  then
    OppAtk = math.max(0,OppAtk-atk)
  end
  return AI.GetPlayerLP(2)<=KogaAtk-OppAtk
end
function SummonKoga(c,lightheroes,mode)
  local card = FindID(50608164,AIExtra())
  if not card then return false end
  --print("checking for Koga summon")
  local g = RemovalCheckList(lightheroes)
  if g and mode == 2 then 
    --print("light hero about to be removed, chaining")
    if c then 
      BestTargets(g,1,TARGET_PROTECT)
      GlobalTargetSet(g[1])
      GlobalCardMode = 1
    end
    return true
  end
  SortByATK(lightheroes,true)
  if (c and IsBattlePhase() and Duel.GetTurnPlayer()==player_ai
  or not c and BattlePhaseCheck())
  and CardsMatchingFilter(OppMon(),KogaTargetFilter,lightheroes[1].attack)>0 
  and mode == 1
  then
    --print("Koga can attack for game, chaining")
    if c then
      GlobalTargetSet(lightheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  if (c and IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  and ExpectedDamage(2)==0
  or not c and BattlePhaseCheck())
  and CanFinishGame(card,nil,nil,bonus)
  and #OppMon()==0
  and mode == 1
  then
    --print("Koga can attack for game, chaining")
    if c then
      GlobalTargetSet(lightheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  return false
end
function SummonAnki(c,darkheroes,mode,bonus)
  local card = FindID(59642500,AIExtra())
  if not card then return false end
  if c or not bonus then bonus = 0 end
  local g = RemovalCheckList(darkheroes)
  if g and mode == 2 then 
    --print("dark hero about to be removed, chaining")
    if c then 
      GlobalMaskChangeId = 59642500
      BestTargets(g,1,TARGET_PROTECT)
      GlobalTargetSet(g[1])
      GlobalCardMode = 1
    end
    return true
  end
  if (c and IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  or not c and BattlePhaseCheck())
  and CanFinishGame(card,nil,1400)
  and #OppMon()>0
  and mode == 1
  then
    --print("Anki can attack directly for game, chaining")
    if c then
      Add(darkheroes,PRIO_TOGRAVE,1,FilterID,50720316)
      GlobalMaskChangeId = 59642500
      GlobalTargetSet(darkheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  if (c and IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  and ExpectedDamage(2)==0
  or not c and BattlePhaseCheck())
  and CanFinishGame(card,nil,nil,bonus)
  and #OppMon()==0
  and mode == 1
  then
    --print("Anki can attack for game, chaining")
    if c then
      Add(darkheroes,PRIO_TOGRAVE,1,FilterID,50720316)
      GlobalMaskChangeId = 59642500
      GlobalTargetSet(darkheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  local filter = function(tc)
    return CanWinBattle(tc,OppMon())
    and CanAttack(tc)
  end
  if (c and IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  or not c and BattlePhaseCheck())
  and CanWinBattle(card,OppMon(),true)
  and mode == 2
  and #OppMon()>0
  and CardsMatchingFilter(AIMon(),filter)==0
  and CardsMatchingFilter(AIDeck(),ChangeFilter)>0
  and (OppHasStrongestMonster() or HasID(AIMon(),50720316,true,FilterOPT,true))
  then
    --print("Anki might get a search, chaining")
    if c then
      Add(darkheroes,PRIO_TOGRAVE,1,FilterID,50720316)
      GlobalMaskChangeId = 59642500
      GlobalTargetSet(darkheroes[1])
      GlobalCardMode = 1
    end
    return true
  end
  return false
end
function ChainMaskChange(c)
  local heroes = SubGroup(AIMon(),HEROFilter)
  heroes = SubGroup(heroes,FilterPosition,POS_FACEUP)
  local mheroes = SubGroup(AIExtra(),MHEROFilter)
  if RemovalCheckCard(c) then
    return true
  end
  if not UnchainableCheck(21143940) then
    return false
  end
  local temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_DARK)
  if #temp>0 
  and HasIDNotNegated(mheroes,58481572,true)
  and SummonDarkLaw(c,temp,1)
  then
    return true
  end
  temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_DARK)
  if #temp>0 
  and HasIDNotNegated(mheroes,58481572,true)
  and SummonAnki(c,temp,1)
  then
    return true
  end
  temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_LIGHT)
  if #temp>0
  and HasIDNotNegated(mheroes,50608164,true)
  and SummonKoga(c,temp,1)
  then
    return true
  end
  temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_WATER)
  if #temp>0
  and HasIDNotNegated(mheroes,29095552,true)
  and SummonAcid(c,temp,1)
  then
    return true
  end
  temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_DARK)
  if #temp>0 
  and HasIDNotNegated(mheroes,58481572,true)
  and SummonAnki(c,temp,2)
  then
    return true
  end
  temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_DARK)
  if #temp>0 
  and HasIDNotNegated(mheroes,58481572,true)
  and SummonDarkLaw(c,temp,2)
  then
    return true
  end
  temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_WATER)
  if #temp>0
  and HasIDNotNegated(mheroes,29095552,true)
  and SummonAcid(c,temp,2)
  then
    return true
  end
  temp = SubGroup(heroes,FilterAttribute,ATTRIBUTE_LIGHT)
  if #temp>0
  and HasIDNotNegated(mheroes,50608164,true)
  and SummonKoga(c,temp,2)
  then
    return true
  end
  return false
end
function ChainKoga(cards)
  local aimon,oppmon=GetBattlingMons() 
  local atk = 0
  local Heroes = SubGroup(AIGrave(),HEROFilter)
  if Heroes and #Heroes>0 then
    SortByATK(Heroes,true)
    atk = Heroes[1].attack
  end
  if aimon and (AttackBoostCheck(0,atk) 
  or CanFinishGame(aimon,oppmon,nil,nil,atk))
  and UnchainableCheck(50608164)
  then
    GlobalTargetSet(oppmon)
    return true
  end
  return false
end
function ChainCotHHERO(c)
  if HasIDNotNegated(AIGrave(),50720316,true,FilterOPT,true)
  and CardsMatchingFilter(AIDeck(),ChangeFilter)>0
  and Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetTurnPlayer()==1-player_ai
  and UnchainableCheck(c.id)
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(50720316),AIGrave())
    return true
  end
  if HasIDNotNegated(AICards(),21143940,true)
  and #OppMon()==0
  and ExpectedDamage()==0
  and Duel.GetCurrentPhase()==PHASE_BATTLE
  and Duel.GetTurnPlayer==player_ai
  then
    return true
  end
end
function HEROChain(cards)
  if HasID(cards,83555666,ChainRoD) then -- Ring of Destruction
    return {1,CurrentIndex}
  end
  if HasID(cards,57728570,ChainCCV) then -- Crush Card Virus
    return {1,CurrentIndex}
  end
  if HasID(cards,58481572) then -- Dark Law
    return {1,CurrentIndex}
  end
  if HasID(cards,50720316) then -- Shadow Mist
    OPTSet(50720316)
    return {1,CurrentIndex}
  end
  if HasID(cards,63060238) then -- Blazeman
    OPTSet(63060238)
    return {1,CurrentIndex}
  end
  if HasID(cards,79979666) then -- Bubbleman
    return {1,CurrentIndex}
  end
  if HasID(cards,21143940,ChainMaskChange) then
    return {1,CurrentIndex}
  end
  if HasID(cards,50608164,ChainKoga) then
    return {1,CurrentIndex}
  end
  if HasID(cards,97077563,ChainCotHHERO) then
    return {1,CurrentIndex}
  end
  return nil
end

function HEROEffectYesNo(id,card)
  local result = nil
  if id == 58481572 -- Dark Law
  then
    result = 1
  end
  if id == 50720316 -- Shadow Mist
  then
    OPTSet(50720316)
    result = 1
  end
  if id == 63060238 -- Blazeman
  then
    OPTSet(63060238)
    result = 1
  end
  if id == 79979666 -- Bubbleman
  then
    result = 1
  end
  if id == 25259669 -- and UseGoblindbergh()
  then
    result = 1
  end
  return result
end

function HEROOption(options)
  return nil
end

function HEROYesNo(id)
  local c = FindID(59642500,AIMon())
  if id == 31 and c
  and CanFinishGame(c,nil,1400)
  then
    return 1
  else
    return 0
  end
  return nil
end

function HEROMaterial(cards,min,max,id)
  local filter = nil
  if HasID(cards,50720316,true) and HasID(AICards(),21143940,true)
  and HasIDNotNegated(AIExtra(),58481572,true)
  then
    filter = function(c) return not FilterID(c,50720316) end
  end
  if id == 18326736 then -- Ptolemaios
    return Add(cards,PRIO_TOGRAVE,math.max(min,math.min(3,max)),filter)
  end
  return Add(cards,PRIO_TOGRAVE,min,filter)
end

HEROAtt={
69884162, -- Neos Alius
95486586, -- Core
03642509, -- Great Tornado
22093873, -- Divine Wind
01945387, -- Nova Master
22061412, -- The Shining
29095552, -- Acid
33574806, -- Escuridao
40854197, -- Absolute Zero
50608164, -- Koga
58481572, -- Dark Law
16304628, -- Gaia
59642500, -- Anki
}
HEROVary={
}
HERODef={
18063928, -- Tin Goldfish
25259669, -- Goblindbergh
00423585, -- Summoner Monk
79979666, -- Bubbleman
63060238, -- Blazeman
--50720316, -- Shadow Mist
}
function HEROPosition(id,available)
  result = nil
  for i=1,#HEROAtt do
    if HEROAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end  
  for i=1,#HEROVary do
    if HEROVary[i]==id 
    then 
      if (BattlePhaseCheck())
      and Duel.GetTurnPlayer()==player_ai 
      then 
        result=POS_FACEUP_ATTACK
      else 
        result=POS_FACEUP_DEFENSE 
      end
    end
  end
  for i=1,#HERODef do
    if HERODef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  if id == 50720316 then
    local c = FindID(50720316,AIAll())
    if BattlePhaseCheck()  and (#OppMon()==0 
    or CanWinBattle(c,OppMon())) and HasID(AICards(),21143940,true)
    then
      result=POS_FACEUP_ATTACK
    else
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end

