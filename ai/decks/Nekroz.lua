function NekrozPriority()
AddPriority(
{
-- Nekroz: 
[90307777] = {6,3,1,1,1,1,1,1,1,1,ShritCond},         -- Shrit, Caster of Nekroz
[52738610] = {3,2,1,1,8,1,1,1,5,1,PrincessCond},      -- Nekroz Dance Princess
[53180020] = {5,2,1,1,6,1,1,1,9,1,ExaCond},           -- Exa, Enforcer of the Nekroz
[27796375] = {4,2,1,1,7,1,1,1,8,1,SorcererCond},      -- Great Sorcerer of the Nekroz

[25857246] = {6,2,3,1,3,1,1,1,3,1,ValkCond},          -- The Nekroz of Valkyrus
[99185129] = {12,2,4,1,5,1,1,1,2,1,ClausCond},        -- The Nekroz of Clausolas
[89463537] = {8,1,7,1,4,1,1,1,6,1,UniCond},           -- The Nekroz of Unicore
[26674724] = {9,3,4,1,4,1,1,1,4,1,BrioCond},          -- The Nekroz of Brionac
[74122412] = {4,2,3,1,4,1,1,1,7,1,GungCond},          -- The Nekroz of Gungnir
[52068432] = {7,2,6,1,3,1,1,1,5,1,TrishCond},         -- The Nekroz of Trishula
[88240999] = {5,2,5,1,1,1,1,1,3,1,ArmorCond},         -- The Nekroz of Decisive Armor
[52846880] = {6,2,4,1,1,1,1,1,4,1,NekrozCatastorCond},-- The Nekroz of Catastor

[67696066] = {6,2,5,1,6,1,1,1,1,1,ClownCond},         -- Performage Trick Clown
[68819554] = {3,1,2,1,5,1,1,1,1,1,JugglerCond},       -- Performage Damage Juggler
[31292357] = {7,1,3,1,2,1,1,1,1,1,HatCond},           -- Performage Hat Tricker

[29888389] = {1,1,1,1,1,1,1,1,1,1,ShadowCond},        -- Gishki Shadow
[08903700] = {3,1,1,1,9,2,1,1,1,1,ReleaserCond},      -- Djinn Releaser of Rituals
[95492061] = {10,1,1,1,5,1,1,1,1,1,ManjuCond},        -- Manju of the Ten Thousand Hands
[23401839] = {9,1,1,1,6,1,1,1,1,1,SenjuCond},         -- Senju of the Thousand Hands
[13974207] = {3,1,1,1,6,1,1,1,1,1,SekkaCond},         -- Denkou Sekka
[30312361] = {2,1,1,1,7,1,1,1,1,1,nil},               -- Phantom of Chaos


[96729612] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Preparation of Rites
[14735698] = {10,3,1,1,3,1,1,1,1,1,ExoCond},          -- Nekroz Exomirror
[51124303] = {11,2,1,1,3,1,1,1,1,1,KaleidoCond},      -- Nekroz Kaleidomirror
[97211663] = {11,2,1,1,3,1,1,1,1,1,CycleCond},        -- Nekroz Cycle

[35952884] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Shooting Quasar Dragon
[24696097] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Shooting Star Dragon
[79606837] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Herald of Rainbow Light
[15240268] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Mist Bird Clausolas
[95113856] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Phantom Fortress Enterblathnir
[44505297] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Inzektor Exa-Beetle
[08809344] = {1,1,1,1,6,3,1,1,1,1,NyarlaCond},        -- Outer God Nyarla
[31563350] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Zubaba General
[86346643] = {1,1,1,1,5,1,1,1,1,1,nil},               -- Rainbow Neos
[63465535] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Underground Arachnid
}
)
end

function NekrozFilter(c,exclude)
  return IsSetCode(c.setcode,0xb4) and (exclude == nil or c.id~=exclude)
end
function NekrozMonsterFilter(c,ritual)
  return FilterType(c,TYPE_MONSTER) and NekrozFilter(c)
  and (not ritual or FilterType(c,TYPE_RITUAL))
end
function CheckLvlSum(cards,level,lvlrestrict)
  local levels = {}
  local count = 0
  for i=1,#cards do
    if cards[i].level>0 and (cards[i].level<level 
    or cards[i].level==level and not lvlrestrict)
    then 
      levels[#levels+1] = cards[i].level
    end
  end
  for i=1,#levels do
    if levels[i]==level then
      count = count + 1
      if count > 1 then
        return true
      end
    end
  end
  levels[0]=0
  -- there is probably a better method to check all possible sums, but for now
  for i=1,#levels do
    for j=0,#levels do
      for k=0,#levels do
        if levels[i]>0 and i~=j and i~=k and j~=k then
          if levels[i]+levels[j]+levels[k] == level then
            return true
          end
        end
      end
    end
  end
  return false
end
function ExoFilter(c)
  return NekrozMonsterFilter(c) or c.id==08903700 -- Djinn Releaser
end
function RitualTributeCheck(level,mirror,lvlrestrict,fav)
  local cards
  local ritual=UseLists(AIHand(),AIST())
  if mirror == 1 or mirror == 0 and HasID(ritual,51124303) then -- Kaleidomirror 
    cards = UseLists(AIHand(),AIMon(),AIExtra())
    if fav then cards = AIExtra() end
    local result = false
    if not lvlrestrict then
      result = CardsMatchingFilter(cards,FilterLevel,level)>0
    end
    if level == 3 and HasID(AIGrave(),08903700,true) then -- Djinn Releaser
      result = true
    end
    return HasID(UseLists(AIHand(),AIMon()),90307777,true) or result
  elseif mirror == 2 or mirror == 0 and HasID(ritual,14735698)then -- Exomirror
    cards = UseLists(AIHand(),AIMon(),SubGroup(AIGrave(),ExoFilter))
    if fav then cards = SubGroup(AIGrave(),ExoFilter) end
    local result = CheckLvlSum(cards,level,lvlrestrict)
    return HasID(UseLists(AIHand(),AIMon(),SubGroup(AIGrave(),ExoFilter)),90307777,true) or result
  elseif mirror == 3 or mirror == 0 and HasID(ritual,97211663) then -- Cycle
    cards = UseLists(AIHand(),AIMon())
    local result = CheckLvlSum(cards,level,lvlrestrict)
    return HasID(cards,90307777,true) or (result and not fav)
  end
end
function RitualSpellCheck(cards)
  if cards == nil then cards = UseLists(AIHand(),AIST()) end
  return HasID(cards,14735698,true) or HasID(cards,51124303,true) or HasID(cards,97211663,true)
end
function NekrozOTKCheck()
  local cards=UseLists({AIMon(),AIExtra()})
  return Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
  and DualityCheck() and NobleSSCheck() and AI.GetPlayerLP(2)<=8000 and AI.GetPlayerLP(2)>4000
  and #OppField()==0 and HasID(cards,31563350,true) and HasID(UseLists(AIHand(),AIST()),52068432,true)
  and HasID(AIHand(),88240999,true) and HasID(AIHand(),14735698,true) 
  and OPTCheck(14735698) and (RitualTributeCheck(10,2,true) 
  or HasID(AIGrave(),26674724,true) and HasID(AIMon(),89463537,true))
end
ReleaserList = {}
function ReleaserCheck(c)
  for i=1,#ReleaserList do
    if ReleaserList[i]==c.cardid then
      return true
    end
  end
  return false
end
function ReleaserSet(id)
  ReleaserList[#ReleaserList+1]=id
end
function ShritCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),90307777,true) and Duel.GetTurnPlayer()==player_ai
  end
  return true
end
function SearchCheck()
  return (HasID(AIHand(),95492061,true) or HasID(AIHand(),23401839,true))
  and not NormalSummonCheck()
end
function ExaCond(loc,c)
  return true
end
function SorcererCond(loc,c)
  return true
end
function ShadowCond(loc,c)
  return true
end
function ShadowCond(loc,c)
  return true
end
function NekrozCatastorCond(loc,c)
  return true
end
function ClausCond(loc,c)
  if loc == PRIO_TOHAND then
    return ((not RitualSpellCheck() or (HasID(AIHand(),89463537,true) or SearchCheck())
    and not HasID(AIHand(),51124303,true))
    and UseClaus() and not HasID(AIHand(),99185129,true)
    and not GlobalPreparation
    and not (#AIMon()==0 and RitualSpellCheck(AIGrave())))
    and Duel.GetTurnPlayer()==player_ai
  end
  if loc == PRIO_TOFIELD then
    return HasID(AIGrave(),08903700,true) -- adjust for turn 1 releaser claus
  end
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_MZONE) then
    return not ReleaserCheck(c)
  end
  return true
end
function UniCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),89463537,true)
    and HasID(AIHand(),51124303,true) 
    and Duel.GetTurnPlayer()==player_ai
  end
  if loc == PRIO_TOFIELD then
    return false
  end
  return true
end
function BrioCond(loc,c)
  if loc == PRIO_TOHAND then
    return UseBrio() and Duel.GetTurnPlayer()==player_ai
    and not FilterLocation(c,LOCATION_GRAVE)
  end
  if loc == PRIO_TOFIELD then
    return SummonBrio()
  end
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_MZONE) then
    return not ReleaserCheck(c)
  end
  return true
end
function GungCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),74122412,true) and Duel.GetTurnPlayer()==player_ai
  end
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_MZONE) then
    return not ReleaserCheck(c)
  end
  return true
end
function TrishCond(loc,c)
  if loc == PRIO_TOHAND then
    return UseTrishula() and Duel.GetTurnPlayer()==player_ai and not HasID(AIHand(),52068432,true)
  end
  if loc == PRIO_TOFIELD then
    return UseTrishula()
  end
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_MZONE) then
    return not ReleaserCheck(c)
  end
  return true
end
function ValkCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),25857246,true)
  end
  if loc == PRIO_TOFIELD then
    return true
  end
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_MZONE) then
    return not ReleaserCheck(c)
  end
  return true
end
function ArmorCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),88240999,true) and Duel.GetTurnPlayer()==player_ai
  end
  if loc == PRIO_TOFIELD then
    return UseArmor()
  end
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_MZONE) then
    return not ReleaserCheck(c)
  end
  return true
end
function ExoCond(loc,c)
  if loc == PRIO_TOHAND then
    return (not RitualSpellCheck() and OPTCheck(14735698)
    and not (#AIMon()==0 and RitualSpellCheck(AIGrave()))
    and (HasID(AIHand(),52068432,true) and SummonTrishula()
    or HasID(AIHand(),25857246,true) or HasID(AIHand(),88240999,true)))
    and Duel.GetTurnPlayer()==player_ai
  end
  return true
end
function ManjuCond(loc,c)
  if loc == PRIO_TOHAND then
    return not (HasID(AIHand(),95492061,true) 
    or HasID(AIHand(),23401839,true))
  end
  return true
end
function UnicoreCheck()
  return HasID(AIHand(),89463537,true) and HasID(UseLists(AIHand(),AIST()),51124303,true) 
  and HasID(AIExtra(),79606837,true) and OPTCheck(51124303) and DualityCheck()
end
function CycleReleaserCheck(kaleido)
  return HasID(AIGrave(),99185129,true) and (HasID(AIGrave(),08903700,true)
    or FieldCheck(4)>1 and HasID(AIExtra(),34086406,true) and HasID(AIDeck(),08903700,true)
    or FieldCheck(4)==1 and UnicoreCheck() or HasID(UseLists(AIHand(),AIMon()),08903700,true) or kaleido)
    and OppGetStrongestAttack() <= 2300
end
function CycleCond(loc,c)
  if loc == PRIO_TOHAND then
    return (not RitualSpellCheck() and OPTCheck(97211663)
    and not (#AIMon()==0 and RitualSpellCheck(AIGrave()))
    and (HasID(AIHand(),90307777,true)
    and (HasID(AIGrave(),52068432,true) and SummonTrishula()
    or HasID(AIGrave(),25857246,true) or HasID(AIGrave(),88240999,true)))
    or CycleReleaserCheck())
    and not HasID(UseLists(AIHand(),AIST()),97211663)
    and Duel.GetTurnPlayer()==player_ai
  end
  return true
end
function KaleidoCond(loc,c)
  if loc == PRIO_TOHAND then
    return ((not RitualSpellCheck() 
    or (HasID(AIHand(),89463537,true) and SummonUnicore(1) or QuasarComboCheck(true))
    and not HasID(AIHand(),51124303,true)) and OPTCheck(51124303)
    and not (#AIMon()==0 and RitualSpellCheck(AIGrave())))
    and Duel.GetTurnPlayer()==player_ai
  end
  return true
end
function PrincessFilter(c)
  return NekrozMonsterFilter(c)
end
function PrincessCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(AIBanish(),PrincessFilter)>0 and not FilterLocation(c,LOCATION_MZONE)
  end
  return true
end
function NyarlaCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return HasID(c.xyz_materials,79606837,true)
  end
  return true
end
function SekkaFilter(c)
  return FilterType(c,TYPE_SPELL+TYPE_TRAP) and FilterPosition(c,POS_FACEDOWN)
end
function SekkaCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(AIST(),SekkaFilter)>0 and CardsMatchingFilter(OppST(),SekkaFilter)==0
  end
  return true
end
function UseTrishula()
  return #OppHand()>0 and #OppField()>0 and #OppGrave()>0
  and OPTCheck(52068432)
end
function SummonTrishula(mirror)
  return DualityCheck() and RitualTributeCheck(9,mirror,true)
end
function SummonUnicore(mirror)
  return DualityCheck() and mirror == 1 
  and HasID(AIExtra(),79606837,true)
  and not HasID(AIMon(),79606837,true)
  and #AIGrave()<10
  --or RitualTributeCheck(4,mirror) 
  --and FieldCheck(4) == 1)
end
function ArmorFilter(c)
  return FilterPosition(c,POS_FACEDOWN) 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function UseArmor()
  return CardsMatchingFilter(OppField(),ArmorFilter)>0
end
function SummonArmor(mirror)
  return DualityCheck() and RitualTributeCheck(10,mirror,true)
end
function UseClaus()
  return (NeedsCard(51124303,AIDeck(),AIHand(),true) and OPTCheck(51124303)
       or NeedsCard(14735698,AIDeck(),AIHand(),true) and OPTCheck(14735698)
       or NeedsCard(97211663,AIDeck(),AIHand(),true) and OPTCheck(97211663))
      and OPTCheck(99185129)
end
function UseBrio()
  return OPTCheck(26674724) and not QuasarComboCheck() and not SummonBrio(0)
end
function BrioFilter(c)
  return FilterLocation(c,LOCATION_MZONE) and FilterPreviousLocation(c,LOCATION_EXTRA) 
  and FilterSummon(c,SUMMON_TYPE_SPECIAL) and FilterPosition(c,POS_FACEUP) 
  and Targetable(c,TYPE_MONSTER) and Affected(c,TYPE_MONSTER,6)
  and CurrentOwner(c)==2
end
function SummonBrio(mirror)
  return OPTCheck(266747241) and CardsMatchingFilter(OppMon(),BrioFilter)>1 
  and (mirror==nil or RitualTributeCheck(6,mirror,false))
end
function UseBrioField()
  return OPTCheck(266747241) and CardsMatchingFilter(OppMon(),BrioFilter)>0
end
function UseUnicore()
  return not SummonUnicore(1) and OPTCheck(89463537)
  and not HasID(UseLists(AIHand(),AIST()),97211663,true) and UseCycle()
end
function SummonValk(mirror)
  return DualityCheck() and RitualTributeCheck(8,mirror,true,true)
end
function UseValk(check)
  return PriorityCheck(AIMon(),PRIO_TOGRAVE)>2 and (MP2Check() or check) 
  and OPTCheck(25857246) and #AIHand()<5
end
function RitualSummonCheck(mirror)
  local cards = UseLists(AIHand(),AIMon(),AIGrave())
  local rituals = AIHand()
  local result = false
  if mirror == 3 then rituals = AIGrave() end
  if HasID(rituals,89463537,true) 
  and SummonUnicore(mirror) 
  then
    result = true
  end
  if HasID(rituals,52068432,true) 
  and SummonTrishula(mirror)
  and (UseTrishula())-- or HasID(cards,08903700,true))
  then
    result = true
  end
  if HasID(rituals,88240999,true)
  and SummonArmor(mirror)
  and (UseArmor() or NekrozOTKCheck())
  then
    result = true
  end
  if HasID(rituals,25857246,true)
  and SummonValk(mirror)
  and OPTCheck(25857246)
  then
    result = true
  end
  if HasID(rituals,99185129,true)
  and HasID(cards,08903700,true)
  then
    result = true
  end
  if HasID(rituals,26674724,true)
  and SummonBrio(mirror)
  then
    result = true
  end
  return result
end
function SummonDenkou()
  return CardsMatchingFilter(AIST(),FilterPosition,POS_FACEDOWN)==0
  or FieldCheck(4)==1
end
GlobalPreparation = nil
function UsePreparation()
  if (NeedsCard(51124303,AIGrave(),AIHand(),true) --and OPTCheck(51124303)
  or NeedsCard(14735698,AIGrave(),AIHand(),true) --and OPTCheck(14735698)
  or NeedsCard(97211663,AIGrave(),AIHand(),true)) --and OPTCheck(97211663))
  and #AIHand()<6
  then
    GlobalPreparation = true
    return true 
  end
  return CardsMatchingFilter(UseLists(AIMon(),AIHand()),NekrozMonsterFilter,true)==0 
  and (not HasID(AIHand(),95492061,true) and not HasID(AIHand(),23401839,true) or NormalSummonCheck(player_ai))
end
function SummonNyarla()
  return DualityCheck() and MP2Check()
  and HasID(AIExtra(),08809344,true)
  and HasID(AIGrave(),79606837,true)
  --and (Duel.GetTurnCount() == 1 
  --or CardsMatchingFilter(AIGrave(),FilterID,79606837)>0)
end
function SummonChainNekroz()
  return DualityCheck() --and MP2Check()
  and HasID(AIExtra(),34086406,true)
  and HasID(AIDeck(),08903700,true)
  --and CardsMatchingFilter(AIHand(),NekrozMonsterFilter,true)>0
  and RitualSpellCheck()
  and ((Chance(50) or not SummonNyarla() 
  or HasID(AIHand(),97211663,true) and HasID(AIGrave(),99185129,true))) 
  and MP2Check(1800)
  or SummonTrishula(2) and UseTrishula()
  and HasID(AIHand(),52068432,true) 
  and HasID(AIHand(),14735698,true)
end
function SummonExaBeetle()
  return HasID(AIGrave(),35952884,true) and HasID(AIExtra(),44505297,true)
  and HasID(AIExtra(),24696097,true) and DualityCheck() and UseExaBeetle()
end
function ExaBeetleFilter(c)
  return FilterPosition(c,POS_FACEUP)
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function UseExaBeetle()
  return CardsMatchingFilter(OppField(),ExaBeetleFilter)>0
end
function SummonZubaba()
  return NekrozOTKCheck()
end
function ZubabaFilter(c)
  return FilterType(c,TYPE_MONSTER) and FilterRace(c,RACE_WARRIOR)
  and c.attack>=1500
end
function UseZubaba()
  return CardsMatchingFilter(AIHand(),ZubabaFilter)>0
end
function UseEnterblathnir(cards)
  if cards == nil then cards = UseLists(OppHand(),OppField()) end
  return #cards>0
end
function SummonEnterblathnir()
  return DualityCheck() and HasID(AIExtra(),95113856,true)
  and MP2Check() and #UseLists(OppHand(),OppMon())>0
end
function UseTradeIn()
  return true
end
function UseChainNekroz1()
  return DeckCheck(DECK_NEKROZ) and HasID(AIDeck(),08903700,true)
end
function UseChainNekroz2() 
  if DeckCheck(DECK_NEKROZ) and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed 
  or HasID(AIMon(),25857246,true) and UseValk())
  then
    GlobalStacked=Duel.GetTurnCount()
    return true
  end
  return false
end
function SummonDancePrincess()
  return true
end
function SummonPoC()
  return UsePoC() and not QuasarComboCheck()
end
function UsePoC()
  return HasID(AIGrave(),86346643,true) and UseRainbowNeos()
  or HasID(AIGrave(),26674724,true) and UseBrioField()
  or NeedsCard(25857246,AIGrave(),AIField(),true) and OPTCheck(25857246)
  or NeedsCard(88240999,AIGrave(),AIField(),true) and UseArmor()
  or HasID(AIGrave(),35952884,true) and #OppMon()>0
  or HasID(AIGrave(),63465535,true)
end
function UseArachnid()
  return true
end
function UseRainbowNeos(mode)
  return (mode == nil or mode == 1) and #OppMon()>2 
  or     (mode == nil or mode == 2) and #OppST()>1 
  or     (mode == nil or mode == 3) and #OppGrave()>5
end
function RainbowNeosCheck()
  return HasID(AIHand(),30312361,true) and HasID(AIExtra(),86346643,true)
  and (HasID(AIHand(),99185129,true) and HasID(AIHand(),74122412,true)
  or HasID(AIHand(),89463537,true) and HasID(AIHand(),26674724,true))
end
function UseKaleido()
  return RitualSummonCheck(1) or QuasarComboCheck() or RainbowNeosCheck()
end
function UseExo()
  return RitualSummonCheck(2) 
end
function UseCycle()
  return RitualSummonCheck(3) 
end
function NekrozInit(cards)
  GlobalPreparation = nil
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,86346643,false,1381546289) and UseRainbowNeos(1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,86346643,false,1381546290) and UseRainbowNeos(2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,86346643,false,1381546291) and UseRainbowNeos(3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,30312361) and UsePoC() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,63465535) and UseArachnid() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,26674724,false,nil,LOCATION_MZONE) and UseBrioField() then
    OPTSet(266747241)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,38120068) and UseTradeIn() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,96729612) and UsePreparation() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,51124303,false,nil,LOCATION_GRAVE) and #AIHand()<6 then -- Kaleido grave
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,97211663,false,nil,LOCATION_GRAVE) and #AIHand()<6 then -- Cycle grave
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end 
  if HasID(Act,14735698,false,nil,LOCATION_GRAVE) and #AIHand()<6 then -- Exo grave
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end 
  if HasID(Act,32807846) and UseRotA() then  -- RotA
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,08809344) then -- Nyarla
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,99185129,false,nil,LOCATION_HAND) and UseClaus() then
    OPTSet(99185129)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,26674724,false,nil,LOCATION_HAND) and UseBrio() then
    OPTSet(26674724)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,88240999,false,nil,LOCATION_MZONE) and UseArmor() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,89463537,false,nil,LOCATION_HAND) and UseUnicore() then
    OPTSet(89463537)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end  
  if HasID(Act,44505297) and UseExaBeetle() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,23401839) then -- Senju
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,95492061) then -- Manju
    return {COMMAND_SUMMON,CurrentIndex}
  end 
  if HasID(Sum,13974207) and SummonDenkou() then 
    return {COMMAND_SUMMON,CurrentIndex}
  end 
  if HasID(Sum,52738610) and SummonDancePrincess() then 
    return {COMMAND_SUMMON,CurrentIndex}
  end   
  if HasID(Sum,30312361) and SummonPoC() then 
    return {COMMAND_SUMMON,CurrentIndex}
  end 
  if HasID(SpSum,31563350) and SummonZubaba() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end  
  if HasID(Act,31563350) and UseZubaba() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,34086406) and SummonChainNekroz() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end 
  if HasIDNotNegated(Act,34086406,false,545382497) and UseChainNekroz1() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end    
  if HasID(SpSum,08809344) and SummonNyarla() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end  
  if HasID(SpSum,44505297) and SummonExaBeetle() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end 
  if HasID(Act,95113856) and UseEnterblathnir() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end   
  if HasID(SpSum,95113856) and SummonEnterblathnir() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end 
  if HasID(Act,51124303,false,nil,LOCATION_HAND+LOCATION_SZONE) and UseKaleido() then 
    OPTSet(51124303)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,97211663,false,nil,LOCATION_HAND+LOCATION_SZONE) and UseCycle() then
    OPTSet(97211663)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,14735698,false,nil,LOCATION_HAND+LOCATION_SZONE) and UseExo() then
    OPTSet(14735698)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,34086406,false,545382498) and UseChainNekroz2() then
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end 
  if HasID(Act,25857246,false,nil,LOCATION_MZONE) and UseValk() then
    OPTSet(25857246)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SetMon,08903700) then -- Djinn Releaser
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  return nil
end

function NekrozOption(options)
  for i=1,#options do
    if options[i] == 1521821697 then -- Enterblathnir control
      return i
    end
    if options[i] == 1521821698 then -- Enterblathnir hand
      return i
    end
    if options[i] == 1521821699 then -- Enterblathnir grave
      return i
    end
  end
end
function QuasarComboCheck(skipmirror)
  return HasID(AIExtra(),35952884,true) and HasID(AIExtra(),24696097,true)
  and HasID(AIExtra(),44505297,true) and CardsMatchingFilter(AIHand(),FilterID,26674724)==2
  and (skipmirror or HasID(AIHand(),51124303,true))
  and UseExaBeetle() and DualityCheck()
end

function QuasarTrishulaCheck()
  return HasID(AIExtra(),35952884,true) and HasID(AIHand(),99185129,true)
  and HasID(AIHand(),52068432,true) and DualityCheck() and UseTrishula()
end
GlobalKaleidoTarget = nil
GlobalExoTarget = nil
GlobalCycleTarget = nil
function KaleidoTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_BANISH)
  end
  if FilterLocation(cards[1],LOCATION_DECK) 
  and FilterType(cards[1],TYPE_SPELL) 
  then
    return ClausTarget(cards)
  end
  local c = FindCard(GlobalKaleidoTarget)
  if c then
    return Add(cards,PRIO_TOFIELD)
  end
  local result = {math.random(#cards)}
  for i=1,#cards do
    if cards[i].level == 12 and HasID(AIHand(),25857246,true) and HasID(AIHand(),89463537,true)
    and not CycleReleaserCheck(true) and GlobalBPAllowed
    then
      return {i}
    end
  end
  for i=1,#cards do
    if cards[i].id == 86346643 and HasID(AIHand(),30312361,true) then
      return {i}
    end
  end
  for i=1,#cards do
    if cards[i].level == 6 and SummonBrio() then
      return {i}
    end
  end
  for i=1,#cards do
    if cards[i].id == 79606837 then
      return {i}
    end
  end
  for i=1,#cards do
    if cards[i].id == 35952884 
    and (QuasarComboCheck(true)
    or QuasarTrishulaCheck())
    then
      return {i}
    end  
  end
  for i=1,#cards do
    if cards[i].id == 90307777
    then
      result = {i}
    end
  end
  GlobalExoTarget = nil
  GlobalCycleTarget = nil
  GlobalKaleidoTarget = cards[result[1]].cardid
  return result
end
function ExoTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_BANISH)
  end
  if FilterLocation(cards[1],LOCATION_DECK) 
  and FilterType(cards[1],TYPE_SPELL) 
  then
    return ClausTarget(cards)
  end
  local result = Add(cards,PRIO_TOFIELD)
  GlobalKaleidoTarget = nil
  GlobalCycleTarget = nil
  GlobalExoTarget = cards[1].cardid
  return result
end
function CycleTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_BANISH)
  end
  if FilterLocation(cards[1],LOCATION_DECK) 
  and FilterType(cards[1],TYPE_SPELL) 
  then
    return ClausTarget(cards)
  end
  local result = Add(cards,PRIO_TOFIELD,1,FilterLocation,LOCATION_GRAVE)
  GlobalKaleidoTarget = nil
  GlobalExoTarget = nil
  GlobalCycleTarget = cards[1].cardid
  return result
end
function NyarlaTarget(cards)
  local result = {}
  for i=1,#cards do
    if cards[i].id == 79606837 then
      return {i}
    elseif not NekrozFilter(cards[i]) then
      result = {i}
    end
  end
  if #result==0 then result = {math.random(#cards)} end
  return result
end
function ExaBeetleTarget(cards)
  local result = {}
  if FilterLocation(cards[1],LOCATION_GRAVE)  then 
    for i=1,#cards do
      if cards[i].id == 35952884 and cards[i].owner == 1 then 
        return {i}
      end
    end
    return {HighestATKIndexTotal(cards)}
  elseif FilterLocation(cards[1],LOCATION_OVERLAY) then 
    return Add(cards,PRIO_TOGRAVE)
  elseif CurrentOwner(cards[1])==1 then 
    for i=1,#cards do
      if cards[i].id == 35952884 then 
        return {i}
      end
    end
    return BestTargets(cards,1,TARGET_TOGRAVE)
  else  
    return BestTargets(cards,1,TARGET_TOGRAVE)
  end
end
function NekrozGungnirTarget(cards)
  local result = {}
  if GlobalCardMode == 1 then
    result = GlobalTargetGet(cards,true)
  end
  if #result==0 then result = {math.random(#cards)} end
  return result
end
function ArmorTarget(cards)
  if FilterPosition(cards[1],POS_FACEDOWN) then
    return BestTargets(cards,1,TARGET_BANISH,ArmorFilter)
  else
    local result = GlobalTargetGet(cards,true)
    return result
  end
end
function ClausTarget(cards)
  if FilterLocation(cards[1],LOCATION_DECK) then
    if NeedsCard(97211663,cards,AIHand()) 
    and (HasID(AIHand(),90307777,true) and (HasID(AIGrave(),25857246,true)
    or HasID(AIGrave(),52068432,true) or HasID(AIGrave(),88240999,true))
    or HasID(AIGrave(),99185129,true) and (HasID(AIGrave(),08903700,true) 
    or FieldCheck(4)>=2 and HasID(AIExtra(),34086406,true)))
    and OPTCheck(97211663) 
    then
      return {CurrentIndex}
    end
    if NeedsCard(51124303,cards,AIHand()) 
    and (HasID(AIHand(),89463537,true)  
    or CardsMatchingFilter(AIGrave(),NekrozMonsterFilter)<3
    and not HasID(AIGrave(),90307777,true))
    and OPTCheck(51124303) 
    then
      return {CurrentIndex}
    end
    if NeedsCard(14735698,cards,AIHand()) and OPTCheck(14735698)  then
      return {CurrentIndex}
    end
    if NeedsCard(97211663,cards,AIHand()) and OPTCheck(97211663) then
      return {CurrentIndex}
    end
    if NeedsCard(51124303,cards,AIHand()) and OPTCheck(51124303) then
      return {CurrentIndex}
    end
    if NeedsCard(14735698,cards,AIHand()) then
      return {CurrentIndex}
    end
    if NeedsCard(51124303,cards,AIHand()) then
      return {CurrentIndex}
    end
    if NeedsCard(97211663,cards,AIHand()) then
      return {CurrentIndex}
    end
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  return BestTargets(cards,1,TARGET_TOGRAVE)
end
function BrioTarget(cards,max)
  if FilterLocation(cards[1],LOCATION_DECK) then
    return Add(cards)
  end
  if max and max>1 then
    local count = math.min(max,CardsMatchingFilter(cards,BrioFilter))
    return BestTargets(cards,count,TARGET_TOHAND)
  end
  return {math.random(#cards)}
end
function TrishTarget(cards)
  if FilterLocation(cards[1],LOCATION_HAND) then
    return {math.random(#cards)}
  end
  return BestTargets(cards,1,TARGET_BANISH)
end
function ZubabaTarget(cards)
  if FilterLocation(cards[1],LOCATION_OVERLAY) then
    if HasID(cards,89463537) then
      return {CurrentIndex}
    end
    return Add(cards,PRIO_TOGRAVE)
  end
  if FilterLocation(cards[1],LOCATION_HAND) then
    if HasID(cards,52068432) then
      return {CurrentIndex}
    end
    return Add(cards,PRIO_TOFIELD)
  end
end
function EnterblathnirTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return {math.random(#cards)}
  end
  return BestTargets(cards,1,TARGET_BANISH)
end
function ValkFilter(c)
  return (FilterLocation(c,LOCATION_MZONE) or FilterID(c,52738610))
end
function ValkTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH)
  end
  local count = math.max(math.min(2,CardsMatchingFilter(UseLists(AIMon(),AIHand()),ValkFilter)),1)
  return Add(cards,PRIO_TOGRAVE,count,ValkFilter)
end
function UsePoC()
  return HasID(AIGrave(),86346643,true) and UseRainbowNeos()
  or HasID(AIGrave(),26674724,true) and UseBrioField()
  or NeedsCard(25857246,AIGrave(),AIField(),true) and OPTCheck(25857246)
  or NeedsCard(88240999,AIGrave(),AIField(),true) and UseArmor()
  or HasID(AIGrave(),35952884,true) and #OppMon()>0
  or HasID(AIGrave(),63465535,true) and #OppMon()>0
end
function PoCTarget(cards)
  for i=1,#cards do
    if cards[i].id == 86346643 and UseRainbowNeos() then
      return {i}
    end
    if cards[i].id == 26674724 and UseBrioField() then
      return {i}
    end
    if cards[i].id == 35952884 and #OppMon()>0 then
      return {i}
    end
    if cards[i].id == 88240999 and not HasID(AIMon(),88240999,true) and UseArmor() then
      return {i}
    end
    if cards[i].id == 63465535 and #OppMon()>0 then
      return {i}
    end
    if cards[i].id == 25857246 and not HasID(AIMon(),25857246,true) and OPTCheck(25857246) then
      return {i}
    end
  end
  return Add(cards,PRIO_TOFIELD)
end
function NekrozCard(cards,min,max,id,c)
  if GlobalNekrozExtra and GlobalNekrozExtra>0 then
    GlobalNekrozExtra = GlobalNekrozExtra - 1
    if GlobalNekrozExtra <=0 then GlobalNekrozExtra = nil end
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if c then
    id = c.id
  end
  if id == 90307777 or id == 89463537   -- Shrit, Unicore
  or id == 95492061 or id == 23401839   -- Manju, Senju
  or id == 96729612 or id == 79606837   -- Preparation, Herald
  then
    return Add(cards,PRIO_TOHAND,max)
  end
  if id == 99185129 then
    return ClausTarget(cards)
  end
  if id == 26674724 then
    return BrioTarget(cards,max)
  end
  if id == 51124303 then
    return KaleidoTarget(cards)
  end
  if id == 14735698 then
    return ExoTarget(cards)
  end
  if id == 97211663 then
    return CycleTarget(cards)
  end
  if id == 08809344 then
    return NyarlaTarget(cards)
  end
  if id == 44505297 then
    return ExaBeetleTarget(cards)
  end
  if id == 74122412 then
    return NekrozGungnirTarget(cards)
  end
  if id == 88240999 then
    return ArmorTarget(cards)
  end
  if id == 52068432 then
    return TrishTarget(cards)
  end
  if id == 31563350 then
    return ZubabaTarget(cards)
  end
  if id == 25857246 then
    return ValkTarget(cards)
  end
  if id == 52738610 then  -- Dance Princess
    return Add(cards)
  end
  if id == 30312361 then
    return PoCTarget(cards)
  end
  if id == 86346643 then  -- Rainbow Neos (for Phantom of Chaos)
    return Add(cards,1,PRIO_TOGRAVE)
  end
  if id == 63465535 then -- Underground Arachnid (for Phantom of Chaos)
    return BestTargets(cards,1,TARGET_TOGRAVE)
  end
  if id == 45986603 then -- Snatch Steal
    return BestTargets(cards,1,TARGET_CONTROL)
  end
  return nil
end
function KaleidoSum(cards,sum,card)
end
function ExoSum(cards,sum,card)
  local result = {}
  local lvl = sum
  if HasID(cards,08903700) then 
    result[#result+1] = CurrentIndex
    lvl = lvl - cards[CurrentIndex].level
    ReleaserSet(GlobalExoTarget)
  end
  if HasID(cards,90307777,false,nil,LOCATION_GRAVE) and #result==0 then
    return {CurrentIndex}
  end
  if HasID(cards,90307777) and #result==0 then
    return {CurrentIndex}
  end
  for j=1,5 do
    for i=1,#cards do
      if cards[i].id ~= 90307777 and cards[i].id ~= 08903700 
      and lvl == cards[i].level
      then
        j=5
        result[#result+1]= i
        return result
      end
    end
    for i=1,#cards do
      if cards[i].id ~= 90307777 and cards[i].id ~= 08903700 
      and lvl - cards[i].level > 2
      then
        lvl = lvl - cards[i].level
        result[#result+1]= i
      end
    end
  end
  return result
end
function CycleSum(cards,sum,card)
  local result = {}
  local lvl = sum
  if HasID(cards,08903700) then 
    result[#result+1] = CurrentIndex
    lvl = lvl - cards[CurrentIndex].level
    ReleaserSet(GlobalCycleTarget)
  end
  if HasID(cards,90307777) and #result==0 then
    return {CurrentIndex}
  end
  for j=1,5 do
    for i=1,#cards do
      if cards[i].id ~= 90307777 and cards[i].id ~= 08903700 
      and lvl == cards[i].level
      then
        j=5
        result[#result+1]= i
        return result
      end
    end
    for i=1,#cards do
      if cards[i].id ~= 90307777 and cards[i].id ~= 08903700 
      and lvl - cards[i].level > 2
      then
        lvl = lvl - cards[i].level
        result[#result+1]= i
      end
    end
  end
  return result
end
function NekrozSum(cards,sum,card)
  local id = nil
  if card then
    id = card.id
  else
  end
  local c = FindCard(GlobalKaleidoTarget)
  if c then
    return KaleidoSum(cards,sum,card)
  end
  c = FindCard(GlobalExoTarget)
  if c then    
    return ExoSum(cards,sum,card)
  end
  c = FindCard(GlobalCycleTarget)
  if c then    
    return CycleSum(cards,sum,card)
  end
  return nil
end
function ChainTrishula(c)
  if FilterLocation(c,LOCATION_HAND) then
    local e,c,id 
    if EffectCheck(1-player_ai)~=nil then
      e,c,id = EffectCheck()
      return true
    end
    return false
  end
  return true
end
function ArmorAtkFilter(c)
  return c:IsSetCard(0xb4)
end
function ChainArmor()
  if Duel.GetCurrentPhase() == PHASE_DAMAGE then
    if AttackBoostCheck(1000,0,player_ai,ArmorAtkFilter) then
      if Duel.GetTurnPlayer() == player_ai then
        GlobalTargetSet(Duel.GetAttacker(),AIMon())
      else
        GlobalTargetSet(Duel.GetAttackTarget(),AIMon())
      end
      return true
    end
  end
  return false
end
function NekrozGungnirFilter(c,immune)
  return c:IsSetCard(0xb4) and c:IsPosition(POS_FACEUP) 
  and c:IsType(TYPE_MONSTER) 
  and not c:IsHasEffect(immune)
end
function ChainGungnir(c)
  if FilterLocation(c,LOCATION_HAND) then
    c=nil
    local cg = RemovalCheck(nil,CATEGORY_DESTROY)
    if cg then
      local tg = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TARGET_CARDS)
      if tg then 
        c=tg:Filter(NekrozGungnirFilter,nil,EFFECT_INDESTRUCTABLE_EFFECT)
        if c and c:GetCount()>0 then c=c:GetMaxGroup(Card.GetAttack):GetFirst() end
      else
        c=cg:Filter(NekrozGungnirFilter,nil,EFFECT_INDESTRUCTABLE_EFFECT)
        if c and c:GetCount()>0 then c=c:GetMaxGroup(Card.GetAttack):GetFirst() end
      end
      if c and c.GetCode and UnchainableCheck(74122412) then
        GlobalTargetSet(c,AIMon())
        GlobalCardMode = 1
        return true
      end
    end
    if Duel.GetCurrentPhase()==PHASE_BATTLE then
      local source = Duel.GetAttacker()
      local target = Duel.GetAttackTarget()
      if source and target then
        if source:IsControler(player_ai) then
          target = Duel.GetAttacker()
          source = Duel.GetAttackTarget()
        end
      end
      if WinsBattle(source,target) 
      and NekrozGungnirFilter(target,EFFECT_INDESTRUCTABLE_BATTLE) 
      and (not (HasID(AIHand(),88240999,true) and target:GetAttack()+1000>source:GetAttack()))
      and UnchainableCheck(74122412)
      then
        GlobalTargetSet(target,AIMon())
        GlobalCardMode = 1
        return true
      end
    end
  end
  return false
end
function ValkBattleFilter(c)
  return c:IsType(TYPE_MONSTER) 
  and not c:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
end
function ChainValk(c)
  if Duel.GetCurrentPhase() == PHASE_BATTLE and Duel.GetTurnPlayer() == 1-player_ai then
    local source = Duel.GetAttacker()
    local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
    end
    if WinsBattle(source,target) and ValkBattleFilter(target) then
      return UnchainableCheck(25857246)
    end
    if #AIMon() == 0 and ExpectedDamage() >= 0.7*AI.GetPlayerLP(1) then
      return UnchainableCheck(25857246)
    end
  end
  return false
end
function ClausFilter(c)
  return c:IsPosition(POS_FACEUP) 
  and c:IsType(TYPE_MONSTER) 
  and c:IsLocation(LOCATION_MZONE) 
  and c:IsPreviousLocation(LOCATION_EXTRA)
  and bit32.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)>0
  and Affected(c,TYPE_MONSTER,3)
  and Targetable(c,TYPE_MONSTER)
  and c:IsControler(1-player_ai)
end
function ClausFilter2(c)
  return FilterPosition(c,POS_FACEUP)
  and FilterType(c,TYPE_MONSTER)
  and FilterLocation(c,LOCATION_MZONE)
  and FilterPreviousLocation(c,LOCATION_EXTRA)
  and FilterSummon(c,SUMMON_TYPE_SPECIAL)
  and Affected(c,TYPE_MONSTER,3)
  and Targetable(c,TYPE_MONSTER)
  and CurrentOwner(c)==2
end
function ChainClaus()
  local targets = CardsMatchingFilter(OppMon(),ClausFilter2)
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  if e then
    local c=e:GetHandler()
    if c and ClausFilter(c) 
    and NotNegated(c)
    then
      GlobalTargetSet(c,OppMon())
      GlobalCardMode = 1
      return true
    end  
  end
  if RemovalCheck(99185129) or NegateCheck(99185129) then
    return targets>0
  end
  if Duel.GetCurrentPhase()==PHASE_DAMAGE then
    local source = Duel.GetAttacker()
    local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
    end
    if WinsBattle(source,target) and source:IsPosition(POS_FACEUP_ATTACK) 
    and ClausFilter(source) then
      GlobalTargetSet(source,OppMon())
      GlobalCardMode = 1
      return true
    end
  end
end
function NekrozChain(cards)
  if HasID(cards,79606837,false,nil,LOCATION_GRAVE) then -- Rainbow Herald
    return {1,CurrentIndex}
  end
  if HasID(cards,99185129) and ChainClaus() then
    OPTSet(991851291)
    return {1,CurrentIndex}
  end
  if HasID(cards,88240999) and ChainArmor() then
    return {1,CurrentIndex}
  end
  if HasID(cards,25857246) and ChainValk(cards[CurrentIndex]) then
    return {1,CurrentIndex}
  end
  if HasID(cards,74122412,ChainGungnir) then
    return {1,CurrentIndex}
  end
  if HasID(cards,52068432) and ChainTrishula(cards[CurrentIndex]) then
    OPTSet(52068432)
    return {1,CurrentIndex}
  end
  if HasID(cards,44505297) then -- Exa-Beetle
    return {1,CurrentIndex}
  end
  if HasID(cards,35952884,false,nil,LOCATION_GRAVE) then -- Quasar
    return {1,CurrentIndex}
  end
  if HasID(cards,95492061) then -- Manju
    return {1,CurrentIndex}
  end
  if HasID(cards,23401839) then -- Senju
    return {1,CurrentIndex}
  end
  if HasID(cards,90307777) then -- Shrit
    return {1,CurrentIndex}
  end
  if HasID(cards,52738610) then -- Dance Princess
    return {1,CurrentIndex}
  end
  return nil
end

function NekrozEffectYesNo(id,card)
  local result = nil
  if id == 99185129 and ChainClaus(card) then 
    OPTSet(991851291)
    result = 1
  end
  if id==79606837 and FilterLocation(card,LOCATION_GRAVE) then -- Rainbow Herald
    result = 1
  end
  if id == 88240999 and ChainArmor() then 
    result = 1
  end
  if id == 25857246 and ChainValk(card) then 
    result = 1
  end 
  if id == 74122412 and ChainGungnir(card) then 
    result = 1
  end
  if id == 52068432 and ChainTrishula(card) then 
    OPTSet(52068432)
    result = 1
  end
  if id == 44505297 then -- Exa-Beetle
    result = 1
  end
  if id == 35952884 and FilterLocation(card,LOCATION_GRAVE) then -- Quasar
    result = 1
  end
  if id == 95492061 then -- Manju
    result = 1
  end
  if id == 23401839 then -- Senju
    result = 1
  end
  if id == 90307777 then -- Shrit
    result = 1
  end
  if id == 52738610 then -- Dance Princess
    result = 1
  end
  return result
end
NekrozAtt={
89463537,26674724,74122412, -- Unicore, Brionac, Gungnir
52068432,88240999,24696097, -- Trishula, Decisive Armor, Shooting Star
95113856,44505297,52738610, -- Enterblathnir, Exa-Beetle, Dance Princess
25857246,53180020,52846880, -- Valk, Exa, Catastor
67696066,68819554,27796375, -- Trick Clown, Damage Juggler, Sorcerer
}
NekrozDef={
90307777,99185129,08903700, -- Shrit, Claus, Releaser
08809344,31292357,29888389, -- Nyarla, Hat Tricker, Shadow
}
function NekrozPosition(id,available)
  result = nil
  for i=1,#NekrozAtt do
    if NekrozAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#NekrozDef do
    if NekrozDef[i]==id then result=POS_FACEUP_DEFENCE end
  end
  return result
end
