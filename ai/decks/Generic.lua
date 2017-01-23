-----
-- Staple cards, or cards used in multiple AI Extra Decks
-----
function XYZSummon(index,id)
  if index == nil then
    index = CurrentIndex
  end
  GlobalMaterial = true
  if id then
    GlobalSSCardID = id
  end
  return {COMMAND_SPECIAL_SUMMON,index}
end
function SynchroSummon(index,id)
  if index == nil then
    index = CurrentIndex
  end
  GlobalMaterial = true
  GlobalSynchroMaterial = true
  if id then
    GlobalSSCardID = id
  end
  return {COMMAND_SPECIAL_SUMMON,index}
end
function PendulumSummon(index,id)
  if index == nil then
    index = CurrentIndex
  end
  if id then
    GlobalSSCardID = id
  end
  GlobalPendulumSummon = true
  return {COMMAND_SPECIAL_SUMMON,index}
end
function Summon(index)
  if index == nil then
    index = CurrentIndex
  end
  return {COMMAND_SUMMON,index}
end
function SpSummon(index,id)
  if index == nil then
    index = CurrentIndex
  end
  if id then
    GlobalSSCardID = id
  end
  return {COMMAND_SPECIAL_SUMMON,index}
end
function Activate(index)
  if index == nil then
    index = CurrentIndex
  end
  return {COMMAND_ACTIVATE,index}
end
function Set(index)
  if index == nil then
    index = CurrentIndex
  end
  return {COMMAND_SET_MONSTER,index}
end
function SetSpell(index)
  if index == nil then
    index = CurrentIndex
  end
  return {COMMAND_SET_ST,index}
end
function Repo(index)
  if index == nil then
    index = CurrentIndex
  end
  return {COMMAND_CHANGE_POS,index}
end
function Chain(index)
  if index == nil then
    index = CurrentIndex
  end
  return {1,index}
end
function SummonExtraDeck(cards,prio)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
---- 
-- use certain effects before doing anything else
---- 
 if prio then 
  if HasID(Act,00691925) then -- Solar Recharge, test
    return Activate()
  end
  if HasIDNotNegated(Act,41142615) then -- Cheerful Coffin, test
    return Activate()
  end
  if HasIDNotNegated(SpSum,07409792) then 
    --return {COMMAND_SPECIAL_SUMMON,CurrentIndex}                                -- test
  end
  if HasIDNotNegated(Act,01621413,UseRequiem,1) then 
    return Activate() -- Requiem Dragon
  end
  if HasIDNotNegated(Rep,12014404,false,nil,nil,POS_FACEUP_ATTACK) and UseCowboyDef() then 
    return {COMMAND_CHANGE_POS,CurrentIndex}                                -- Gagaga Cowboy finish
  end
  if HasIDNotNegated(Act,12014404,false,nil,nil,POS_DEFENSE) and UseCowboyDef() then 
    return Activate()                                -- Gagaga Cowboy finish
  end
  if HasIDNotNegated(Act,29669359) and UseVolcasaurus() then                -- Volcasaurus finish
    return Activate()
  end  
  if HasIDNotNegated(Act,46772449,UseFieldNuke,1) then       -- Evilswarm Exciton Knight
    return Activate()
  end  
  if HasIDNotNegated(Act,57774843,UseFieldNuke,1) then       -- Judgment Dragon
    return Activate()
  end  
  if HasIDNotNegated(Act,39765958,UseJeweledRDA,0) then 
    return Activate()                                -- Hot Red Dragon Archfiend
  end
  if HasIDNotNegated(Act,53129443) and UseDarkHole() then
    return Activate()
  end
  if HasIDNotNegated(Act,12580477) and UseRaigeki() then
    return Activate()
  end  
  if HasIDNotNegated(Act,45986603) and UseSnatchSteal() then
    return Activate()
  end
  if HasIDNotNegated(Act,89882100) then  -- Night Beam
    return Activate()
  end
  if HasIDNotNegated(Act,67616300,UseChickenGame) then
    return Activate()
  end
  if HasID(Act,05133471,nil,nil,LOCATION_GRAVE) 
  and UseGalaxyCyclone(2) 
  then  
    return Activate()
  end
  if HasIDNotNegated(Act,05133471,nil,nil,LOCATION_HAND+LOCATION_ONFIELD) 
  and UseGalaxyCyclone(1) 
  then  
    return Activate()
  end
  if HasID(Act,60082869,nil,nil,LOCATION_SZONE,UseDustTornado) then
    return Activate()
  end
  if HasID(Act,05318639,nil,nil,LOCATION_SZONE,UseMST) then
    return Activate()
  end
  if HasID(Act,08267140,nil,nil,LOCATION_SZONE,UseCosmicCyclone) then
    return Activate()
  end
  if HasID(Act,43898403,UseTwinTwister) then
    return Activate()
  end
  if HasID(Act,05318639,UseMST) then
    return Activate()
  end
  if HasID(Act,08267140,UseCosmicCyclone) then
    return Activate()
  end
  if HasID(Act,18326736,UsePtolemaios) then
    return Activate()
  end
---- 
-- summon certain monsters before anything else
----   
  if MaxxCheck() then
  
  if HasIDNotNegated(SpSum,12014404) and SummonCowboyDef() then          
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,29669359) and SummonVolcasaurusFinish() then  
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,29669359) and SummonVolcaGaiaFinish(1) then  
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,91949988) and SummonVolcaGaiaFinish(2) then  
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,88120966,SummonGiantGrinderFinish) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,46772449,SummonBelzebuth) then          
    return XYZSummon()
  end
  if HasID(SpSum,57774843,SummonJD,1) then                 
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,73580471,UseFieldNuke,-2) then             -- Black Rose
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,16195942) and SummonRebellionFinish() then 
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,31320433) and SummonNightmareSharkFinish() then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,66547759) and SummonLancelotFinish() then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,85909450,SummonHPPDFinish) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,31437713) and SummonHeartlanddracoFinish() then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,56840427,SummonUtopiaRay,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,56832966,SummonUtopiaLightningFinish,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,84013237,SummonUtopiaLightningFinish,1) then
    return XYZSummon()
  end
  
  end
---- 
-- activate removal effects before progressing
---- 
  if HasIDNotNegated(Act,10443957,UseInfinity) then
    return Activate()
  end
  if HasIDNotNegated(Act,04779823) and UseMichael() then
    return Activate()
  end 
  if HasIDNotNegated(Act,31924889) and UseArcanite() then
    return Activate()
  end
  if HasIDNotNegated(Act,80117527) and UseBigEye() then
    return Activate()
  end
  if HasIDNotNegated(Act,88120966,UseGiantGrinder) then
    return Activate()
  end
  if HasIDNotNegated(Act,22110647,false,353770352,UseDracossack1) then
    return Activate()
  end
  if HasIDNotNegated(Act,22110647,false,353770353,UseDracossack2) then
    GlobalCardMode=2
    return Activate()
  end
  if HasIDNotNegated(Act,38495396) and UsePtolemy() then
    return Activate()
  end
  if HasIDNotNegated(Act,15561463) and UseGauntletLauncher() then
    GlobalCardMode = 1
    return Activate()
  end
  if HasIDNotNegated(Act,94380860) then -- Ragnazero                         
    GlobalCardMode = 1
    return Activate()
  end
  if HasIDNotNegated(Act,63519819,UseTER) then
    return Activate()
  end
  if HasIDNotNegated(Act,22653490) then -- Chidori                         
    GlobalCardMode = 2
    return Activate()
  end
  if HasIDNotNegated(Act,48739166) then -- Silent Honors ARK
    OPTSet(48739166)
    return Activate()
  end
  if HasIDNotNegated(Act,82633039,false,1322128625) and UseSkyblaster() then
    OPTSet(82633039)
    return Activate()
  end
  if HasIDNotNegated(Act,10406322,UseAlsei) then
    GlobalActivatedCardID = 10406322
    return Activate()
  end
  if HasIDNotNegated(Act,73964868,ChainPleiades)  then
    return Activate()
  end
  if HasIDNotNegated(Act,61344030) then -- Paladynamo
    GlobalCardMode = 1
    return Activate()
  end
  if HasIDNotNegated(Act,50321796,UseBrionac) then
    return Activate()
  end
  if HasIDNotNegated(Act,16195942) and UseRebellion() then
    return Activate()
  end
  if HasID(Act,31320433) and UseNightmareShark() then
    return Activate()
  end
  if HasID(Act,31437713) and UseHeartlanddraco() then
    return Activate()
  end
  if HasIDNotNegated(Act,01621413,UseRequiem,2) then 
    return Activate() -- Requiem Dragon
  end
  if HasIDNotNegated(Act,48905153,UseDrancia,1) then 
    return Activate()
  end
  if HasIDNotNegated(Act,48905153,UseDrancia,2) then 
    return Activate()
  end
  return nil
 end
 if MaxxCheck() then
 -- summon Gaia Dragon after removal effects
   if HasIDNotNegated(SpSum,91949988,SummonGaiaDragonFinish) then
    return XYZSummon()
  end
  
---- 
-- Generic extra deck monster summons
---- 

-- Synchro
  if HasIDNotNegated(SpSum,52687916,SummonSyncTrishula) then
    return SynchroSummon()
  end
  
  -- Trishula enabling
  for i=1,#Sum do
    if TrishulaCheck(Sum[i]) then
      return Summon(i)
    end
  end
  if HasID(Act,01845204,ShaddollUseInstantFusion,1) then
    return Activate()
  end
  if HasID(SpSum,08561192,SummonLeoh) then
    return SynchroSummon()
  end
  if HasID(SpSum,39765958,SummonJeweledRDA) then
    return SynchroSummon()
  end

  if HasID(SpSum,83994433,SummonStardustSpark) then
    return SynchroSummon()
  end
  if HasID(SpSum,44508094,SummonStardust) then
    return SynchroSummon()
  end
  if HasID(SpSum,23693634,SummonColossal) then
    return SynchroSummon()
  end
  if HasID(SpSum,04779823,SummonMichael) then
    return SynchroSummon()
  end
  if HasID(SpSum,82044279,SummonClearWing) then
    return SynchroSummon()
  end

  if HasIDNotNegated(SpSum,31924889) and SummonArcanite() then
    return SynchroSummon()
  end
  if HasIDNotNegated(SpSum,33698022,SummonMoonlightRose) then
    return SynchroSummon()
  end
  if HasIDNotNegated(SpSum,98012938,SummonVulcan) then
    return SynchroSummon()
  end
  if HasID(SpSum,50321796,SummonBrionac) then
    return SynchroSummon()
  end
  if HasID(SpSum,33198837,SummonNaturiaBeast) then
    return SynchroSummon()
  end
  if HasID(SpSum,88033975,SummonArmades) then
    return SynchroSummon()
  end
  if HasID(SpSum,90953320,SummonLibrarian) then
    return SynchroSummon()
  end
  if HasID(SpSum,26593852,SummonCatastor) then
    return SynchroSummon()
  end

-- XYZ

-- Rank 8
  if HasIDNotNegated(SpSum,63767246,SummonTitanicGalaxy,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,01639384,SummonFelgrand,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,88120966,SummonGiantGrinder) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,10406322,SummonAlsei) then
    return XYZSummon()
  end
  if HasID(SpSum,73445448,SummonZombiestein) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,01639384,SummonFelgrand,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,63767246,SummonTitanicGalaxy,2) then
    return XYZSummon()
  end
  
-- Rank 7
  if HasIDNotNegated(SpSum,80117527) and SummonBigEye() then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSum,80117527)}
  end

  if HasIDNotNegated(SpSum,22110647,SummonDracossack) then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSum,22110647)}
  end
  
-- Rank 6
  if HasID(SpSum,10443957,SummonInfinity) then
    return XYZSummon()
  end
  if HasID(SpSum,38495396,SummonPtolemy) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,15561463) and SummonGauntletLauncher() then
    return XYZSummon()
  end
  if HasID(SpSum,91949988,SummonGaiaDragon) then
    return XYZSummon()
  end

-- Rank 5
  if HasID(SpSum,58069384,SummonNova) then
    return XYZSummon()
  end
  if HasID(SpSum,73964868,SummonPleiades) then
    return XYZSummon()
  end
  if HasID(SpSum,29669359,SummonVolcasaurus) then
    return XYZSummon()
  end

-- Rank 4
  if HasIDNotNegated(SpSum,56832966,SummonUtopiaLightning,1) then
    return XYZSummon()
  end
  if HasID(SpSum,18326736,SummonPtolemaios,1) then
    return XYZSummon(nil,18326736)
  end
  if HasID(SpSum,84013237,SummonUtopia,1) then
    return XYZSummon()
  end 
  if HasID(SpSum,94380860,SummonRagnaZero) then
    return XYZSummon()
  end  
  if HasID(SpSum,09272381,SummonDiamond,1) then
    return XYZSummon(nil,09272381)
  end
  if HasIDNotNegated(SpSum,56638325,SummonDelteros,2) then
    return XYZSummon()
  end
  if HasID(SpSum,18326736,SummonPtolemaios,2) then
    return XYZSummon(nil,18326736)
  end
  if HasID(SpSum,18326736,SummonPtolemaios,3) then
    return XYZSummon(nil,18326736)
  end
  if HasIDNotNegated(SpSum,21044178,SummonDweller,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,22653490,SummonChidori,1) then 
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,56638325,SummonDelteros,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,48739166) and SummonSharkKnight() then 
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,82633039) and SummonSkyblaster() then 
    return XYZSummon()
  end
  if HasID(SpSum,26329679,SummonConstellarOmega) then 
    return XYZSummon()
  end
  if HasID(SpSum,16195942,SummonRebellion) then 
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,61344030) and SummonPaladynamo() then
    return XYZSummon()
  end
  if HasID(SpSum,84013237,SummonUtopia,2) then
    return XYZSummon()
  end 
  if HasIDNotNegated(SpSum,22653490,SummonChidori,2) then 
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,06511113,SummonRafflesia) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,48905153,SummonDrancia,1) then
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,85115440,SummonBullhorn,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,85115440,SummonBullhorn,2) then
    return XYZSummon()
  end  
  if HasIDNotNegated(SpSum,63746411) and SummonGiantHand() then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,91499077) and SummonGagagaSamurai() then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,91499077) and UseGagagaSamurai() then
    return Activate()
  end
  if HasIDNotNegated(SpSum,34086406) and SummonLavalvalChain() then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,34086406,false,545382497) and UseLavalvalChain() then   
    return Activate()
  end
  if HasID(SpSum,11398059,SummonImpKing) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,11398059) then
    GlobalCardMode = 1
    return Activate()
  end
  if HasIDNotNegated(SpSum,21044178,SummonDweller,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,00581014) and SummonEmeral() then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,00581014,false,9296225) and UseEmeral() then
    return Activate()
  end
  if HasID(SpSum,21501505,SummonCairngorgon) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,93568288) and SummonRhapsody() then
    return XYZSummon()
  end
  if HasID(SpSum,84013237,SummonUtopia,3) then
    return XYZSummon()
  end 
  if HasIDNotNegated(SpSum,12014404) and SummonCowboyAtt() then
    return XYZSummon()
  end
  if HasIDNotNegated(Rep,12014404,nil,nil,POS_DEFENSE,UseCowboyAtt) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Act,12014404,FilterPosition,POS_FACEUP_ATTACK) and UseCowboyAtt() then
    Global1PTGunman = 1
    return Activate()
  end
  if HasIDNotNegated(SpSum,12014404) and SummonCowboyDef(2) then 
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,21044178,SummonDweller,3) then
    return XYZSummon()
  end
  
-- Rank 3
  if HasIDNotNegated(SpSum,78156759,SummonZenmaines) then
    GlobalDWSS=2
    return XYZSummon()
  end
  if HasID(Rep,78156759,RepoZenmaines) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,15914410) and SummonMechquipped() then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,95992081) and SummonLeviair() then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,95992081) and UseLeviair() then
    GlobalCardMode = 1
    return Activate()
  end
  if HasIDNotNegated(SpSum,81330115,SummonAcidGolem) then
    return XYZSummon()
  end
  
-- Pendulum scales
  local scales={}
  for i,c in pairs(Act) do
    if c.description == 1160  -- activate as pendulum scale
    and CardIsScripted(c.id) == 0
    then
      scales[#scales+1]=c
      c.index = i
    end
  end
  if #scales>0 then
    table.sort(scales,function(a,b) return a.lscale>b.lscale end)
    local high = scales[1]
    local low = scales[#scales]
    local levels = 0
    local mons = SubGroup(UseLists(AIHand(),AIExtra()),FilterPendulumSummonable)
    local hand = SubGroup(AIHand(),FilterPendulumSummonable)
    local targets = {}
    local targets2 = {}
    if ScaleCheck() == false and #hand>1 then -- no active scales
      table.remove(mons,FindCard(high,mons,true)[1])
      table.remove(mons,FindCard(low,mons,true)[1])
      for i,c in pairs(mons) do
        if high.lscale>c.level and c.level>low.lscale then
          targets[#targets+1]=c
        end
      end
      if #targets>1 then
        return Activate(high.index)
      end
    elseif ScaleCheck() == true then -- 2 active scales, and you can still use some?
      print("Warning: Can activate more than 2 scales?")
    elseif type(ScaleCheck()) == "number" then -- one scale active
      table.remove(mons,FindCard(high,mons,true)[1])
      for i,c in pairs(mons) do
        if high.lscale>c.level and c.level>ScaleCheck() then
          targets[#targets+1]=c
        end
      end
      table.insert(mons,high)
      table.remove(mons,FindCard(low,mons,true)[1])
      for i,c in pairs(mons) do
        if ScaleCheck()>c.level and c.level>low.lscale then
          targets2[#targets2+1]=c
        end
      end
      if #targets>1 or #targets2>1 then
        if #targets>#targets2 then
          return Activate(high.index)
        else
          return Activate(low.index)
        end
      end
    end
  end
  
-- Pendulum summoning
  for i,c in pairs(SpSum) do
    if FilterLocation(c,LOCATION_SZONE) then
      return PendulumSummon(i)
    end
  end
-- Speedroid engine
  if HasID(SpSum,81275020,SummonTerrortop,1) then
    return SpSummon()
  end
  if HasID(SpSum,53932291,SummonTaketomborg,1) then
    return SpSummon()
  end
  if HasID(Sum,81275020,SummonTerrortop,2) then
    return Summon()
  end
  if HasID(Sum,81275020,SummonTerrortop,3) then
    return Summon()
  end
  if HasID(Sum,53932291,SummonTaketomborg,2) then
    return Summon()
  end
  if HasIDNotNegated(Act,53932291,UseTaketomborg,1) then
    return Activate()
  end
 end
-- if the opponent still has stronger monsters, use Raigeki  
  if HasID(Act,12580477) and UseRaigeki2() then
    return Activate()
  end 
 if MaxxCheck() then 
-- use Soul Charge when other plays have been exhausted
  if HasID(Act,54447022) and UseSoulCharge() then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseInstantFusion,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseInstantFusion,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseInstantFusion,4) then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseInstantFusion,3) then
    return Activate()
  end
 end
  if HasIDNotNegated(Act,98645731)  -- Duality
  and not DeckCheck(DECK_HAT) and not DeckCheck(DECK_BUJIN) 
  then
    GlobalDuality = Duel.GetTurnCount()
    return Activate()
  end
  if HasID(Act,73176465) and UseFelis() then
    return Activate()
  end
  if HasID(Act,19508728,UseMoonMirror) then
    return Activate()
  end
  for i=1,#Rep do
    local c=Rep[i]
    local equips = c:get_equipped_cards()
    if HasIDNotNegated(equips,19508728,true)
    and FilterPosition(c,POS_DEFENSE)
    then
      return Repo()
    end
  end
  return nil
end
function SummonCrystalWing(c,mode)
  return true
end
function CrystalWingFilter(c,attacker)
  return NotNegated(attacker)
  and c.level>4
end
function CrystalWingCheck(attacker,targets)
  return CardsMatchingFilter(targets,CrystalWingFilter,attacker)>0
end
function SummonBullhorn(c,mode)
  if not MaxxCheck() then return false end
  if mode == 1
  and HasIDNotNegated(AIExtra(),48905153,true,SummonDrancia,2)
  then
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIExtra(),48905153,true,SummonDrancia,3)
  then
    return true
  end
end
function DranciaFilter(c,prio)
  return Affected(c,TYPE_MONSTER,4)
  and Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP)
  and DestroyFilterIgnore(c)
  and (not prio or PriorityTarget(c))
end
function UseDrancia(c,mode)
  if mode == 1
  and CardsMatchingFilter(OppField(),DranciaFilter,true)>0
  then
    return true
  end
  if mode == 2
  and MP2Check()
  and CardsMatchingFilter(OppField(),DranciaFilter)>0
  and c.xyz_material_count>1 
  then
    return true
  end
end
function SummonDrancia(c,mode)
  if not MaxxCheck() then return false end
  if mode == 1
  and HasID(AIMon(),85115440,true)
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(OppField(),DranciaFilter)>0
  and MP2Check()
  then
    return true
  end
  if mode == 3
  and MP2Check()
  and CardsMatchingFilter(AIMon(),PriorityTarget)>0
  then
    return true
  end
end
function RequiemFilter(c,source)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,5)
  and CanDealBattleDamage(source,{c})
end
function UseRequiem(c,mode)
  if mode == 1 -- can finish game with attack
  then
    for i,target in pairs(SubGroup(OppMon(),RequiemFilter,c)) do
      if CanFinishGame(c,target,nil,target.base_attack,target.attack) then
        GlobalTargetSet(target)
        GlobalCardMode = 1
        return true
      end
    end
  end
  if mode == 2
  and OppHasStrongestMonster()
  and CardsMatchingFilter(OppMon(),RequiemFilter,c)>0
  then
    return true
  end
end
function SummonTerrortop(c,mode)
  if mode == 1 -- special summon
  and NotNegated(c)
  and HasID(UseLists(AIHand(),AIDeck()),53932291,true) -- Taketomborg
  and CardsMatchingFilter(AIExtra(),FilterRank,3)>0
  and SpaceCheck(LOCATION_MZONE)>1
  and OPTCheck(c.id)
  then
    return true
  end
  if mode == 2 -- normal summon
  and NotNegated(c)
  and HasID(UseLists(AIHand(),AIDeck()),53932291,true) -- Taketomborg
  and CardsMatchingFilter(AIExtra(),FilterRank,3)>0
  and SpaceCheck(LOCATION_MZONE)>1
  and OPTCheck(c.id)
  then
    return true
  end
  if mode == 3 -- normal summon
  and FieldCheck(3)==1
  and CardsMatchingFilter(AIExtra(),FilterRank,3)>0
  then
    return true
  end
end
function SummonTaketomborg(c,mode)
  if mode == 1 -- special summon
  and FieldCheck(3)==1
  and CardsMatchingFilter(AIExtra(),FilterRank,3)>0
  then
    return true
  end
  if mode == 2 -- normal summon
  and FieldCheck(3)==1
  and CardsMatchingFilter(AIExtra(),FilterRank,3)>0
  then
    return true
  end
end
function TaketomborgFilter(card,targets)
  for i,c in pairs(targets) do
    if FilterType(card,TYPE_SYNCHRO)
    and FilterAttribute(card,ATTRIBUTE_WIND)
    --and c.level+3==card.level
    then
      return true
    end
  end
  return false
end
function UseTaketomborg(c,mode)
  local targets = SubGroup(AIDeck(),FilterTuner)
  targets = SubGroup(targets,FilterAttribute,ATTRIBUTE_WIND)
  if mode == 1
  and FieldCheck(3)>1
  and CardsMatchingFilter(AIExtra(),TaketomborgFilter,targets)>0
  then
    return true
  end
end
function TERFilter(c)
  return Affected(c,TYPE_MONSTER,1)
  and Targetable(c,TYPE_MONSTER)
end
function UseTER(c)
  if CardsMatchingFilter(OppMon(),TERFilter)>0 then
    return true
  end
end
function UseTwinTwister(c,mode)
  local targets = DestroyCheck(OppST())
  local facedown = DestroyCheck(OppST(),nil,nil,nil,FilterPosition,POS_FACEDOWN)
  local prio = HasPriorityTarget(OppST(),true)
  if facedown>1 then
    GlobalTwinTwisterTarget = function(c) return FilterPosition(c,POS_FACEDOWN) end
    return true
  end
  if prio and targets>1 then
    return true
  end
  if PriorityCheck(AIHand(),PRIO_TOGRAVE)>3 
  and targets>1 then
    return true
  end
end
GlobalTwinTwisterTarget = nil
function ChainTwinTwister(c,mode)
  local targets = DestroyCheck(OppST())
  local facedown = DestroyCheck(OppST(),nil,nil,nil,FilterPosition,POS_FACEDOWN)
  local prio = HasPriorityTarget(OppST(),true)
  local endphase = CardsMatchingFilter(OppST(),MSTEndPhaseFilter)
  if RemovalCheckCard(c)
  then
    return targets>1 or targets>0 and PriorityCheck(AIHand(),PRIO_TOGRAVE)>3
  end
  if not UnchainableCheck(c) then
    return false
  end
  if Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetCurrentChain()==0
  and endphase>0
  and targets>1
  then
    GlobalTwinTwisterTarget = MSTEndPhaseFilter
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai
  and prio
  and targets>1
  then
    return true
  end
  local target = RemoveOnActivation(nil,MSTFilter)
  if target and targets>1 then
    GlobalTwinTwisterTarget = target
    return true
  end
end
function SummonDelteros(c,mode)
  if DeckCheck(DECK_TELLARKNIGHT) then return false end
  if mode == 1 
  and MP2Check(2500)
  and DestroyCheck(OppCards())>0
  then
    return true
  end
  if mode == 2 
  and HasID(AIExtra(),09272381,true,SummonDiamond)
  and (DestroyCheck(OppCards())>0 or not HasID(AIExtra(),18326736,true))
  then
    return true
  end
  return false
end
function DiamondSummonFilter(c)
  return SatellarknightFilter(c) 
  and FilterType(c,TYPE_XYZ)
end
function SummonDiamond(c)
  if not mode 
  and Duel.GetCurrentPhase()==PHASE_MAIN2
  and MatchupCheck(c.id)
  and (not OppHasStrongestMonster()
  or OppGetStrongestAttDef()<c.attack)
  and DualityCheck()
  and WindaCheck()
  and NotNegated(c)
  then
    return true
  end
  if mode == 1 
  and Duel.GetCurrentPhase()==PHASE_MAIN2
  and MatchupCheck(c.id)
  and (not OppHasStrongestMonster()
  or OppGetStrongestAttDef()<c.attack)
  and CardsMatchingFilter(AIMon(),DiamondSummonFilter)>0
  and NotNegated(c)
  then
    return true
  end
  return false
end
function MoonMirrorFilter(c)
  return Affected(c,TYPE_SPELL)
  and Targetable(c,TYPE_SPELL)
  and CanAttack(c)
  and BattlePhaseCheck(c)
  and CurrentOwner(c)==1
end
function UseMoonMirror(c)
  return OppHasStrongestMonster()
  and CardsMatchingFilter(AIMon(),MoonMirrorFilter)
end
function UseFelis()
  return Duel.GetCurrentPhase()==PHASE_MAIN2 and DestroyCheck(OppMon())>0
end
function SummonAcidGolem(c)
  return Negated(c) 
  and OppGetStrongestAttDef()<c.attack
end
function UseChickenGame(c)
--67616300
--1081860800 draw
--1081860801 destroy
--1081860802 lp
  if FilterLocation(c,LOCATION_HAND) then
    return ExpectedDamage(2)<.5*AI.GetPlayerLP(2)
    and CardsMatchingFilter(AIST(),FilterType,TYPE_FIELD)==0
  end
  if ExpectedDamage(2)>=.5*AI.GetPlayerLP(2)
  or #AIHand()>6
  then
    return c.description==1081860801
    and AI.GetPlayerLP(1)>1000
  else
    return c.description==1081860800
    and AI.GetPlayerLP(1)>2000
  end
end
function SummonRafflesia(c)
  return CardsMatchingFilter(AIDeck(),TrapHoleFilter)>1
  and TurnEndCheck() and (#OppMon()==0 
  or OppGetStrongestAttack()<c.attack 
  and #SubGroup(OppST(),FilterPosition,POS_FACEDOWN)>2)
end
function InfinityCheck(count)
  if not count then count = 3 end
  return HasID(AIExtra(),58069384,true)
  and HasIDNotNegated(AIExtra(),10443957,true)
  and (HasIDNotNegated(AIExtra(),18326736,true)
  and FieldCheck(4)==count
  or HasIDNotNegated(AIMon(),18326736,true,FilterMaterials,3))
  and DualityCheck()
end
GlobalPtolemaiosID = nil
function SummonPtolemaios(c,mode)
  if mode == 1
  and InfinityCheck()
  and CardsMatchingFilter(OppMon(),InfinityFilter,FindID(10443957,AIExtra()))>0
  and MP2Check()
  then
    GlobalPtolemaiosID = 10443957
    return true
  end
  if mode == 2
  and HasID(AIExtra(),09272381,true,SummonDiamond)
  then
    GlobalPtolemaiosID = 09272381
    return true
  end
  if mode == 3
  and InfinityCheck()
  and MP2Check()
  then
    GlobalPtolemaiosID = 10443957
    return true
  end
  return false
end
function UsePtolemaios(c)
  return InfinityCheck() and FilterMaterials(c,3)
end
function SummonNova(c)
  return HasIDNotNegated(AIExtra(),10443957,true)
  --and UseInfinity(FindID(10443957,AIExtra()))
end
function SummonInfinity(c)
  return HasID(AIMon(),58069384,true)
  and HasIDNotNegated(AIExtra(),10443957,true)
end
function InfinityFilter(c,source)
  return Affected(c,TYPE_MONSTER,6)
  and Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and not FilterType(c,TYPE_TOKEN)
  and (CurrentOwner(c)==2
  or CurrentOwner(c)==1 
  and c.attack<=1500
  and source.xyz_material_count<2
  and not CardsEqual(c,source))
end
function UseInfinity(c)
  return CardsMatchingFilter(OppMon(),InfinityFilter,c)>0
  or TurnEndCheck() and CardsMatchingFilter(AIMon(),InfinityFilter,c)>0
end
function UseMST(c)
  local filter = function(c) 
    return FilterPosition(c,POS_FACEDOWN)
    and FilterPrivate(c)
    and DestroyFilter(c)
  end
  local OppTargets=SubGroup(OppST(),filter)
  if (#AIField()==0 
  or #AIField()==CardsMatchingFilter(AIField(),FilterID,c.id))
  and #OppTargets>0
  and #OppTargets<=CardsMatchingFilter(AICards(),FilterID,c.id)
  then
    GlobalCardMode = 1
    GlobalTargetSet(OppTargets[math.random(1,#OppTargets)])
    return true
  end
  return false
end
function UseCosmicCyclone(c)
  if AI.GetPlayerLP(1)<=1000 then
    return false
  end
  local filter = function(c) 
    return FilterPosition(c,POS_FACEDOWN)
    and FilterPrivate(c)
    and DestroyFilter(c)
  end
  local OppTargets=SubGroup(OppST(),filter)
  if (#AIField()==0 
  or #AIField()==CardsMatchingFilter(AIField(),FilterID,c.id))
  and #OppTargets>0
  and #OppTargets<=CardsMatchingFilter(AICards(),FilterID,c.id)
  then
    GlobalCardMode = 1
    GlobalTargetSet(OppTargets[math.random(1,#OppTargets)])
    return true
  end
  return false
end
function UseDustTornado(c)
  return UseMST(c)
end
function SummonStardust(c)
  return OppGetStrongestAttDef()<2500 and MP2Check(c)
end
function SummonColossal(c)
  return BattlePhaseCheck() and (OppGetStrongestAttack()==c.attack
  or Negated(c) and OppHasStrongestMonster() 
  and OppGetStrongestAttDef()<=c.attack)
end
function BrionacFilter(c)
  return PriorityTarget(c)
  and not ToHandBlacklist(c.id)
  and Affected(c,TYPE_MONSTER,6)
  and Targetable(c,TYPE_MONSTER)
end
function UseBrionac(c)
  return NotNegated(c) 
  and CardsMatchingFilter(OppField(),BrionacFilter)>0
  and PriorityCheck(AIHand(),PRIO_TOGRAVE)>2
end
function SummonBrionac(c)
  return NotNegated(c) 
  and CardsMatchingFilter(OppMon(),BrionacFilter)>0
  and PriorityCheck(AIHand(),PRIO_TOGRAVE)>2
end
function SummonCatastor(c)
  return NotNegated(c) and OppHasStrongestMonster()
  and CardsMatchingFilter(OppMon(),CatastorFilter)>0
  or Negated(c) and OppHasStrongestMonster() 
  and OppGetStrongestAttDef()<=c.attack
end
function SummonLibrarian(c)
  return NotNegated(c) and CardsMatchingFilter(AIMon(),FilterType,TYPE_TUNER)>1
  or Negated(c) and OppHasStrongestMonster() 
  and OppGetStrongestAttDef()<=c.attack
end
function SummonZombiestein(c)
  return MP2Check(c) and OppHasStrongestMonster() --and OppGetStrongestAttack()>2800
  and OppGetStrongestAttack()<4500
end
function SummonFelgrand(c,mode)
  if mode == 1 
  and NotNegated(c)
  and MP2Check(c) 
  and OppGetStrongestAttack()<c.attack
  then
    return true
  end
  if mode == 2
  and OppHasStrongestMonster()
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function SummonTitanicGalaxy(c,mode)
  if mode == 1 
  and NotNegated(c) 
  and MP2Check(c) 
  and OppGetStrongestAttack()<c.attack
  then
    return true
  end
  if mode == 2
  and OppHasStrongestMonster()
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function FieldNukeFilter(c,source)
  return Affected(c,TYPE_MONSTER,source.level)
end
function FieldNukeCollateralFilter(c)
  return not (FilterType(c,TYPE_TOKEN)
  or KozmoShip(c)
  or c.id == 67237709) -- Kozmotown
end
function UseFieldNuke(source,exclude)
  local targets = SubGroup(OppField(),FieldNukeFilter,source)
  local collateral = SubGroup(AIField(),FieldNukeCollateralFilter)
  return DestroyCheck(targets,true)+exclude-DestroyCheck(collateral,true)>0 
end
function SummonBelzebuth(c)
  if DeckCheck(DECK_CONSTELLAR) and HasIDNotNegated(AIMon(),70908596,true)
  and CardsMatchingFilter(AIMon(),ConstellarNonXYZFilter)>1
  and (SummonVolcasaurusFinish() or SummonVolcaGaiaFinish(1))
  then
    return false
  end
  local AICards=UseLists({AIHand(),AIField()})
  local OppCards=UseLists({OppHand(),OppField()})
  return #AICards<=#OppCards and UseFieldNuke(c,-1)
end
function SummonCowboyDef(mode)
  return AI.GetPlayerLP(2)<=800 
  or mode == 2 and MP2Check() and AI.GetPlayerLP(2)<=1600 
end
function SummonPaladynamo()
  local cards = OppMon()
  local c
  for i=1,#cards do
    c=cards[i]
    if c.attack>=2000 and bit32.band(c.position,POS_FACEUP_ATTACK)>0
    and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
    then
      return MP2Check()
    end 
  end
  return false
end
function SummonLavalvalChain()
  if DeckCheck(DECK_HAT) or DeckCheck(DECK_HERALDIC) 
  or DeckCheck(DECK_QLIPHORT) or DeckCheck(DECK_DARKWORLD)
  or DeckCheck(DECK_CONSTELLAR) or DeckCheck(DECK_HARPIE)
  then
    return false
  else
    return MP2Check(1800) and OppGetStrongestAttDef()<1800 and #AIGrave()<10
  end
end
function UseLavalvalChain()
  return not (DeckCheck(DECK_NEKROZ) or DeckCheck(DECK_DARKWORLD)
  or DeckCheck(DECK_CONSTELLAR) or DeckCheck(DECK_HARPIE))
end
function ChidoriFilter(c,pos)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,4)
  and (pos == nil or FilterPosition(c,pos))
end
function SummonChidori(c,mode)
  if mode == 1 
  and CardsMatchingFilter(OppField(),ChidoriFilter,POS_FACEUP)>0
  and CardsMatchingFilter(OppField(),ChidoriFilter,POS_FACEDOWN)>0
  then
    return true
  end
  if mode == 2 
  and HasPriorityTarget(OppField(),false,nil,ChidoriFilter,POS_FACEUP)
  then
    return true
  end
  return false
end
function SummonRagnaZero(card)
  local cards = OppMon()
  for i=1,#cards do
    local c=cards[i]
    if c.attack~=c.base_attack
    and bit32.band(c.position,POS_FACEUP_ATTACK)>0    
    and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
    and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
    and NotNegated(card)
    then
      return true
    end 
  end
  if Negated(card) then
    return OppGetStrongestAttDef() < 2400
    and OppHasStrongestMonster()
  end
  return false
end
function SummonImpKing(c,mode)
  if mode == 1 then
    return MP2Check(c) 
    and CardsMatchingFilter(AIDeck(),FilterRace,RACE_REPTILE)>0
    and NotNegated(c)
    and OppGetStrongestAttDef() < 2300
  end
  return MP2Check(c) 
  and (CardsMatchingFilter(AIDeck(),FilterRace,RACE_REPTILE)>0
  and NotNegated(c)
  or Negated(c) and OppGetStrongestAttDef() < 2300
  and OppHasStrongestMonster())
end
function SummonDracossack()
  return MP2Check() and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>0
end
function BigEyeFilter(c)
  return c.attack>=2600 and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
end
function SummonBigEye()
  return CardsMatchingFilter(OppMon(),BigEyeFilter)>0 and MP2Check()
end
function SummonNaturiaBeast(c)
  return OppGetStrongestAttDef()<2200 and MP2Check(c)
end
function SummonArmades(c)
  return BattlePhaseCheck()
  and c and CanWinBattle(c,OppMon())
end
function SummonStardustSpark(c)
  return NotNegated(c) and MP2Check(c) 
  or Negated(c) and OppGetStrongestAttDef()<2500
  or HasID(AICards(),05851097,true) 
  and (not OppHasStrongestMonster() or OppGetStrongestAttDef()<2500)
end
function JeweledRDAFilter(card,id)
  return card.cardid~=id and bit32.band(card.position,POS_FACEUP_ATTACK)>0 
  and card:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 and card:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
end
function UseJeweledRDA(card,mod)
  local aimon=AIMon()
  local AITargets=SubGroup(aimon,JeweledRDAFilter,card.cardid)
  local OppTargets=SubGroup(OppMon(),JeweledRDAFilter,card.cardid)
  local diff=(#OppTargets+mod)-#AITargets
  if HasIDNotNegated(aimon,83994433,true,FilterOPT) 
  --and GlobalStardustSparkActivation[aimon[CurrentIndex].cardid]~=Duel.GetTurnCount() 
  then
    diff = diff+1
  end
  if HasIDNotNegated(aimon,23232295,true,HasMaterials)
  then
    diff = diff+1
  end
  AITargets[#AITargets+1]=card
  ApplyATKBoosts(AITargets)
  ApplyATKBoosts(OppTargets)
  local AIAtt=Get_Card_Att_Def(AITargets,"attack",">",nil,"attack")
  local OppAtt=Get_Card_Att_Def(OppTargets,"attack",">",nil,"attack")
  return #AITargets==1 or diff>1 or (diff<=1 and AIAtt-OppAtt < diff*500)
end
function SummonJeweledRDA(c)
  return (UseJeweledRDA(c,1) or OppGetStrongestAttDef() > 2500
  or #AIMon()==2 and DestroyCheck(OppMon(),true,false,false,FilterPosition,POS_FACEUP_ATTACK)>1) 
  and NotNegated(c)
  or Negated(c) and OppGetStrongestAttDef() < c.attack
end

function SummonClearWing(c)
  return OppGetStrongestAttDef() < c.attack 
  and MP2Check(c)
end
function UseBigEye()
  return true
end
function UseDarkHole()
  local aimon=AIMon()
  local AITargets=DestroyCheck(AIMon(),true)
  local OppTargets=DestroyCheck(OppMon(),true)
  local diff=OppTargets-AITargets
  if HasIDNotNegated(aimon,83994433,true,FilterOPT) 
  --and GlobalStardustSparkActivation[aimon[CurrentIndex].cardid]~=Duel.GetTurnCount() 
  then
    diff = diff+1
  end
  if HasIDNotNegated(AIST(),27243130,true) or HasID(AIHand(),27243130,true) then
    diff = diff+1
  end
  local AIAtt=AIGetStrongestAttack()
  local OppAtt=OppGetStrongestAttDef()
  return (AITargets==0 and OppAtt >= 2000) or diff>1 or (OppAtt >= 2000 and diff<=1 and AIAtt-OppAtt < diff*500)
end
function UseRaigeki()
  local OppTargets=DestroyCheck(OppMon(),true)
  local OppAtt=OppGetStrongestAttDef()
  return OppTargets>2 or OppTargets>1 and OppAtt >=2000 or OppTargets>0 and OppAtt>=2500
end
function UseRaigeki2()
  local OppTargets=DestroyCheck(OppMon(),true)
  return OppTargets>0 and OppHasStrongestMonster()
end
function UseSnatchSteal()
  return true
end
function UseEmeral()
  return true
end
function EmeralFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0
end
function SummonEmeral()
  return HasID(AIExtra(),00581014,true) and MP2Check(1800) 
  and CardsMatchingFilter(AIGrave(),EmeralFilter)>10 
  and (OppGetStrongestAttDef()<1800 
  or not OppHasStrongestMonster())
end
function UseCowboyDef()
  return AI.GetPlayerLP(2) < 1600
end
function UseVolcasaurus()
  return DestroyCheck(OppMon())>0
end
function VolcasaurusFilter(c,lp)
  return FilterType(c,TYPE_MONSTER)
  --and not FilterType(c,TYPE_PENDULUM+TYPE_TOKEN)
  and Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,5)
  and DestroyFilter(c)
  and DestroyCountCheck(c,TYPE_MONSTER,false)
  and FilterPosition(c,POS_FACEUP)
  and (lp==nil or c.text_attack and c.text_attack>=AI.GetPlayerLP(2))
end
function SummonVolcasaurus(c)
  return NotNegated(c) and (WindaCheck() or FieldCheck(5)>2) and HasID(AIExtra(),29669359,true)
  and CardsMatchingFilter(OppMon(),VolcasaurusFilter)>0 and MP2Check()
  or Negated(c) and OppHasStrongestMonster() and OppGetStrongestAttack()<c.attack
end
function SummonVolcasaurusFinish()
  return HasID(AIExtra(),29669359,true) and CardsMatchingFilter(OppMon(),VolcasaurusFilter,true)>0
end
function SummonVolcaGaiaFinish(mode)
  local cards = OppMon()
  if not BattlePhaseCheck() then return false end
  if mode == 1 and HasID(AIExtra(),29669359,true) and HasID(AIExtra(),91949988,true) 
  then
    local result = -1
    local index = 0
    for i=1,#cards do
      local c = cards[i]
      if VolcasaurusFilter(c) and c.text_attack>=result then
        result=c.text_attack
        index = i
      end
    end
    if result>-1 then
      table.remove(cards,index)
    end
    local result2 = 0
    if #cards == 0 then
      result2 = 2600
    else 
      for i=1,#cards do
        local dmg = BattleDamage(cards[i],FindID(91949988,AIExtra()),nil,nil,nil,true)
        if dmg>result2 then
          result2 = dmg
        end
      end
    end
    return result>=0 and result + result2 >= AI.GetPlayerLP(2)
  elseif mode == 2 and HasID(AIMon(),29669359,true) and HasID(AIExtra(),91949988,true) 
  then
    local result = 0
    local result2 = 0
    if #cards == 0 then
      result = 2600
    else 
      for i=1,#cards do
        local dmg = BattleDamage(cards[i],FindID(91949988,AIExtra()),nil,nil,nil,true)
        if dmg>result then
          result = dmg
        end
        dmg = BattleDamage(cards[i],FindID(29669359,AIMon()))
        if dmg>result2 then
          result2 = dmg
        end
      end
    end
    return result >= AI.GetPlayerLP(2) and result2 < AI.GetPlayerLP(2)
  end
end

function LeviairFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and c.level<5 
  and c:is_affected_by(EFFECT_SPSUMMON_CONDITION)==0
end
function SummonLeviair()
  if DeckCheck(DECK_DARKWORLD) then
    return false
  end
  return PriorityCheck(AIBanish(),PRIO_TOFIELD,1,LeviairFilter)>4 
end
function UseLeviair()
  return true
end
function SharkKnightFilter(c)
  return FilterPosition(c,POS_FACEUP_ATTACK)
  and not FilterType(c,TYPE_TOKEN)
  and FilterSummon(c,SUMMON_TYPE_SPECIAL)
  and Affected(c,TYPE_MONSTER,4)
  and Targetable(c,TYPE_MONSTER)
end
function SummonSharkKnight(cards)
  return CardsMatchingFilter(OppMon(),SharkKnightFilter)>0 
  and (OppHasStrongestMonster() or HasPriorityTarget(OppMon(),nil,nil,SharkKnightFilter))
  and HasID(AIExtra(),48739166,true) 
  and CanSpecialSummon()
  and MP2Check()
end
function CowboyFilter(c)
  return ((c.attack<3000 and bit32.band(c.position,POS_ATTACK)>0
  or c.defense<2500 and bit32.band(c.position,POS_DEFENSE)>0
  and FilterPublic(c))
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)==0 
  and c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0)
end
function UseCowboyAtt(c)
  return CardsMatchingFilter(OppMon(),CowboyFilter)>0 
  and Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
  and (c == nil or c.xyz_material_count>0)
end
function SummonCowboyAtt()
  return OppHasStrongestMonster() and UseCowboyAtt() 
  and BattlePhaseCheck() and not(CanUseHand())
end
function SkyblasterFilter(c)
  return Affected(c,TYPE_MONSTER,4)
  and Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP)
end
function SummonSkyblaster()
  return (OppHasStrongestMonster() or HasPriorityTarget(OppMon(),nil,nil,SkyblasterFilter))
  and CardsMatchingFilter(OppMon(),SkyblasterFilter)>0 
  and HasID(AIExtra(),82633039,true) 
  and MP2Check()
end
function UseSkyblaster()
  return CardsMatchingFilter(OppField(),SkyblasterFilter)>0
end
function SummonLeoh(c)
  return c and OppGetStrongestAttDef() < c.attack 
  and MP2Check(c) and HasID(AIExtra(),08561192,true)
end
function SummonMechquipped()
  return Duel.GetCurrentPhase() == PHASE_MAIN2 or Duel.GetTurnCount()==1
end
function DwellerFilter(c)
  return FilterAttribute(c,ATTRIBUTE_WATER) and FilterLevel(c,4)
end
function SummonDweller(c,mode)
  local atk = c.attack
  if CardsMatchingFilter(AIMon(),DwellerFilter)>0 then
    atk = atk + 500
  end
  if mode == 1 and MatchupCheck(c.id)
  and (OppGetStrongestAttDef()<atk
  or not OppHasStrongestMonster())
  then
    return true
  end
  if mode == 2 and MP2Check(atk) 
  and (OppGetStrongestAttDef()<atk
  or not OppHasStrongestMonster())
  then
    return true
  end
  if mode == 3 and TurnEndCheck()
  and CardsMatchingFilter(AIMon(),DwellerFilter)>0
  and (OppGetStrongestAttDef()<atk
  or not OppHasStrongestMonster())
  then
    return true
  end
  return false
end
function PleiadesFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,5)
end
function PleiadesFilter2(c)
  return PleiadesFilter(c) and not ToHandBlacklist(c.id) 
  and PriorityTarget(c)
end
function PleiadesRemovalFilter(c)
  return not ((c:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_XYZ) 
  or c:IsHasEffect(EFFECT_SPSUMMON_CONDITION))
  or ToHandBlacklist(c:GetCode()))
  and not c:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET)
end
function ChainPleiades(c)
  local targets = CardsMatchingFilter(OppMon(),PleiadesFilter)
  local targets2 = CardsMatchingFilter(OppMon(),PleiadesFilter2)
  if RemovalCheckCard(c) then
    if (Duel.GetOperationInfo(Duel.GetCurrentChain(),CATEGORY_TOHAND) 
    or Duel.GetOperationInfo(Duel.GetCurrentChain(),CATEGORY_TODECK))
    and targets>0 or targets2>0
    then
      return true
    else
      GlobalCardMode = 2
      GlobalTargetSet(FindID(73964868,AIMon()),AIMon())
      return true
    end
  end
  if not UnchainableCheck(73964868) then
    return false
  end
  if targets2 and targets2 > 0 and (AIGetStrongestAttack()<=OppGetStrongestAttDef(PleiadesFilter2) 
  or TurnEndCheck() or Duel.GetTurnPlayer()==1-player_ai)
  then
    return true
  end
  if targets and targets == 1 and #OppMon()==1 and BattlePhaseCheck()
  and Duel.GetTurnPlayer()==player_ai
  and ExpectedDamage(2)>=AI.GetPlayerLP(2) then
    return true
  end
  cg = RemovalCheck()
  if cg and not Duel.GetOperationInfo(Duel.GetCurrentChain(),CATEGORY_TOHAND) then
		if cg:IsExists(function(c) return c:IsControler(player_ai) end, 1, nil) then
      local g=cg:Filter(PleiadesRemovalFilter,nil,player_ai):GetMaxGroup(Card.GetAttack)
      if g then
        GlobalCardMode = 2
        GlobalTargetSet(g:GetFirst(),AIField())
        return true
      end
    end	
  end
  cg = NegateCheck()
  if cg and Duel.GetCurrentChain()>1 then
		if cg:IsExists(function(c) return c:IsControler(player_ai) end, 1, nil) then
      local g=cg:Filter(PleiadesRemovalFilter,nil,player_ai):GetMaxGroup(Card.GetAttack)
      if g then
        GlobalCardMode = 2
        GlobalTargetSet(g:GetFirst(),AIField())
        return true
      end
    end	
  end
  if IsBattlePhase() and Duel.GetTurnPlayer()~=player_ai and targets>0 then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and target 
    and (WinsBattle(source,target) or source:GetCode()==68535320 or source:GetCode()==95929069)
    and target:IsControler(player_ai) and Targetable(source,TYPE_MONSTER) and Affected(source,TYPE_MONSTER,5)
    then
      GlobalCardMode = 2
      GlobalTargetSet(source,OppMon())
      return true
    end
  end
  if (Duel.GetCurrentPhase()==PHASE_END and Duel.GetTurnPlayer()~=player_ai 
  or (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) 
  and Duel.GetTurnPlayer()==player_ai) and Duel.GetCurrentChain()==0
  then
    if HasID(AIST(),57103969,true,nil,nil,POS_FACEUP) 
    and CardsMatchingFilter(AIDeck(),FilterRace,RACE_BEASTWARRIOR)>0 
    and NeedsCard(70908596,AIDeck(),AIHand(),true)
    and OPTCheck(57103969) and not HasID(AIHand(),57103969,true)
    then
      GlobalCardMode = 2
      GlobalTargetSet(FindID(57103969,AIST(),nil,FilterPosition,POS_FACEUP),AIST())
      return true
    end
    if HasID(AIST(),05851097,true,nil,nil,POS_FACEUP) 
    and OppHasStrongestMonster()
    then
      GlobalCardMode = 2
      GlobalTargetSet(FindID(05851097,AIST(),nil,FilterPosition,POS_FACEUP),AIST())
      return true
    end
    if HasID(AIST(),50078509,true,nil,nil,POS_FACEUP) 
    then
      GlobalCardMode = 2
      GlobalTargetSet(FindID(50078509,AIST(),nil,FilterPosition,POS_FACEUP),AIST())
      return true
    end
    if HasID(AIST(),57103969,true,nil,nil,POS_FACEUP) 
    and CardsMatchingFilter(AIDeck(),FilterRace,RACE_BEASTWARRIOR)>0 
    and OPTCheck(57103969) and not HasID(AIHand(),57103969,true)
    then
      GlobalCardMode = 2
      GlobalTargetSet(FindID(57103969,AIST(),nil,FilterPosition,POS_FACEUP),AIST())
      return true
    end
  end
  return false
end
function SummonPleiades()
  return HasID(AIExtra(),73964868,true) and (MP2Check()
  or HasPriorityTarget(OppField()) or #OppMon()==1
  and CardsMatchingFilter(OppMon(),PleiadesFilter)==1
  and AI.GetPlayerLP(2)<=2500 and BattlePhaseCheck())
end
function SummonGiantHand()
  return MP2Check(2000) and OppGetStrongestAttDef()<2000
end
function SummonCairngorgon(c)
  return OppGetStrongestAttDef()<c.attack and MP2Check(c)
  and (NotNegated(c) or OppHasStrongestMonster())
end
function SummonRhapsody()
  local cards=AIMon()
  for i=1,#cards do
    if bit32.band(cards[i].type,TYPE_XYZ)>0 and cards[i].attack+1200 > OppGetStrongestAttack() and  #OppGrave()>=2 then
      return MP2Check()
    end
  end
  return false
end
function SummonGagagaSamurai()
  return Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed and #OppMon()==0 and ExpectedDamage(2)<2000
end
function UseGagagaSamurai()
  return Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed and not OppHasStrongestMonster()
end
function RebellionFilter(c)
  return FilterPosition(c,POS_FACEUP) and c.attack>0
  and Targetable(c,TYPE_MONSTER) and Affected(c,TYPE_MONSTER,4) 
end
function RebellionFilter2(c)
  return FilterPosition(c,POS_FACEUP_ATTACK)
  and Targetable(c,TYPE_MONSTER) and Affected(c,TYPE_MONSTER,4) 
end
function SummonRebellion(c)
  local OppAttDef=OppGetStrongestAttDef()
  return OppHasStrongestMonster() and OppAttDef>2500
  and 2500+OppGetStrongestAttack(RebellionFilter)*0.5 > OppAttDef
  and Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
  and NotNegated(c)
  or Negated(c) and OppHasStrongestMonster() and OppAttDef<2500
end
function SummonRebellionFinish()
  return CardsMatchingFilter(OppMon(),RebellionFilter2)>0 and AI.GetPlayerLP(2)<=2500
  and Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
end
function UseRebellion()
  return CardsMatchingFilter(OppMon(),RebellionFilter)>0
end
function ZenmainesFilter(c,source)
  return (c.attack>source.attack and DestroyFilterIgnore(c) 
  and AI.GetPlayerLP(1)>(c.attack-source.attack)+800
  or c.attack==source.attack and DestroyCheck(OppField())>1)
  and AttackBlacklistCheck(c,source)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and not FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
end
function ZenmainesCheck(card,targets)
  return CardsMatchingFilter(OppMon(),ZenmainesFilter,card)>0 
  and NotNegated(card)
  and (FilterLocation(card,LOCATION_EXTRA) 
  or card.xyz_material_count>0)
end
function SummonZenmaines(card)
  return (ZenmainesCheck(card,OppMon()) or MP2Check())
  and not DeckCheck(DECK_BA)
end
function RepoZenmaines(c)
  if (ZenmainesCheck(c,OppMon())
  or not OppHasStrongestMonster()
  or #OppMon()==0)
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()==PHASE_MAIN1
  and GlobalBPAllowed
  then
    return FilterPosition(c,POS_DEFENSE)
  else
    return FilterPosition(c,POS_ATTACK)
  end
end
function SummonNightmareSharkFinish()
  return GlobalBPAllowed 
  and Duel.GetCurrentPhase() == PHASE_MAIN1 
  and AI.GetPlayerLP(2)<=2000
  and not HasID(AIMon(),31320433,true)
  and #OppMon()>0
end
function UseNightmareShark()
  return GlobalBPAllowed and Duel.GetCurrentPhase() == PHASE_MAIN1
end
function SummonLancelotFinish()
  return GlobalBPAllowed and Duel.GetCurrentPhase() == PHASE_MAIN1 and AI.GetPlayerLP(2)<=2000
end
function AlseiFilter(c,source)
  return Affected(c,TYPE_MONSTER,source.level)
  and Targetable(c,TYPE_MONSTER)
end
function SummonAlsei(c)
  return MP2Check(c) and UseAlsei(c)
  and HasPriorityTarget(OppField(),false,nil,AlseiFilter,c)
end
function UseAlsei(c)
  return OPTCheck(10406322) 
  and CardsMatchingFilter(OppField(),AlseiFilter,c)>0
end
function GiantGrinderFilter(c,source)
  return FilterSummon(c,SUMMON_TYPE_SPECIAL)
  and DestroyFilter(c)
  and Affected(c,TYPE_MONSTER,source.level)
  and Targetable(c,TYPE_MONSTER)
  and DestroyCountCheck(c,TYPE_MONSTER,false)
end
function GiantGrinderFilter2(c,source)
  return GiantGrinderFilter(c,source)
  and FilterType(c,TYPE_XYZ)
end
function SummonGiantGrinder(c)
  return UseGiantGrinder(c)
  and HasPriorityTarget(OppMon(),true,nil,GiantGrinderFilter,c)
  and CardsMatchingFilter(OppMon(),GiantGrinderFilter,c)>1
  and OppHasStrongestMonster()
end
function SummonGiantGrinderFinish(source)
  local cards = SubGroup(OppMon(),GiantGrinderFilter2,source)
  if cards and #cards>1 then
    table.sort(cards,function(a,b)return a.base_attack>b.base_attack end)
  end
  local result = 0
  for i=1,math.min(#cards,2) do 
    result = result + cards[i].base_attack
  end
  if result >= AI.GetPlayerLP(2) then
    GlobalGrinderFinish = true
    return true
  end
  return false
end
function UseGiantGrinder(c)
  return Duel.GetCurrentPhase()==PHASE_MAIN1
  and CardsMatchingFilter(OppMon(),GiantGrinderFilter,c)>0
end
function PtolemySummonFilter(c)
  return FilterType(c,TYPE_XYZ) 
  and ConstellarMonsterFilter(c,38495396) 
  and c.xyz_material_count==0
end
function SummonPtolemy(c)
  return (NotNegated(c) 
  and (FieldCheck(6)>1 and MP2Check(c)
  or CardsMatchingFilter(AIMon(),PtolemySummonFilter)>0))
  or OppHasStrongestMonster() 
  and OppGetStrongestAttack()<c.attack
end
function UsePtolemy()
  return true
end
function SummonHPPDFinish()
  return BattlePhaseCheck()
  and AI.GetPlayerLP(2)<=2000
  and #OppMon()>0
end
function SummonHeartlanddracoFinish()
  return BattlePhaseCheck()
  and AI.GetPlayerLP(2)<=2000
  and #OppMon()>0
  and OPTCheck(02273734)
end
function UseHeartlanddraco()
  return BattlePhaseCheck()
end
function LightningFinishFilter(c,source)
  return FilterPosition(c,POS_FACEUP_ATTACK) and AttackBlacklistCheck(c,source) 
  and BattleDamageCheck(c,source) and AI.GetPlayerLP(2)<=5000-c.attack
end
function SummonUtopiaLightningFinish(c,mode)
  --if true then return true end
  if GlobalBPAllowed 
  and Duel.GetCurrentPhase() == PHASE_MAIN1 
  then
    if mode == 1 then 
      c = FindID(56832966,AIExtra()) 
      if HasID(AIExtra(),56832966,true)
      and HasID(AIExtra(),84013237,true)
      and CardsMatchingFilter(OppMon(),LightningFinishFilter,c)>0 
      then
        return true
      end
    else
      if HasID(AIExtra(),56832966,true)
      and (HasID(AIMon(),84013237,true)
      or HasID(AIMon(),56840427,true))
      and CardsMatchingFilter(OppMon(),LightningFinishFilter,c)>0 
      then
        return true
      end
    end
  end
  return false
end
function LightningFilter(c,source)
  if NotNegated(source)
  and (source.xyz_material_count>1
  and CardsMatchingFilter(source.xyz_materials,FilterSet,0x7f)>0
  or FilterLocation(source,LOCATION_EXTRA))
  then 
    source.attack=5000 
  end
  return CanWinBattle(source,{c})
end
function LightningPrioFilter(c,source)
  return LightningFilter(c,source) 
  and NotNegated(source)
  and (c.id == 27279764 -- Towers
  or c.id == 40061558 -- Skybase
  --or c.id == 86221741 -- Ultimate Falcon
  or CardsMatchingFilter(AIMon(),function(card) 
    return SelectAttackConditions(c,card) 
    and not FilterID(card,56832966) -- Utopia Lightning
   end)==0
  --or FilterPrivate(c)
  or FilterAttackMin(c,2500) 
  and not (Targetable(c,TYPE_MONSTER) and Affected(c,TYPE_MONSTER,4))
  or CanFinishGame(source,c))
end
function SummonUtopiaLightning(c,mode)
  if mode == 1 
  and (HasID(AIMon(),84013237,true) 
  or HasID(AIMon(),56840427,true))
  then
    return true
  end
  if mode == 2 
  and CardsMatchingFilter(OppMon(),LightningPrioFilter,c)>0
  and BattlePhaseCheck()
  then
    return true
  end
  if mode == 3 and OppHasStrongestMonster() 
  and CardsMatchingFilter(OppMon(),LightningFilter,c)>0
  and BattlePhaseCheck()
  and not HasIDNotNegated(AIMon(),65305468,true) -- F0
  then
    return true
  end
end
function SummonUtopiaRay(c,mode)
  local c = FindID(56832966,AIExtra()) 
  if mode == 1 and c and HasID(AIMon(),84013237,true) then
    return true
  end
  return false
end
function SummonUtopia(c,mode)
  local lightning = FindID(56832966,AIExtra()) 
  if mode == 1 and lightning and SummonUtopiaLightning(lightning,2) then
    return true
  end
  if mode == 2 and lightning and SummonUtopiaLightning(lightning,3) then
    return true
  end
  if mode == 3 and CanWinBattle(c,OppMon()) 
  and not lightning and MP2Check(2500)
  then
    return true
  end
  return false
end

function GaiaFilter(c)
  return (FilterRank(c,5) or FilterRank(c,6))
  and c.attack<2600 and c.xyz_material_count==0
end
function SummonGaiaDragon(c)
  return CardsMatchingFilter(AIMon(),GaiaFilter)>0
end
function SummonGaiaDragonFinish(source)
  local result = false
  if not (BattlePhaseCheck() and HasID(AIExtra(),91949988,true)) then return false end
  for i=1,#OppMon() do
    for j=1,#AIMon() do
    local target = OppMon()[i]
    local c = AIMon()[j]
      if BattleDamage(target,source,nil,nil,nil,true) >= AI.GetPlayerLP(2) then
        result = true
      end
      if BattleDamage(c,source,nil,nil,nil,true) > AI.GetPlayerLP(2) then
        result = false
      end
    end
  end
  return result
end
function ChainConstellarOmega(source)
  local cards = RemovalCheckList(AIMon(),nil,TYPE_SPELL+TYPE_TRAP,nil,nil,ConstellarMonsterFilter)
  if cards and #cards>0 then
    return true
  end
  cards = NegateCheckList(AIMon(),TYPE_SPELL+TYPE_TRAP,nil,ConstellarMonsterFilter)
  if cards and #cards>0 then
    return true
  end
  return false
end
function SummonConstellarOmega(c)
  return NotNegated(c) and (not OppHasStrongestMonster() or OppGetStrongestAttDef()<c.attack)
  and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN)>2
  or Negated(c) and OppHasStrongestMonster() and OppGetStrongestAttDef()<c.attack
  or DeckCheck(DECK_CONSTELLAR) and TurnEndCheck() and OppGetStrongestAttDef()<c.attack
end
function InstantFusionFilter(c)
  return bit32.band(c.attribute,ATTRIBUTE_LIGHT)>0 and c.level==5
  or c.id==70908596 and NotNegated(c)
end
function NodenFilter(c,level)
  return (level and c.level==level or not level and c.level<=4)
  and FilterType(c,TYPE_MONSTER)
  and FilterRevivable(c)
end
function NodenTunerFilter(c,level)
  return NodenFilter(c,level-4)
  and FilterType(c,TYPE_TUNER)
end
function UseInstantFusion(c,mode)
  if not (WindaCheck() and DualityCheck()) then return false end
  local b = (HasIDNotNegated(AIExtra(),17412721,true))
  if mode == 1 
  and CardsMatchingFilter(AIGrave(),NodenFilter,4)>0 
  and b
  and SpaceCheck()>1
  and (FieldCheck(4)==1 and OverExtendCheck(2,6) 
  or #AIMon()==0 and #OppMon()>0 and FieldCheck(4)==1 and DestroyCheck(OppField())>0)
  then
    GlobalCardMode = nil
    return true
  elseif mode == 2 and CardsMatchingFilter(AIMon(),InstantFusionFilter)==1 
  and HasID(AIExtra(),73964868,true) -- Pleiades
  then
    GlobalCardMode = 1
    return true
  elseif mode == 3 and HasPriorityTarget(OppField(),true)
  and HasID(AIExtra(),72959823,true) and TurnEndCheck()  -- Panzer Dragon
  and MacroCheck()
  then
    GlobalCardMode = 1
    return true
  end
  if mode == 4 
  and HasPriorityTarget(OppField(),true)
  and HasID(AIExtra(),63519819,true)
  then
    GlobalIFTarget = 63519819 -- Thousand-Eyes Restrict
    return true
  end
  if mode == 5
  and HasIDNotNegated(AIExtra(),17412721,true) -- Norden
  and SpaceCheck()>1
  and (OverExtendCheck(2,6)
  or #AIMon()==0)
  then
    for i,c in pairs(AIExtra()) do
      if FilterType(c,TYPE_SYNCHRO) 
      and c.level>4 and c.level<9
      then
        for j,target in pairs(AIGrave()) do
          if NodenTunerFilter(target,c.level) then
            GlobalNordenFilter=function(card)return FilterTuner(card,c.level) end
            return true
          end
        end
      end
    end
  end
  return false
end

function MoonlightRoseFilter(c)
  return FilterSummon(c,SUMMON_TYPE_SPECIAL)
  and Affected(c,TYPE_MONSTER,7)
  and Targetable(c,TYPE_MONSTER)
  and not ToHandBlacklist(c.id)
  and PriorityTarget(c)
end
function SummonMoonlightRose(c)
  return (WindaCheck() or FieldCheck(5)>1 
  or not DeckCheck(DECK_SHADDOLL))
  and HasID(AIExtra(),33698022,true)
  and CardsMatchingFilter(OppMon(),MoonlightRoseFilter)>0
  and MP2Check(c)
end
function VulcanFilter(c)
  return Affected(c,TYPE_MONSTER,6)
  and Targetable(c,TYPE_MONSTER)
  and not ToHandBlacklist(c.id)
  and PriorityTarget(c)
end
function SummonVulcan(c)
  return HasID(AIExtra(),98012938,true)
  and CardsMatchingFilter(OppMon(),VulcanFilter)>0
  and CardsMatchingFilter(AIST(),FilterPosition,POS_FACEUP)>0
end
function UseGalaxyCyclone(mode)
  if mode == 1 then
    return DestroyCheck(OppST(),false,false,false,FilterPosition,POS_FACEDOWN)>0
  end
  return DestroyCheck(OppST(),false,false,false,FilterPosition,POS_FACEUP)>0
end

function MichaelFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function SummonMichael(c)
  return c and (CardsMatchingFilter(UseLists({OppMon(),OppST()}),MichaelFilter)>0 
  and AI.GetPlayerLP(1)>1000 and NotNegated(c)  
  or Negated (c) and OppGetStrongestAttDef()<2600)
  and MP2Check(c) and HasID(AIExtra(),04779823,true)
end
function UseMichael()
  return CardsMatchingFilter(UseLists({OppMon(),OppST()}),MichaelFilter)>0
end

function ArcaniteFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
end
function SummonArcanite()
  return CardsMatchingFilter(UseLists({OppMon(),OppST()}),ArcaniteFilter)>1 
  and MP2Check() and HasID(AIExtra(),31924889,true)
end
function UseArcanite()
  return CardsMatchingFilter(UseLists({OppMon(),OppST()}),ArcaniteFilter)>0
end

function UseSoulCharge()
  return #AIMon()==0 and AI.GetPlayerLP(1)>1000 
  and CardsMatchingFilter (AIGrave(),function(c) return bit32.band(c.type,TYPE_MONSTER)>2 end)
end
----

function ChainChalice(card)
  local c = ChainCardNegation(card,true,false,FilterType,TYPE_MONSTER)
  if c then
    GlobalTargetSet(c,OppMon())
    return true
  end
  return false
end
function ChainVeiler(card)
  local c = ChainCardNegation(card,true,false,FilterType,TYPE_MONSTER)
  if c then
    GlobalTargetSet(c,OppMon())
    return true
  end
  return false
end
function ChainBTS(card)
  local prio=4
  if FilterLocation(card,LOCATION_GRAVE) then
    prio=1
  end
  local c = ChainCardNegation(card,true,prio,FilterType,TYPE_MONSTER)
  if c then
    GlobalTargetSet(c,OppMon())
    return true
  end
  if IsBattlePhase() then
    if Duel.GetTurnPlayer()==player_ai then
      local cards=OppMon()
      for i=1,#cards do
        if VeilerTarget(cards[i]) then
          GlobalTargetSet(cards[i],OppMon())
          return true
        end
      end
    end
    local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if source:GetAttack() <= target:GetAttack() and target:IsControler(player_ai) 
      and target:IsPosition(POS_FACEUP_ATTACK) and source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
      then
        --GlobalTargetSet(source)
        --return true
      end
    end
  end
  if RemovalCheckCard(card) then
	return true
  end
  return false
end
function ChainFiendish(card)
  local c = ChainCardNegation(card,true,false,FilterType,TYPE_MONSTER)
  if c and Affected(c,TYPE_TRAP) then
    GlobalTargetSet(c,OppMon())
    return true
  end
  if IsBattlePhase() and Duel.GetTurnPlayer()~=player_ai then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target and WinsBattle(source,target) 
    and Targetable(source,TYPE_TRAP) and Affected(source,TYPE_TRAP)
    and UnchainableCheck(50078509)
    and not FilterAffected(source,EFFECT_DISABLE)
    and not FilterType(source,TYPE_NORMAL)
    then
      GlobalTargetSet(source)
      return true
    end
    if source and CanFinishGame(source) and #AIMon()==0 
    and Targetable(source,TYPE_TRAP) and Affected(source,TYPE_TRAP)
    and UnchainableCheck(50078509)
    and not FilterAffected(source,EFFECT_DISABLE)
    and not FilterType(source,TYPE_NORMAL)
    then
      GlobalTargetSet(source)
      return true
    end
  end
  return false
end
function ChainFogBlade(card)
  if FilterLocation(card,LOCATION_SZONE) then
    local c = ChainCardNegation(card,true,false,FilterType,TYPE_MONSTER)
    if c and Affected(c,TYPE_TRAP) then
      GlobalCardMode = 1
      GlobalTargetSet(c,OppMon())
      return true
    end
    if IsBattlePhase() and Duel.GetTurnPlayer()~=player_ai then
      local source = Duel.GetAttacker()
      local target = Duel.GetAttackTarget()
      if source and target and WinsBattle(source,target) 
      and Targetable(source,TYPE_TRAP) and Affected(source,TYPE_TRAP)
      and UnchainableCheck(25542642)
      and not FilterAffected(source,EFFECT_DISABLE)
      and not FilterType(source,TYPE_NORMAL)
      then
        GlobalCardMode = 1
        GlobalTargetSet(source)
        return true
      end
      if source and CanFinishGame(source) and #AIMon()==0 
      and Targetable(source,TYPE_TRAP) and Affected(source,TYPE_TRAP)
      and UnchainableCheck(25542642)
      and not FilterAffected(source,EFFECT_DISABLE)
      and not FilterType(source,TYPE_NORMAL)
      then
        GlobalCardMode = 1
        GlobalTargetSet(source)
        return true
      end
    end
  end
end
function ChainSkillDrain(card)
  if AI.GetPlayerLP(1)<=1000 then
    return false
  end
  local c = ChainCardNegation(card,false,0,FilterType,TYPE_MONSTER)
  if c then
    --GlobalTargetSet(c,OppMon())
    return true
  end
  if IsBattlePhase() then
    if Duel.GetTurnPlayer()==player_ai 
    and not OppHasStrongestMonster() 
    and CardsMatchingFilter(OppMon(),NegateBPCheck)>0 
    then
      return true
    end
    local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
      and (source:IsPosition(POS_FACEUP_ATTACK) 
      and source:GetAttack() >= target:GetAttack() 
      and source:GetAttack() <= target:GetAttack()+QliphortAttackBonus(target:GetCode(),target:GetLevel())
      and not (source:GetAttack() == target:GetAttack() 
      and QliphortAttackBonus(target:GetCode(),target:GetLevel())==0)
      or source:IsPosition(POS_FACEUP_DEFENSE)
      and source:GetDefense() >= target:GetAttack() 
      and source:GetDefense() < target:GetAttack()+QliphortAttackBonus(target:GetCode(),target:GetLevel()))
      and target:IsPosition(POS_FACEUP_ATTACK) 
      then
        return true
      end
    end
  end
  return false
end
function ChainGiantHand(card)
  local c = ChainCardNegation(card,true,false,FilterType,TYPE_MONSTER)
  if c then
    GlobalTargetSet(c,OppMon())
    return true
  end
  return false
end
function ChainFelgrand(card)
  local c=nil
  local targets={}
  for i=1,#AIMon() do
    c=AIMon()[i]
    if RemovalCheckCard(c) or NegateCheckCard(c) then
      targets[#targets+1]=c
    end
  end
  if #targets == 1 then
    GlobalTargetSet(targets[1],AIMon())
    return true
  end
  c=nil
  c = ChainCardNegation(card,true,true,FilterType,TYPE_MONSTER)
  if c then
    GlobalTargetSet(c,OppMon())
    return true
  end
  c=nil
  if #targets>1 then
    BestTargets(targets,1,TARGET_PROTECT)
    c=targets[1]
    GlobalTargetSet(c,AIMon())
    return true
  end
  return false
end
function ChainZombiestein(card)
  local targets=RemovalCheckCard(AIField())
  local c,cl = ChainCardNegation(card,true,true,FilterLocation,LOCATION_ONFIELD,true)
  if c and (PriorityCheck(AIHand(),PRIO_TOGRAVE)>2 
  or targets and #targets>1) 
  then
    GlobalTargetSet(c,OppField())
    SetNegated(cl)
    return true
  end
  return false
end
function ChainUtopiaLightning(c)
  local aimon,oppmon=GetBattlingMons() 
  if AttackBoostCheck(5000-c.attack) 
  or CanFinishGame(aimon,oppmon,5000)
  then
    return true
  end
end
function ChainShrink(c)
  if RemovalCheckCard(c) 
  and CardsMatchingFilter(OppMon(),Targetable,TYPE_SPELL)>0
  then
    return true
  end
  local aimon,oppmon=GetBattlingMons() 
  if aimon and oppmon
  and Duel.GetCurrentPhase()==PHASE_DAMAGE
  and AttackBoostCheck(0,oppmon:GetBaseAttack()*0.5) 
  and Targetable(oppmon,TYPE_SPELL)
  and Affected(oppmon,TYPE_SPELL)
  and UnchainableCheck(55713623)
  then
    GlobalCardMode=1
    GlobalTargetSet(oppmon)
    return true
  end
  return false
end
function TrapStunFilter(c)
  return FilterLocation(c,LOCATION_SZONE)
  and FilterType(c,TYPE_TRAP)
  and c.id~=51452091
  and c.id~=59616123
end
function TrapStunFilter2(c)
  return FilterLocation(c,LOCATION_SZONE)
  and (FilterType(c,TYPE_TRAP) and FilterPublic(c)
  or FilterPrivate(c))
end
function ChainTrapStun(source)
  if RemovalCheckCard(source)
  and CardsMatchingFilter(AIST(),TrapStunFilter)<2 
  then
    return true
  end
  local c,cl = ChainCardNegation(source,false,2,TrapStunFilter,nil,true)
  if c 
  --and CardsMatchingFilter(AIST(),TrapStunFilter)<3 
  and UnchainableCheck(59616123)
  then
    SetNegated(cl)
    return true
  end
  if Duel.GetTurnPlayer()==player_ai 
  and Duel.GetCurrentPhase()==PHASE_MAIN1
  and Duel.GetCurrentChain()==0
  and (HasIDNotNegated(Field(),05851097,nil,nil,POS_FACEUP)
  or HasIDNotNegated(Field(),82732705,nil,nil,POS_FACEUP))
  then
    return true
  end
  return false
end
function ChainDecree(source)
  if RemovalCheckCard(source)
  and CardsMatchingFilter(AIST(),TrapStunFilter)<2 
  then
    return true
  end
  local c,cl = ChainCardNegation(source,false,0,TrapStunFilter,nil,true)
  if c 
  --and CardsMatchingFilter(AIST(),TrapStunFilter)<3 
  and UnchainableCheck(51452091)
  then
    SetNegated(cl)
    return true
  end
  if Duel.GetTurnPlayer()==player_ai 
  and Duel.GetCurrentPhase()==PHASE_MAIN1
  and Duel.GetCurrentChain()==0
  and (HasIDNotNegated(Field(),05851097,nil,nil,POS_FACEUP)
  or HasIDNotNegated(Field(),82732705,nil,nil,POS_FACEUP))
  then
    return true
  end
  return false
end
function TreacherousFilter(c,type)
  type=type or TYPE_TRAP
  return Affected(c,type,4)
  and Targetable(c,type)
  and (type~=TYPE_TRAP or not TraptrixFilter(c))
end
function FloodgateFilter(c,type)
  type=type or TYPE_TRAP
  return Affected(c,type,4)
  and FilterController(c,2)
  and (type~=TYPE_TRAP or not TraptrixFilter(c))
end
GlobalRafflesia = nil
function ChainRafflesia(source,mode)
  if mode == 1 then
    local e=Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
    local check = false
    if e then
      local c=e:GetHandler()
      if bit32.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
      and c:GetFlagEffect(29616929)>0
      then
        check=true
      end
    end
    if HasID(AIDeck(),29616929,true) 
    and check
    and UnchainableCheck(06511113)
    and ChainNegation(source)
    then
      GlobalRafflesia = 29616929
      return true
    end
  elseif mode == 2 then
    local summoned = AI.GetLastSummonedCards()
    if HasID(AIDeck(),29401950,true)
    and (Duel.CheckEvent(EVENT_SUMMON_SUCCESS)
    or Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS)
    or Duel.CheckEvent(EVENT_FLIP_SUMMON_SUCCESS))
    then
      local targets = SubGroup(summoned,BottomlessFilter,TYPE_MONSTER)
      if #targets>2 
      and UnchainableCheck(06511113)
      then
        GlobalRafflesia = 29401950
        return true
      end
    end
    if HasID(AIDeck(),99590524,true)
    and CardsMatchingFilter(AIGrave(),FilterType,TYPE_TRAP)==0
    and CardsMatchingFilter(OppMon(),TreacherousFilter,TYPE_MONSTER)>1
    and UnchainableCheck(06511113)
    then
      GlobalRafflesia = 99590524
      return true
    end
    if HasID(AIDeck(),29401950,true)
    and (Duel.CheckEvent(EVENT_SUMMON_SUCCESS)
    or Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS)
    or Duel.CheckEvent(EVENT_FLIP_SUMMON_SUCCESS))
    then
      local targets = SubGroup(summoned,BottomlessFilter,TYPE_MONSTER)
      if #targets>0 
      and UnchainableCheck(06511113)
      then
        GlobalRafflesia = 29401950
        return true
      end
    end
    if HasID(AIDeck(),69599136,true)
    and (Duel.CheckEvent(EVENT_SUMMON_SUCCESS)
    or Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS)
    or Duel.CheckEvent(EVENT_FLIP_SUMMON_SUCCESS))
    then
      local targets = SubGroup(summoned,FloodgateFilter,TYPE_MONSTER)
      local targets2 = SubGroup(targets,FilterPriorityTarget)
      if (#targets>1 or #targets2>0)
      and UnchainableCheck(06511113)
      then
        GlobalRafflesia = 69599136
        return true
      end
    end
  end
  if RemovalCheckCard(c) and #AIMon()<2 then
    --return true
  end
  return false
end
function ChainTreacherous(c)
  return CardsMatchingFilter(OppMon(),TreacherousFilter,TYPE_TRAP)>1
  and UnchainableCheck(99590524)
end
function ChainFloodgate(c)
  local targets = SubGroup(AI.GetLastSummonedCards(),FloodgateFilter)
  local targets2 = SubGroup(targets,FilterPriorityTarget)
  if UnchainableCheck(c.id) 
  and (#targets>1 or #targets2>0)
  then
    return true
  end
  return false
end
function CompulseFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and c:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
end
function CompulseFilter2(c)
  return CompulseFilter(c) and not ToHandBlacklist(c.id) 
  and (c.level>4 or bit32.band(c.type,TYPE_FUSION+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_XYZ)>0)
end
function ChainCompulse()
  local targets = CardsMatchingFilter(OppMon(),CompulseFilter)
  local targets2 = CardsMatchingFilter(OppMon(),CompulseFilter2)
  if RemovalCheck(94192409) and targets>0 then
    return true
  end
  if not UnchainableCheck(94192409) then
    return false
  end
  if targets2 > 0 then
    return true
  end
  if IsBattlePhase() and targets>0 then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(1-player_ai) and target:IsControler(player_ai) 
      and (target:IsPosition(POS_DEFENSE) and source:GetAttack()>target:GetDefense() 
      or target:IsPosition(POS_ATTACK) and source:GetAttack()>=target:GetAttack())
      and not source:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET)
      and not source:IsHasEffect(EFFECT_IMMUNE_EFFECT)
      then
        GlobalCardMode = 1
        GlobalTargetSet(source,OppMon())
        return true
      end
    end
  end
  return false
end

function MSTFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 
  and not (DestroyBlacklist(c)
  and FilterPublic(c))
end
function MSTEndPhaseFilter(c)
  return MSTFilter(c) and bit32.band(c.status,STATUS_SET_TURN)>0
end
function ChainMST(c)
  local targets=CardsMatchingFilter(OppST(),MSTFilter)
  local targets2=CardsMatchingFilter(UseLists({OppMon(),OppST()}),MoralltachFilter)
  local targets3=CardsMatchingFilter(UseLists({OppMon(),OppST()}),SanctumFilter)
  local targets4=CardsMatchingFilter(OppST(),MSTEndPhaseFilter)
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
  if RemovalCheckCard(c) then
    if e and e:GetHandler():IsCode(12697630) then
      return false
    end
    if SignCheck(AIST()) and not RemovalCheck(19337371) then
      GlobalCardMode = 1
      GlobalTargetSet(FindID(19337371,AIST()))
      return true
    end
    if targets2 > 0 and ArtifactCheck()
    then
      return true
    end
    if targets > 0 then
      return true
    end
  end
  if not UnchainableCheck(c.id) then
    return false
  end
  if targets3 > 0 and ArtifactCheck() then
    return true
  end
  if IsBattlePhase() then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and source:IsControler(1-player_ai) then
      if targets2 > 0 and ArtifactCheck() then
        return true
      end
    end
  end
  if Duel.GetCurrentPhase()==PHASE_END and Duel.GetTurnPlayer()==1-player_ai 
  and #AIST()>0 and SignCheck(AIST()) and LadyCount(AIHand())<2 
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(19337371,AIST()))
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_END then
    if targets2 > 0 and ArtifactCheck() then
      return true
    end
    if targets4 > 0 then
      local cards = SubGroup(OppST(),MSTEndPhaseFilter)
      GlobalCardMode = 1
      GlobalTargetSet(cards[math.random(#cards)],OppST())
      return true
    end
  end
  local target = RemoveOnActivation(nil,MSTFilter)
  if target then
    GlobalCardMode = 1
    GlobalTargetSet(target)
    return true
  end
  if HasPriorityTarget(OppST(),true) and Duel.GetCurrentChain()==0 then
    return true
  end
  if ScytheCheck() and ArtifactCheck(nil,true) then
    return true
  end
  return false
end
function ChainDustTornado(c)
  return ChainMST(c)
end
function CosmicCycloneFilter(c,ep)
  return Targetable(c,TYPE_SPELL)
  and Affected(c,TYPE_SPELL)
  and (not ep or FilterStatus(c.STATUS_SET_TURN))
end
function ChainCosmicCyclone(c)
  if AI.GetPlayerLP(1)<=1000 then
    return false
  end
  local targets=CardsMatchingFilter(OppST(),CosmicCycloneFilter)
  local targets2=CardsMatchingFilter(OppST(),CosmicCycloneFilter,true)
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
  if RemovalCheckCard(c) then
    if e and e:GetHandler():IsCode(12697630) then -- Beagalltach
      return false
    end
    if targets > 0 then
      return true
    end
  end
  if not UnchainableCheck(c.id) then
    return false
  end
  if Duel.GetCurrentPhase()==PHASE_END then
    if targets2 > 0 then
      local cards = SubGroup(OppST(),CosmicCycloneFilter,true)
      GlobalCardMode = 1
      GlobalTargetSet(cards[math.random(#cards)],OppST())
      return true
    end
  end
  local target = RemoveOnActivation(nil,CosmicCycloneFilter)
  if target then
    GlobalCardMode = 1
    GlobalTargetSet(target)
    return true
  end
  if HasPriorityTarget(OppST(),true) 
  and Duel.GetCurrentChain()==0 then
    return true
  end
  return false
end
function ChainPanzerDragon(c)
  return DestroyCheck(OppField())>0
end
function ChainTitanicGalaxy(c)
  local aimon,oppmon = GetBattlingMons()
  if NotNegated(c)
  and WinsBattle(oppmon,aimon)
  and not WinsBattle(oppmon,c)
  and Affected(oppmon,TYPE_MONSTER,8)
  then
    return true
  end
end
function ChainDrancia(c)
  local targets = CardsMatchingFilter(OppField(),DranciaFilter)
  local targets2 = CardsMatchingFilter(OppField(),DranciaFilter,true)
  if RemovalCheckCard(c) 
  or NegateCheckCard(c)
  then
    return true
  end
  if not UnchainableCheck(48905153) then
    return false
  end
  if targets2 and targets2 > 0 
  and (AIGetStrongestAttack()<=OppGetStrongestAttDef(DranciaFilter,true) 
  or TurnEndCheck() or Duel.GetTurnPlayer()==1-player_ai)
  then
    return true
  end
  if targets and targets == 1 and #OppMon()==1 and BattlePhaseCheck()
  and Duel.GetTurnPlayer()==player_ai
  and ExpectedDamage(2)>=AI.GetPlayerLP(2) then
    return true
  end
  if IsBattlePhase() 
  and Duel.GetTurnPlayer()~=player_ai 
  and targets>0 then
    local aimon,oppmon = GetBattlingMons()
    if aimon and oppmon 
    and (WinsBattle(oppmon,aimon) 
    and DranciaFilter(oppmon))
    then
      GlobalCardMode = 1
      GlobalTargetSet(oppmon)
      return true
    end
  end
  if Duel.GetTurnPlayer()==1-player_ai 
  and Duel.CheckTiming(TIMING_END_PHASE)
  and targets>0
  then
    return true
  end
end
GlobalDimensionalBarrier = nil
function ChainDimensionalBarrier(source)
  if not UnchainableCheck(source.id)
  and not RemovalCheckCard(source)
  then
    return false
  end
  local c,link = ChainCardNegation(source,false,0,nil,nil,true)
  if c and Duel.GetOperationInfo(link,CATEGORY_SPECIAL_SUMMON) 
  and CanSpecialSummon(2)
  then
    local e = Duel.GetChainInfo(link, CHAININFO_TRIGGERING_EFFECT)
    if FilterType(c,TYPE_SPELL+TYPE_TRAP) 
    and FilterType(c,TYPE_RITUAL)
    then
      GlobalDimensionalBarrier = TYPE_RITUAL -- Ritual summon
      SetNegated(link)
      return true
    end
    if FilterSet(c,0x95) -- Rank-Up Magic
    then
      GlobalDimensionalBarrier = TYPE_XYZ -- Rank-Up XYZ summon
      SetNegated(link)
      return true
    end 
    if e:IsHasCategory(CATEGORY_FUSION_SUMMON)
    then
      GlobalDimensionalBarrier = TYPE_FUSION -- Fusion summon
      SetNegated(link)
      return true
    end
  end
  if Duel.GetCurrentChain()==0 
  and CanSpecialSummon(2)
  and Duel.GetTurnPlayer()==1-player_ai
  or RemovalCheckCard(source) 
  then
    local cards = SubGroup(OppMon(),FilterPosition,POS_FACEUP)
    if CardsMatchingFilter(cards,FilterTuner)>0
    and CardsMatchingFilter(cards,FilterNonTuner)>0
    then
      --GlobalDimensionalBarrier = TYPE_SYNCHRO -- Synchro summon
      --return true
    end
    cards=SubGroup(cards,FilterInvert,{FilterType,TYPE_TOKEN})
    for i,c in pairs(cards) do
      if CardsMatchingFilter(cards,FilterLevel,c.level)>1 
      then
        --GlobalDimensionalBarrier = TYPE_XYZ -- XYZ summon
        --return true
      end
    end
    if CanPendulumSummon(2) 
    and CardsMatchingFilter(OppExtra(),FilterPosition,POS_FACEUP)+#OppHand()>1
    then
      GlobalDimensionalBarrier = TYPE_PENDULUM -- Pendulum summon
      return true
    end
  end
  local c,link = ChainCardNegation(source,false,4,nil,nil,true)
  if c and FilterType(c,TYPE_MONSTER)
  and Affected(c,TYPE_TRAP)
  then
    local types={TYPE_RITUAL,TYPE_FUSION,TYPE_SYNCHRO,TYPE_XYZ,TYPE_PENDULUM}
    for i,v in pairs(types) do
      if FilterType(c,v) 
      and FilterLocation(c,LOCATION_ONFIELD)
      and NotNegated(c)
      then
        GlobalDimensionalBarrier = v
        SetNegated(link)
        return true
      end
    end
  end
  if RemovalCheckCard(source) then
    GlobalDimensionalBarrier = true
    return true
  end
end
function PriorityChain(cards) -- chain these before anything else
  if HasIDNotNegated(cards,48229808,ChainNegation,0) then -- Black Flame Horus
    return Chain()
  end
  if HasIDNotNegated(cards,58120309,ChainNegation) then -- Starlight Road
    return Chain()
  end
  if HasIDNotNegated(cards,02956282,ChainNegation,2) then -- Naturia Barkion
    return Chain()
  end
  if HasIDNotNegated(cards,33198837,ChainNegation,0) then -- Naturia Beast
    return Chain()
  end
  if HasIDNotNegated(cards,99916754,ChainNegation,0) then -- Naturia Exterio
    return Chain()
  end
  if HasIDNotNegated(cards,64063868,ChainNegation,2) then -- Kozmo Dark Eclipser
    return Chain()
  end
  if HasID(cards,44508094,false,nil,LOCATION_MZONE,ChainNegation,2) then -- Stardust
    return Chain()
  end
  if HasIDNotNegated(cards,82044279,ChainNegation) then -- Clear Wing Synchro Dragon
    return Chain()
  end
  if HasID(cards,61257789,false,nil,LOCATION_MZONE,ChainNegation) then -- Stardust AM
    return Chain()
  end
  if HasIDNotNegated(cards,63767246,ChainNegation,2) then -- Titanic Galaxy
    return Chain()
  end
  if HasIDNotNegated(cards,50954680,ChainNegation) then -- Crystal Wing Synchro Dragon
    return Chain()
  end
  if HasIDNotNegated(cards,35952884,false,nil,LOCATION_MZONE,ChainNegation) then -- Quasar
    return Chain()
  end
  if HasIDNotNegated(cards,24696097,ChainNegation) then -- Shooting Star
    return Chain()
  end
  if HasIDNotNegated(cards,12408276,false,12408276*16+1,ChainNegation) -- Kozmo Dark Lady
  and AI.GetPlayerLP(1)>1000 
  then 
    return Chain()
  end
  if HasIDNotNegated(cards,55063751,ChainNegation) then -- Gameciel
    return Chain()
  end
  if HasIDNotNegated(cards,10443957,ChainNegation) then -- Infinity
    return Chain()
  end
  if HasIDNotNegated(cards,99188141,ChainNegation) then -- THRIO
    return Chain()
  end
  if HasIDNotNegated(cards,66994718,ChainNegation) then -- Raptor's Gust
    return Chain()
  end
  if HasID(cards,74822425,false,nil,LOCATION_MZONE,ChainNegation) then -- Shekinaga
    return Chain()
  end
  if HasIDNotNegated(cards,75286621,ChainNegation) then -- Merkabah
    return Chain()
  end
  if HasIDNotNegated(cards,27346636,ChainNegation) then -- Heraklinos
    return Chain()
  end
  if HasIDNotNegated(cards,01621413,ChainNegation) then -- Requiem Dragon
    return Chain()
  end
  if HasIDNotNegated(cards,29616929,ChainNegation) then -- Traptrix Trap Hole Nighmare
    return Chain()
  end
  if HasIDNotNegated(cards,74294676,ChainNegation) then -- Laggia
    return Chain()
  end
  if HasIDNotNegated(cards,42752141,ChainNegation) then -- Dolkka
    return Chain()
  end
  if HasIDNotNegated(cards,71068247,ChainNegation) then -- Totem Bird
    return Chain()
  end
  if HasIDNotNegated(cards,06511113,ChainRafflesia,1) then -- Rafflesia
    return Chain()
  end
  if HasIDNotNegated(cards,96216229,ChainNegation) then -- War Chariot
    return Chain()
  end
  if HasIDNotNegated(cards,41510920,ChainNegation) then -- Stellarnova Alpha
    return Chain()
  end
  if HasIDNotNegated(cards,34507039,ChainNegation,2) then -- Wiretap
    return Chain()
  end
  if HasIDNotNegated(cards,03819470,ChainNegation) and AI.GetPlayerLP(1)>1000 then -- Seven Tools
    return Chain()
  end
  if HasIDNotNegated(cards,49010598,ChainNegation,5) then -- Divine Wrath
    return Chain()
  end
  if HasIDNotNegated(cards,58851034,ChainNegation) then -- Cursed Seal
    return Chain()
  end
  if HasIDNotNegated(cards,77414722,ChainNegation) then -- Magic Jammer
    return Chain()
  end
  if HasIDNotNegated(cards,77538567,ChainNegation,5) then -- Dark Bribe
    return Chain()
  end
  if HasIDNotNegated(cards,93016201,ChainNegation,0) then -- Royal Oppression
    return Chain()
  end
  if HasIDNotNegated(cards,50323155,ChainNegation) then -- Black Horn of Heaven
    return Chain()
  end
  if HasIDNotNegated(cards,04810828,ChainNegation) then -- Sauravis
    return Chain()
  end
  if HasIDNotNegated(cards,40605147,ChainNegation) and AI.GetPlayerLP(1)>1500 then -- Solemn Notice
    return Chain()
  end
  if HasIDNotNegated(cards,84749824,ChainNegation) and AI.GetPlayerLP(1)>2000 then -- Solemn Warning
    return Chain()
  end
  if HasIDNotNegated(cards,41420027,ChainNegation) then -- Solemn Judgment
    return Chain()
  end
  if HasIDNotNegated(cards,92512625,ChainNegation) and AI.GetPlayerLP(1)>3000 then -- Solemn Advice
    return Chain()
  end
  if HasIDNotNegated(cards,59438930,ChainNegation,2) then -- Ghost Ogre
    return Chain()
  end
  if HasIDNotNegated(cards,82732705,ChainSkillDrain) then
    return Chain()
  end
  if HasIDNotNegated(cards,78474168,ChainBTS) then
    return Chain()
  end
  if HasIDNotNegated(cards,25542642,ChainFogBlade) then
    return Chain()
  end
  if HasIDNotNegated(cards,50078509,ChainFiendish) then
    return Chain()
  end
  if HasIDNotNegated(cards,63746411,ChainGiantHand) then
    return Chain()
  end
  if HasIDNotNegated(cards,06511113,ChainRafflesia,2) then
    return Chain()
  end
  if HasIDNotNegated(cards,01639384,ChainFelgrand) then
    return Chain()
  end
  if HasIDNotNegated(cards,25789292,ChainChalice) then
    return Chain()
  end
  if HasIDNotNegated(cards,73445448,ChainZombiestein) then
    return Chain()
  end
  if HasIDNotNegated(cards,97268402,ChainVeiler) then
    return Chain()
  end
  
  if HasIDNotNegated(cards,83326048,ChainDimensionalBarrier) then
    return Chain()
  end
  if HasIDNotNegated(cards,69599136,ChainFloodgate) then
    return Chain()
  end
  if HasIDNotNegated(cards,99590524,ChainTreacherous) then
    return Chain()
  end
  if HasIDNotNegated(cards,26329679,ChainConstellarOmega) then
    return Chain()
  end
  if HasIDNotNegated(cards,51452091,ChainDecree) then
    return Chain()
  end
  if HasIDNotNegated(cards,59616123,ChainTrapStun) then
    GlobalTrapStun = Duel.GetTurnCount()
    return Chain()
  end

  return nil
end
function GenericChain(cards)
  if HasID(cards,48905153,ChainDrancia) then
    return Chain()
  end
  if HasID(cards,43898403,ChainTwinTwister) then
    return Chain()
  end
  if HasID(cards,60082869,ChainDustTornado) then
    return Chain()
  end
  if HasID(cards,05318639,ChainMST) then
    return Chain()
  end
  if HasID(cards,08267140,ChainCosmicCyclone) then
    return Chain()
  end
  if HasID(cards,94192409) and ChainCompulse() then
    return Chain()
  end
  if HasIDNotNegated(cards,10406322,UseAlsei) then
    return Chain()
  end
  if HasIDNotNegated(cards,56832966,ChainUtopiaLightning) then
    return Chain()
  end
  if HasIDNotNegated(cards,55713623,ChainShrink) then
    return Chain()
  end
  if HasID(cards,33698022) then -- Moonlight Rose
    return Chain()
  end
  if HasID(cards,72959823,ChainPanzerDragon) then
    return Chain()
  end
  if HasID(cards,73176465,false,nil,LOCATION_GRAVE) then -- Felis
    return Chain()
  end
  if HasIDNotNegated(cards,81275020) then -- Speedroid Terrortop
    OPTSet(81275020)
    return Chain()
  end
  return nil
end

function FelgrandTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return GlobalTargetGet(cards,true)
end
function ZombiesteinTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return GlobalTargetGet(cards,true)
end
function ZenmainesTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards)
end
function LancelotTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    OPTSet(c.cardid)
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards)
end
function AlseiTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    OPTSet(10406322)
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_TODECK)
end
function GiantGrinderTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if GlobalGrinderFinish then
    return BestTargets(cards,1,TARGET_DESTROY,GiantGrinderFilter2,c,true,c)
  end
  return BestTargets(cards,1,TARGET_DESTROY,GiantGrinderFilter,c,true,c)
end
function InstantFusionTarget(cards)
  if GlobalIFTarget then
    local id = GlobalIFTarget
    GlobalIFTarget = nil
    result = FindID(id,cards,true)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    result = FindID(72959823,cards,true)
  else
    result = FindID(17412721,cards,true)
  end
  if result==nil then result={math.random(#cards)} end
  return result
end
function BrionacTarget(cards,c)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_TOHAND)
end
function ShrinkTarget(cards)
  if GlobalCardMode==1 then
    return GlobalTargetGet(cards,true)
  end
  return BestTargets(cards,1,TARGET_OTHER)
end
function VulcanTarget(cards)
  local result = nil
  if CurrentOwner(cards[1])==1 then
    if DeckCheck(DECK_FIREFIST) then
      result=FireFormationCost(cards,1)
    elseif BounceTargets(AIField())>0 then
      result=BestTargets(cards,1,TARGET_TOHAND,BounceFilter)
    end
  end
  if result == nil then 
    result=BestTargets(cards,1,TARGET_TOHAND) 
  end
  return result
end
function ChidoriTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_TODECK)
end
function PtolemaiosTarget(cards,min)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_EXTRA) then
    return Add(cards,PRIO_TOFIELD,min,FilterID,58069384)
  end
  return Add(cards,PRIO_TOGRAVE,min)
end
function InfinityTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_TOGRAVE)
end
function RafflesiaTarget(cards,min)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOHAND,1,FilterID,GlobalRafflesia)
  end
  return BestTargets(cards,min,TARGET_DESTROY)
end
function EmeralTarget(cards,count)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if count>0 then
    return Add(cards,PRIO_EXTRA,count)
  end
  return Add(cards,PRIO_TOFIELD)
end
function SkyblasterTarget(cards,count)
  return BestTargets(cards,count)
end
function VolcasaurusTarget(cards)
  return BestTargets(cards,1)
end

function ArcaniteTarget(cards)
  return BestTargets(cards,1)
end
function PanzerDragonTarget(cards)
  return BestTargets(cards,1)
end
function CompulseTarget(cards)
  local result = nil
  if GlobalCardMode == 1 then
    result=GlobalTargetGet(cards,true)
  end
  GlobalCardMode = nil
  if result == nil then result = BestTargets(cards,1,TARGET_TOHAND) end
  return result
end
function MSTTarget(cards)
  result = nil
  if GlobalCardMode == 1 then
    result=GlobalTargetGet(cards,true)
  end
  GlobalCardMode=nil
  if result==nil then result=BestTargets(cards,1,TARGET_DESTROY,TargetCheck) end
  if cards[1].prio then TargetSet(cards[1]) else TargetSet(cards[result[1]]) end
  return result
end
function DustTornadoTarget(cards)
  return MSTTarget(cards)
end
function CosmicCycloneTarget(cards)
  result = nil
  if GlobalCardMode == 1 then
    result=GlobalTargetGet(cards,true)
    GlobalCardMode=nil
  end
  return BestTargets(cards,1,TARGET_BANISH,CosmicCycloneFilter)
end
function SoulChargeTarget(cards,min,max)
  local result={}
  local count = max
  if AI.GetPlayerLP(1)>=7000 then
    count = math.min(3,max)
  elseif AI.GetPlayerLP(1)>=4000 then
    count = math.min(2,max)
  else
    count = 1
  end
  if DeckCheck(DECK_TELLARKNIGHT) or DeckCheck(DECK_HAT) then
    result = Add(cards,PRIO_TOFIELD,count)
  else
    for i=1,#cards do
      cards[i].index=i
    end
    table.sort(cards,function(a,b) return a.attack>b.attack end)
    for i=1,count do
      result[i]=cards[i].index
    end
  end
  return result
end
function MathTarget(cards)
  return Add(cards,PRIO_TOGRAVE)
end
function DwellerTarget(cards)
  if HasID(cards,74311226,true) then -- Dragoons
    return Add(cards,PRIO_TOGRAVE,1,FilterID,74311226)
  end
  local filter = function(c) return not FilterAttribute(c,ATTRIBUTE_WATER) end
  return Add(cards,PRIO_TOGRAVE,1,filter)
end
function TwinTwisterTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  local filter = function(c) return true end
  local targets = {}
  if GlobalTwinTwisterTarget then
    if type(GlobalTwinTwisterTarget) == "function" then
      filter = GlobalTwinTwisterTarget
    elseif type(GlobalTwinTwisterTarget) == "table" then
      if GlobalTwinTwisterTarget.id then
        targets[1]=GlobalTwinTwisterTarget
      else
        targets=GlobalTwinTwisterTarget
      end
      filter=function(card) 
        for i,c in pairs(targets) do
          if CardsEqual(c,card) then
            return true
          end
        end
      end
    end
    GlobalTwinTwisterTarget = nil
  end
  if #targets<2
  and HasID(AIST(),20292186,true) -- Artifact Scythe
  and Duel.GetTurnPlayer()==1-player_ai
  and CanSpecialSummon()
  and SpaceCheck()>0
  then
    targets[#targets+1] = FindID(20292186,cards)
  end
  if #targets<2
  and HasID(AIST(),85103922,true) -- Artifact Moralltach
  and Duel.GetTurnPlayer()==1-player_ai
  and CanSpecialSummon()
  and SpaceCheck()>0
  and CardsMatchingFilter(OppField(),MoralltachFilter)>0
  then
    targets[#targets+1] = FindID(85103922,cards)
  end
  local count = 0
  local check = DestroyCheck(cards,false,true,false,FilterController,2)
  if #targets == 0 then
    count = check
  else
    count = 2,math.max(#targets,check)
  end
  count = math.min(2,count)
  return BestTargets(cards,count,TARGET_DESTROY,filter)
end
function TERTarget(cards)
  return BestTargets(cards,1,TARGET_TOGRAVE)
end
function PendulumSummonTarget(cards,max)
  return BestTargets(cards,max,TARGET_PROTECT,FilterLocation,LOCATION_EXTRA)
end
function FogBladeTarget(cards,source)
  if LocCheck(cards,LOCATION_ONFIELD) then
    if GlobalCardMode == 1 then
      GlobalCardMode = nil
      return BestTargets(cards,1,TARGET_OTHER,FilterGlobalTarget,cards)
    end
    return BestTargets(cards,1,TARGET_OTHER)
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOFIELD,1,FilterGlobalTarget,cards)
  end
  return Add(cards,PRIO_TOFIELD,1,PKNonXYZFilter)
end
function RequiemTarget(cards,min)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,LOCATION_GRAVE,min,ExcludeID,16195942)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOFIELD)
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return BestTargets(cards,1,TARGET_OTHER,FilterGlobalTarget)
  end
  return BestTargets(cards,1,TARGET_OTHER)
end
function LightningTarget(cards,min)
  return Add(cards,PRIO_TOGRAVE,min,ExcludeID,84013237)
end
function DranciaTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  return BestTargets(cards,1,TARGET_DESTROY,DranciaFilter)
end
GenericTargetFunctions = {
[48905153] = DranciaTarget,
}
function GenericCard(cards,min,max,id,c)
  if c then
    id = c.id
  end 
  if GlobalPendulumSummon then
    GlobalPendulumSummon = nil
    return PendulumSummonTarget(cards,max)
  end
  for i,v in pairs(GenericTargetFunctions) do
    if id == i then
      return v(cards,c,min,max)
    end
  end
  if id == 56832966 then
    return LightningTarget(cards,min)
  end
  if id == 63519819 then
    return TERTarget(cards)
  end
  if id == 01621413 then
    return RequiemTarget(cards,min)
  end
  if id == 43898403 then
    return TwinTwisterTarget(cards)
  end
  if id == 21044178 then
    return DwellerTarget(cards)
  end
  if id == 19508728 then -- Moon Mirror Shield
    return BestTargets(cards,1,TARGET_DESTROY,MoonMirrorFilter)
  end
  if id == 06511113 then
    return RafflesiaTarget(cards,min)
  end 
  if id == 18326736 then
    return PtolemaiosTarget(cards,min)
  end 
  if id == 10443957 then
    return InfinityTarget(cards)
  end 
  if id == 22653490 then
    return ChidoriTarget(cards)
  end 
  if id == 98012938 then
    return VulcanTarget(cards)
  end 
  if id == 55713623 then
    return ShrinkTarget(cards,c)
  end
  if id == 50321796 then
    return BrionacTarget(cards,c)
  end
  if id == 01639384 then
    return FelgrandTarget(cards,c)
  end
  if id == 78156759 then
    return ZenmainesTarget(cards)
  end
  if id == 73445448 then
    return ZombiesteinTarget(cards)
  end
  if id == 66547759 then
    return LancelotTarget(cards,c)
  end
  if id == 10406322 then
    return AlseiTarget(cards,c)
  end
  if id == 88120966 then
    return GiantGrinderTarget(cards,c)
  end
  if id == 01845204 then
    return InstantFusionTarget(cards)
  end
  if id == 33698022 then  -- Moonlight Rose
    return BestTargets(cards,1,TARGET_TOHAND)
  end
  if id == 05133471 then -- Galaxy Cyclone
    return BestTargets(cards)
  end
  if id == 54447022 then
    return SoulChargeTarget(cards,min,max)
  end
  if id == 05318639 then
    return MSTTarget(cards)
  end
  if id == 60082869 then
    return DustTornadoTarget(cards)
  end
  if id == 94192409 then
    return CompulseTarget(cards)
  end
  if id == 00581014 then
    return EmeralTarget(cards,min)
  end
  if id == 82633039 then
    return SkyblasterTarget(cards,min)
  end
  if id == 29669359 then
    return VolcasaurusTarget(cards)
  end
  if id == 04779823 then
    return MichaelTarget(cards,c)
  end
  if id == 31924889 then
    return ArcaniteTarget(cards)
  end
  if id == 72959823 then
    return PanzerDragonTarget(cards)
  end
  if id == 41386308 then
    return MathTarget(cards)
  end
  if id == 73176465 then -- Felis
    return BestTargets(cards,1,TARGET_DESTROY)
  end
  if id == 99590524 then -- Treacherous
    return BestTargets(cards,min,TARGET_DESTROY)
  end
  if id == 81275020 then -- Terrortop
    return Add(cards)
  end
  if id == 25542642 then
    return FogBladeTarget(cards)
  end
  return nil
end

function GenericEffectYesNo(id,card)
  local result = nil
  if card then 
    id = card.id
  end
  if id == 66547759 then -- Lancelot
    result = 1
  end
  if id == 10406322 and UseAlsei(card) then
    result = 1
  end
  if id == 56832966 and ChainUtopiaLightning(card) then
    result = 1
  end
  if id == 33698022 then -- Moonlight Rose
    retult = 1
  end
  if id == 72959823 and ChainPanzerDragon(card) then
    result = 1
  end
  if id == 73176465 and grave then -- Felis
    result = 1
  end
  if id == 63767246 and ChainTitanicGalaxy(card) then
    result = 1
  end
  if id == 81275020 then -- Speedroid Terrortop
    OPTSet(id)
    return 1
  end
  return result
end
GenericAtt={
}
GenericDef={
  31924889, -- Arcanite Magician
  73176465, -- Felis
  06511113, -- Rafflesia
}
function GenericPosition(id,available)
  result = nil
  for i=1,#GenericAtt do
    if GenericAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#GenericDef do
    if GenericDef[i]==id then result=POS_FACEUP_DEFENSE end
  end
  if id == 78156759 then -- Zenmaines
    local c = FindID(78156759,AIExtra())
    if ZenmainesCheck(c,OppMon())
    and Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()==PHASE_MAIN1
    and GlobalBPAllowed
    then
      result = POS_FACEUP_ATTACK
    else
      result = POS_FACEUP_DEFENSE
    end
  end
  return result
end


