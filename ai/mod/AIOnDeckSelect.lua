-- Functions to check which deck the AI is playing

GlobalDeck = nil
Decks={}
function NewDeck(name,identifier,startup)
  local deck={}
  deck.ID=#Decks+1
  deck.Name=name
  deck.Identifier=identifier 
  deck.Startup=startup
  Decks[deck.ID]=deck
  return deck
end

DECK_SOMETHING    = 0
DECK_CHAOSDRAGON  = NewDeck("Chaos Dragon"    ,99365553) -- Lightpulsar Dragon
DECK_FIREFIST     = NewDeck("Fire Fist"       ,01662004) -- Firefist Spirit
DECK_HERALDIC     = NewDeck("Heraldic Beast"  ,82293134) -- Heraldic Beast Leo
DECK_GADGET       = NewDeck("Gadget"          ,05556499) -- Machina Fortress
DECK_BUJIN        = NewDeck("Bujin"           ,32339440) -- Bujin Yamato
DECK_MERMAIL      = NewDeck("Mermail"         ,21954587) -- Mermail Abyssmegalo
DECK_TELLARKNIGHT = NewDeck("Satellarknight"  ,75878039) -- Satellarknight Deneb
DECK_HAT          = NewDeck("HAT"             ,45803070) -- Traptrix Dionaea
DECK_QLIPHORT     = NewDeck("Qliphort"        ,65518099) -- Qliphort Tool
DECK_NOBLEKNIGHT  = NewDeck("Noble Knight"    ,59057152) -- Noble Knight Medraut
DECK_NEKROZ       = NewDeck("Nekroz"          ,14735698) -- Nekroz Exomirror
DECK_EXODIA       = NewDeck("Exodia"          ,{33396948,70791313}) -- Exodia the Forbidden One, Royal Magical Library
DECK_DARKWORLD    = NewDeck("Dark World"      ,34230233) -- DW Grapha
DECK_CONSTELLAR   = NewDeck("Constellar"      ,78358521) -- Constellar Sombre
DECK_BLACKWING    = NewDeck("Blackwing"       ,91351370) -- Black Whirlwind
DECK_HARPIE       = NewDeck("Harpie"          ,19337371) -- Hysteric Sign


function IdentifierCheck(deck)
  if deck == nil or deck.Identifier == nil then return false end
  local ident = deck.Identifier
  if type(ident)=="table" then
    result = 0
    for i=1,#ident do
      local id = ident[i]
      if HasID(AIAll(),id,true) then
        result = result+1
      end
    end
    if result>=#ident then
      return true
    end
  else
    if HasID(AIAll(),ident,true) then
      return true
    end
  end
  return false
end
function DeckCheck(opt)
  if GlobalDeck == nil then
    for i=1,#Decks do
      local d = Decks[i]
      if IdentifierCheck(d) then
        GlobalDeck = i
      end
    end
    if GlobalDeck == nil then
      GlobalDeck = DECK_SOMETHING
      --print("AI deck is something else")
    else 
      print("AI deck is "..Decks[GlobalDeck].Name)
    end
    DeckSetup()
  end
  if opt then
    if type(opt) == "table" then
      return GlobalDeck==opt.ID
    end
    return GlobalDeck==opt
  else
    return GetDeck()
  end
end


function GetDeck()
  if GlobalDeck == 0 then
    return nil
  end
  return Decks[GlobalDeck]
end

function DeckSetup()
  local deck = GetDeck()
  if deck then
    if deck.Startup then
      deck.Startup(deck)
    end
    BlacklistSetup(deck)
  end
  PrioritySetup()
end

PRIO_TOHAND = 1
PRIO_TOFIELD = 3
PRIO_TOGRAVE = 5
PRIO_DISCARD,PRIO_TODECK,PRIO_EXTRA,PRIO_TRIBUTE = 7,7,7,7
PRIO_BANISH = 9
-- priority lists for decks:
function PrioritySetup()

  DarkWorldPriority()
  ConstellarPriority()
  BlackwingPriority()
  HarpiePriority()
  MermailPriority()
  ChaosDragonPriority()
  QliphortPriority()
  SatellarknightPriority()
  --HEROPriority()
  --BAPriority()
  NekrozPriority()
  GadgetPriority()
  
AddPriority({
-- HERO

[69884162] = {3,1,1,1,1,1,1,1,1,1,AliusCond},   -- Neos Alius
[63060238] = {1,1,1,1,1,1,1,1,1,1,BlazeCond},   -- Blazeman
[50720316] = {7,1,7,1,1,1,1,1,1,1,MistCond},    -- Shadow Mist
[00423585] = {4,1,1,1,1,1,1,1,1,1,MonkCond},    -- Summoner Monk
[79979666] = {8,1,8,1,1,1,1,1,1,1,BubbleCond},  -- Bubbleman

[00213326] = {1,1,1,1,8,1,1,1,1,1,nil},         -- E-Call
[08949584] = {1,1,1,1,6,1,1,1,1,1,nil},         -- AHL
[18511384] = {1,1,1,1,3,1,1,1,1,1,nil},         -- Fusion Recovery
[24094653] = {1,1,1,1,3,1,1,1,1,1,nil},         -- Polymerization
[45906428] = {1,1,1,1,3,1,1,1,1,1,nil},         -- Miracle Fusion
[55428811] = {1,1,1,1,3,1,1,1,1,1,nil},         -- Fifth Hope
[21143940] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Mask Change
[87819421] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Mask Charge
[87819421] = {1,1,1,1,9,1,1,1,1,1,nil},         -- Upstart
[84536654] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Form Change
[84536654] = {1,1,1,1,2,1,1,1,1,1,nil},         -- Forbidden Lance
[12580477] = {1,1,1,1,2,1,1,1,1,1,nil},         -- Raigeki
[57728570] = {1,1,1,1,1,1,1,1,1,1,nil},         -- CCV
[83555666] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Ring of Destruction

[95486586] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Core
[03642509] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Great Tornado
[22093873] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Divine Wind
[01945387] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Nova Master
[22061412] = {1,1,1,1,1,1,1,1,1,1,nil},         -- The Shining
[29095552] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Acid
[33574806] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Escuridao
[40854197] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Absolute Zero
[50608164] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Koga
[58481572] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Dark Law
[16304628] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Gaia
})


AddPriority({
-- Noble Knight:
[95772051] = {4,0,9,2,9,2,1,1,1,1,BlackSallyCond},    -- Black Sally
[93085839] = {4,0,8,2,10,2,1,1,1,1,EachtarCond},      -- Eachtar
[19680539] = {4,2,2,1,4,2,3,2,4,2,GawaynCond},        -- Gawayn
[53550467] = {3,3,3,3,6,3,3,2,3,2,DrystanCond},       -- Drystan
[59057152] = {7,2,7,2,4,2,5,3,3,2,MedrautCond},       -- Medraut
[47120245] = {6,1,5,3,4,3,3,2,3,2,BorzCond},          -- Borz
[13391185] = {5,2,4,2,5,2,3,2,5,2,ChadCond},          -- Chad
[57690191] = {4,3,3,2,5,3,3,2,2,2,BrothersCond},      -- Brothers
[19748583] = {8,1,1,1,11,3,1,1,1,1,GwenCond},         -- Gwen
[10736540] = {6,0,1,1,12,3,1,1,1,1,LadyCond},         -- Lady

[92125819] = {1,0,2,1,8,1,3,2,3,1,ArtorigusCond},     -- Artorigus
[73359475] = {3,3,3,3,7,3,3,2,3,2,PeredurCond},       -- Peredur
[03580032] = {9,2,4,2,3,2,1,1,1,1,nil},               -- Merlin
[30575681] = {5,2,6,2,3,2,3,2,3,1,BedwyrCond},        -- Bedwyr

[66970385] = {8,5,1,1,1,1,9,1,1,1,nil},               -- Chapter
[07452945] = {7,1,7,1,4,1,2,1,1,1,RequipArmsCond},    -- Destiny
[14745409] = {4,1,4,1,5,1,2,1,1,1,RequipArmsCond},    -- Gallatin
[23562407] = {6,1,6,1,7,1,2,1,1,1,RequipArmsCond},    -- Caliburn
[46008667] = {5,2,5,1,5,1,1,1,1,1,ExcaliburnCond},    -- Excaliburn
[83438826] = {3,1,3,1,6,2,3,1,1,1,ArfCond},           -- Arfeudutyr
[55742055] = {9,2,1,1,1,1,7,1,1,1,TableCond},         -- Table
[92512625] = {4,1,1,1,1,1,1,1,1,1,nil},               -- Advice

[48009503] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Gandiva
[82944432] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Blade Armor Ninja
[60645181] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Excalibur
[21223277] = {1,1,1,1,1,1,5,1,3,1,nil},               -- R4torigus
[10613952] = {1,1,1,1,3,1,6,1,3,1,R5torigusCond},     -- R5torigus
[83519853] = {1,1,6,1,1,1,1,1,1,1,nil},               -- High Sally
[68618157] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Amaterasu
[73289035] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Tsukuyomi
})




AddPriority({ 
-- Stuff
[73176465] = {1,1,1,1,6,5,1,1,1,1,FelisCond},         -- Lightsworn Felis
[41386308] = {1,1,1,1,1,1,1,1,1,1,MathCond},          -- Mathematician

-- Speedroid Engine 

[81275020] = {9,1,5,1,1,1,1,1,1,1},                   -- Speedroid Terrortop
[53932291] = {8,1,1,1,1,1,1,1,1,1},                   -- Speedroid Taketomborg

[05318639] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Mystical Space Typhoon

[82044279] = {1,1,1,1,1,1,1,1,1,1,ClearWingCond},     -- Clear Wing Synchro Dragon
[72959823] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Panzer Dragon
[29669359] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Number 61: Volcasaurus
[82633039] = {1,1,1,1,6,1,1,1,1,1,CastelCond},        -- Skyblaster Castel
[00581014] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Daigusto Emeral
[33698022] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Moonlight Rose Dragon
[31924889] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Arcanite Magician
[08561192] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Leoh, Keeper of the Sacred Tree
})

AddPriority({
-- HAT
[91812341] = {6,3,5,1,1,1,1,1,1,1,MyrmeleoCond},      -- Traptrix Myrmeleo
[45803070] = {7,4,4,1,1,1,1,1,1,1,DionaeaCond},       -- Traptrix Dionaea
[68535320] = {5,2,2,1,1,1,1,1,1,1,FireHandCond},      -- Fire Hand
[95929069] = {4,2,2,1,1,1,1,1,1,1,IceHandCond},       -- Ice Hand
[85103922] = {4,1,6,4,3,1,3,1,1,1,MoralltachCond},    -- Artifact Moralltach
[12697630] = {5,1,7,3,5,1,5,1,1,1,BeagalltachCond},   -- Artifact Beagalltach
[20292186] = {4,1,5,3,4,1,4,1,1,1,ScytheCond},        -- Artifact Scythe

[14087893] = {2,1,1,1,1,1,1,1,1,1,nil},               -- Book of Moon
[98645731] = {2,1,1,1,1,1,1,1,1,1,nil},               -- Pot of Duality
[29616929] = {2,1,1,1,1,1,1,1,1,1,nil},               -- Traptrix Trap Hole Nightmare
[53582587] = {2,1,1,1,1,1,1,1,1,1,nil},               -- Torrential Tribute
[29401950] = {3,1,1,1,1,1,1,1,1,1,nil},               -- Bottomless Trap Hole
[84749824] = {3,1,1,1,1,1,1,1,1,1,nil},               -- Solemn Warning
[94192409] = {2,1,1,1,1,1,1,1,1,1,nil},               -- Compulsory Evacuation Device
[12444060] = {5,1,1,1,1,1,1,1,1,1,SanctumCond},       -- Artifact Sanctum
[29223325] = {4,1,1,1,1,1,1,1,1,1,IgnitionCond},      -- Artifact Ignition
[97077563] = {3,1,1,1,1,1,1,1,1,1,COTHCond},          -- Call of the Haunted
[78474168] = {2,1,1,1,4,1,4,1,1,1,nil},               -- Breakthrough Skill

[91949988] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Gaia Dragon, the Thunder Charger
[91499077] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Gagaga Samurai
[63746411] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Giant Hand
})

AddPriority({
--for backwards compatibility
[05361647] = {1,1,1,1,9,1,1,1,1,1,nil},               -- Battlin' Boxer Glassjaw
[68144350] = {1,1,1,1,5,1,1,1,1,1,nil},               -- Battlin' Boxer Switchhitter

[44519536] = {1,1,-1,-1,-1,-1,-1,-1,1,1,nil},
[08124921] = {1,1,-1,-1,-1,-1,-1,-1,1,1,nil},
[07902349] = {1,1,-1,-1,-1,-1,-1,-1,1,1,nil},         -- Exodia pieces
[70903634] = {1,1,-1,-1,-1,-1,-1,-1,1,1,nil},
[33396948] = {1,1,-1,-1,-1,-1,-1,-1,1,1,nil},

[05133471] = {1,1,1,1,4,1,1,1,1,1,nil},               -- Galaxy Cyclone

})

  local deck = GetDeck()
  if deck and deck.PriorityList then
    AddPriority(deck.PriorityList,true)
  end
 
end

Prio = {}
function AddPriority(list,override)
  for i,v in pairs(list) do
    if Prio[i] and not override then print("warning: duplicate priority entry for ID: "..i) end
    Prio[i]=v
  end
end
function GetPriority(card,loc)
  card.prio=0
  local id=card.id      
  if id == 76812113 then
    id=card.original_id
  end
  local checklist = nil
  local result = 0
  if loc == nil then
    loc = PRIO_TOHAND
  end
  checklist = Prio[id]
  if checklist then
    if checklist[11] and not(checklist[11](loc,card)) then
      loc = loc + 1
    end
    result = checklist[loc]
    if checklist[11] and checklist[11](loc,card) 
    and type(checklist[11](loc,card))=="number"  
    then
      result = checklist[11](loc,card)
    end
  else
    --print("no priority defined for id: "..id..", defaulting to 0")
    return 0
  end
  --print("got priority: "..result.." for "..GetName(card))
  return result
end
function AssignPriority(cards,loc,filter,opt)
  local index = 0
  Multiple = nil
  for i,c in pairs(cards) do
    if not c.index then c.index=i end
    c.prio=GetPriority(c,loc)
    if loc==PRIO_TOFIELD and c.location==LOCATION_DECK then
      c.prio=c.prio+2
    end
    if loc==PRIO_TOGRAVE and c.location==LOCATION_DECK then
      c.prio=c.prio+2
    end
    if loc==PRIO_TOFIELD and c.location==LOCATION_GRAVE then
      c.prio=c.prio+1
    end
    if loc==PRIO_TOFIELD and c.location==LOCATION_EXTRA then
      c.prio=c.prio+5
    end
    if loc==PRIO_TOGRAVE and bit32.band(c.location,LOCATION_ONFIELD)>0
    and c.equip_count and c.equip_count>0 and HasID(c:get_equipped_cards(),17639150,true) 
    then
      c.prio=10
    end
    if loc==PRIO_TOGRAVE and FilterLocation(c,LOCATION_ONFIELD)
    then
      if FilterCrippled(c) then 
        c.prio=c.prio+5
      end
      if FilterPosition(c,POS_DEFENSE)
      and c.turnid==Duel.GetTurnCount()
      and c.attack>c.defense
      then
        c.prio=c.prio+2
      end
      if FilterType(c,TYPE_XYZ)
      and c.xyz_material_count==0 
      then
        c.prio=c.prio+2
      end
    end
    if loc==PRIO_TOHAND and bit32.band(c.location,LOCATION_ONFIELD)>0 
    and not DeckCheck(DECK_HARPIE) -- TODO: temp
    then
      c.prio=-1
    end
    if c.owner==2 then
      c.prio=-1*c.prio
    end
    if not TargetCheck(c) then
      c.prio=-1
    end
    if loc==PRIO_TOGRAVE and not MacroCheck() then
      c.prio=-1*c.prio
    end
    if loc==PRIO_TOGRAVE and HasID(AIMon(),17412721,true) --Norden
    then
      local norden = FindID(17412721,AIMon())
      if CardTargetCheck(norden,c) then
        c.prio=12
      end
      if CardsEqual(norden,c) then
        c.prio=11
      end
    end
    c.prio=c.prio or 0
    if not FilterCheck(c,filter,opt) then
      c.prio=c.prio-9999
    end
    SetMultiple(c.original_id)
  end
end
function PriorityCheck(cards,loc,count,filter,opt)
  if count == nil then count = 1 end
  if loc==nil then loc=PRIO_TOHAND end
  if cards==nil or #cards<count then return -1 end
  AssignPriority(cards,loc,filter,opt)
  table.sort(cards,function(a,b) return a.prio>b.prio end)
  return cards[count].prio
end
function Add(cards,loc,count,filter,opt)
  local result={}
  if count==nil then count=1 end
  if loc==nil then loc=PRIO_TOHAND end
  local compare = function(a,b) return a.prio>b.prio end
  AssignPriority(cards,loc,filter,opt)
  table.sort(cards,compare)
  for i=1,count do
    result[i]=cards[i].index
  end
  --PrintList(cards,true)
  if #result<count then 
    for i=#result+1,count do
      result[i]=i
    end
  end
  return result
end
function SortByPrio(cards)
  table.sort(cards,function(a,b) return a.prio>b.prio end)
end
