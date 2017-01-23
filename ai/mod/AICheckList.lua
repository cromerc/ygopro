---------------------------------------
-- AICheckList.lua
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
  if CardId == 31305911 or CardId == 34408491 or CardId == 69031175 -- Marshmallon, Beelze, BW Armor Master
  or CardId == 31764700 or CardId == 04779091 or CardId == 78371393 -- the 3 Yubel forms
  or CardId == 74530899 or CardId == 23205979 or CardId == 62892347 -- Metaion, Spirit Reaper, AF - The Fool
  then 
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
     CardId == 38495396 or CardId == 01662004 then  -- Constellar Ptolemy M7, FireFist Spirit  
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
  local AIMons  = AI.GetAIMonsterZones()
  for i=1,#AIMons do
  if AIMons[i] ~= false then
  if AIMons[i].id == CardId then
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
     (AIMons[i].position == POS_FACEUP_ATTACK or AIMons[i].position == POS_FACEUP_DEFENSE) then
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

---------------------------------------------------------
-- Checks if the specified card ID is in this "blacklist"
-- of cards to never normal summon or set, and returns
-- True or False depending on if it's in the list.
---------------------------------------------------------
NSBL={
   -- 
19665973,98777036,50933533,18964575, -- Battle Fader, Trag,AGG Dragon, Scarecrow
53804307,89399912,44330098,26400609, -- Blaster, Tempest,Gorz, Tidal
53797637,89185742,90411554,27415516, -- Burner, Lightning,Redox, Stream
07902349,70903634,91020571,33396948, -- Left Arm, Right Arm,Reactan, Exodia
70095154,88264978,44519536,08124921, -- CyDra, REDMD,Left Leg, Right Leg
74530899,37742478,83039729,63176202, -- Metaion, Honest,Grandmaster, Shogun                   
40240595,40640057,75498415,51945556, -- Cocoon of Evolution, Kuriboh,Sirocco, Zaborg the Thunder Monarch 
74131780,91949988,57116033,00423585, -- Exiled Force, Gaia Dragon, Winged Kuriboh, Summoner Monk 
45812361,37742478,09748752,78364470, -- Cardcar D, Honest, Caius the Shadow Monarch, Constellar Pollux
66762372,92572371,23434538,03534077, -- Boar, Buffalo, Maxx "C", Wolfbark
01662004,06353603,43748308,39699564, -- Spirit, Bear, Dragon, Leopard
44860890,93294869,70355994,17475251, -- Raven, Wolf, Gorilla, Hawk
80344569,30929786,97268402,41269771, -- Neo-Spacian Grand Mole, FF Chicken, Effect Veiler, Constellar Algiedi
87255382,19310321,82293134,60316373, -- Amphisbaena, Twin Eagle, Heraldic Beasts: Leo, Aberconway
56921677,86445415,45705025,82315772, -- Basilisk, Red Gadget, Unicorn, Eale
42940404,05556499,41172955,13839120, -- Machina Gearframe, Machina Fortress, Green Gadget, Yellow Gadget
53573406,32339440,39284521,18063928, -- Masked Chameleon, Bujin Yamato, Machina Cannon, Tin Goldfish
68601507,59251766,53678698,23979249, -- Bujin Crane, Hare, Bujin Mikazuchi, Arasuda
88940154,50474354,05818294,69723159, -- Centipede, Peacock, Turtle, Quilin
21954587,22446869,37104630,00706925, -- Mermail AbyssMegalo, Mermail Abyssteus, Atlantean Heavy Infantry, Atlantean Marksman
58471134,22076135,37781520,74311226, -- Mermail Apysspike, Mermail Abyssturge, Mermail Abyssleed, Atlantean Dragoons
78868119,26400609,23899727,74298287, -- Deep Sea Diva, Tidal, Dragon Ruler of Waterfalls Mermail Abysslinde, Mermail Abyssdine
30328508,77723643,37445295,04939890, -- Shaddoll Lizard, Shaddoll Dragon, Shaddoll Falcon, Shaddoll Hedgehog
85103922,12697630,03717252,24062258, -- Artifact Moralltach, Artifact Beagalltach, Shaddoll Beast, Secret Sect Druid Dru
75878039,02273734,38667773,63274863, -- Satellarknights Deneb,Altair,Vega,Sirius
38331564,91110378,69293721,99365553, -- Star Seraphs Scepter,Sovereign,Mermail Abyssgunde, Lightpulsar
77558536,22624373,95503687,16404809, -- LS Raiden, Lyla, Lumina, Kuribandit
33420078,51858306,10802915,16178681, -- Plaguespreader, Eclipse Wyvern, Tour Guide,Odd-Eyes Pendulum Dragon
04904812,68505803,91812341,45803070, -- Genex Undine, Genex Controller, Traptrix Myrmeleo, Dioena
68535320,95929069,84764038,43241495, -- Fire Hand, Ice Hand, Burning Abyss Scarm, Performapal Trampolynx
65518099,90885155,64496451,91907707, -- Qliphort Tool, Shell, Disk, Archive
27279764,37991342,03580032,30575681, -- Qliphort Killer, Genome, Noble Knight Merlin, Bewdyr
95772051,93085839,19680539,53550467, -- Black Sally, Eachtar, Gawayn, Drystan
59057152,47120245,13391185,57690191, -- Medraut, Borz, Chad, Brothers
19748583,10736540,92125819,73359475, -- Gwen, Lady, Artorigus, Peredur
90307777,08903700,95492061,23401839, -- Shrit, Caster of Nekroz, Djinn Releaser of Rituals, Manju, Senju 
13974207,57143342,73213494,47728740, -- Denkou Sekka, BA Cir, Calcab, Alich
20758643,00734741,36553319,09342162, -- BA Graff, Rubic, Farfa, Cagna
62957424,52738610,30312361,41386308, -- BA Libic, Necroz Dance Princess, Phantom of Chaos, Mathematician
34230233,60228941,33731070,79126789, -- DW Grapha, Snoww, Beiige, Broww
94283662,20292186,70908596,78364470, -- Trance Archfiend, Artifact Scythe, Constellar Kaus, Pollux
41269771,78358521,81105204,58820853, -- Constellar Algiedi, Sombre, BW Kris, Shura
49003716,14785765,85215458,02009101, -- BW Bora, Zephyros, Kalut, Gale
55610595,28190303,22835145,73652465, -- BW Pinaka, Gladius, Blizzard, Oroshi
75498415,72714392,24508238,76812113, -- BW Sirocco, Vayu, D.D. Crow, Harpie Lady
75064463,80316585,56585883,90238142, -- Harpie Queen, Cyber, Harpist, Channeler
91932350,68815132,89399912,52040216, -- Harpie Lady #1, Dancer, Tempest, Pet Dragon
69884162,25259669,63060238,50720316, -- Neos Alius, Goblindbergh, Blazeman,Shadow Mist
79979666,21565445,47826112,13073850, -- Bubbleman, Atlantean Neptabyss, Poseidra, Qli Stealth
51194046,18326736,58069384,10443957, -- Qli Monolith, Planetellarknight Ptolemaios, Cyber Dragon Nova, Infinity
81992475,59438930,01050186,16947147, -- BA Barbar, Ghost Ogre, Satellarknight Unukalhai, Speedroid Menko
29888389,47106439,53180020,27796375, -- Gishki Shadow, Vision, Nekroz Exa, Sorcerer
67696066,68819554,44635489, -- Trick Clown, Damage Juggler, Siat
81275020,53932291, -- Speedroid Terrortop, Taketomborg
}
function NormalSummonBlacklist(CardId) 
  for i=1,#NSBL do
    if NSBL[i]==CardId then
      return 1
    end
  end
  return 0
end

------------------------------------------------
-- Checks if the card ID is in this "whitelist"
-- of cards to always normal summon, and returns
-- True or False depending on the result.
------------------------------------------------
function NormalSummonWhitelist(CardId)
  if CardId == 88241506 or                          -- Blue-Eyed Maiden
     CardId == 03657444 or CardId == 93816465  then -- Cyber Valley, 0 Gardna
    return 1
  end
  return 0
end

---------------------------------------------------
-- Prefer monsters that benefit from being tributed
---------------------------------------------------
function TributeWhitelist(id)
  if id == 03300267 or id == 77901552 -- Hieratic Dragons of Su, Tefnuit,
  or id == 31516413 or id == 78033100 -- Eset, Gebeb
  then
    return 1
  end
  return 0
end

---------------------------------------------------------
-- Checks if the specified card ID is in this "blacklist"
-- of cards to never special summon, and returns
-- True or False depending on if it's in the list.
---------------------------------------------------------
function SpecialSummonBlacklist(CardId)
  for i=1,#SSBL do
    if SSBL[i]==CardId then
      return 1
    end
  end
  return 0
end

SSBL={
01710476,00598988,09433350, -- Sin End, Sin Bow, Sin Blue
36521459,55343236,95992081, -- Sin Dust, Sin Red, Leviair
80117527,34230233,33347467, -- No.11, Grapha, Ghost Ship
41269771,48579379,14536035, -- Constellar Algiedi, PU Great Moth, Dark Grepher
72989439,09596126,99365553, -- BLS, Chaos Sorcerer, Lightpulsar
98012938,58504745,96381979, -- Vulcan, Cardinal, Tiger King
74168099,37057743,88264978, -- Horse Prince, Lion Emperor, REDMD 
47387961,23649496,02407234, -- Number 8, Number 18, Number 69
47387961,23649496,02407234, -- Number 8, Number 18, Number 69
11398059,22653490,34086406, -- King of the Feral Imps, Chidori, Lavalval Chain
12014404,46772449,48739166, -- Gagaga Cowboy, Evilswarm Exciton Knight, SHArk Knight
89856523,38495396,94380860, -- Kirin, Constellar Ptolemy M7, Ragna Zero
61344030,82315772,28912357, -- Starliege Paladynamo, Heraldic Beast Eale, Gear Gigant X
80117527,22110647,88033975, -- Number 11: Big Eye, Mecha Phantom Beast Dracossack, Armades, Keeper of Boundaries
33198837,83994433,76774528, -- Naturia Beast, Stardust Spark Dragon, Scrap Dragon
05556499,39284521,39765958, -- Machina Fortress, Machina Cannon, Jeweled RDA
09418365,68618157,75840616, -- Bujin Hirume, Amaterasu, Susanowo
01855932,73289035,26329679, -- Bujin Kagutsuchi, Tsukuyomi, Constellar Omega
21044178,00440556,59170782, -- Abyss Dweller, Bahamut Shark, Mermail Abysstrite
15914410,50789693,65749035, -- Mechquipped Angineer, Armored Kappa, Gugnir, Dragon of  the Ice Barrier
95169481,70583986,74371660, -- Diamond Dire Wolf, Dewloren Tiger King of the Ice Barrier, Mermail Abyssgaios
73964868,29669359,82633039, -- Pleiades, Volcasaurus, Skyblaster Castel
00581014,33698022,04779823, -- Emeral, Moonlight Rose, Michael
31924889,08561192,63504681, -- Arcanite Magician, Leoh, Rhongomiant
93568288,56638325,42589641, -- Number 80,Delteros, Triveil
17412721,38273745,21501505, -- Noden, ouroboros, Cairngorgon
34408491,15561463,07391448, -- Beelze, Gauntlet Launcher, Goyo Guardian
61901281,99234526,84764038, -- Collapserpent, Wyverbuster, Scarm
25460258,65192027,91499077, -- Darkflare Dragon, Dark Armed Dragon, Gagaga Samurai
63746411,83531441,16178681, -- Giant Hand, Dante,Odd-Eyes Pendulum Dragon
65518099,90885155,64496451, -- Qliphort Tool, Shell, Disk
91907707,27279764,37991342, -- Qliphort Archive, Killer, Genome
43241495,19680539,44505297, -- Performapal Trampolynx, Noble Knight Gawayn,Inzektor Exa-Beetle
48009503,60645181,82944432, -- HC - Gandiva, Excalibur, Blade Armor Ninja
21223277,10613952,83519853, -- R4torigus, R5torigus, High Sally 
08809344,95113856,31563350, -- Outer God Nyarla, Phantom Fortress Enterblathnir, Zubaba General
00601193,72167543,81330115, -- BA Virgil, Downerd Magician, Acid Golem of Destruction
31320433,47805931,75367227, -- Nightmare Shark, Giga-Brillant, Ghostrick Alucard
68836428,52558805,78156759, -- Tri-Edge Levia, Temptempo the Percussion Djinn, Wind-Up Zenmaines
16259549,51617185,16195942, -- Fortune Tune, Machina Megaform, Dark Rebellion Dragon
26563200,82044279,73445448, -- Muzurythm, Clear Wing Synchro Dragon, Zombiestein
01639384,10406322,66547759, -- Felgrand, Sylvan Alsei, Lancelot
88120966,78156759,31386180, -- Giant Grinder, Zenmaines, Tiras
84013237,56832966,31437713, -- Utopia, Utopia Lightning, Heartlanddraco
81983656,69031175,95040215, -- BW Hawk Joe, Armor Master, Nothung
73347079,81105204,49003716, -- Force Strix, BW Kris, Bora
02009101,28190303,73652465, -- BW Gale, Gladius, Oroshi
73580471,76067258,52687916, -- Black Rose, Master Key Beetle, Synch Trishula
27315304,33236860,09012916, -- Mist Wurm, BW Silverwing, Black Winged Dragon
23693634,50321796,76913983, -- Colossal Fighter, Synch Brionac, BW Armed Wind
90953320,26593852,44508094, -- Hyper Librarian, Catastor, Stardust
85909450,86848580,79979666, -- HPPD, Zerofyne, Bubbleman
13959634,55863245,06511113, -- Moulinglacia, Child Dragon, Rafflesia
18326736,58069384,10443957, -- Planetellarknight Ptolemaios, Cyber Dragon Nova, Infinity
27552504,18386170,65305468, -- Beatrice, Pilgrim, F0
56840427,16051717,30100551, -- Utopia Ray, Raikiri, Minerva
31292357,44635489,01621413, -- Hat Tricker, Siat, Requiem Dragon
81275020,53932291,91949988, -- Speedroid Terrortop, Taketomborg, Gaia Dragon
85115440,48905153, -- Zodiac Beast Drancia,Bullhorn
}


---------------------------------------------------------
-- Checks if the specified card ID is in this "blacklist"
-- of cards to never set in the Spell&Trap zone
---------------------------------------------------------
function SetBlacklist(CardId)
  for i=1,#SetBL do
    if SetBL[i]==CardId then
      return 1
    end
  end
  return 0
end

SetBL={
  61314842,92365601,84220251, -- Advanced Heraldry Art, Rank-Up Magic - Limited Barian's Force, Heraldry Reborn
  73906480,96947648,74845897, -- Bujincarnation, Salvage, Rekindling
  54447022,44394295,55742055, -- Soul Charge, Shaddoll Fusion, Table
  07452945,14745409,23562407, -- Noble Arms Destiny, Gallatin, Caliburn
  46008667,83438826,66970385, -- Excaliburn, Arfeudutyr, Chapter
  92512625,51124303,14735698, -- Advice, Nekroz Kaleidomirror, Exomirror
  96729612,97211663,45986603, -- Preparation of Rites, Nekroz Cycle, Snatch Steal
  12580477,27174286,19337371, -- Raigeki, RftDD, Hysteric Sign
}


function RepositionBlacklist(id)
  for i=1,#RepoBL do
    if RepoBL[i]==id then
      return 1
    end
  end
  return 0
end
RepoBL={
  37445295,04939890,30328508, -- Shaddoll Falcon,Hedgehog,Lizard
  77723643,03717252,21502796, -- Shaddoll Dragon, Beast,Ryko
  23899727,88241506,15914410, -- Mermail Abysslinde, Blue-Eyes Maiden, Mechquipped Angineer
  23232295,85909450,83531441, -- Lead Yoke, HPPD, Dante
  65305468, --F0
}
---------------------------------------------------------
-- Checks if the specified card ID is in this "blacklist"
-- of cards to never negate on the field via cards like
-- Effect Veiler or Breakthrough Skill
---------------------------------------------------------
NegBL={
  53804307,26400609,89399912,90411554 -- the 4 Dragon Rulers
}
function NegateBlacklist(id)
  for i=1,#NegBL do
    if NegBL[i]==id then
      return true
    end
  end
  if id == 00423585 -- negate Summoner Monk only, when he tries to special summon something
  and not Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_SPECIAL_SUMMON) then
    return true
  end
  return false
end

-- for cards like Solemn Warning
EffNegBL={
  70368879,32807846,12538374, -- Upstart, RotA, Treeborn
  19748583,98645731,81439173, -- Gwen, Duality, Foolish
  75500286, -- Gold Sarc
}

function ToHandBlacklist(id) -- cards to not return to your opponent's hand 
  for i=1,#ToHandBL do
    if ToHandBL[i]==id then
      return true
    end
  end
  return false
end

ToHandBL={
  70095154,57774843,92841002, -- Cyber Dragon, JD, Mythic Water Dragon
  77901552  -- Tefnuit
}

function DestroyBlacklist(c) -- cards to not destroy in your opponent's possession
  local AICard = true
  local id = nil
  local faceup
  if c.GetCode then
    AICard = false
    id = c:GetCode()
    faceup = c:IsPosition(POS_FACEUP)
    if c:IsSetCard(0x97) and c:GetOwner()==1-player_ai 
    and Duel.GetTurnPlayer()==player_ai and c:IsLocation(LOCATION_SZONE)
    then
      return true
    end
  else
    id = c.id
    faceup = FilterPosition(c,POS_FACEUP)
    if IsSetCode(c.setcode,0x97) and c.owner==2 
    and Duel.GetTurnPlayer()==player_ai and bit32.band(c.location,LOCATION_SZONE)>0
    then
      return true
    end
  end
  for i=1,#DestroyBL do
    if DestroyBL[i]==id then
      return true
    end
  end
  if id == 68535320 and #AIMon()>0 
  and MacroCheck(2)
  then -- Fire Hand
    return true
  end
  if id == 95929069 and #AIST()>0 
  and MacroCheck(2)
  then -- Ice Hand
    return true
  end
  return false
end

DestroyBL={
  19337371,29223325,12444060, -- Hysteric Sign, Artifact Ignition, Sanctum,
}

function IgnoreList(c) -- cards to ignore with removal effects
  local id = nil      -- until other targets have been dealt with 
  local faceup = FilterPosition(c,POS_FACEUP)
  if c.GetCode then
    id = c:GetCode()   
  else 
    id = c.id
  end
  if FilterSet(c,0x7c)  -- Fire Formation
  and faceup
  then
    return true
  end
  if FilterSet(c,0x207a) -- Noble Arms
  and id~=46008667      -- except Excaliburn
  and faceup
  and MacroCheck(2)
  then 
    return true
  end
  if id==67237709 --Kozmotown
  and faceup
  and MacroCheck(2)
  --and HasID(OppDeck(),67237709,true) -- TODO: find non-cheating check
  then 
    return true
  end
  if id==05851097 -- Vanity's Emptiness
  and faceup  -- hit other cards first to trigger selfdestruct
  then 
    return true
  end
  if (id == 97077563 -- CotH
  or id == 50078509) -- Fiendish Chain
  and FilterPosition(c,POS_FACEUP)
  and CardTargetCheck(c)==0 then
    return true
  end
  if id == 07563759 -- Flame Mascot
  and MacroCheck(2)
  then
    return true
  end
  if id == 56111151 -- Kyotou Waterfront
  and c:get_counter(0x37)>0
  then
    return true
  end
  for i=1,#Ignore do
    if Ignore[i]==id then
      return true
    end
  end
  return false
end

Ignore={
}
-----------------------------------------------------
-- Checks if the card's ID is in a list of spell/trap
-- cards that work well when multiple copies are
-- activated in the same chain.
-----------------------------------------------------
function MultiActivationOK(CardId)
  if CardId == 39526584 or CardId == 21466326 or   -- Gift Card, Blast Ruins
     CardId == 50470982 or CardId == 18807108 then -- The Paths of Destiny
    return 1
  end
  return 0
end

-----------------------------------------------------
-- List of cards that shouldn't be activated when Necrovalley is on field.
-----------------------------------------------------
function isUnactivableWithNecrovalley(CardId)
  if CardId == 83764718 or --Reborn
     CardId == 97077563 or --Call of the Haunted
     CardId == 67169062 or --Pot of Adarice
     CardId == 95503687 or --Lumina
     CardId == 74848038 or --Monster-Reinkarnation
     CardId == 61962135 or --Glourise Illusion
     CardId == 45906428 or --Miraclefusion
     CardId == 37412656 or --Hero Blast
     CardId == 13391185 or --Noble Knight Gwalchavad
     CardId == 14943837 or --Debris Dragon
     CardId == 30312361 or --Phantom of Chaos
     CardId == 13504844 or --Gottoms`Emercency Call
     CardId == 02204140 or --Book of Life
     CardId == 17259470 then -- Zombymaster
    return 1
  end
  return 0
end

function NecrovalleyCheck(c)
  local id
  if c.GetCode then
    id = c:GetCode()
  else
    id = c.id
  end
  if HasID(Field(),47355498,true) then
    return isUnactivableWithNecrovalley(id)==0
  end
  return true
end

-----------------------------------------------------
-- List of cards that shouldn't be activated in a same chain
-----------------------------------------------------
Unchainable={ 
44095762,70342110,56120475,73964868, -- Mirror force, DPrison, Sakuretsu, Pleiades
55713623,08698851,21481146,62271284, -- Shrink, D-Counter, Radiant mirror force,Justi-breal
77754944,79178930,89041555,73178098, -- Widespread RuinKarakuri klock, Blast held by a tribut, Ego boost
10759529,25642998,29590905,43250041, -- Kid Guard,Poseidon wave,Super junior confrontation,Draining shiled
43452193,57115864,60080151,62279055, -- Mirrot Gate, Lumenize, Memory of an adversary, Magic Cylinder
75987257,23171610,37390589,01005587, -- Butterflyoke, Limiter Removal, Kunai with Chain, Void Trap Hole
04206964,28654932,94192409,29401950, -- Trap hole, Deep dark trap hole, Compulsory Evacuation Device, Bottomless trap hole
62325062,80723580,99590524,11593137, -- Adhesion, Giant, Treacherous, Chaos trap hole
19230407,33846209,04178474,15083728, -- Offerings to the doomed, Gemini spark, Raigeki-breaker, House of adhesive tape
30127518,39765115,42578427,46656406, -- Dark trap hole, Splash capture, Eatgaboon, Mirror of oaths
58990631,72287557,86871614,84749824, -- Automatic laser, Chthonian Polymer, Cloning, Solem warning
37412656,19665973,18964575,29223325, -- Hero blast, Battle Fader, Swift Scarecrow, Artifact Ignition
12444060,85103922,12697630,77505534, -- Artifact Sanctum, Moralltach, Beagalltach, Facing the Shadows
05318639,53582587,97077563,14087893, -- Mystical Space Typhoon, Torrential tribute, Call of the Haunted, Book of Moon
78474168,50078509,29616929,19748583, -- Breakthrough Skill, Fiendish Chain, TTHN, Gwen
25789292,36006208,71587526,63356631, -- Forbidden Chalice, Fire Lake, Karma Cut, PWWB
25857246,74122412,99185129,56574543, -- Nekroz Valkyrus, Nekroz Gungnir, Nekroz Clausolas, Bujingi Sinyou
59251766,37742478,41930553,20292186, -- Bujingi Hare, Honest, Dark Smog, Artifact Scythe
38296564,53567095,72930878,81983656, -- Safe Zone, Icarus, Black Sonic, BW Hawk Joe
85215458,24508238,59616123,27243130, -- BW Kalut, D.D. Crow, Trap Stun, Forbidden lance
77778835,21143940,84536654,57728570, -- Hysteric Party, Mask Change, Form Change, CCV
83555666,88197162,24348807,21143940, --  Ring of Destruction, Soul Transition, Lose a turn, Mask Change
84536654,50608164,06511113,30575681, -- Form Change, Koga, Rafflesia, Treacherous, Bedwyr
27552504,18386170,60743819,20036055, -- Beatrice, Pilgrim, Fiend Griefing, Traveler
36553319,65305468,20513882,31222701, -- Farfa, F0, Painful Escape, Wavering Eyes
43898403,60082869,83326048,69599136, -- Twin Twister, Dust Tornado, Dimensional Barrier, Floodgate Trap Hole
16947147,08267140, -- Speedroid Menko, Cosmic Cyclone
}
function isUnchainableTogether(CardId)
  for i=1,#Unchainable do
    if Unchainable[i] == CardId then
      return 1
    end
  end
  return 0
end

function UnchainableCheck(id)
  local e = nil
  if type(id)=="table" then
    id=id.id
  end
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and isUnchainableTogether(e:GetHandler():GetCode())>0 
    and e:GetHandlerPlayer()==player_ai
    then
      return isUnchainableTogether(id)==0;
    end
  end
  return true
end

----------------------------------------------------
-- Checks if the selected card searches the deck for
-- another card, simply by comparing it to a list of
-- often-used search cards. A work-in-progress, but
-- it gets the job done for now.
----------------------------------------------------
function CardIsASearchCard(CardId)
  local Result = 0
  if CardId == 73628505 or --CardId == 32807846 or   -- Terraforming, ROTA
     --[[CardId == 00213326 or]] CardId == 25377819 or   -- E-Call, Convocation
     CardId == 54031490 or CardId == 94886282 or   -- SSS, Charge
     CardId == 96363153 or --CardId == 57103969 or   -- Tuning, FF Tenki
     CardId == 74968065 or CardId == 12171659 or   -- Hecatrice, Zeradias
     CardId == 17393207 or CardId == 51435705 or   -- Commandant, Skull
     --[[CardId == 75064463 or]] CardId == 48675364 or   -- Harpie Q, ArchF Gen
     CardId == 03431737 or CardId == 43797906 or   -- Assault B, Atlantis
     CardId == 89739383 or CardId == 89997728 then -- Secrets, Toon Table
    Result = 1
  end
  return Result
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

---
-- List of mandatory effects the AI might skip otherwise
---
Mandatory={
53804307,26400609,89399912,90411554, -- Blaster, Tidal, Tempest, Redox
78156759 -- Zenmaines
}
function MandatoryCheck(c)
  if Duel.GetCurrentPhase()==PHASE_END and c 
  and IsSetCode(c.setcode,0x38) 
  and FilterLocation(c,LOCATION_MZONE) 
  then --Lightsworn monsters
    return true
  end
  for i=1,#Mandatory do
    if c and Mandatory[i]==c.id then
      return true
    end
  end
  return false
end

----------------------------------------------------
-- Checks if the selected card is already scripted 
-- in "OnSelectInitCommand", "SelectChain" functions.
----------------------------------------------------
ScriptedCards ={
27970830,54031490,15259703,79875176,  -- Gateway of the Six, Shien's Smoke Signal, Toon World, Toon Cannon Soldier 
58775978,82878489,41426869,14536035,  -- Nightmare's Steelcage, Shine Palace,Black Illusion Ritual, Dark Grepher
33420078,09411399,65192027,15561463,  -- Plaguespreader Zombie, Malicious, Dark Armed Dragon, Gauntlet Launcher
06353603,73964868,38495396,44635489,  -- Fire Fist - Bear, Constellar Pleiades,Ptolemy M7, Siat
70908596,41142615,68597372,47217354,  -- Constellar Kaust, The Cheerful CoffinWind-Up Zenmaister, Fabled Raven
74131780,36916401,12014404,34086406,  -- Exiled Force, Burnin' Boxin' Spirit,Gagaga Gunman, Lavalval Chain
00423585,40640057,95727991,71413901,  -- Summoner Monk, Kuriboh,Catapult Turtle, Breaker the Magical Warrior
83133491,18807108,87880531,72302403,  -- Zero Gravity, Spellbinding Circle,Diffusion Wave-Motion, Swords of Revealing Light
83746708,25774450,78156759,72892473,  -- Mage Power, Mystic Box,Wind-Up Zenmaines, Number 61: Volcasaurus		   
72892473,72892473,22110647,16435215,  -- Tiras, Card Destruction,Dracossack, Dragged Down into the Grave		   
93554166,74117290,81439173,40240595,  -- Dark World Lightning, Dark World Dealingd,Foolish Burial, Cocoon of Evolution		    		   
72989439,23265313,68005187,98045062,  -- Black Luster Soldier - Envoy of the Beginning, Cost Down,Soul Exchange, Enemy Controller		   
55713623,05758500,43973174,22046459,  -- Shrink, Soul Release,The Flute of Summoning Dragon, Megamorph		   
46910446,12607053,70231910,59385322,  -- Chthonian Alliance, Waboku	,Dark Core, Core Blaster	   
46009906,91595718,27174286,94192409,  -- Beast Fangs, Book of Secret Arts,Return from the Different Dimension, Compulsory Evacuation Device            
19596712,72932673,53610653,69243953,  -- Abyss-scale of Cetus, Abyss-scale of the Mizuchi,Bound Wand, Butterfly Dagger - Elma         
63851864,88190790,08719957,86198326,  -- Break! Draw!, Assault Armor, Abyss-scale of the Kraken, 7 Completed          
40830387,37457534,79965360,84740193,  -- Ancient Gear Fist, Ancient Gear Tank,Amazoness Heirloom, Buster Rancher             
05183693,90374791,00303660,53586134,  -- Amulet of Ambition, Armed Changer,Amplifier, Bubble Blaster          
65169794,40619825,00242146,61127349,  -- Black Pendant, Axe of Despair,Ballista of Rampart Smashing, Big Bang Shot                
50152549,41587307,18937875,24668830,  -- Paralyzing Potion, Broken Bamboo Sword,Burning Spear, Germ Infection           
75560629,39897277,46967601,56948373,  -- Flint, Elf's Light,Cursed Bill, Mask of the accursed       
53129443,07165085,05318639,19613556,  -- Dark Hole, Bait Doll, Mystical Space Typhoon, Heavy Storm           
31036355,93816465,09596126,01475311,  -- Swap, Zero Gardna,Chaos Sorcerer, Allure of darkness        
53567095,74848038,04178474,16255442,  -- Icarus, Monster Reincarnation,Raigeki Break, Beckoning                  
47387961,82732705,95503687,22624373,  -- #8 Genome,Skill Drain,Lumina, Lyla         
51452091,10026986,37742478,94283662,  -- Royal Decree, Worm King,Honest, Trance         
57774843,53582587,55794644,500000090, -- Judgment Dragon, Torrential Tribute,Hyperion, Toon Kingdom 
41420027,84749824,84013237,96216229,  -- Solemn Judgment, Solemn WarningNumber 39: Utopia, Gladiator Beast War Chariotthen
61257789,35952884,44508094,58120309,  -- Stardust Dragon/Assault Mode, Shooting Quasar DragonStardust Dragon, Starlight Road
50078509,14315573,24696097,50091196,  -- Fiendish Chain, Negate AttackShooting Star Dragon,Formula Synchron   
44095762,67987611,29267084,59616123,  -- Mirror Force, Amazoness ArchersShadow Spell, Trap Stun	 
70355994,10719350,39699564,30929786,  -- FireFormation Tenken, FireFist GorillaFireFist Leopard, Chicken
21350571,23434538,44920699,70329348,  -- Horn of the Phantom Beast, Maxx "C"FireFormation Tensen 
43748308,97268402,96381979,19059929,  -- FireFist Dragon, Effect VeilerFireFist Tiger King, FireFormation Gyokko
58504745,36499284,92572371,78474168,  -- FireFist Cardinal, FireFormation YokoFireFist Buffalo, Breakthrough Skill
46772449,58504745,77538567,70342110,  -- Noblswarm Belzebuth, FireFist Cardinal Dark Bribe, Dimensional Prison                       
19310321,45705025,60316373,87255382,  -- Twin Eagle, UnicornHeraldic Beasts: Aberconway, Amphisbaena
59048135,81439173,61314842,84220251,  -- Heraldry Augmentation, Foolish BurialAdvanced Heraldry Art, Heraldry Reborn
38296564,92365601,47387961,23649496,  -- Safe Zone, Rank-Up Magic: Limited Barian's Force,Number 8, Number 18       
76774528,90411554,27243130,94656263,  -- Scrap Dragon, Redox, Dragon Ruler of Boulders,Forbidden Lance, Kagetokage
22110647,33198837,18964575,80117527,  -- Dracossack, Naturia Beast, Swift Scarecrow, Number 11: Big Eye
97077563,94380860,83994433,76774528,  -- Call of the Haunted, Ragna Zero,Stardust Spark Dragon, Scrap Dragon
42940404,39765958,48739166,12744567,  -- Machina Gearframe, Jeweled Red Dragon Archfiend,SHArk Knight, SHDark Knight
09418365,68601507,53678698,23979249,  -- Bujin Hirume, Crane,Bujin Mikazuchi, Arasuda
69723159,88940154,59251766,05818294,  -- Bujin Quilin, Centipede,Bujin Hare, Turtle
32339440,30338466,50474354,73906480,  -- Bujin Yamato, Bujin Regalia - The Sword, Bujin Peacock, Bujincarnation
26329679,95169481,98645731,68618157,  -- Constellar Omega, Diamond Dire Wolf, Pot of Duality, Bujin Amaterasu
75840616,21954587,73289035,01855932,  -- Bujintei Susanowo, Mermail AbyssMegalo, Bujin Tsukuyomi, Kagutsuchi
22076135,58471134,22446869,37781520,  -- Mermail Abyssturge, Mermail Abysspike, Mermail Abyssteus, Mermail Abyssleed
74311226,78868119,23899727,74298287,  -- Atlantean Dragoons, Deep Sea Diva, Mermail Abysslinde, Mermail Abyssdine
34707034,60202749,26400609,96947648,  -- Abyss-squall, Abyss-sphere, Tidal, Salvage
74371660,50789693,00440556,21044178,  -- Mermail Abyssgaios, Armored Kappa, Bahamut Shark, Abyss Dweller
15914410,59170782,70583986,65749035,  -- Mechquipped Angineer, Mermail Abysstrite, Dewloren, Gugnir
30328508,77723643,37445295,04939890,  -- Shaddoll Lizard, Shaddoll Dragon, Shaddoll Falcon, Shaddoll Hedgehog
44394295,29223325,03717252,24062258,  -- Shaddoll Fusion, Artifact Ignition, Shaddoll Beast, Secret Sect Druid Dru
04904633,12444060,01845204,77505534,  -- Facing the Shadows, Artifact Sanctum, Instant Fusion, Facing the Shadows
29669359,82633039,20366274,94977269,  -- Volcasaurus, Skyblaster Castel, El-Shaddoll Construct, El-Shaddoll Winda
04779823,31924889,00581014,33698022,  -- Michael, Arcanite Magician, Emeral, Moonlight Rose
54447022,74845897,34507039,14087893,  -- Soul Charge, Rekindling, Wiretap, Book of Moon
19665973,18964575,37576645,21954587,  -- Battle Fader, Swift Scarecrow, Reckless Greed, Mermail AbyssMegalo
75878039,02273734,38667773,63274863,  -- Satellarknights Deneb,Altair,Vega,Sirius
38331564,91110378,01845204,14087893,  -- Star Seraphs Scepter,Sovereign,Instant Fusion,Book of Moon
25789292,41510920,93568288,17412721,  -- Forbidden Chalice,Celestial Factor,Number 80,Noden
56638325,42589641,38273745,21501505,  -- Stellarknights Delteros, Triveil,Evilswarm Ouroboros,Cairngorgon
88264978,98777036,44330098,99365553,  -- REDMD, Tragoedia, Gorz, Lightpulsar
61901281,99234526,77558536,16404809,  -- Wyverbuster, Collapserpent, LS Raiden, Kuribandit
51858306,10802915,00691925,16178681,  -- Eclipse Wyvern, Tour Guide, Solar Recharge,Odd-Eyes Pendulum Dragon
94886282,95992081,07391448,43241495,  -- Charge of the Light Brigade,Leviair, Goyo Guardian,Performapal Trampolynx
25460258,04904812,91812341,45803070,  -- Darkflare Dragon, Genex Undine, Traptrix Myrmeleo,Dioena
68535320,95929069,29616929,91499077,  -- Fire Hand, Ice Hand, Traptrix Trap Hole Nightmare, Gagaga Samurai
63746411,83531441,84764038,05851097,  -- Giant Hand, Dante, Scarm, Vanitys Emptiness
65518099,90885155,64496451,37991342,  -- Qliphort Tool, Shell, Disk, Genome
91907707,27279764,17639150,04450854,  -- Qliphort Archive, Killer, Sacrifice, Apoqliphort
95772051,93085839,59057152,47120245,  -- Noble Knights Black Sally, Eachtar, Medraut, Borz
13391185,57690191,19748583,10736540,  -- Chad, Brothers, Gwen, Lady of the Lake
73359475,55742055,92512625,32807846,  -- Peredur, Table, Solemn Advice, RotA
07452945,14745409,23562407,46008667,  -- Noble Arms Destiny, Gallatin, Caliburn, Excaliburn
83438826,48009503,60645181,82944432,  -- Arfeudutyr, HC - Gandiva, Excalibur, Blade Armor Ninja
21223277,10613952,83519853,03580032,  -- R4torigus, R5torigus, High Sally, Merlin
66970385,30575681,95113856,44505297,  -- Chapter, Bedwyr, Phantom Fortress Enterblathnir, Inzektor Exa-Beetle
90307777,99185129,89463537,26674724,  -- Nekroz Shrit, Clausolas, Unicore, Brionac
74122412,52068432,88240999,08903700,  -- Nekroz Gungnir, Trishula, Decisive Armor, Djinn Releaser of Rituals
95492061,23401839,13974207,08809344,  -- Manju, Senju, Denkou Sekka, Outer God Nyarla
93016201,51124303,14735698,31563350,  -- Royal Oppression, Kaleidomirror, Exomirror, Zubaba General
57143342,73213494,47728740,20758643,  -- BA Cir, Calcab, Alich, Graff
00734741,36006208,00601193,63356631,  -- BA Rubic, Fire Lake, Virgil, PWWB
71587526,72167543,81330115,31320433,  -- Karma Cut, Downerd Magician, Acid Golem, Nightmare Shark
47805931,75367227,68836428,52558805,  -- Giga-Brillant, Ghostrick Alucard, Tri-Edge Levia, Temptempo the Percussion Djinn
16259549,51617185,36553319,09342162,  -- Fortune Tune, Machina Megaform, BA Farfa, Cagna
62957424,35330871,62835876,73680966,  -- BA Libic, Malacoda, Good&Evil, The Beginning of the End
25857246,52738610,97211663,30312361,  -- Necroz Valkyrus, Dance Princess, Cycle, Phantom of Chaos
12580477,45986603,16195942,56574543,  -- Raigeki, Snatch Steal, Dark Rebellion Dragon, Bujingi Sinyou
86346643,63465535,26563200,74822425,  -- Rainbow Neos, Underground Arachnid, Muzurythm, Shaddoll Shekinaga
48424886,06417578,60226558,73176465,  -- El-Shaddoll Egrystal, Fusion, Nepheshaddoll Fusion, Lightsworn Felis
94283662,16435215,74117290,33017655,  -- Trance Archfiend, Dragged Down, DWD, Gates
54974237,41930553,73445448,01639384,  -- EEV, Dark Smog, Zombiestein, Felgrand
10406322,66547759,88120966,78156759,  -- Sylvan Alsei, Lancelot, Giant Grinder, Zenmaines
74294676,42752141,71068247,50323155,  -- Laggia, Dolkka, Totem Bird, Black Horn
02956282,82044279,99188141,41269771,  -- Naturia Barkion, Clear Wing Synchro Dragon, THRIO, Constellar Algiedi
78358521,35544402,31386180,56832966,  -- Constellar Sombre, Twinkle, Tiras, Utopia Lightning
31437713,57103969,72959823,53567095, -- Heartlanddraco, Tenki, Panzer Dragon, Icarus
81105204,58820853,49003716,14785765, -- BW Kris, Shura, Bora, Zephyros
85215458,02009101,55610595,28190303, -- BW Kalut, Gale, Pinaka, Gladius
22835145,73652465,81983656,69031175, -- BW Blizzard, Oroshi, Hawk Joe, Armor Master
95040215,73347079,91351370,72930878, -- Nothung, Force Strix, Black Whirlwind, Black Sonic
76067258,75498415,72714392,24508238, -- Master Key Beetle,BW Sirocco, Vayu, D.D. Crow
42703248,83764719,27174286,59616123, -- Trunade, Monster Reborn, RftDD, Trap Stun
33236860,09012916,50321796,59839761, --Silverwing, Black-Winged Dragon, Synch Brionac, Delta Crow
75064463,56585883,90238142,68815132, -- Harpie Queen, Harpist, Channeler, Dancer
90219263,19337371,15854426,75782277, -- Elegant Egotist, Hysteric Sign, Divine Wind of Mist Valley, Harpie's Hunting Ground
77778835,85909450,86848580,89399912, -- Hysteric Party, HPPD, Zerofyne, Tempest
52040216,94145683,76812113,69884162, -- Harpie Lady -- Pet Dragon, Swallow's, Harpie Lady, Neos Alius
25259669,63060238,50720316,18063928, -- Goblindbergh, Blazeman, Shadow Mist, Tin Goldfish
79979666,00213326,08949584,18511384, -- Bubbleman, E-Call, AHL, Fusion Recovery
--[[24094653,]]45906428,55428811,21143940, -- Polymerization, Miracle Fusion, Fifth Hope, Mask Change
84536654,57728570,83555666,95486586, -- Form Change, CCV, Ring of Destruction, Core
03642509,22093873,01945387,22061412, -- Great Tornado, Divine Wind, Nova Master, The Shining
29095552,33574806,40854197,50608164, -- Acid, Escuridao, Absolute Zero, Koga
58481572,16304628,38992735,33904024, -- Dark Law, Gaia, Wave-Motion Cannon, Shard of Greed
72345736,05133471,21565445,47826112, -- Six Sams United, Galaxy Cyclone, Atlantean Neptabyss, Poseidra
13959634,72932673,13073850,88197162, -- Moulinglacia, Mizuchi, Qli Stealth, Soul Transition
51194046,20426097,24348807,25067275, -- Qli Monolith, Re-qliate, Lose a Turn, Swords At Dawn
18326736,58069384,10443957,03819470, -- Planetellarknight Ptolemaios, Cyber Dragon Nova, Infinity, Seven Tools
29401950,06511113,99590524,81992475, -- Bottomless, Rafflesia, Treacherous, BA Barbar
27552504,18386170,60743819,20036055, -- Beatrice, Pilgrim, Fiend Griefing, Traveler
40605147,65305468,59438930,56840427, -- Solemn Notice, F0, Ghost Ogre, Utopia Ray
16051717,30100551,20513882,31222701, -- Raikiri, Minerva, Painful Escape, Wavering Eyes
01050186,19508728,27796375,53180020, -- Satellarknight Unukalhai, Moon Mirror Shield, Nekroz Exa, Sorcerer
29888389,47106439,68819554,67696066, -- Gishki Shadow, Vision, Performage Damage Juggler, Trick Clown
43898403,63519819,60082869,27346636, -- Twin Twister, Thousand-Eyes Restrict, Dust Tornado, Gladbeast Heraklinos
63767246,81275020,53932291,01621413, -- Titanic Galaxy, Speedroid Terrortop, Taketomborg, Requiem Dragon
66994718,77414722,58851034,83326048, -- Raptor's Gust, Magic Jammer, Cursed Seal, Dimensional Barrier
85115440,48905153,69599136,43422537, -- Zodiac Beast Drancia,Bullhorn, Floodgate Trap Hole, Double Summon
08267140,50954680,75286621,48229808, -- Cosmic Cyclone, Crystal Wing, Merkabah, Black Flame Horus
}
function CardIsScripted(CardId)
  for i=1,#ScriptedCards do
    if CardId == ScriptedCards[i] then
      return 1
    end
  end
  return 0
end
function UpdateList(list,addlist)
  if list then
    if type(list)=="table" then
      for i=1,#list do
        addlist[#addlist+1]=list[i]
      end
    else
      print("Warning: invalid Blacklist for "..DeckCheck().Name)
      list=nil
    end
  end
end
function BlacklistSetup(deck)
  UpdateList(deck.ActivateBlacklist,ScriptedCards)
  UpdateList(deck.SummonBlacklist,NSBL)
  UpdateList(deck.SummonBlacklist,SSBL)
  UpdateList(deck.SetBlacklist,SetBL)
  UpdateList(deck.RepositionBlacklist,RepoBL)
  UpdateList(deck.Unchainable,Unchainable)
end
function ListHasNumber(list,number)
  for i=1,#list do
    if number == list[i] then
      return true
    end
  end
  return false
end
function BlacklistCheckInit(command,index,deck,cards)
  if deck == nil then return true end
  if command == COMMAND_ACTIVATE 
  and deck.ActivateBlacklist 
  then
    local id = cards.activatable_cards[index].id
    if ListHasNumber(deck.ActivateBlacklist,id) then
      return false
    end
  end
  if command == COMMAND_SUMMON
  and deck.SummonBlacklist 
  then
    local id = cards.summonable_cards[index].id
    if ListHasNumber(deck.SummonBlacklist,id) then
      return false
    end
  end
  if command == COMMAND_SPECIAL_SUMMON
  and deck.SummonBlacklist 
  then
    local id = cards.spsummonable_cards[index].id
    if ListHasNumber(deck.SummonBlacklist,id) then
      return false
    end
  end
  if command == COMMAND_SET_MONSTER
  and deck.SummonBlacklist 
  then
    local id = cards.monster_setable_cards[index].id
    if ListHasNumber(deck.SummonBlacklist,id) then
      return false
    end
  end
  if command == COMMAND_SET_ST
  and deck.SummonBlacklist 
  then
    local id = cards.st_setable_cards[index].id
    if ListHasNumber(deck.SetBlacklist,id) then
      return false
    end
  end
  if command == COMMAND_CHANGE_POS
  and deck.RepositionBlacklist 
  then
    local id = cards.repositionable_cards[index].id
    if ListHasNumber(deck.RepositionBlacklist,id) then
      return false
    end
  end
  return true
end
function BlacklistCheckChain(command,index,deck,cards)
  if deck == nil then return true end
  if command == 1
  and deck.ActivateBlacklist 
  then
    local id = cards[index].id
    if ListHasNumber(deck.ActivateBlacklist,id) then
      return false
    end
  end
  return true
end

GraveTargetPriority= -- cards to hit in the opponent's graveyard
{
  [34230233] = 3, -- Grapha
  [12538374] = 2, -- Treeborn
  [78474168] = 1, -- BTS
  [72291412] = 1, -- Necro Slime
  [19580308] = 2, -- Lamia
  [45206713] = 2, -- Swirl Slime
  [04904633] = 1, -- Shaddoll Core
  [44394295] = 1, -- Shaddoll Fusion
  [06417578] = 1, -- El-Shaddoll Fusion
  [74586817] = 1, -- PSYFrame Omega
  [34710660] = 2, -- Electromagnetic Turtle
  [69764158] = 2, -- Peropero Cerberus
  [02830693] = 1, -- Rainbow Kuriboh
  [67441435] = 1, -- Glow-up Bulb
  [05133471] = 1, -- Galaxy Cyclone
  [17412721] = 1, -- Norden
  [67696066] = 2, -- Trick Clown
  [14735698] = 1, -- Nekroz Mirror
  [51124303] = 1, -- Nekroz Kaleido
  [97211663] = 1, -- Nekroz Exo
  [50720316] = 1, -- Shadow Mist
  [95457011] = 2, -- Edea
  [59463312] = 1, -- Eidos
  [01357146] = 1, -- Ronintoadin
  [83531441] = 3, -- Dante
  [57143342] = 2, -- Cir
  [20758643] = 1, -- Graff
  [84764038] = 1, -- Scarm
  [62835876] = 1, -- Good&Evil
  [00601193] = 1, -- Virgil
  [90307777] = 1, -- Shurit
  [19748583] = 2, -- Gwen
  [93085839] = 1, -- Eachtar
  [07452945] = 1, -- Destiny
  [14745409] = 1, -- Gallatin
  [23562407] = 1, -- Caliburn
  [46008667] = 1, -- Excaliburn
  [03580032] = 1, -- Merlin
  [46008667] = 1, -- Excaliburn
  [88264978] = 1, -- REDMD
  [99365553] = 1, -- Lightpulsar
  [33420078] = 1, -- Plaguespreader
  [51617185] = 2, -- Machina Megaform
  [05556499] = 3, -- Machina Fortress
  [53804307] = 3, -- Dragon Rulers
  [26400609] = 3,
  [89399912] = 3,
  [90411554] = 3,
}
function GetGraveTargetPriority(c)
  local id
  if type(c) == "number" then
    id = c
  else
    c = GetCardFromScript(c)
    id = c.id
  end
  return GraveTargetPriority[id] or 0
end

--[[RemoveOnSummonFilter={
[82633039] = HasMaterials -- Castel

}
function RemoveOnSummon(c)
  if Negated(c) then
    return false
  end
  for id,filter in pairs(RemoveOnSummonFilter) do
    if c.id == id and filter(c) then
      return true
    end
  end
end  ]]




