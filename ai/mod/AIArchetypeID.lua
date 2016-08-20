---------------------------------------
-- AIArchetypeID.lua
--
-- A set of functions to determine if a
-- card is part of an archetype or list.
---------------------------------------

-----------------------------
-- Checks if the card's ID is
-- of a Tribute Exception monster.
-----------------------------
function IsTributeException(CardId)
  if CardId == 64631466 or CardId == 63519819 or -- Relinquished, Thousand-Eyes Restrict 
     CardId == 10000000 or CardId == 10000020 or -- Obelisk the Tormentor, Slifer the Sky Dragon
     CardId == 10000010 then	                 -- The Winged Dragon of Ra		 
    return 1
  end
  return 0
end

function Is3TributeMonster(CardId)
  if CardId == 10000000 or CardId == 10000020 or -- Obelisk the Tormentor, Slifer the Sky Dragon
     CardId == 10000010 then	                 -- The Winged Dragon of Ra		 
    return 1
  end
  return 0
end

function LegitDWMonster(CardId)
  if CardId == 34230233 or CardId == 32619583 or 
     CardId == 33731070 or CardId == 79126789 then	 
    return 1
  end
  return 0
end

function IsUndestroyableByBattle(CardId)
  if CardId == 31305911 then -- Marshmallon 
    return 1
  end
  return 0
end

---------------------------------------------------------
-- Some cards shouldn't be banished
---------------------------------------------------------
function BanishBlacklist(CardId)
  if CardId == 65192027 or CardId == 88264978 or -- Dark Armed Dragon, REDMD
     CardId == 34230233 or CardId == 72989439 or -- Grapha, Black Luster Soldier
     CardId == 38495396 then                     -- Constellar Ptolemy M7  
	return 1
  end
    return 0
end

---------------------------------------------------------
-- Cards that benefit from being banished
---------------------------------------------------------
function BanishWhitelist(CardId)
  if CardId == 42216237 or CardId == 51858306   -- Angel of Zera, Eclipse Wyvern
  then
    return 1
  end
    return 0
end

-----------------------------
-- Checks if the card's ID is
-- of a Nordic Tuner monster.
-----------------------------
function IsNordicTuner(CardId)
  if CardId == 41788781 or CardId == 73417207 or   -- Guldfaxe, Mara
     CardId == 77060848 or CardId == 40844552 or   -- Svartalf, Valkyrie
     CardId == 61777313 then                       -- Vanadis
    return 1
  end
  return 0
end

-----------------------------
-- Checks if the card's ID is
-- of a "Gladiator Beast" archetype monster.
-----------------------------
function IsGladiatorArchetype(CardId)
  local AIMon  = AI.GetAIMonsterZones()
  for i=1,#AIMon do
  if AIMon[i] ~= false then
  if AIMon[i].id == CardId then
  if CardId == 42592719 or CardId == 90582719 or   -- Gladiator Beast Alexander, Gladiator Beast Andal
     CardId == 41470137 or CardId == 25924653 or   -- Gladiator Beast Bestiari, Gladiator Beast Darius
     CardId == 31247589 or CardId == 57731460 or   -- Gladiator Beast Dimacari, Gladiator Beast Equeste
     CardId == 73285669 or CardId == 90957527 or   -- Gladiator Beast Essedarii, Gladiator Beast Gaiodiaz
     CardId == 48156348 or CardId == 27346636 or   -- Gladiator Beast Gyzarus, Gladiator Beast Heraklinos
     CardId == 04253484 or CardId == 02067935 or   -- Gladiator Beast Hoplomus, Gladiator Beast Lanista
     CardId == 78868776 or CardId == 05975022 or   -- Gladiator Beast Laquari, Gladiator Beast Murmillo
     CardId == 29590752 or CardId == 00612115 or   -- Gladiator Beast Octavius, Gladiator Beast Retiari
     CardId == 02619149 or CardId == 77642288 or   -- Gladiator Beast Samnite, Gladiator Beast Secutor
     CardId == 79580323 or CardId == 65984457 or   -- Gladiator Beast Spartacus, Gladiator Beast Torax
     CardId == 50893987 and                        -- Gladiator Beast Tygerius
     (AIMon[i].position == POS_FACEUP_ATTACK or AIMon[i].position == POS_FACEUP_DEFENSE) then
    return 1
     end
      end
    end
  end
  return 0
end

--------------------------------
-- Checks if the card's ID is of
-- a main deck Nordic monster.
--------------------------------
function IsNordicMonster(CardId)
  if IsNordicTuner(CardId) == 1 then
    return 1
  end
  if CardId == 13455953 or CardId == 88283496 or   -- Dverg, Garmr
     CardId == 40666140 or CardId == 76348260 or   -- Ljosalf, Mimir
     CardId == 15394083 or CardId == 14677495 or   -- Tanngrisnir,Tanngnjostr
     CardId == 02333365 then                       -- Tyr
    return 1
  end
  return 0
end


-------------------------------------------------------
-- Checks if the card's ID is a Dark World monster that
-- has an effect that activates when it is discarded
-- by an effect controlled by the AI.
-------------------------------------------------------
function IsDiscardEffDWMonster(CardId)
  if CardId == 33731070 or CardId == 79126789 or   -- Beiige, Broww
     CardId == 07623640 or CardId == 78004197 or   -- Ceruli, Goldd
     CardId == 34230233 or CardId == 51232472 or   -- Grapha, Gren
     CardId == 25847467 or CardId == 15667446 or   -- Kahkki, Latinum
     CardId == 32619583 or CardId == 60228941 then -- Sillva, Snoww
    return 1
  end
  return 0
end


--------------------------------
-- Checks if the card's ID is an
-- Elemental HERO monster.
--------------------------------
function IsEHeroMonster(CardId)
  if IsEHeroMainDeckMonster(CardId) == 1 or
     IsEHeroFusionMonster(CardId) == 1 then
    return 1
  end
  return 0
end


------------------------------------
-- Checks if the card's ID is a
-- main deck Elemental HERO monster.
------------------------------------
function IsEHeroMainDeckMonster(CardId)
  if CardId == 21844576 or CardId == 59793705 or   -- Avian, Bladedge
     CardId == 79979666 or CardId == 58932615 or   -- Bubbleman, Burstinatrix
     CardId == 80908502 or CardId == 84327329 or   -- Captain Gold, Clayman
     CardId == 69572169 or CardId == 98266377 or   -- Flash, Heat
     CardId == 41077745 or CardId == 62107981 or   -- Ice Edge, Knospe
     CardId == 95362816 or CardId == 89252153 or   -- Lady Heat, Necroshade
     CardId == 05285665 or CardId == 89943723 or   -- Neo Bubbleman, Neos
     CardId == 69884162 or CardId == 37195861 or   -- Neos Alius, Ocean
     CardId == 51085303 or CardId == 89312388 or   -- Poison Rose, Prisma
     CardId == 20721928 or CardId == 40044918 or   -- Sparkman, Stratos
     CardId == 09327502 or CardId == 86188410 or   -- Voltic, Wildheart
     CardId == 75434695 then                       -- Woodsman
    return 1
  end
  return 0
end

---------------------------------
-- Checks if the card's ID is an
-- Elemental HERO fusion monster.
---------------------------------
function IsEHeroFusionMonster(CardId)
  if CardId == 40854197 or CardId == 11502550 or   -- Absolute Zero, Air Neos
     CardId == 55171412 or CardId == 17032740 or   -- Aqua Neos, Chaos Neos
     CardId == 28677304 or CardId == 41517968 or   -- Dark Neos, Darkbright
     CardId == 31111109 or CardId == 29343734 or   -- Divine Neos, Electrum
     CardId == 33574806 or CardId == 35809262 or   -- Escuridao, Flame Wing
     CardId == 81566151 or CardId == 16304628 or   -- Flare Neos, Gaia
     CardId == 85507811 or CardId == 48996569 or   -- Glow Neos, Grand Neos
     CardId == 03642509 or CardId == 68745629 or   -- Great Tornado, Inferno
     CardId == 78512663 or CardId == 05128859 or   -- Magma Neos, Marine Neos
     CardId == 14225239 or CardId == 52031567 or   -- Mariner, Mudballman
     CardId == 81003500 or CardId == 72926163 or   -- Necroid Shaman, Neos K
     CardId == 01945387 or CardId == 41436536 or   -- Nova Master, Phoenix E
     CardId == 60493189 or CardId == 47737087 or   -- Plasma Vice, Rampart B
     CardId == 25366484 or CardId == 88820235 or   -- Sh.Flare, Sh.Phoenix
     CardId == 81197327 or CardId == 49352945 or   -- Steam Healer,Storm Neos
     CardId == 83121692 or CardId == 74711057 or   -- Tempest, Terra Firma
     CardId == 22061412 or CardId == 61204971 or   -- The Shining, Thunder G
     CardId == 13293158 or CardId == 55615891 or   -- Wild Cyclone, Wild Wing
     CardId == 10526791 then                       -- Wildedge
    return 1
  end
  return 0
end


-----------------------------
-- Checks if the card's ID is
-- a Synchron tuner monster.
-----------------------------
function IsSynchronTunerMonster(CardId)
  if CardId == 52840598 or CardId == 25652655 or   -- Bri, Changer
     CardId == 56286179 or CardId == 19642774 or   -- Drill, Fleur
     CardId == 50091196 or CardId == 40348946 or   -- Formula, Hyper
     CardId == 63977008 or CardId == 56897896 or   -- Junk, Mono
     CardId == 96182448 or CardId == 20932152 or   -- Nitro, Quickdraw
     CardId == 71971554 or CardId == 83295594 or   -- Road, Steam
     CardId == 67270095 or CardId == 15310033 then -- Turbo, Unknown
    return 1
  end
  return 0
end


--------------------------
-- Checks if the card's ID
-- is a Synchron monster.
--------------------------
function IsSynchronMonster(CardId)
  if IsSynchronTunerMonster(CardId) == 1 or
     CardId == 36643046 then                -- Synchron Explorer
    return 1
  end
  return 0
end


-----------------------------
-- Checks if the card's ID is
-- a Destiny HERO monster.
-----------------------------
function IsDHeroMonster(CardId)
  if CardId == 55461064  or CardId == 77608643 or    -- Blade M, Captain T
     CardId == 100000275 or CardId == 81866673 or    -- Celestial, Dasher
     CardId == 54749427  or CardId == 39829561 or    -- Defender, Departed
     CardId == 13093792  or CardId == 56570271 or    -- Diamond Dude, Disc
     CardId == 17132130  or CardId == 41613948 or    -- Dogma, Doom Lord
     CardId == 28355718  or CardId == 36625827 or    -- Double, Dread Serv
     CardId == 80744121  or CardId == 09411399 or    -- Fear Monger, Mali
     CardId == 83965310  or CardId == 100000274 then -- Plasma, The Dark A
    return 1
  end
  return 0
end


------------------------------------
-- Checks if every card in the index
-- is that of a specified archetype.
------------------------------------
function AllCardsArchetype(Cards,SetCode)
  for i=1,#Cards do
    if Cards[i] ~= false then
      if Cards[i].setcode ~= SetCode then
        return 0
      end
    end
  end
  return 1
end
