
function ChaosDragonPriority()
AddPriority({

--Chaos Dragons
[65192027] = {8,5,8,2,1,0,0,0,2,0,DADCond},           -- Dark Armed Dragon 
[72989439] = {9,5,6,3,1,0,0,0,2,0,BLSCond},           -- BLS Envoy
[88264978] = {9,5,7,0,2,0,0,0,0,0,REDMDCond},         -- REDMD
[98777036] = {2,1,0,0,4,0,0,0,8,0,nil},               -- Tragoedia
[09596126] = {8,4,6,3,1,0,0,0,3,0,SorcCond},          -- Chaos Sorcerer
[44330098] = {2,1,0,0,4,0,0,0,8,0,nil},               -- Gorz
[99365553] = {6,4,5,4,4,3,0,0,1,0,LightpulsarCond},   -- Lightpulsar Dragon
[25460258] = {5,3,4,3,5,3,0,0,4,0,DarkflareCond},     -- Darkflare Dragon
[61901281] = {6,3,6,2,6,2,0,0,8,3,CollapserpentCond}, -- Black Dragon Collapserpent
[99234526] = {6,3,6,2,6,2,0,0,8,3,WyverbusterCond},   -- Light Dragon Wyverbuster
[77558536] = {5,3,7,4,5,2,0,0,5,0,RaidenCond},        -- Lightsworn Raiden
[22624373] = {3,2,4,2,6,3,0,0,8,0,LylaCond},          -- Lightsworn Lyla
[95503687] = {4,3,8,3,4,3,0,0,7,0,LuminaCond},        -- Lightsworn Lumina
[16404809] = {3,2,4,2,6,3,0,0,8,0,KuribanditCond},    -- Kuribandit
[51858306] = {5,0,3,0,9,0,0,0,9,9,WyvernCond},        -- Eclipse Wyvern
[33420078] = {2,1,6,2,6,0,0,0,3,1,PSZCond},           -- Plaguespreader Zombie
[19665973] = {2,1,1,1,6,1,1,1,6,1,FaderCond},         -- Battle Fader
[85087012] = {2,1,4,1,6,1,1,1,6,1,nil},               -- Card Trooper
[09748752] = {5,1,4,1,2,1,1,1,6,1,CaiusCond},         -- Caius


[00691925] = {8,3,0,0,3,0,0,0,0,0,nil},               -- Solar Recharge
[94886282] = {7,2,0,0,1,0,0,0,0,0,nil},               -- Charge of the Light Brigade
[01475311] = {5,3,0,0,4,0,0,0,0,0,nil},               -- Allure of Darkness
[81439173] = {4,2,0,0,2,0,0,0,0,0,nil},               -- Foolish Burial

--[83531441] = {0,0,0,0,5,2,0,0,8,0,DanteCond},         -- BA Dante
[15914410] = {0,0,0,0,5,2,0,0,8,0,AngineerCond},      -- Mechquipped Angineer
[95992081] = {0,0,0,0,5,2,0,0,8,0,LeviairCond},       -- Leviair the Sea Dragon
[34086406] = {0,0,0,0,5,3,0,0,8,0,ChainCond},         -- Lavalval Chain
[48739166] = {0,0,0,0,5,3,0,0,8,0,SharkCond},         -- SHArk
[15561463] = {0,0,0,0,4,2,0,0,8,0,GauntletCond},      -- Gauntlet Launcher
[07391448] = {0,0,0,0,2,0,0,0,8,0,nil},               -- Goyo Guardian
[04779823] = {0,0,8,0,2,0,0,0,5,0,nil},               -- Michael, Lightsworn Ark
[44508094] = {0,0,8,0,2,0,0,0,5,0,nil},               -- Stardust Dragon
[76774528] = {0,0,7,0,2,0,0,0,5,0,nil},               -- Scrap Dragon
[34408491] = {0,0,9,0,2,0,0,0,4,0,nil},               -- Beelze of the Diabolic Dragons
})
end

function DarksInGrave()
  return CardsMatchingFilter(AIGrave(),FilterAttribute,ATTRIBUTE_DARK)
end
function LightsInGrave()
  return CardsMatchingFilter(AIGrave(),FilterAttribute,ATTRIBUTE_LIGHT)
end
function CaiusCond(loc,c)
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
  end
  if loc == PRIO_TOFIELD then
    return not HasID(AIHand(),c.id,true)
  end
  return true
end
function FaderCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_MZONE)
  end
  return true
end
function DADCond(loc,c)
  if loc == PRIO_TOFIELD then
    return DestroyCheck(OppField())>1 
    and PriorityCheck(AIGrave(),PRIO_BANISH,2,FilterAttribute,ATTRIBUTE_DARK)>4
  end
  if loc == PRIO_TOHAND then
    return DarksInGrave() <= 5
  end
  return true
end
function ChaosSummonCheck()
  return math.min(PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_DARK)
  ,PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_LIGHT))
end
function LightpulsarCheck()
  return DualityCheck() and MacroCheck() and (CardsMatchingFilter(OppMon(),HandFilter,2500)>0 
  and HasID(AIGrave(),88264978,true))
end
function LightpulsarSummonCheck()
  return math.min(PriorityCheck(AIHand(),PRIO_TOGRAVE,1,FilterAttribute,ATTRIBUTE_DARK)
  ,PriorityCheck(AIHand(),PRIO_TOGRAVE,1,FilterAttribute,ATTRIBUTE_LIGHT))
end
function BLSCond(loc,c)
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(UseLists({OppMon(),OppST()}),DADFilter)>0
  end
  if loc == PRIO_TOHAND then
    return ChaosSummonCheck()>4
  end
  return true
end

function REDMDCond(loc,c)
  if loc == PRIO_TOFIELD then
    return true
  end
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
function SorcFilter(c)
  return bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and bit32.band(c.position, POS_FACEUP)>0 
end
function SorcCond(loc,c)
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(OppMon(),SorcFilter)>0 and OverExtendCheck()
  end
  if loc == PRIO_TOHAND then
    return ChaosSummonCheck()>4
  end
  return true
end
function LightpulsarFilter(c)
  return bit32.band(c.race,RACE_DRAGON) and c:is_affected_by(EFFECT_SPSUMMON_CONDITION)>0 
  and bit32.band(c.attribute,ATTRIBUTE_DARK) and c.level>4
end
function LightpulsarCond(loc,c)
  if loc == PRIO_TOHAND then
    return ChaosSummonCheck()>4 
  end
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(AIGrave(),LightpulsarFilter)>0
  end
  return true
end
function DarkflareCond(loc,c)
  if loc == PRIO_TOFIELD then
    return HasID(AIHand(),51858306,true)
  end
  return true
end
function MiniDragonCount(cards)
  local result = 0
  for i=1,#cards do
    if cards[i].id == 61901281 or cards[i].id == 99234526 then
      result = result + 1
    end
  end
  return result
end
function MiniDragonCond(loc,c)
  if loc == PRIO_BANISH then
    return bit32.band(c.location,LOCATION_HAND)==0 or MiniDragonCount(UseLists({AIMon(),AIHAnd()}))>1
  end
  return true
end
function RaidenCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),77558536,true)
  end
  if loc == PRIO_TOGRAVE and bit32.band(c.location,LOCATION_HAND) then
    return true
  end
  return true
end
function LylaCond(loc,c)
  return true
end
function LuminaCond(loc,c)
  if loc == PRIO_TOFIELD then
    return not HasID(AIMon(),95503687,true)
  end
  return true
end
function KuribanditCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return #AIDeck()<20
  end
  return true
end
function WyvernCond(loc,c)
  if loc == PRIO_TOHAND then
    return bit32.band(c.location,LOCATION_GRAVE)==0
  end
  if loc == PRIO_TOFIELD then
    return bit32.band(c.location,LOCATION_GRAVE)==0
  end
  return true
end
function PSZCond(loc,c)
  return true
end
function TourGuideCond(loc,c)
  if loc == PRIO_TOHAND then
    local cards = UseLists(AIHand(),AIST())
    return not HasID(AIHand(),10802915,true) 
    and not (HasID(cards,63356631,true) or HasID(cards,71587526 ,true))
    and not SkillDrainCheck()
    and (DiscardOutlets()==0 or CardsMatchingFilter(AIMon(),DarkWorldMonsterFilter)>0)
    and not ((Duel.GetCurrentPhase()==PHASE_END or Duel.GetTurnPlayer()==player_ai)
    and (HasID(AIMon(),83531441) or CardsMatchingFilter(AIMon(),BASelfDestructFilter)>0)
    or NormalSummonCheck())
  end
  if loc == PRIO_BANISH then
    return bit32.band(c.location,LOCATION_HAND)==0 or CardsMatchingFilter(AIHand(),FilterID,10802915)>1
  end
  if loc == PRIO_DISCARD then
    return #AIHand()>5 or CardsMatchingFilter(AIHand(),FilterID,10802915)>1
    or SkillDrainCheck() --or NormalSummonCheck() 
  end
  return true
end
function DanteCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0 and (Duel.GetCurrentPhase()==PHASE_MAIN2 or c.attack<1500)
  end
  return true
end
function AngineerCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0
  end
  return true
end
function LeviairCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0
  end
  return true
end
function ChainCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0
  end
  return true
end
function SharkCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0
  end
  return true
end
function GauntletCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0
  end
  return true
end
function ScarmCond(loc,c)
  return true
end
function CollapserpentCond(loc,c)
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_HAND) then
    return MiniDragonCount(AIHand())>1
  end
  if loc == PRIO_TOHAND then
    return MiniDragonCount(AIHand())==0
  end
  return true
end
function WyverbusterCond(loc,c)
  if loc == PRIO_TOGRAVE and FilterLocation(c,LOCATION_HAND) then
    return MiniDragonCount(AIHand())>1
  end
  if loc == PRIO_TOHAND then
    return MiniDragonCount(AIHand())==0
  end
  return true
end

--{hand,hand+,field,field+,grave,grave+,other,other+,banish,banish+} 
function MergePriorities()
  --[[for i,line in pairs(BujinPrio) do
    local line2={}
    for j=1,6 do
      line2[j]=line[j]
    end
    line2[7]=0
    line2[8]=0
    line2[9]=line[7]
    line2[10]=0
    line2[11]=nil
    Prio[i]=line2
  end]]
end

function SSLightpulsar(c,loc)
  if bit32.band(c.location,LOCATION_HAND)>0 and loc==LOCATION_HAND then
    GlobalCardMode=4
    return ChaosSummonCheck()>4 and OverExtendCheck() and #OppMon()>0  --and LightpulsarSummonCheck()>4
  elseif bit32.band(c.location,LOCATION_GRAVE)>0 and loc==LOCATION_GRAVE then
    GlobalCardMode=2
    return (LightpulsarSummonCheck()>4 or (LightpulsarSummonCheck()>2 
    and #AIHand()>4) and OverExtendCheck() and #OppMon()>0)
    and not (HasID(AIHand(),99365553,true) and ChaosSummonCheck()>4)
  end
end
function NSLightpulsar(c)
  return PriorityCheck(AIMon(),PRIO_TOGRAVE)>4 
end
function SummonDAD()
  return DADCond(PRIO_TOFIELD)
end
function UseDAD()
  return DestroyCheck(OppField())>0 
  and PriorityCheck(AIGrave(),PRIO_BANISH,2,FilterAttribute,ATTRIBUTE_DARK)>4
end
function SummonDante()
  return #AIDeck()>20 and DeckCheck(DECK_CHAOSDRAGON)
end
function LeviairFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and c.level<5 and c:is_affected_by(EFFECT_SPSUMMON_CONDITION)==0
end
function SummonLeviair()
  return PriorityCheck(AIBanish(),PRIO_TOFIELD,1,LeviairFilter)>4 
end
function UseLeviair()
  return true
end
function UseChaosSorc()
  return CardsMatchingFilter(OppMon(),ChaosSorcFilter2)>0 or ((OppHasStrongestMonster() 
  or AI.GetCurrentPhase() == PHASE_MAIN2 or FieldCheck(6)>1 or HasID(AIMon(),33420078,true))
  and CardsMatchingFilter(OppMon(),ChaosSorcFilter)>0)
end
function SummonGauntletLauncher()
  return DestroyCheck(OppMon())>1 and MP2Check(2400)
end
function UseGauntletLauncher()
  return DestroyCheck(OppMon())>0 
end
function SummonScrapDragon()
  return DestroyCheck(OppField())>0 and (HasID(AIMon(),34408491,true) 
  or PriorityCheck(AIField(),PRIO_TOGRAVE,2)>4)
end
function UseScrapDragon()
  return DestroyCheck(OppField())>0 
  and (HasID(AIMon(),34408491,true) 
  or (PriorityCheck(AIField(),PRIO_TOGRAVE)>4 
  and (MP2Check() or HasPriorityTarget(OppField(),true) 
  or OppHasStrongestMonster() or HasID(AIMon(),12538374,true))) 
  or (HasID(AIMon(),99365553,true) and LightpulsarCond(PRIO_TOFIELD))
  or OppHasStrongestMonster() and #AIField()>1)
end
function SummonBLS()
  return OverExtendCheck() and #OppMon()>0 and ChaosSummonCheck()>4
end
function BLSFilter(c)
  return bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function BLSFilter2(c)
  return BLSFilter(c)
  and (c.attack>=3000 or c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==1 
  or c:is_affected_by(EFFECT_INDESTRUCTABLE)==1 or bit32.band(c.position,POS_FACEDOWN)>0)
end
function UseBLS()
  return CardsMatchingFilter(OppMon(),BLSFilter2)>0 or ((OppHasStrongestMonster() 
  or AI.GetCurrentPhase() == PHASE_MAIN2) and CardsMatchingFilter(OppMon(),BLSFilter)>0)
end
function REDMDFilter(c)
  return bit32.band(c.race,RACE_DRAGON)>0 and c:is_affected_by(EFFECT_SPSUMMON_CONDITION)==0 and c.id~=51858306
end
function SummonREDMD()
  return PriorityCheck(AIMon(),PRIO_BANISH,1,FilterRace,RACE_DRAGON)>4 and UseREDMD()
end
function UseREDMD()
  return CardsMatchingFilter(AIGrave(),REDMDFilter)>0
end
function UseTrag1() -- mindcontrol
  return PriorityCheck(AIHand(),PRIO_TOGRAVE)>4
end
function LevelFilter(c,level)
  return bit32.band(c.type,TYPE_MONSTER)>0 and c.level==level
end
function TragCheck(level)
  return HasID(AIMon(),98777036,true,nil,nil,nil,LevelFilter,10) and CardsMatchingFilter(AIGrave(),LevelFilter,level)>0
end

function UseTrag2() -- change level
  if FieldCheck(6)>0 and TragCheck(6) and ExtraDeckCheck(TYPE_XYZ,6)>0 then
    GlobalCardMode=6
    return true
  elseif FieldCheck(4)>0 and TragCheck(4) and ExtraDeckCheck(TYPE_XYZ,4)>0 then
    GlobalCardMode=4
    return true
  elseif FieldCheck(3)>0 and TragCheck(3) and ExtraDeckCheck(TYPE_XYZ,3)>0 then
    GlobalCardMode=3
    return true
  elseif HasID(AIMon(),33420078,true) then
    if TragCheck(6) and ExtraDeckCheck(TYPE_SYNCHRO,8)>0 then
      GlobalCardMode=6
      return true
    elseif TragCheck(4) and ExtraDeckCheck(TYPE_SYNCHRO,6)>0 then
      GlobalCardMode=4
      return true
    elseif TragCheck(3) and ExtraDeckCheck(TYPE_SYNCHRO,5)>0 then
      GlobalCardMode=3
      return true
    end
  end
  return false
end
function SummonChaosSorc()
  return OverExtendCheck() and #OppMon()>0 and ChaosSummonCheck()>4
end
function ChaosSorcFilter(c)
  return bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and bit32.band(c.position,POS_FACEUP)>0
end
function ChaosSorcFilter2(c)
  return ChaosSorcFilter(c)
  and (c.attack>=2300 or c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==1 
  or c:is_affected_by(EFFECT_INDESTRUCTABLE)==1)
end
function SummonDarkflare()
  return ChaosSummonCheck()>4 and OverExtendCheck() and #OppMon()>0
end
function UseDarkflare()
  return false--PriorityCheck(AIHand(),PRIO_TOGRAVE,1,RaceFilter,RACE_DRAGON)>4 and #OppGrave()>0
end
function SummonMini()
  return HasID(AIMon(),77558536,true) and FieldCheck(4)==1 
  and ExtraDeckCheck(TYPE_SYNCHRO,8)>0 and #OppMon()>0 --and OppHasStrongestMonster()
  or OppHasStrongestMonster() and ExtraDeckCheck(TYPE_XYZ,4)>0
  and (FieldCheck(4)==1 or TragCheck(4))
  or HasID(AIMon(),33420078,true) and OppHasStrongestMonster() 
  and FieldCheck(4)==0 and ExtraDeckCheck(TYPE_SYNCHRO,6)>0
  or HasID(AIHand(),99365553,true) and PriorityCheck(AIField(),PRIO_TOGRAVE)<4 
  and not NormalSummonCheck(player_ai) and OverExtendCheck() and #OppMon()>0
  or HasID(AIHand(),88264978,true) and UseREDMD() and OverExtendCheck()
  or HasID(AIMon(),76774528,true) and DestroyCheck(OppField())>0 
  or HasID(AIHand(),09748752,true) and not NormalSummonCheck(player_ai) and UseCaius()
  or FieldCheck(4)==1 and HasID(AIExtra(),30100551,true,SummonMinerva,1)
end
function SummonCollapserpent()
  return PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_LIGHT)>4 and SummonMini()
end
function SummonWyverbuster()
  return PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_DARK)>4 and SummonMini()
end
function SetScarm(deck)
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase() == PHASE_MAIN2) 
  and #AIMon()==0 and (deck == nil or DeckCheck(deck))
end
function LuminaFilter(c)
  return bit32.band(c.type,TYPE_MONSTER) and c.level<5 and IsSetCode(c.setcode,0x38)
end
function SummonLumina()
  return CardsMatchingFilter(AIGrave(),LuminaFilter)>0 and OverExtendCheck()
end
function UseLumina()
  return OverExtendCheck() or PriorityCheck(AIHand(),PRIO_TOGRAVE)>1
end
function SummonLyla()
  return CardsMatchingFilter(OppST(),DestroyFilterIgnore)>0 and OverExtendCheck()
end
function UseLyla()
  return CardsMatchingFilter(OppST(),DestroyFilter)>0 
  and (Duel.GetCurrentPhase()==PHASE_MAIN2 or FieldCheck(4)>1 
  or HasID(AIMon(),33420078,true) 
  or (HasID(AIHand(),99365553,true) 
  or HasID(AIHand(),09748752,true) and UseCaius())
  and not NormalSummonCheck(player_ai))
end
function SummonRaiden()
  return OverExtendCheck()
end
function SummonTrooper()
  return OverExtendCheck() and #AIDeck()>10
end
function UseRaiden()
  return #AIDeck()>10
end
function SummonPSZ()
  return (FieldCheck(6)==1 or TragCheck(6)) 
  or (FieldCheck(4)==1 or TragCheck(4)) 
  and Duel.GetCurrentPhase==PHASE_MAIN1 
  and OppGetStrongestAttDef()<2800 and not HasID(AIMon(),77558536,true)
end
function UsePSZ()
  return SummonPSZ() and #AIHand()>4
end
function UseAllure()
  return PriorityCheck(AIHand(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_DARK)>4
end

function SummonGoyoGuardian()
  return Duel.GetCurrentPhase==PHASE_MAIN1 and OppGetStrongestAttDef()<2800
end
function SummonKuribandit()
  return true
end
function UseDante()
  return true
end
function UseTrooper()
  return true
end
function SummonBeelze()
  return true
end
function CaiusFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,6)
end
function UseCaius()
   return CardsMatchingFilter(OppField(),CaiusFilter)>0
   or AI.GetPlayerLP(2)<=1000
end
function SummonCaius(c,mode)
  if mode == 1 then
    return AI.GetPlayerLP(2)<=1000
  elseif mode == 2 then
    return PriorityCheck(AIMon(),PRIO_TOGRAVE)>4
    and UseCaius()
  end
  return false
end
function SummonMinerva(c,mode)
  if mode == 1
  then
    return #AIDeck()>10
  end
  return false
end
function UseMinerva(c,mode)
  return true
end
function ChaosDragonOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  local Activatable = cards.activatable_cards
  local Summonable = cards.summonable_cards
  local SpSummonable = cards.spsummonable_cards
  local Repositionable = cards.repositionable_cards
  local SetableMon = cards.monster_setable_cards
  local SetableST = cards.st_setable_cards
  GlobalScepterOverride = 0
  if HasID(Activatable,32807846) and DeckCheck(DECK_CHAOSDRAGON) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,30100551,UseMinerva) then
    return Activate()
  end
  if HasID(Activatable,94886282) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,00691925) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,01475311) and UseAllure() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Summonable,09748752,SummonCaius,1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,65192027) and SummonDAD() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,65192027) and UseDAD() then
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Summonable,33420078) and SummonPSZ() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Activatable,33420078) and UsePSZ() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,77558536) and UseRaiden() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,22624373) and UseLyla() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,95503687) and UseLumina() then
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,09596126) and UseChaosSorc() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSummonable,83531441) and SummonDante() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,83531441) and UseDante() then
    GlobalActivatedCardID = 83531441
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,85087012 ) and UseTrooper() then
    GlobalActivatedCardID = 85087012
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  --if HasIDNotNegated(Activatable,34086406) and UseLavalvalChain() then
  --  return {COMMAND_ACTIVATE,CurrentIndex}
  --end

  if HasID(SpSummonable,34408491) and SummonBeelze() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,07391448) and SummonGoyoGuardian() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  --if HasIDNotNegated(Activatable,04779823) and UseMichael() then
    --return {COMMAND_ACTIVATE,CurrentIndex}
  --end
  if HasID(SpSummonable,76774528) and SummonScrapDragon() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,76774528) and UseScrapDragon() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSummonable,88264978) and SummonREDMD() then
    GlobalSSCardID = 88264978
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,88264978) and UseREDMD() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  for i=1,#SpSummonable do
    if SpSummonable[i].id == 99365553 and SSLightpulsar(SpSummonable[i],LOCATION_HAND) then
      GlobalSSCardID = 99365553
      return {COMMAND_SPECIAL_SUMMON,i}
    end
  end
  if HasID(SpSummonable,09596126) and SummonChaosSorc() then
    GlobalSSCardID = 09596126
    GlobalCardMode = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end

  if HasID(SpSummonable,72989439) and SummonBLS() then
    GlobalCardMode=1
    GlobalSSCardID = 72989439
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,72989439) and UseBLS() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,98777036,false,1580432577) and UseTrag1() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,98777036,false,1580432578) and UseTrag2() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSummonable,25460258) and SummonDarkflare() then
    GlobalCardMode=4
    GlobalSSCardID = 25460258
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,25460258) and UseDarkflare() then
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSummonable,61901281) and SummonCollapserpent() then
    GlobalSSCardID = 61901281
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,99234526) and SummonWyverbuster() then
    GlobalSSCardID = 99234526
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,30100551,SummonMinerva,1) then
    return SpSummon()
  end
  if HasIDNotNegated(Summonable,09748752,SummonCaius,2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,10802915) and SummonTourguide() and DeckCheck(DECK_CHAOSDRAGON) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,95503687) and SummonLumina() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,77558536) and SummonRaiden() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,85087012) and SummonTrooper() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  
  if HasID(Summonable,99365553) and NSLightpulsar(Summonable[CurrentIndex]) then
    GlobalActivatedCardLevel=6
    GlobalActivatedCardAttack=2500
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,22624373) and SummonLyla() then
    return {COMMAND_SUMMON,CurrentIndex}
  end

  if HasID(Summonable,16404809) and SummonKuribandit() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,95503687) and OverExtendCheck() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,22624373) and OverExtendCheck() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,61901281) and OverExtendCheck()
  and PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_LIGHT)>4
  and GlobalBPAllowed and Duel.GetCurrentPhase()==PHASE_MAIN1
  then
    GlobalSSCardID = 61901281
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,99234526) and OverExtendCheck() 
  and PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_DARK)>4
  and GlobalBPAllowed and Duel.GetCurrentPhase()==PHASE_MAIN1
  then
    GlobalSSCardID = 99234526
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  for i=1,#SpSummonable do
    if SpSummonable[i].id == 99365553 and SSLightpulsar(SpSummonable[i],LOCATION_GRAVE) then
      GlobalSSCardID = 99365553
      return {COMMAND_SPECIAL_SUMMON,i}
    end
  end
  if HasID(Summonable,10802915) and DeckCheck(DECK_CHAOSDRAGON) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SetableMon,84764038) and SetScarm(DECK_CHAOSDRAGON) then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  return nil
end
function DarkflareTarget(cards)
  if GlobalCardMode == 4 then
    GlobalCardMode = 3
    return Add(cards,PRIO_BANISH)
  elseif GlobalCardMode == 3 then
    GlobalCardMode = nil
    GlobalSSCardID = nil
    return Add(cards,PRIO_BANISH)
  elseif GlobalCardMode == 2 then
    GlobalCardMode = 1
    return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOGRAVE)
  else
    return BestTargets(cards,1,TARGET_BANISH)
  end
end
function DADTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return Add(cards,PRIO_BANISH)
  else
    return BestTargets(cards,1,TARGET_DESTROY)
  end
end
function LuminaTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOGRAVE)
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function DanteTarget(cards,c)
  if bit32.band(c.location,LOCATION_GRAVE)>0 then
    result = Add(cards,PRIO_TOHAND,1,TargetCheck)
    TargetSet(cards[1])
    return result
  else
    return Add(cards,PRIO_TOGRAVE)
  end
end
function LeviairTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOGRAVE)
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function GauntletLauncherTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOGRAVE)
  else
    return BestTargets(cards,1,TARGET_DESTROY)
  end
end
function PtolemyFilter(c)
  return Affected(c,TYPE_MONSTER,6)
  and Targetable(c,TYPE_MONSTER)
  and not ToHandBlacklist(c.id)
end
function PtolemyTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOHAND,1,FilterOwner,1)
  end
  return BestTargets(cards,1,TARGET_TOHAND,PtolemyFilter)
end
function LightpulsarTarget(cards)
  if GlobalCardMode == 4 then
    GlobalCardMode = 3
    return Add(cards,PRIO_BANISH)
  elseif GlobalCardMode == 3 then
    GlobalCardMode = nil
    GlobalSSCardID = nil
    return Add(cards,PRIO_BANISH)
  elseif GlobalCardMode == 2 then
    GlobalCardMode = 1
    return Add(cards,PRIO_TOGRAVE)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    GlobalSSCardID = nil
    return Add(cards,PRIO_TOGRAVE)
  else
    GlobalSSCardID = nil
    return Add(cards,PRIO_TOFIELD)
  end
end
function TragTarget(cards)
  local result={}
  if GlobalCardMode and GlobalCardMode>0 then
    for i=1,#cards do
      if cards[i].level==GlobalCardMode then
        result[1]=i
      end
    end
  else
    result = BestTargets(cards,1,TARGET_CONTROL)
  end
  GlobalCardMode=nil
  if #result~=1 then result={math.random(#cards)} end
  return result
end
function BLSTarget(cards)
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    return Add(cards,PRIO_BANISH)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    GlobalSSCardID = nil
    return Add(cards,PRIO_BANISH)
  else
    return BestTargets(cards,1,TARGET_BANISH)
  end 
end
function ScrapDragonTarget(cards)
  if HasID(cards,99365553) and LightpulsarCond(PRIO_TOFIELD) then
    return {CurrentIndex}
  end
  if Duel.GetCurrentPhase() == PHASE_MAIN1 
  and not (OppHasStrongestMonster() or HasPriorityTarget(OppMon(),true))
  and DestroyCheck(OppST())>0 and CurrentOwner(cards[1])==2
  then
    return BestTargets(cards,1,TARGET_DESTROY,FilterLocation,LOCATION_SZONE)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function ChaosSorcTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
  else
    GlobalSSCardID = nil
  end
  return Add(cards,PRIO_BANISH)
end
function CaiusTarget(cards)
  if AI.GetPlayerLP(2)<=1000 then
    return BestTargets(cards,1,TARGET_BANISH,FilterAttribute,ATTRIBUTE_DARK)
  end
  return BestTargets(cards,1,TARGET_BANISH)
end
function MinervaTarget(cards,max)
  local count = math.max(1,math.min(DestroyCheck(OppField(),true,true),max))
  return BestTargets(cards,count,TARGET_DESTROY)
end
function ChaosDragonOnSelectCard(cards, minTargets, maxTargets,triggeringID,triggeringCard)
  local ID 
  local result=nil
  if triggeringCard then
    ID = triggeringCard.id
  else
    ID = triggeringID
  end
  if ID == 65192027 then -- DAD
    return DADTarget(cards)
  end
  if GlobalSSCardID == 72989439 then -- BLS
    return BLSTarget(cards)
  end
  if ID == 72989439 then -- BLS
    return BestTargets(cards,1,TARGET_BANISH)
  end
  if ID == 88264978 then -- REDMD
    return Add(cards,PRIO_TOFIELD)
  end
  if GlobalSSCardID == 88264978 then -- REDMD
    GlobalSSCardID = nil
    return BestTargets(cards,1,TARGET_BANISH)
  end
  if ID == 98777036 then
    return TragTarget(cards)
  end
  if ID == 09596126 then -- Chaos Sorc
    return BestTargets(cards,1,TARGET_BANISH)
  end
  if GlobalSSCardID == 09596126 then -- Chaos Sorc
    return ChaosSorcTarget(cards)
  end
  if ID == 99365553 then -- Lightpulsar
    return Add(cards,PRIO_TOFIELD)
  end
  if GlobalSSCardID == 99365553 then -- Lightpulsar
    return LightpulsarTarget(cards)
  end
  if ID == 25460258 then -- Darkflare
    return DarkflareTarget(cards)
  end
  if GlobalSSCardID == 25460258 then -- Darkflare
    return DarkflareTarget(cards)
  end
  if GlobalSSCardID == 61901281 or GlobalSSCardID == 99234526  then -- Collapserpent, Wyverbuster
    GlobalSSCardID = nil
    return Add(cards,PRIO_BANISH)
  end
  if ID == 22624373 then -- Lyla
    return BestTargets(cards,1,TARGET_DESTROY)
  end
  if ID == 95503687 then
    return LuminaTarget(cards)
  end
  if ID == 33420078 then -- PSZ
    return Add(cards,PRIO_DISCARD)
  end
  if ID == 51858306 or ID == 94886282 -- Eclipse Wyvern, Scarm, Charge of the Light Brigade
  or ID == 84764038
  then 
    return Add(cards)
  end
  if ID == 10802915 then -- Tour Guide
    GlobalSummonNegated=true
    return Add(cards,PRIO_TOFIELD)
  end
  if ID == 00691925 then -- Solar Recharge
    return Add(cards,PRIO_TOGRAVE)
  end
  if ID == 01475311 then -- Allure
    return Add(cards,PRIO_BANISH)
  end
  if ID == 81439173 then -- Foolish
    return Add(cards,PRIO_TOGRAVE)
  end
  if ID == 83531441 then 
    return DanteTarget(cards,triggeringCard)
  end
  if ID == 95992081 then 
    return LeviairTarget(cards)
  end
  if ID == 15561463 then 
    return GauntletLauncherTarget(cards)
  end
  if ID == 38495396 then 
    return PtolemyTarget(cards)
  end
  if ID == 76774528 then 
    return ScrapDragonTarget(cards)
  end
  if ID == 16404809 then -- Kuribandit
    return Add(cards)
  end
  if ID == 09748752 then 
    return CaiusTarget(cards)
  end
  if ID == 30100551 then 
    return MinervaTarget(cards,maxTargets)
  end
  return nil
end
function ChainTrag()
  local c=Duel.GetAttacker()
  c=OppMon()
  if #c>0 then c=c[1] end
  return true
end
function ChainMinerva(c)
  return #AIDeck()>10
end
function ChaosDragonOnSelectChain(cards,only_chains_by_player)
  if HasID(cards,30100551,ChainMinerva) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,34408491) then -- Beelze
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,61901281) then -- Collapserpent
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,99234526) then -- Wyverbuster
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,99365553) then -- Lightpulsar Dragon
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,72989439) then -- BLS
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,16404809) then -- Kuribandit
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,10802915) then -- Tour Guide
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,84764038) then -- Scarm
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,51858306) then -- Eclipse Wyvern
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,07391448) then -- Goyo Guardian
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,83531441) then -- Dante
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,44330098,ChainGorz) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,98777036) and ChainTrag() then
    return {1,CurrentIndex}
  end
  if HasID(cards,09748752) then
    return {1,CurrentIndex}
  end
  return nil
end
GlobalBLS=0
function ChaosDragonOnSelectEffectYesNo(id,card)
  local result = nil
  local field = bit32.band(card.location,LOCATION_ONFIELD)>0
  local grave = bit32.band(card.location,LOCATION_GRAVE)>0
  if id==34408491 or id==61901281 or id==99234526 or id==99365553 -- Beelze, Collapserpent, Wyverbuster, Lightpulsar
  or id==16404809 or id==10802915 -- Kuribandit, Tour Guide,
  or id==51858306 or id==07391448 or id==83531441 -- Eclipse Wyvern, Goyo Guardian
  or id==84764038 -- Scarm
  and NotNegated(card) 
  then
    result = 1
  end
  if id == 30100551 and ChainMinerva(card) then
    return 1
  end
  if id == 44330098 and ChainGorz(card) then
    result = 1
  end
  if id == 98777036 and ChainTrag() then
    result = 1
  end
  if id == 09748752 then
    result = 1
  end
  if id==72989439 then
    result = 1
    GlobalBLS = Duel.GetTurnCount()
  end
  return result
end
ChaosDragonAtt={
  44330098,09596126,22624373,95992081,
}
ChaosDragonDef={
  98777036,16404809,33420078,
  10802915,84764038,19665973,
  85087012,
}
function ChaosDragonOnSelectPosition(id, available)
  result = nil
  for i=1,#ChaosDragonAtt do
    if ChaosDragonAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#ChaosDragonDef do
    if ChaosDragonDef[i]==id then result=POS_FACEUP_DEFENCE end
  end
  if id == 83531441 then -- Dante
    if GlobalBPAllowed and Duel.GetCurrentPhase()==PHASE_MAIN1 
    and Duel.GetTurnPlayer() == player_ai
    and (OppGetWeakestAttDef()<2500 or CardsMatchingFilter(OppMon(),FilterPosition,POS_FACEDOWN)>0)
    then
      result=POS_FACEUP_ATTACK
    else
      result=POS_FACEUP_DEFENCE
    end
  end
  if id == 61901281 or id == 99234526 then
    if GlobalBPAllowed and Duel.GetCurrentPhase()==PHASE_MAIN1 
    then
      result=POS_FACEUP_ATTACK
    else
      result=POS_FACEUP_DEFENCE
    end
  end
  return result
end