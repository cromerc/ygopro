-----------------------------------------
-- AIHelperFunctions.lua
--
-- A set of functions for use with ai.lua
--
-- Parameters (none):
-----------------------------------------
-- This file is divided into sections 
-- for easier use.
-----------------------------------------

-------------------------------------------------
-- **********************************************
-- Functions to shorten names of general functions
-- for better access in future.
-- **********************************************
-------------------------------------------------

function AIMon()
local list = {}
local AIMon = AI.GetAIMonsterZones()
 for i=1,#AIMon do
   if AIMon[i] ~= false then
     list[#list+1]=AIMon[i]
     end
   end
  return list
end

function OppMon()
local list = {}
local OppMon = AI.GetOppMonsterZones()
 for i=1,#OppMon do
   if OppMon[i] ~= false then
     list[#list+1]=OppMon[i]
     end
   end
  return list
end

function AIST()
local list = {}
local AIST = AI.GetAISpellTrapZones()
 for i=1,#AIST do
   if AIST[i] ~= false then
     list[#list+1]=AIST[i]
     end
   end
  return list
end

function AIPendulum()
local list = {}
local AIST = AI.GetAISpellTrapZones()
 for i=7,8 do
   if AIST[i] ~= false then
     list[#list+1]=AIST[i]
     end
   end
  return list
end

function OppPendulum()
local list = {}
local AIST = AI.GetOppSpellTrapZones()
 for i=7,8 do
   if AIST[i] ~= false then
     list[#list+1]=AIST[i]
     end
   end
  return list
end

function AllPendulum()
  return UseLists(AIPendulum(),OppPendulum())
end

function OppST()
local list = {}
local OppST = AI.GetOppSpellTrapZones()
 for i=1,#OppST do
   if OppST[i] ~= false then
     list[#list+1]=OppST[i]
     end
   end
  return list
end

function AIGrave()
local list = {}
local AIGrave = AI.GetAIGraveyard()
 for i=1,#AIGrave do
   if AIGrave[i] ~= false then
     list[#list+1]=AIGrave[i]
     end
   end
  return list
end

function OppGrave()
local list = {}
local OppGrave = AI.GetOppGraveyard()
 for i=1,#OppGrave do
   if OppGrave[i] ~= false then
     list[#list+1]=OppGrave[i]
     end
   end
  return list
end

function AIBanish()
local list = {}
local AIBanish = AI.GetAIBanished()
 for i=1,#AIBanish do
   if AIBanish[i] ~= false then
     list[#list+1]=AIBanish[i]
     end
   end
  return list
end

function OppBanish()
local list = {}
local OppBanish = AI.GetOppBanished()
 for i=1,#OppBanish do
   if OppBanish[i] ~= false then
     list[#list+1]=OppBanish[i]
     end
   end
  return list
end

function AIHand()
local list = {}
local AIHand = AI.GetAIHand()
 for i=1,#AIHand do
   if AIHand[i] ~= false then
     list[#list+1]=AIHand[i]
     end
   end
  return list
end

function OppHand()
local list = {}
local OppHand = AI.GetOppHand()
 for i=1,#OppHand do
   if OppHand[i] ~= false then
     list[#list+1]=OppHand[i]
     end
   end
  return list
end

function AIDeck()
local list = {}
local AIDeck = AI.GetAIMainDeck()
 for i=1,#AIDeck do
   if AIDeck[i] ~= false then
     list[#list+1]=AIDeck[i]
     end
   end
  return list
end

function OppDeck()
local list = {}
local OppDeck = AI.GetOppMainDeck()
 for i=1,#OppDeck do
   if OppDeck[i] ~= false then
     list[#list+1]=OppDeck[i]
     end
   end
  return list
end

function AIExtra()
local list = {}
local AIExtra = AI.GetAIExtraDeck()
 for i=1,#AIExtra do
   if AIExtra[i] ~= false then
     list[#list+1]=AIExtra[i]
     end
   end
  return list
end

function OppExtra()
local list = {}
local OppExtra = AI.GetOppExtraDeck()
 for i=1,#OppExtra do
   if OppExtra[i] ~= false then
     list[#list+1]=OppExtra[i]
     end
   end
  return list
end
function Merge(lists,opt,opt2)
  local cards
  local Result={}
  if lists then
    if type(lists)~="table" then
      print("Warning: Merge invalid type")
      PrintCallingFunction()
      return Result
    end
    if opt and type(opt)~="table" then
      print("Warning: Merge invalid type")
      PrintCallingFunction()
      return Result
    end
    if opt2 and type(opt2)~="table" then
      print("Warning: Merge invalid type")
      PrintCallingFunction()
      return Result
    end
    if opt then
      for i=1,#lists do
        Result[#Result+1]=lists[i]
      end
      for i=1,#opt do
        Result[#Result+1]=opt[i]
      end
      if opt2 then
        for i=1,#opt2 do
          Result[#Result+1]=opt2[i]
        end
      end
    else
      for i=1,#lists do
        cards = lists[i]
        if cards then
          for j=1,#cards do
            Result[#Result+1]=cards[j]
          end
        end
      end
    end
  end
  return Result
end
function UseLists(lists,opt,opt2)
  return Merge(lists,opt,opt2)
end
function AIField() 
  return UseLists({AIMon(),AIST()})
end
function OppField() 
  return UseLists({OppMon(),OppST()})
end
function AICards() 
  return UseLists(AIField(),AIHand())
end
function OppCards() 
  return UseLists(OppField(),OppHand())
end
function AIAll() 
  return UseLists({AIHand(),AIField(),AIGrave(),AIDeck(),AIBanish(),AIExtra()})
end
function OppAll() 
  return UseLists({OppHand(),OppField(),OppGrave(),OppDeck(),OppBanish(),OppExtra()})
end
function Field()
  return UseLists(AIField(),OppField())
end
function All()
  return UseLists(AIAll(),OppAll())
end
function AllMon()
  return UseLists(AIMon(),OppMon())
end
function AllST()
  return UseLists(AIST(),OppST())
end
function AIMaterials()
  local result = {}
  for i=1,#AIMon() do
    local cards = AIMon()[i].xyz_materials
    if cards and #cards>0 then
      result = UseLists(result,cards)
    end
  end
  return result
end
function OppMaterials()
  local result = {}
  for i=1,#OppMon() do
    local cards = OppMon()[i].xyz_materials
    if cards and #cards>0 then
      result = UseLists(result,cards)
    end
  end
  return result
end
-------------------------------------------------
-- **********************************************
-- Functions related to monster count returning, 
-- using specified parameters.
-- **********************************************
-------------------------------------------------

---------------------------------------
-- Returns the total number of cards in 
-- specified location
--
-- Parameters (1):
-- Cards = array of cards for search
---------------------------------------
function Get_Card_Count(Cards)
  local Result = 0
  for i=1,#Cards do
    if Cards[i] ~= false then
      Result = Result + 1
     end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who are in 
-- specified position
--
-- Parameters (2):
-- Cards = array of cards for search
-- Position = Specified position of the card
---------------------------------------
function Get_Card_Count_Pos(Cards, Position)
  local Result = 0
  for i=1,#Cards do
      if bit32.band(Cards[i].position,Position) > 0 then   
	  Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who are of 
-- specified ID
--
-- Parameters (3):
-- Cards = first array of cards for search
-- CardID = Specified id of the card
-- Position = Card's position
---------------------------------------
function Get_Card_Count_ID(Cards, CardID, Position)
  local Result = 0
  for i=1,#Cards do 
     if (Position == nil or bit32.band(Cards[i].position,Position) > 0) and    
    	(CardID == nil or Cards[i].id == CardID) then    
		Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who are of 
-- specified attribute
--
-- Parameters (3):
-- Cards = first array of cards for search
-- Oper = operation used (>, >=, == etc.)
-- Attribute = Specified attribute of the card
-- Position = Card's position
---------------------------------------
function Get_Card_Count_ATT(Cards, Oper, Attribute, Position)
  local Result = 0
  for i=1,#Cards do 
     if (Position == nil or bit32.band(Cards[i].position,Position) > 0) and    
    	(Oper == "==" or Cards[i].attribute == Attribute) or   
		(Oper == "~=" or Cards[i].attribute ~= Attribute) then 
		Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who are of 
-- specified ID
--
-- Parameters (4):
-- Cards = first array of cards for search
-- Oper = operation used (>, >=, == etc.)
-- Race = Specified race of the card
-- Position = Card's position
---------------------------------------
function Get_Card_Count_Race(Cards, Oper, Race, Position)
  local Result = 0
  for i=1,#Cards do 
     if (Position == nil or bit32.band(Cards[i].position,Position) > 0) and    		
		(Oper == "==" and Cards[i].race == Race) or    
		(Oper == "~=" and Cards[i].race ~= Race) then 
		Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who are of 
-- specified rank
--
-- Parameters (2):
-- Cards = array of cards for search
-- Rank = Specified rank of the card
-- Oper = operation used (>, >=, == etc.)
-- Position = Card's position
---------------------------------------
function Get_Card_Count_Rank(Cards, Rank, Oper, Position)
  local Result = 0
  for i=1,#Cards do
     if (Position == nil or bit32.band(Cards[i].position,Position) > 0) and    
    	(Oper == ">" and Cards[i].rank > Rank) or 
		(Oper == "<" and Cards[i].rank < Rank) or   
		(Oper == "==" and Cards[i].rank == Rank) or 
		(Oper == ">=" and Cards[i].rank >= Rank) or
		(Oper == "<=" and Cards[i].rank <= Rank) then
	    Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who are of 
-- specified rank
--
-- Parameters (2):
-- Cards = array of cards for search
-- Level = Specified level of the card
-- Oper = operation used (>, >=, == etc.)
-- Position = Card's position
---------------------------------------
function Get_Card_Count_Level(Cards, Level, Oper, Position)
  local Result = 0
  for i=1,#Cards do
     if (Position == nil or bit32.band(Cards[i].position,Position) > 0) and    
    	(Oper == ">" and Cards[i].level > Level) or 
		(Oper == "<" and Cards[i].level < Level) or   
		(Oper == "==" and Cards[i].level == Level) or 
		(Oper == ">=" and Cards[i].level >= Level) or
		(Oper == "<=" and Cards[i].level <= Level) then
	    Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who are of 
-- specified type
--
-- Parameters (2):
-- Cards = array of cards for search
-- Type = Specified type of the card
-- Oper = operation used (>, >=, == etc.)
-- Position = Card's position
---------------------------------------
function Get_Card_Count_Type(Cards, Type, Oper, Position)
  local Result = 0
  for i=1,#Cards do
     if (Position == nil or bit32.band(Cards[i].position,Position) > 0) and  
	    (Oper == ">" and bit32.band(Cards[i].type,Type) > 0) or  
		(Oper == "==" and bit32.band(Cards[i].type,Type) == Type) and 
		Cards[i].id ~= 72892473 then   
	    Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards in 
-- specified location who have specified 
-- amount of Attack or/and Defense
-- compared with specified operation 
-- and who are in specified position
--
-- Parameters (5):
-- Cards = array of cards for search
-- Oper = operation used (>, >=, == etc.)
-- Attack = Compared attack value 
-- Defense = Compared defense value
-- Position = Card's position
---------------------------------------
function Get_Card_Count_Att_Def(Cards, Oper, Attack, Defense, Position)
  local Result = 0
  for i=1,#Cards do
    if bit32.band(Cards[i].type,TYPE_MONSTER)>0 and
     (Position == nil or bit32.band(Cards[i].position,Position) > 0) and 
     (Attack == nil or 
     Oper == ">" and Cards[i].attack > Attack or 
     Oper == "<" and Cards[i].attack < Attack or   
     Oper == "==" and Cards[i].attack == Attack or 
     Oper == ">=" and Cards[i].attack >= Attack or
     Oper == "<=" and Cards[i].attack <= Attack ) and
    (Defense == nil or 
     Oper == ">" and Cards[i].defense > Defense or 
     Oper == "<" and Cards[i].defense < Defense or   
     Oper == "==" and Cards[i].defense == Defense or 
     Oper == ">=" and Cards[i].defense >= Defense or
     Oper == "<=" and Cards[i].defense <= Defense) then
      Result = Result + 1
      end
   end
  return Result
end

----------------------------------------
-- Returns the total number of cards
-- currently affected by specified effect
-- in specified card location.
--
-- Parameters (2):
-- Effect = checked effect (refer to constant.lua)
-- Cards = array of cards for search
---------------------------------------
function Card_Count_Affected_By(Effect,Cards)
  local Result = 0
  for i=1,#Cards do
    if Cards[i]:is_affected_by(Effect) == 0 then
	  Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards,
-- of specified archetype in specified 
-- location.
--
-- Parameters (4):
-- SetCode = code of searched archetype
-- Cards = array of cards to serach
-- Pos = required position (nil if any)
---------------------------------------
function Archetype_Card_Count(Cards, SetCode, Pos)
 local Result = 0
 if Cards ~= nil then 
  for i=1,#Cards do	 
	 if Cards[i].setcode == SetCode and 
	   (Pos == nil or bit32.band(Cards[i].position,Pos) > 0) then   
	     Result = Result + 1
        end
	 end
  end
  return Result
end


---------------------------------------
-- Returns the total number of cards,
-- who are of a specified list
-- and are in a specified location.
-- 
-- Parameters (2):
-- List = list of cards to compare with (refer to AICheckList.lua) 
-- Cards = specified array of cards
-- Oper = used operation (~= or ==)
---------------------------------------
function Card_Count_From_List(List, Cards, Oper)
 local Result = 0
 for i=1,#Cards do
	if (Oper == "==" and List(Cards[i].id) == 1) or
       (Oper == "~=" and List(Cards[i].id) == 0) then
	  Result = Result + 1
      end
   end
  return Result
end

---------------------------------------
-- Returns the total number of cards,
-- who match specified parametrs.
-- 
-- Parameters (9):
-- Cards = specified array of cards
-- ID = card's id
-- Type = card's type
-- Pos = card's position
-- Oper = operation used (>, >=, == etc.)
-- Level = card's level
-- Race = card's race
-- SetCode = code of card's archetype
-- MinLvl = minimal level check
-- Att = Card's attribute
-- Note: Set parametr to nil if it's not required.
---------------------------------------
function Card_Count_Specified(Cards, ID, Type, Pos, Oper, Level, Race, SetCode, MinLvl, Att)
  local Result = 0
  for i=1,#Cards do
      if Cards[i].location ~= LOCATION_OVERLAY and
	    (Type == nil or bit32.band(Cards[i].type,Type) > 0) and 
	    (Pos == nil or bit32.band(Cards[i].position,Pos) > 0) and   
		(ID == nil or Cards[i].id == ID) and
	    (Race == nil or Cards[i].race  == Race) and
	    (SetCode == nil or Cards[i].setcode == SetCode)	and      
	    (Att == nil or Cards[i].attribute == Att)	and
		(MinLvl == nil or Cards[i].level > MinLvl) and		 
		 (Level == nil or 
		(Oper == ">" and Cards[i].level > Level) or 
		(Oper == "<" and Cards[i].level < Level) or   
		(Oper == "==" and Cards[i].level == Level) or 
		(Oper == ">=" and Cards[i].level >= Level) or
		(Oper == "<=" and Cards[i].level <= Level)) then
		 Result = Result + 1
       end
    end
  return Result
end

----------------------------------------
-- Returns the total number of monsters
-- currently controlled by the AI
-- with lower level and attack points than specified
----------------------------------------
function AIMonCountLowerLevelAndAttack(Level, Attack)
  local AIMons = AI.GetAIMonsterZones()
  local Result = 0
  for x=1,#AIMons do
    if AIMons[x] ~= false then
      if AIMons[x].level <= Level and AIMons[x].attack < Attack and AIMons[x].rank == 0 and 
	     IsTributeException(AIMons[x].id) == 0 or TributeWhitelist(AIMons[x].id) > 0 and AIMons[x]:is_affected_by(EFFECT_CANNOT_RELEASE) == 0 then
        Result = Result + 1
       end
     end
   end
  return Result
end

---------------------------------------
-- Returns count of monsters of same level 
-- as special summonable monsters rank 
---------------------------------------
function AIMonOnFieldMatCount(Rank)  
local AIMons = AI.GetAIMonsterZones()
local AIExtra = AI.GetAIExtraDeck()
local Result = 0
 for i=1,#AIMons do
  if AIMons[i] ~= false then  
	if bit32.band(AIMons[i].type,TYPE_MONSTER) > 0 and AIMons[i].level == Rank and
	   IsTributeException(AIMons[i].id) == 0 then
       Result = Result + 1
	  end
	end
  end
  return Result
end

---------------------------------------
-- Returns count of monsters of same level 
-- as summonable XYZ monsters rank currently on the field.
---------------------------------------
function AIMonOnFieldMatCurrentCount()  
local AIMons = AI.GetAIMonsterZones()
local Result = 0
 for i=1,#AIMons do
  if AIMons[i] ~= false then  
	if isMonLevelEqualToRank(AIMons[i].level,AIMons[i].id) == 1 then
      Result = Result + 1
	  end
	end
  end
  return Result
end

---------------------------------------
-- Returns the total number of XYZ materials
-- attached to monster of a specified rank
---------------------------------------
function AIXyzMonsterMatCount(Rank, MatCount)
  local AIMon = AI.GetAIMonsterZones()
  local Result = 0
  for x=1,#AIMon do
    if AIMon[x] ~= false then
     if AIMon[x] and bit32.band(AIMon[x].type,TYPE_XYZ)> 0 and AIMon[x].rank == Rank and AIMon[x].xyz_material_count == MatCount then 
	  Result = Result + 1
	 end
   end
  end
  return Result
end

---------------------------------------
-- Returns required count of monsters 
-- to special summon XYZ monster.
-- TODO: Add Material count depending on card's id, for every individual card
---------------------------------------
function GetXYZRequiredMatCount() 
local AIExtra = AI.GetAIExtraDeck()
 local MaterialCount = 0
  for i=1,#AIExtra do
    if AIExtra[i] ~= false and bit32.band(AIExtra[i].type,TYPE_MONSTER) > 0 then  	  
	  MaterialCount = 2
	 end
   end
  return MaterialCount
end

---------------------------------------
-- Returns required tribute count of monster
-- by it's level or id
---------------------------------------
function AIMonGetTributeCountByLevel(CardLevel)
  local AIHand = AI.GetAIHand() 
  local TributeCount = 0
  for i=1,#AIHand do
	if AIHand[i] ~= false and bit32.band(AIHand[i].type,TYPE_MONSTER) > 0 then 
	 if AIHand[i].level == CardLevel then
	  if AIHand[i].level == 5 or AIHand[i].level == 6 then 	  
	  TributeCount = 1
	  elseif Is3TributeMonster(AIHand[i].id) == 0 and AIHand[i].level >= 7 then 
      TributeCount = 2
	  elseif Is3TributeMonster(AIHand[i].id) == 1 then 
      TributeCount = 3
	  end
     end
    end 
   end
  return TributeCount
end

---------------------------------------
-- Returns the total number of monsters,
-- of specified archetype in AI's hand
--  who aren't of specified id.
---------------------------------------
function AIArchetypeMonNotID(SetCode, CardID)
  local AIHand = AI.GetAIHand()
  local Result = 0
  for x=1,#AIHand do
    if AIHand[x] ~= false then
     if AIHand[x].setcode == SetCode and AIHand[x].id ~= CardID then 
	  Result = Result + 1
     end
   end
  end
  return Result
end

---------------------------------------
-- Returns count of attacked light monster 
-- who have weaker attack 
---------------------------------------
function AIAttackedLightMonCount()
  local AIMon = AI.GetAIMonsterZones()
  local Result = 0
 for i=1,#AIMon do
   if AIMon[i] ~= false then
	if AIMon[i].attribute == ATTRIBUTE_LIGHT and AIMon[i].status == STATUS_ATTACKED and AIMon[i].attack >= 1900 
      and AIMon[i].owner == 1 then
	  Result = Result + 1
      end
	end
  end
  return Result
end


-------------------------------------------------
-- **********************************************
-- Functions related to returning true (1) or false (0)
-- after checking for specified conditions.
-- **********************************************
-------------------------------------------------

---------------------------------------
-- Returns if monster is controlled by AI (1) or Player (2)
-- by checking it's position on side of the field.
---------------------------------------
function CurrentMonOwner(CardId)
  local cards = AIMon()
  local Result = 2 -- by default it's controlled by Player
  for i=1,#cards do
    if cards[i] and cards[i].cardid == CardId then
      Result = 1 -- if monster exists on AI's side of the field it is owned by AI (well duh)
    end
  end
  return Result
end

---------------------------------------
-- Returns if Spell/Trap card is controlled by AI (1) or Player (2)
-- by checking it's position on side of the field.
---------------------------------------
function CurrentSTOwner(CardsID)
  local AIST = AI.GetAISpellTrapZones()
  local Result = 2 -- by default it's controlled by Player
  for i=1,#AIST do
    if AIST[i] ~= false then  
	 if AIST[i].cardid == CardsID then  
	   Result = 1 -- if S/T exists on AI's side of the field it is owned by AI (well duh)
      end
    end
  end
  return Result
end
function CurrentOwner(c,cards)
  c=GetCardFromScript(c)
  if not FilterLocation(c,LOCATION_ONFIELD) then
    return c.owner
  end
  if cards == nil then
    cards = AICards()
  end
  local result = 2
  for i=1,#cards do
    if cards[i].cardid == c.cardid then
      result = 1
    end
  end
  return result
end
----------------------------------------
-- Checks whether or not the opponent
-- controls a face-up monster with a
-- specified ATK (if in attack position)
-- or DEF (if in defense position), and
-- returns True or False as the result.
----------------------------------------
function OppHasFaceupMonster(AtkDef)
  if Get_Card_Count_Att_Def(OppMon(),">=",AtkDef,nil,POS_FACEUP_ATTACK) > 0 then
    return 1
  end
  if Get_Card_Count_Att_Def(OppMon(),">=",AtkDef,nil,POS_FACEUP_DEFENSE) > 0 then
    return 1
  end
  return 0
end

---------------------------------------
-- Compares level of specified card with 
-- monsters rank in AI's extra deck
-- and returns true or false
---------------------------------------
function isMonLevelEqualToRank(Level,ID) 
local AIExtra = AI.GetAIExtraDeck()
local Result = 0
 for i=1,#AIExtra do
  if AIExtra[i] ~= false then  
	if bit32.band(AIExtra[i].type,TYPE_MONSTER) > 0 and AIExtra[i].rank == Level and
	IsTributeException(ID) == 0 then
	  Result = 1
	 end
    end
   end
  return Result
end


--------------------------------------------------
-- Checks if card is a "Toon" monster, and AI
-- controls face up "Toon Kingdom" 
--------------------------------------------------
function isToonUndestroyable(Cards)
  local Result = 0
  for i=1,#Cards do  
   if Cards[i] ~= false then
     if (Cards[i].setcode == 98 and Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 15259703, POS_FACEUP) > 0) or
	    (Cards[i].setcode == 4522082 and Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 15259703, POS_FACEUP) > 0) then 
	    return 1
        end
      end
    end
  return 0
end

-----------------------------------------------------
-- Check if any face up card is from unchain-able card list
-----------------------------------------------------
function AIControlsFaceupUnchainable(CardId)
  local AIST = AIST()
  for i=1,#AIST do
   if isUnchainableTogether(AIST[i].id) == 1 and bit32.band(AIST[i].position,POS_FACEUP) > 0 then
     return 1
     end
  end
  return 0
end

-------------------------------------------------
-- **********************************************
-- Functions related to returning value of specified
-- parameter, usually attack or defense.
-- **********************************************
-------------------------------------------------


---------------------------------------
-- Returns highest or lowest attack or 
-- defense in specified array of cards
--
-- Parameters (4):
-- Cards = array of cards for search
-- AttDef = attack or defense value of card
-- Oper = operation to check for (> or <)
-- Position = card's position
-- Return = value to return (attack or defense)
---------------------------------------
function Get_Card_Att_Def(Cards, AttDef, Oper, Position, Return)
  local Result = 0
  local Highest   = 0
  local Lowest   = 99999999
  if Oper == ">" and AttDef == "attack" then 
  for i=1,#Cards do
    if(Position == nil or bit32.band(Cards[i].position,Position) > 0) then   
      if Cards[i].attack > Highest and Return == "attack" then
          Highest = Cards[i].attack
		  Result = Cards[i].attack
	   elseif Cards[i].attack > Highest and Return == "defense" then
		  Highest = Cards[i].attack
		  Result = Cards[i].defense
		  end
        end
      end
    end
  if Oper == ">" and AttDef == "defense" then 
  for i=1,#Cards do
    if(Position == nil or bit32.band(Cards[i].position,Position) > 0) then   
      if Cards[i].defense > Highest and Return == "attack" then
          Highest = Cards[i].defense
		  Result = Cards[i].attack
	   elseif Cards[i].defense > Highest and Return == "defense" then
		  Highest = Cards[i].defense
		  Result = Cards[i].defense
		  end
        end
      end
    end
  if Oper == "<" and AttDef == "attack" then  
  for i=1,#Cards do
    if(Position == nil or bit32.band(Cards[i].position,Position) > 0) then   
      if Cards[i].attack < Lowest and Return == "attack" then
          Lowest = Cards[i].attack
		  Result = Cards[i].attack
	   elseif Cards[i].attack < Lowest and Return == "defense" then
		  Lowest = Cards[i].attack
		  Result = Cards[i].defense
		  end
        end
      end
    end
  if Oper == "<" and AttDef == "defense" then 
  for i=1,#Cards do
    if(Position == nil or bit32.band(Cards[i].position,Position) > 0) then   
      if Cards[i].defense < Lowest and Return == "attack" then
          Lowest = Cards[i].defense
		  Result = Cards[i].attack
	   elseif Cards[i].defense < Lowest and Return == "defense" then
		  Lowest = Cards[i].defense
		  Result = Cards[i].defense
		  end
        end
      end
    end
  return Result
end


---------------------------------------------------------------
-- Returns the highest ATK or DEF (depending on position) in 
-- specified index of cards
--
-- Parameters (1):
-- Cards = array of cards for search
----------------------------------------------------------------
function Get_Card_Att_Def_Pos(Cards)
  local Result = 0
  for i=1,#Cards do
    if Cards[i].position == POS_FACEUP_ATTACK then
       if Cards[i].attack > Result then
          Result = Cards[i].attack
        end
      end
      if Cards[i].position == POS_FACEUP_DEFENSE then
        if Cards[i].defense > Result then
          Result = Cards[i].defense
        end
      end
    end
  return Result
end


---------------------------------------
-- Returns the attack points of card by it's id
--
-- Parameters (1):
-- CardId = ID of the card
---------------------------------------
function AIMonGetAttackById(CardId)  
  local Result = -1
  local AllCards = UseLists({AIMon(),AIDeck(),AIHand(),AIGrave(),AIExtra(),AIBanish(),OppMon(),OppDeck(),OppHand(),OppGrave(),OppExtra(),OppBanish()})
   for i=1,#AllCards do
	if AllCards[i] ~= false then
       if AllCards[i].id == CardId then
        Result = AllCards[i].attack
		end
      end
   end
  return Result
end

---------------------------------------
-- Returns the race of card by it's id
--
-- Parameters (1):
-- CardId = ID of the card
---------------------------------------
function AIMonGetRaceById(CardId)  
   local Result = -1
   local AllCards = UseLists({AIMon(),AIDeck(),AIHand(),AIGrave(),AIExtra(),AIBanish(),OppMon(),OppDeck(),OppHand(),OppGrave(),OppExtra(),OppBanish()})
   for i=1,#AllCards do
	if AllCards[i] ~= false then
       if AllCards[i].id == CardId then
        Result = AllCards[i].race
		end
      end
   end
  return Result
end

---------------------------------------
-- Checks, if a specific level/rank is 
-- available in specified index of cards
--
-- Parameters (3):
-- Cards = array of cards for search
-- Type = card's type
-- level = card's level
---------------------------------------
function Cards_Available(Cards, Type, level)
  local cards=Sort_List_By(Cards,nil,nil,nil,">",Type)
  local result={}
  for i=1,#cards do
    if math.max(cards[i].level,cards[i].rank) == level then
      return 1
    end
  end
  return 0
end

---------------------------------------
-- Returns table of xyz materials
-- attached to a specified card
--
-- Parameters (1):
-- CardId = id of the card
---------------------------------------
function Get_Mat_Table(CardId) 
  local AIMon = AI.GetAIMonsterZones()
  local Result = {}
  for i=1,#AIMon do
    if AIMon[i] ~= false then  
	 if AIMon[i].id == CardId then
	   Result = AIMon[i].xyz_materials
      end
    end
  end
  return Result
end

-------------------------------------------------
-- **********************************************
-- Functions related to returning index of card
-- that is matching specified parameters.
-- **********************************************
-------------------------------------------------

------------------------------------------------
-- Returns index of random spell or trap card on field
--
-- Parameters (2):
-- Cards = array of cards for search
-- Owner = card's current owner
------------------------------------------------
function getRandomSTIndex(Cards, Owner)
  local targets = {}
  local Index = -1
  if #Cards > 0 then
    for i=1,#Cards do
      if Cards[i] ~= false then
		if (bit32.band(Cards[i].type,TYPE_TRAP) == TYPE_TRAP 
    or bit32.band(Cards[i].type,TYPE_SPELL) == TYPE_SPELL) 
    and  CurrentSTOwner(Cards[i].cardid) == Owner then
		  targets[#targets+1]=i
		  Index = targets[math.random(#targets)]
		end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (5):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
---------------------------------------
function Get_Card_Index(Cards, Owner, Oper, Type, Position)
  local Index = 1
  local Highest  = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and  
		  Cards[i].attack > Highest then
          Highest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  if Oper == "Lowest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if (Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
          (Position == nil or bit32.band(Cards[i].position,Position) > 0) and  
		  Cards[i].attack < Lowest then
          Lowest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (7):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
-- Oper2 = operation used (>, >=, == etc.)
-- Race = card's race
---------------------------------------
function Index_By_Race(Cards, Owner, Oper, Type, Position, Oper2, Race)
  local Index = 1
  local Highest  = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].race == Race) or
		 (Oper2 == "~=" and Cards[i].race ~= Race) and
		  Cards[i].attack > Highest then
          Highest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  if Oper == "Lowest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].race == Race) or
		 (Oper2 == "~=" and Cards[i].race ~= Race) and
		  Cards[i].attack < Lowest then
          Lowest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (7):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
-- Oper2 = operation used (>, >=, == etc.)
-- Attribute = card's attribute
---------------------------------------
function Index_By_ATT(Cards, Owner, Oper, Type, Position, Oper2, Attribute)
  local Index = 1
  local Highest   = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].attribute == Attribute) or
		 (Oper2 == "~=" and Cards[i].attribute ~= Attribute) and
		  Cards[i].attack > Highest then
          Highest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  if Oper == "Lowest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].attribute == Attribute) or
		 (Oper2 == "~=" and Cards[i].attribute ~= Attribute) and
		  Cards[i].attack < Lowest then
          Lowest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (7):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
-- Oper2 = operation used (>, >=, == etc.)
-- ID = card's ID
---------------------------------------
function Index_By_ID(Cards, Owner, Oper, Type, Position, Oper2, ID)
  local Index = 1
  local Highest   = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].id == ID) or
		 (Oper2 == "~=" and Cards[i].id ~= ID) and
		  (Cards[i].attack > Highest or bit32.band(Cards[i].type,TYPE_MONSTER) == 0) then
          Highest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  if Oper == "Lowest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].id == ID) or
		 (Oper2 == "~=" and Cards[i].id ~= ID) and
		  (Cards[i].attack < Lowest or bit32.band(Cards[i].type,TYPE_MONSTER) == 0)then
          Lowest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (7):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
-- Oper2 = operation used (>, >=, == etc.)
-- SetCode = card's setcode
---------------------------------------
function Index_By_SetCode(Cards, Owner, Oper, Type, Position, Oper2, Setcode)
  local Index = 1
  local Highest   = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].setcode == Setcode) or
		 (Oper2 == "~=" and Cards[i].setcode ~= Setcode) and
		  Cards[i].attack > Highest then
          Highest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  if Oper == "Lowest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and (Oper2 == "==" and Cards[i].setcode == Setcode) or
		 (Oper2 == "~=" and Cards[i].setcode ~= Setcode) and
		  Cards[i].attack < Lowest then
          Lowest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (7):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
-- Oper2 = operation used (>, >=, == etc.)
-- Location = card's location
---------------------------------------
function Index_By_Loc(Cards, Owner, Oper, Type, Position, Oper2, Location)
  local Index = 1
  local Highest   = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
    for i=1,#Cards do
      if Cards[i] ~= false then
        if  (Type == nil or bit32.band(Cards[i].type,Type) >= Type) 
        and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) 
        and (Position == nil or bit32.band(Cards[i].position,Position) > 0) 
        and (Oper2 == "==" and Cards[i].location == Location  or  Oper2 == "~=" and Cards[i].location ~= Location) 
        and Cards[i].attack > Highest then
          Highest = Cards[i].attack
          Index = i
        end
      end
    end
  end
  if Oper == "Lowest" then 
    for i=1,#Cards do
      if Cards[i] ~= false then
        if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) 
        and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) 
        and (Position == nil or bit32.band(Cards[i].position,Position) > 0) 
        and (Oper2 == "==" and Cards[i].location == Location or Oper2 == "~=" and Cards[i].location ~= Location) 
        and Cards[i].attack < Lowest then
          Lowest = Cards[i].attack
          Index = i
        end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (7):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
-- Oper2 = operation used (>, >=, == etc.)
-- Level = card's level
---------------------------------------
function Index_By_Level(Cards, Owner, Oper, Type, Position, Oper2, Level)
  local Index = 1
  local Highest   = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and 
		 (Oper2 == ">" and Cards[i].level > Level) or 
		 (Oper2 == "<" and Cards[i].level < Level) or   
		 (Oper2 == "==" and Cards[i].level == Level) or 
		 (Oper2 == ">=" and Cards[i].level >= Level) or
		 (Oper2 == "<=" and Cards[i].level <= Level) and
		  Cards[i].attack > Highest then
          Highest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  if Oper == "Lowest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and
		 (Oper2 == ">" and Cards[i].level > Level) or 
		 (Oper2 == "<" and Cards[i].level < Level) or   
		 (Oper2 == "==" and Cards[i].level == Level) or 
		 (Oper2 == ">=" and Cards[i].level >= Level) or
		 (Oper2 == "<=" and Cards[i].level <= Level) and
		  Cards[i].attack < Lowest then
          Lowest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  return {Index}
end

---------------------------------------
-- Returns index of lowest or highest
-- attack monster of specified parameters in 
-- specified array of cards
--
-- Parameters (7):
-- Cards = array of cards for search
-- Owner = card's current owner
-- Oper = search of Highest or Lowest attack monster
-- Type = card's type
-- Position = card's current position
-- Oper2 = operation used (>, >=, == etc.)
-- Attack = card's attack
---------------------------------------
function Index_By_Attack(Cards, Owner, Oper, Type, Position, Oper2, Attack)
  local Index = 1
  local Highest   = 0
  local Lowest   = 99999999
  if Oper == "Highest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and 
		 (Oper2 == ">" and Cards[i].attack > Attack) or 
		 (Oper2 == "<" and Cards[i].attack < Attack) or   
		 (Oper2 == "==" and Cards[i].attack == Attack) or 
		 (Oper2 == ">=" and Cards[i].attack >= Attack) or
		 (Oper2 == "<=" and Cards[i].attack <= Attack) and
		  Cards[i].attack > Highest then
          Highest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  if Oper == "Lowest" then 
   for i=1,#Cards do
     if Cards[i] ~= false then
       if(Type == nil or bit32.band(Cards[i].type,Type) >= Type) and (Owner == nil or CurrentMonOwner(Cards[i].cardid) == Owner) and
         (Position == nil or bit32.band(Cards[i].position,Position) > 0) and
		 (Oper2 == ">" and Cards[i].attack > Attack) or 
		 (Oper2 == "<" and Cards[i].attack < Attack) or   
		 (Oper2 == "==" and Cards[i].attack == Attack) or 
		 (Oper2 == ">=" and Cards[i].attack >= Attack) or
		 (Oper2 == "<=" and Cards[i].attack <= Attack) and
		  Cards[i].attack < Lowest then
          Lowest = Cards[i].attack
          Index = i
	    end
      end
    end
  end
  return {Index}
end

------------------------------------------
-- Returns the location of the highest ATK
-- monster who is of a specified type or 
-- higher or equal of a specified level, 
-- which is controlled by AI - 1 or Player -2,
-- in a specified index of cards.
------------------------------------------
function GetHighestATKMonByLevelOrSS(Cards,Type, Level, Position, Owner)
  local HighestATK   = 0
  local HighestIndex = 1
  if #Cards > 0 then
    for i=1,#Cards do
      if Cards[i] ~= false then
        if bit32.band(Cards[i].type,Type) == Type and Cards[i].owner == Owner or Cards[i].rank > 0 and Cards[i].owner == Owner and 
        Cards[i].attack > HighestATK then  
        HighestATK = Cards[i].attack
        HighestIndex = i
		elseif bit32.band(Cards[i].type,TYPE_MONSTER) > 0 and (Cards[i].owner == Owner or CurrentMonOwner(Cards[i].cardid) == Owner) and
         Cards[i].attack > HighestATK and Cards[i].level >= Level and Cards[i].position == Position then
          HighestATK = Cards[i].attack
          HighestIndex = i
        end
      end
    end
  end
  return {HighestIndex}
end

------------------------------------------
-- Returns the location of the highest ATK
-- monster with same ID's, 
-- which is controlled by AI - 1 or Player -2,
-- in a specified index of cards.
------------------------------------------
function GetHighestATKMonBySameID(Cards, Position, Owner)
  local HighestATK   = 0
  local HighestIndex = 1
  if #Cards > 0 then
    for i=1,#Cards do
      if Cards[i] ~= false then
        if bit32.band(Cards[i].type,TYPE_MONSTER) == TYPE_MONSTER and 
           Cards[i].attack > HighestATK and Cards[i].id == Cards[i].id and Cards[i].position == Position then
          if (Cards[i].owner == Owner or CurrentMonOwner(Cards[i].cardid) == Owner) then
          HighestATK = Cards[i].attack
          HighestIndex = i
        end
      end
    end
   end
 end 
  return {HighestIndex}
end

-------------------------------------------------
-- **********************************************
-- Functions to calculate attack, or defense of cards
-- before preforming certain actions.
-- **********************************************
-------------------------------------------------

-------------------------------------------------
-- Function to calculate possible attack or defense 
-- increase for certain cards
-- when they are about to be summoned.
-------------------------------------------------
function CalculatePossibleSummonAttack(SummonableCards)
    
 for i=1,#SummonableCards do
 if SummonableCards[i] ~= false then
   if SummonableCards[i].id == 10000020 then -- Slifer the Sky Dragon
      SummonableCards[i].attack = SummonableCards[i].attack + 1000 * (Get_Card_Count(AIHand()) -1)
      end
    end
  end
 
 for i=1,#SummonableCards do
 if SummonableCards[i] ~= false then
   if SummonableCards[i].id == 10000010 then -- The Winged Dragon of Ra	
      SummonableCards[i].attack = SummonableCards[i].attack + (AI.GetPlayerLP(1) - 100)
      end
    end
  end
 
 for i=1,#SummonableCards do
 if SummonableCards[i] ~= false then
   if SummonableCards[i].id == 12014404 then -- Gagaga gunman
      SummonableCards[i].attack = SummonableCards[i].attack + 1500
      end
    end
  end
end
 
-------------------------------------------------
-- This temporarily applies ATK boosts to certain
-- cards, either built-in or from a field spell.
-------------------------------------------------
function ApplyATKBoosts(Cards)
  for i=1,#Cards do
    Cards[i].bonus = 0  -- bonus is used, if the ATK boost needs to use up a card to apply
                        -- (Honest, Crane, Lance...), to make sure they are not used on indestructible targets
  end
  ------------------------------------------------------
  -- Apply Jain, Lightsworn Paladin's, X-Saber Galahad's
  -- and Cyber Dragon Zwei's +300 ATK boost.
  ------------------------------------------------------
  if #Cards > 0 then
    for i=1,#Cards do
      if Cards[i] ~= false then
        if  Cards[i].id == 50604950 or -- XSG
           Cards[i].id == 05373478 then                          -- Zwei
          Cards[i].attack = Cards[i].attack + 300
        end
      end
    end
  end
  ---------------------------------------------------------
  -- Apply Max Warrior's, Black Veloci's, T.G. Rush Rhino's
  -- and Crystal Beast Topaz Tiger's +400 ATK boost.
  ---------------------------------------------------------
  if #Cards > 0 then
    for i=1,#Cards do
      if Cards[i] ~= false then
        if Cards[i].id == 94538053 or Cards[i].id == 52319752 or   -- Max,BV
           Cards[i].id == 36687247 or Cards[i].id == 95600067 then -- RR,CBTT
          Cards[i].attack = Cards[i].attack + 400
        end
      end
    end
  end
  -------------------------------------------------------
  -- Apply Steamroid's and Etoile Cyber's +500 ATK boost.
  -------------------------------------------------------
  if #Cards > 0 then
    for i=1,#Cards do
      if Cards[i] ~= false then
        if Cards[i].id == 96235275 or
           Cards[i].id == 11460577 then
          Cards[i].attack = Cards[i].attack + 500
        end
      end
    end
  end
  ----------------------------------------
  -- Apply Dash Warrior's +1200 ATK boost.
  ----------------------------------------
  if #Cards > 0 then
    for i=1,#Cards do
      if Cards[i] ~= false then
        if Cards[i].id == 342570017 then
          Cards[i].attack = Cards[i].attack + 1200
        end
      end
    end
  end
  -------------------------------------------
  -- Apply Skyscraper's 1000 ATK boost to any
  -- Elemental HERO monsters the AI controls.
  -------------------------------------------
  if Get_Card_Count_ID(UseLists({AIMon(),AIST(),OppMon(),OppST()}), 63035430, POS_FACEUP) > 0 then
    if #Cards > 0 then
      for i=1,#Cards do
        if Cards[i] ~= false then
          if IsEHeroMonster(Cards[i].id) == 1 then
            Cards[i].attack = Cards[i].attack + 1000
          end
        end
      end
    end
  end
  
  -------------------------------------------
  -- Gagaga Gunman's 1500 ATK boost if his
  -- attacking opponents monster.
  -------------------------------------------
    if #Cards > 0 then
      for i=1,#Cards do
        if Cards[i] ~= false then
          if Cards[i].id == 12014404 then
		   if Global1PTGunman == 1 then
			Cards[i].attack = Cards[i].attack + 1500
          end
        end
      end
    end
  end
  
  ------------------------------------------
  -- Apply Dark City's 1000 ATK boost to any
  -- Destiny HERO monsters the AI controls.
  ------------------------------------------
  if Get_Card_Count_ID(UseLists({AIMon(),AIST(),OppMon(),OppST()}), 53527835, POS_FACEUP) > 0 then
    if #Cards > 0 then
      for i=1,#Cards do
        if Cards[i] ~= false then
          if IsDHeroMonster(Cards[i].id) == 1 then
            Cards[i].attack = Cards[i].attack + 1000
          end
        end
      end
    end
  end
  
  ------------------------------------------
  -- Apply Tensen's 1000 ATK boost to Beast-
  -- Warrior monsters
  ------------------------------------------
  if #Cards > 0 then
    local ST = AIST()
    local check = false
    for i=1,#ST do
      if ST[i].id == 44920699 and bit32.band(ST[i].position,POS_FACEDOWN)>0
      and bit32.band(ST[i].status,STATUS_SET_TURN)==0 then
        check = true
      end
    end
    if check then
      for i=1,#Cards do
        if Cards[i].race==RACE_BEASTWARRIOR and CurrentOwner(Cards[i])==1 then
          Cards[i].attack = Cards[i].attack + 1000
          Cards[i].bonus = 1000
        end
      end
    end
  end
  
  ------------------------------------------
  -- Apply Forbidden Lance's 800 ATK reduction
  ------------------------------------------
  if #Cards > 0 then
    local ST = AIST()
    local check = false
    if HasIDNotNegated(AIST(),27243130,true) then
      check = true
    end
    if HasIDNotNegated(AIHand(),27243130,true) 
    and Duel.GetLocationCount(player_ai,LOCATION_SZONE)>0 
    then
      check = true
    end
    if check then
      for i=1,#Cards do
        local c = Cards[i]
        if CurrentOwner(c)==2 
        and Affected(c,TYPE_SPELL)
        and Targetable(c,TYPE_SPELL)
        and not ArmadesCheck(c)
        then
          Cards[i].attack = Cards[i].attack -800
          Cards[i].bonus = -800
        end
      end
    end
  end
  
  ------------------------------------------
  -- Apply Forbidden Chalice 400 ATK boost
  ------------------------------------------
  if #Cards > 0 then
    local ST = AIST()
    local check = false
    for i=1,#ST do
      if ST[i].id == 25789292 and bit32.band(ST[i].status,STATUS_SET_TURN)==0 then
        check = true
      end
    end
    if HasID(AIHand(),25789292,true) and Duel.GetLocationCount(player_ai,LOCATION_SZONE)>0 then
      check = true
    end
    if check then
      for i=1,#Cards do
        if CurrentOwner(Cards[i])==1  
        and (Cards[i]:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
        or QliphortFilter(Cards[i],27279764))
        and Cards[i]:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
        then
          Cards[i].attack = Cards[i].attack+400+QliphortAttackBonus(Cards[i].id,Cards[i].level)
          Cards[i].bonus = 400+QliphortAttackBonus(Cards[i].id,Cards[i].level)
        end
      end
    end
  end 
  
  ------------------------------------------
  -- Apply attack bonuses monster get for Skill Drain
  ------------------------------------------
  if #Cards > 0 then
    local ST = AIST()
    local check = false
    for i=1,#ST do
      if ST[i].id == 82732705 and bit32.band(ST[i].status,STATUS_SET_TURN)==0 
      and AI.GetPlayerLP(1)>1000 and not SkillDrainCheck()
      then
        check = true
      end
    end
    if check then
      for i=1,#Cards do
        if CurrentOwner(Cards[i])==1 
        and (Cards[i]:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
        or QliphortFilter(Cards[i],27279764))
        and NotNegated(Cards[i])
        then
          Cards[i].attack = Cards[i].attack+QliphortAttackBonus(Cards[i].id,Cards[i].level)
        end
      end
    end
  end 
  ------------------------------------------
  -- Apply Vampire Empire's Attack Boost
  ------------------------------------------
  if HasID(UseLists({AIST(),OppST()}),62188962,true) then
    for i=1,#Cards do
      if bit32.band(Cards[i].race,RACE_ZOMBIE)>0 then
        Cards[i].attack = Cards[i].attack +500
      end
    end
  end
  ------------------------------------------
  -- Apply Bujingi Crane's Attack Doubling
  ------------------------------------------
  for i=1,#Cards do
    if HasID(AIHand(),68601507,true) and bit32.band(Cards[i].setcode,0x88)>0
    and bit32.band(Cards[i].race,RACE_BEASTWARRIOR)>0 and Cards[i].owner==1 
    and MacroCheck()
    then
      Cards[i].bonus = Cards[i].base_attack * 2 - Cards[i].attack 
      Cards[i].attack = Cards[i].base_attack * 2
    end
  end
  
  ------------------------------------------
  -- Apply Bujingi Sinyou's Attack Bonus
  ------------------------------------------
  for i=1,#Cards do
    if HasID(AIGrave(),56574543,true) and bit32.band(Cards[i].setcode,0x88)>0
    and bit32.band(Cards[i].race,RACE_BEASTWARRIOR)>0 and CurrentOwner(Cards[i])==1
    then
      local OppAtt = Get_Card_Att_Def(OppMon(),"attack",">",nil,"attack")
      Cards[i].attack = Cards[i].attack + OppAtt
      Cards[i].bonus = OppAtt
    end
  end
  
  ------------------------------------------
  -- Apply Honest's Attack Bonus
  ------------------------------------------
  for i=1,#Cards do
    if HasID(AIHand(),37742478,true) and CurrentOwner(Cards[i])==1
    and bit32.band(Cards[i].attribute,ATTRIBUTE_LIGHT)>0 
    and MacroCheck()
    then
      local OppAtt = Get_Card_Att_Def(OppMon(),"attack",">",nil,"attack")
      Cards[i].attack = Cards[i].attack + OppAtt
      Cards[i].bonus = OppAtt
    end
  end
  
  -- Nekroz Decisive Armor
  for i=1,#Cards do
    if HasID(AIHand(),88240999,true) and NekrozMonsterFilter(Cards[i])
    and CurrentOwner(Cards[i])==1 and not FilterAffected(Cards[i],EFFECT_CANNOT_BE_EFFECT_TARGET)
    then
      Cards[i].bonus = Cards[i].bonus + 1000
      Cards[i].attack = Cards[i].attack + 1000
    end
  end
  
  -- Nekroz Clausolas
  for i=1,#Cards do
    if HasIDNotNegated(AIMon(),99185129,true) and OPTCheck(991851291) then
      for i=1,#Cards do
        if ClausFilter2(Cards[i]) then
          Cards[i].attack = 0
        end
      end
    end
  end
  
  -- Utopia Lightning
  for i=1,#Cards do
    local c = Cards[i]
    if c.id == 56832966 
    and c.xyz_material_count>1
    and CardsMatchingFilter(c.xyz_materials,FilterSet,0x7f)>0
    and NotNegated(c)
    and #OppMon()>0
    then
      c.bonus = 5000-c.attack
      c.attack = 5000
    end
  end
  
  -- Kalut
  for i=1,CardsMatchingFilter(AIHand(),FilterID,85215458) do
    for j=1,#Cards do
      local c = Cards[j]
      if BlackwingFilter(c) 
      and CurrentOwner(c)==1
      and MacroCheck()
      then
        c.attack=c.attack+1400
        if c.bonus==nil then
          c.bonus=0
        end
        c.bonus=c.bonus+1400
      end
    end
  end
  
 
  -- Shrink
  if HasIDNotNegated(AICards(),55713623,true) then
    for i=1,#Cards do
      local c = Cards[i]
      if Targetable(c,TYPE_SPELL) 
      and Affected(c,TYPE_SPELL)
      and CurrentOwner(c)==2
      then
        c.attack=c.attack-c.base_attack*.5
        c.bonus=c.base_attack*-.5
      end
    end
  end
  
  -- Masked HERO Koga
  if HasIDNotNegated(AICards(),50608164,true) then
    local atk = 0
    local Heroes = SubGroup(AIGrave(),HEROFilter)
    if Heroes and #Heroes>0 then
      SortByATK(Heroes,true)
      atk = math.min(atk,Heroes[1].attack)
    end
    for i=1,#Cards do
      local c = Cards[i]
      if Targetable(c,TYPE_MONSTER) 
      and Affected(c,TYPE_MONSTER,8)
      and CurrentOwner(c)==2
      then
        local temp=c.attack
        c.attack=math.max(0,c.attack-atk)
        c.bonus=c.attack-temp
      end
    end
  end
  
  
  local d = DeckCheck()
  if d and d.AttackBoost then
    d.AttackBoost(Cards)
  end
  
  -- Moon Mirror Shield
  for i=1,#Cards do
    local c = Cards[i]
    local equips = c:get_equipped_cards()
    if HasIDNotNegated(equips,19508728,true) then
      local list = OppMon()
      if CurrentOwner(c)==2 then
        list = AIMon()
      end
      c.attack=GetHighestAttDef(list)+100
    end
  end
  
  -- Crystal Wing
  for i,c in pairs(Cards) do
    if c.id == 50954680 -- Crystal Wing
    and NotNegated(c)
    then
      local targets = FilterController(c,1) and OppMon() or AIMon()
      if CardsMatchingFilter(targets,CrystalWingFilter,c)>0
      then
        SortByATK(targets,true)
        c.attack=(c.attack or 0)+targets[1].attack
      end
    end
  end
  
  -- unknown face-down monsters
  for i=1,#Cards do
    local c = Cards[i]
    if FilterPosition(c,POS_FACEDOWN_DEFENSE)
    and FilterPrivate(c)
    and CurrentOwner(c)==2
    then
      c.defense=1499
    end
  end
  
  -- fix cards with attack < 0 after attack boosts
  for i=1,#Cards do
    Cards[i].attack=math.max(Cards[i].attack,0)
  end
end
function CatastorFilter(c)
  return bit32.band(c.attribute,ATTRIBUTE_DARK)==0 
  and bit32.band(c.position,POS_FACEUP)>0
  and c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
end
-------------------------------------------------
-- **********************************************
-- Set of global functions to serve general purposes
-- **********************************************
-------------------------------------------------

--------------------------------------------------------
-- Certain effects and other things should only be used
-- by the AI once per turn to prevent infinite loops.
-- This will help allow them to be used once every turn.
--------------------------------------------------------
GlobalTurn = 0
function ResetOncePerTurnGlobals()
  if GlobalTurn == Duel.GetTurnCount() then 
    return
  end
  GlobalSummonRestriction = nil
  GlobalTurn = Duel.GetTurnCount() 
  Global1PTLylaST  = nil
  Global1PTGenome  = nil
  Global1PTHonest  = nil
  Global1PTFormula = nil
  Global1PTWaboku  = nil
  GlobalNoBattle   = nil  
  Global1PTVariable = nil
  Global1PTGunman   = nil
  Global1PTSparSSed = nil
  Global1PTAArchers = nil
  Global1PTPollux = nil
  GlobalAttackerID = 0
  GlobalKaustActivated = nil
  GlobalAdditionalTributeCount   = 0
  GlobalKaustActivationCount = 0
  GlobalPosChangedByControllerUseTime = 0
  GlobalPosChangedByController = nil
  GlobalPosChangedByController2 = nil
  GlobalSummonedThisTurn = 0
  GlobalSoulExchangeActivated = 0
  GlobalCostDownActivated = 0
  GlobalInfiniteLoopCheck = {}
 end

 function Globals()
  GlobalCocoonTurnCount = 0
  GlobalEffectNum = 0
 end

---------------------------------------
-- Sorts selected array of cards by 
-- cards of only specified parameters
--
-- Parameters (6):
-- Cards = array of cards for search
-- Level = card's level
-- Attribute = card's attribute
-- Race = card's race
-- Oper = operation used (> or ==)
-- Type = card's type
---------------------------------------
function Sort_List_By(Cards, Level, Attribute, Race, Oper, Type)
  local result = {}
  for i=1,#Cards do
   if  (Level       == nil or Cards[i].level == level) and
       (Attribute == nil or bit32.band(Cards[i].attribute,Attribute) > 0) and 
       (Race      == nil or bit32.band(Cards[i].race,Race) > 0) and
       (Oper      == nil or Oper == ">" and bit32.band(Cards[i].type,Type) > 0 or
       (Oper      == "==" and bit32.band(Cards[i].type,Type) == Type)) then 
     result[#result+1]=Cards[i]
    end
  end
  return result
end


----------------------------------------------------------
-- Compares each field of 2 specified cards. Returns True
-- if both are equal, and False if any field is different.
----------------------------------------------------------
function CardsEqual(Card1, Card2)
  if not (Card1 and Card2) then
    print("Warning: CardsEqual null cards")
    PrintCallingFunction()
    return false 
  end
  local type1=type(Card1)
  local type2=type(Card2)
  if type1~="table" and type1~="userdata" 
  or type2~="table" and type2~="userdata"
  then
    print("Warning: CardsEqual invalid cards")
    PrintCallingFunction()
    return false
  end
  if Card1.GetCode then
    Card1=GetCardFromScript(Card1)
  end
  if Card2.GetCode then
    Card2=GetCardFromScript(Card2)
  end
  return Card1 and Card2 and Card1.cardid==Card2.cardid
end

function CardsNotEqual(c1,c2)
  return not CardsEqual(c1,c2)
end

function ListHasCard(cards,c)
  if cards and c then
    for i=1,#cards do
      if CardsEqual(cards[i],c) then
        return true
      end
    end
  end
  return false
end

function ListRemoveCards(cards,rem)
  if rem == nil then
    return cards
  end
  if rem.GetCode then
    rem = GetCardFromScript(rem)
  end
  if type(rem) == "table" and rem.id then
    rem = {rem}
  end
  for i=1,#cards do
    for j=1,#rem do
      if cards[i] and rem[j] and CardsEqual(cards[i],rem[j]) then
        table.remove(cards,i)
      end
    end
  end
end
