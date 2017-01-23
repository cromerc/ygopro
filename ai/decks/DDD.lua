--[[
74069667 -- Abyss Ragnarok
19302550 -- Newton
19808608 -- Berformet
72181263 -- Orthros
46796664 -- Copernicus
48210156 -- Night Howling
45206713 -- Swirl Slime
72291412 -- Necro Slime
19580308 -- Lamia
11609969 -- Kepler
02295440 -- One for one
12580477 -- Raigeki
43898403 -- Twin Twister
46372010 -- Gate
73360025 -- Swamp King
05851097 -- Vanity
40605147 -- Solemn Strike
84749824 -- Solemn Warning

27873305 -- Caesar Ragnarok
82956492 -- D'Arc
74583607 -- Temujin
52687916 -- Trishula
81020646 -- Void Ogre Dragon
50954680 -- Crystal Wing
44852429 -- Siegfried
00987311 -- Alexander
15939229 -- Kali Yuga
71612253 -- Tell
03758046 -- Caesar
]]

function DDDStartup(deck)
  deck.Init                 = DDDInit
  deck.Card                 = DDDCard
  deck.Chain                = DDDChain
  deck.EffectYesNo          = DDDEffectYesNo
  deck.Position             = DDDPosition
  deck.YesNo                = DDDYesNo
  deck.BattleCommand        = DDDBattleCommand
  deck.AttackTarget         = DDDAttackTarget
  deck.AttackBoost          = DDDAttackBoost
  deck.Tribute              = DDDTribute
  deck.Option               = DDDOption
  deck.ChainOrder           = DDDChainOrder
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = DDDActivateBlacklist
  deck.SummonBlacklist      = DDDSummonBlacklist
  deck.RepositionBlacklist  = DDDRepoBlacklist
  deck.SetBlacklist         = DDDSetBlacklist
  deck.Unchainable          = DDDUnchainable
  --[[
  
  ]]
  deck.PriorityList         = DDDPriorityList
  
  DDDRegisterCombos()
  
end


DDDIdentifier = 11609969 -- DD Savant Kepler

DECK_DDD = NewDeck("DDD",DDDIdentifier,DDDStartup) 


DDDActivateBlacklist={
74069667, -- Abyss Ragnarok
19302550, -- Newton
19808608, -- Berformet
72181263, -- Orthros
46796664, -- Copernicus
48210156, -- Night Howling
45206713, -- Swirl Slime
72291412, -- Necro Slime
19580308, -- Lamia
11609969, -- Kepler
02295440, -- One for one
46372010, -- Gate
73360025, -- Swamp King

27873305, -- Caesar Ragnarok
82956492, -- D'Arc
74583607, -- Temujin
81020646, -- Void Ogre Dragon
50954680, -- Crystal Wing
44852429, -- Siegfried
00987311, -- Alexander
15939229, -- Kali Yuga
71612253, -- Tell
03758046, -- Caesar
}
DDDSummonBlacklist={
74069667, -- Abyss Ragnarok
19302550, -- Newton
19808608, -- Berformet
72181263, -- Orthros
46796664, -- Copernicus
48210156, -- Night Howling
45206713, -- Swirl Slime
72291412, -- Necro Slime
19580308, -- Lamia
11609969, -- Kepler

27873305, -- Caesar Ragnarok
82956492, -- D'Arc
74583607, -- Temujin
52687916, -- Trishula
81020646, -- Void Ogre Dragon
50954680, -- Crystal Wing
44852429, -- Siegfried
00987311, -- Alexander
15939229, -- Kali Yuga
71612253, -- Tell
03758046, -- Caesar
}
DDDSetBlacklist={
46372010, -- Gate
}
DDDRepoBlacklist={
}
DDDUnchainable={
}
function DDDFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0x10af) and check
end
function DDDMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and DDDFilter(c,exclude)
end
function DDFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xaf) and check
end
function DDMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and DDFilter(c,exclude)
end
function ContractFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xae) and check
end

DDDPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- DDD

[74069667] = {1,1,1,1,1,1,1,1,1,1,AbyssRagCond},    -- Abyss Ragnarok
[19302550] = {1,1,1,1,1,1,1,1,1,1,NewtonCond},      -- Newton
[19808608] = {1,1,1,1,1,1,1,1,1,1,BerformetCond},   -- Berformet
[72181263] = {1,1,1,1,1,1,1,1,1,1,OrthrosCond},     -- Orthros
[46796664] = {1,1,1,1,1,1,1,1,1,1,CopernicusCond},  -- Copernicus
[48210156] = {1,1,1,1,1,1,1,1,1,1,HowlingCond},     -- Night Howling
[45206713] = {1,1,1,1,1,1,1,1,1,1,SwirlCond},       -- Swirl Slime
[72291412] = {1,1,1,1,1,1,1,1,1,1,NecroCond},       -- Necro Slime
[19580308] = {1,1,1,1,1,1,1,1,1,1,LamiaCond},       -- Lamia
[11609969] = {1,1,1,1,1,1,1,1,1,1,KeplerCond},      -- Kepler
[46372010] = {1,1,1,1,1,1,1,1,1,1,GateCond},        -- Gate
[73360025] = {1,1,1,1,1,1,1,1,1,1,SwampCond},       -- Swamp King

[27873305] = {1,1,1,1,1,1,1,1,1,1,CaesarRagCond},   -- Caesar Ragnarok
[82956492] = {1,1,1,1,1,1,1,1,1,1,DArcCond},        -- D'Arc
[74583607] = {1,1,1,1,1,1,1,1,1,1,TemujinCond},     -- Temujin
[81020646] = {1,1,1,1,1,1,1,1,1,1,},                -- Void Ogre Dragon
[50954680] = {1,1,1,1,1,1,1,1,1,1,},                -- Crystal Wing
[44852429] = {1,1,1,1,1,1,1,1,1,1,SiegfriedCond},   -- Siegfried
[00987311] = {1,1,1,1,1,1,1,1,1,1,AlexanderCond},   -- Alexander
[15939229] = {1,1,1,1,1,1,1,1,1,1,KaliYugaCond},    -- Kali Yuga
[71612253] = {1,1,1,1,1,1,1,1,1,1,TellCond},        -- Tell
[03758046] = {1,1,1,1,1,1,1,1,1,1,CaesarCond},      -- Caesar

} 
function SummonAbyssRag(c,mode)
end
function SummonNewton(c,mode)
  return false
end
function SummonBerformet(c,mode)
end
function SummonOrthros(c,mode)
end
function SummonCopernicus(c,mode)
end
function SummonHowling(c,mode)
end
function SummonSwirl(c,mode)
end
function UseSwirlHand(c,mode)
end
function UseSwirlGrave(c,mode)
end
function SummonNecro(c,mode)
end
function UseNecro(c,mode)
end
function SummonLamia(c,mode)
end
function UseLamia(c,mode)
end
function SummonKepler(c,mode)
end
function UseGate(c,mode)
end
function UseSwamp(c,mode)
end
function SummonVoidOgre(c,mode)
end
function SummonCrystalWing(c,mode)
  return true
end
function SummonSiegfried(c,mode)
end
function UseSiegfried(c,mode)
end
function SummonAlexander(c,mode)
end
function SummonKaliYuga(c,mode)
end
function UseKaliNuke(c,mode)
end
function UseKaliYuga(c,mode)
end
function SummonTell(c,mode)
end
function UseTell(c,mode)
end
function SummonCaesar(c,mode)
end
function UseCaesar(c,mode)
end

function ComboPieceCheck(cards,gatevar)
  local hasgate = HasIDNotNegated(AICards(),46372010,true,FilterOPT,true)
  if gatevar == 2 and not (hasgate and OPTCheck(46372010)) then return false end
  if gatevar == 1 and not OPTCheck(46372010) then return false end
  local hand = AIHand()
  local count = #cards
  if gatevar == 0 and hasgate or gatevar == 2 then
    count = count -1
  end
  for i,v in pairs(cards) do
    if HasID(AIHand(),v,true) then
      count = count-1
      table.remove(hand,FindID(v,hand,true)[1])
    end
  end
  return count<=0 
end

ComboList={}
Combo={}
Combo.__index = Combo
DDDActiveCombo=nil
function Combo.new(cards,gatevar,filter,steps)
  local self = setmetatable({},Combo)
  self.cards = cards or {}
  self.gatevar = gatevar or 0
  self.filter = filter or nil
  self.steps = steps or 0
  ComboList[#ComboList+1]=self
  print("registered combo: "..#ComboList)
  return self
end
function Combo:init()
  if ComboPieceCheck(self.cards,self.gatevar) then
    DDDActiveCombo=self
    self.step = 1
    return self
  end
  return false
end
function Combo:step()
  if self.step<self.steps then
    self.step = self.step+1
  else
    DDDActiveCombo=nil
  end
end
function Combo:checkIntegrity()
  local check = self.filter(self,self.step) 
  if check~=nil then
    return check
  end
  return true
end
function GateFilter(c)
  return NotNegated(c) and FilterLocation(c,LOCATION_SZONE)
end
function MissingCardFilter(c,cards)
  for i,v in pairs(cards) do
    if c.id==v and not HasID(AIHand(),v,true) then
      return true
    end
  end
end
function GetGateIndex(cards)
  local result = nil
  for i,c in pairs(cards) do
    if c.id == 46372010 
    and FilterLocation(c,LOCATION_SZONE) 
    then
      result = i
    end
  end
  if not result then 
    for i,c in pairs(cards) do
      if c.id == 46372010 
      then
        result = i
      end
    end
  end
  return result
end
function Combo:command(cards)
  print("executing command")
  local step = self.step
  if step == 1 then -- activate Gate
    if HasIDNotNegated(cards,46372010,false,nil,LOCATION_SZONE,POS_FACEUP,FilterOPT,true) then
      self.step = self.step + 1 
      OPTSet(46372010)
      return COMMAND_ACTIVATE,CurrentIndex
    elseif HasIDNotNegated(cards,46372010,false,nil,LOCATION_SZONE,POS_FACEDOWN,FilterOPT,true) then
      OPTSet(46372010)
      return COMMAND_ACTIVATE,CurrentIndex
    elseif HasIDNotNegated(cards,46372010,false,nil,LOCATION_HAND,FilterOPT,true) then
      OPTSet(46372010)
      return COMMAND_ACTIVATE,CurrentIndex
    end
    return nil
  end
  if step == 2 then -- search missing piece
    return Add(cards,PRIO_TOHAND,1,MissingCardFilter,self.cards)
  end
end
--[[
74069667 -- Abyss Ragnarok
19302550 -- Newton
19808608 -- Berformet
72181263 -- Orthros
46796664 -- Copernicus
48210156 -- Night Howling
45206713 -- Swirl Slime
72291412 -- Necro Slime
19580308 -- Lamia
11609969 -- Kepler
02295440 -- One for one
12580477 -- Raigeki
43898403 -- Twin Twister
46372010 -- Gate
73360025 -- Swamp King
05851097 -- Vanity
40605147 -- Solemn Strike
84749824 -- Solemn Warning

27873305 -- Caesar Ragnarok
82956492 -- D'Arc
74583607 -- Temujin
52687916 -- Trishula
81020646 -- Void Ogre Dragon
50954680 -- Crystal Wing
44852429 -- Siegfried
00987311 -- Alexander
15939229 -- Kali Yuga
71612253 -- Tell
03758046 -- Caesar
]]

function DDDComboFilter1(self,step)
  if not (DualityCheck() 
  and MacroCheck())
  then
    return false
  end
  if step == 1 then
    return SpaceCheck()>2
    and ComboPieceCheck(self.cards,self.gatevar)
  end
  if step == 2 then
    return SpaceCheck()>2
    and ComboPieceCheck(self.cards,self.gatevar)
  end
  return true
end
--[[DDDComboCommands1=
{
  {COMMAND_ACTIVATE,FindID(46372010,params.activatable_cards,true,GateFilter)},
  {Add(params,PRIO_TOHAND,MissingCardFilter
}]]

function DDDRegisterCombos()
  print("registering combos")
  local combo = Combo.new({19580308,45206713,72181263,46796664},2)
  combo.filter=DDDComboFilter1
  --combo.commands=DDDComboCommands1
end


function DDDComboCheck(cards)
  print("Combo Check")
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local combo = DDDActiveCombo
  if combo then
    print("have an active combo")
    if combo:checkIntegrity() then
      print("integrity intact, continue combo")
      return combo:command(Act)
    else
      print("integrity not intact, cancel combo")
      combo = nil
    end
  end
  if combo == nil then
    print("no active combo")
    for i,v in pairs(ComboList) do
      if v:init() then 
        print("initializing combo "..i)
        return v:command(Act)
      end
    end
  end
  return nil
end
function DDDInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  print("Init")
  local ComboOverride,opt = DDDComboCheck(cards)
  print(ComboOverride)
  print(opt)
  if ComboOverride then
    print("combo override command:")
    print(ComboOverride)
    print(opt)
    return ComboOverride,opt
  end
  
  return nil
end

function DDDCard(cards,min,max,id,c)

  return nil
end

function DDDChain(cards)
  
  return nil
end
function DDDEffectYesNo(id,card)

  return nil
end
function DDDYesNo(desc)
end
function DDDTribute(cards,min, max)
end
function DDDBattleCommand(cards,targets,act)
end
function DDDAttackTarget(cards,attacker)
end
function DDDAttackBoost(cards)
end
function DDDOption(options)
end
function DDDChainOrder(cards)
end
DDDAtt={
27873305, -- Caesar Ragnarok
82956492, -- D'Arc
74583607, -- Temujin
52687916, -- Trishula
81020646, -- Void Ogre Dragon
50954680, -- Crystal Wing
44852429, -- Siegfried
00987311, -- Alexander
15939229, -- Kali Yuga
71612253, -- Tell
03758046, -- Caesar
}
DDDVary={
74069667, -- Abyss Ragnarok
19808608, -- Berformet
}
DDDDef={
19302550, -- Newton
72181263, -- Orthros
46796664, -- Copernicus
48210156, -- Night Howling
45206713, -- Swirl Slime
72291412, -- Necro Slime
19580308, -- Lamia
11609969, -- Kepler
}
function DDDPosition(id,available)
  result = nil
  for i=1,#DDDAtt do
    if DDDAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#DDDVary do
    if DDDVary[i]==id 
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
  for i=1,#DDDDef do
    if DDDDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end