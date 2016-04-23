--
--        Spellbook AI Version 1.7.1
--        produced by Yeon & Satone
--
--
spellbook={}
judgment={}
tower={}
JudgmentCount = 0
GlobalSpellbookCheck = false
CrescentAlready = false
JudgmentAlready = false
SecretsAlready = false
EternityAlready = false
MasterAlready = false
PowerAlready = false
LifeAlready = false
function SpellbookStartup(deck)
  AI.Chat("Spellbook of Judgment AI ver 1.7.1")
  AI.Chat("produced by Yeon & Satone")
  
  deck.Init = SpellbookOnSelectInit
  deck.Card = SpellbookOnSelectCard
  deck.Chain = SpellbookOnSelectChain
  deck.EffectYesNo = SpellbookOnSelectEffectYesNo
  deck.Position = SpellbookOnSelectPosition
  deck.Option = SpellbookOnSelectOption
  
  --[[
  deck.YesNo
  deck.BattleCommand 
  deck.AttackTarget
  deck.AttackBoost
  deck.Sum 
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = SpellbookActivateBlacklist
  deck.SummonBlacklist      = SpellbookSummonBlacklist
  deck.RepositionBlacklist  = SpellbookRepoBlacklist
  deck.Unchainable          = BoxerUnchainable
  deck.SetBlacklist	= SpellbookSetBlacklist
  deck.PriorityList         = BoxerPriorityList
  SpellbookResetOPT()
	local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
		--Duel.ConfirmCards(1-player_ai,g)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	Duel.RegisterEffect(e2,0)
end
DECK_SPELLBOOK    = NewDeck("Spellbook",46448938,SpellbookStartup)
SpellbookActivateBlacklist={
46448938,40230018,89739383,
14824019,61592395,97997309,
25123082,33981008,52628687,
56321639,56981417,41855169,
86585274,88616795,88241506,
89631139,01249315
}
SpellbookSummonBlacklist={
89631139,86585274,01249315,
40908371,
}
SpellbookSetBlacklist={
25123082,40230018,56981417,
61592395,89739383,46448938,
52628687,56321639,97997309,
88616795,
}
SpellbookRepoBlacklist={
41855169,14824019,
}
function SpellbookHasSpellcaster()
	return ((HasID(AIHand(),14824019) or HasID(AIHand(),88241506) or HasID(AIHand(),41855169) or HasID(AIHand(),88240808) or (HasID(AIHand(),89739383) and not SecretsAlready)) and GlobalSummonedThisTurn<1) or #AIMon()>0
end
function UseJudgment()
	return ((HasID(AIHand(),25123082) and UsePower() and not PowerAlready) or (HasID(AIHand(),89739383) and not SecretsAlready) or HasID(AIHand(),56321639) or HasID(AIHand(),33981008) or (HasID(AIHand(),56981417) and CheckMaster() and not MasterAlready and (HasID(UseLists({AIGrave(),AIST()}),89739383) or HasID(UseLists({AIGrave(),AIST()}),40230018)) or (HasID(AIHand(),14824019) and GlobalSummonedThisTurn<1)) or (HasID(AIHand(),61592395) and HasID(AIBanish(),89739383))) and SpellbookSearchCheck()
end
function UsePower()
	if Duel.GetTurnCount() == 1 or AI.GetCurrentPhase() == PHASE_MAIN2 then
		return false
	end
	return #OppMon()>0 and #AIMon()>0 and SpellbookSearchCheck()
end
function SpellbookSearchFilter(c)
	return c.setcode == 0x106e and not FilterAffected(c,EFFECT_CANNOT_TO_HAND)
end
function SpellbookSearchCheck()
	local sscheck = SubGroup(AIDeck(),SpellbookSearchFilter)
	return sscheck and #sscheck>0
end
function CheckMasterFilter(c)
	return c.setcode == 0x106e and c.id ~= 56981417
end
function CheckEternityFilter(c)
	return c.setcode == 0x106e and c.id ~= 61592395 and bit32.band(c.type,TYPE_SPELL)>0
end
function CheckMaster()
	local master = SubGroup(AIHand(),CheckMasterFilter)
	return master and #master>0 and SpellbookHasSpellcaster()
end
function CheckEternity()
	local eternity = SubGroup(AIBanish(),CheckEternityFilter)
	return eternity and #eternity>0
end
function JudgmentSummonable()
	return (HasID(UseLists({AIHand(),AIST()}),46448938,true) or (HasID(UseLists({AIHand(),AIST()}),61592395,true) and HasID(AIBanish(),46448938,true))) and HasID(UseLists({AIHand(),AIST()}),89739383,true) and Duel.IsExistingMatchingCard(Card.IsSetCard,player_ai,LOCATION_HAND,0,3,nil,0x106e)
end
function UseLife()
	return HasID(AIGrave(),14824019,true) and (HasID(AIGrave(),41855169,true) or HasID(AIGrave(),86585274,true))
end
function StarHallFilter(c)
	return c:IsSetCard(0x106e) and not c:IsCode(56321639)
end
function UseStarHall()
	return Duel.IsExistingMatchingCard(StarHallFilter,player_ai,LOCATION_HAND,0,2,nil) or not Duel.IsExistingMatchingCard(StarHallFilter,player_ai,LOCATION_HAND,0,1,nil)
end
function UsePriestess()
	return Duel.IsExistingMatchingCard(Card.IsDestructable,player_ai,0,LOCATION_ONFIELD,1,nil)
end
function SpSummonHeraldSpellbook()
	return HasID(AIGrave(),41855169) and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed)
end
function SpellbookOnSelectInit(cards,to_bp_allowed,to_ep_allowed)
  SpellbookResetOPT()
	local Activatable = cards.activatable_cards
	local Summonable = cards.summonable_cards
	local SpSummonable = cards.spsummonable_cards
	local Repositionable = cards.repositionable_cards
	local SetableST = cards.st_setable_cards
	if HasID(Activatable,86585274,false,1385364384) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,40230018) then
		CrescentAlready = true
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,40230018)}
	end
	if SpellbookSearchCheck() and HasID(Repositionable,14824019) and Repositionable[CurrentIndex].position == POS_FACEDOWN_DEFENCE then
		return {COMMAND_CHANGE_POS,CurrentIndex}
	end
	if HasID(Repositionable,41855169) and Repositionable[CurrentIndex].position == POS_FACEDOWN_DEFENCE then
		return {COMMAND_CHANGE_POS,CurrentIndex}
	end
	if HasID(Summonable,41855169) and JudgmentSummonable() then
		GlobalSummonedThisTurn = GlobalSummonedThisTurn + 1
		return {COMMAND_SUMMON,IndexByID(Summonable,41855169)}
	end
	if HasID(Summonable,88241506) and JudgmentSummonable() then
		GlobalSummonedThisTurn = GlobalSummonedThisTurn + 1
		return {COMMAND_SUMMON,IndexByID(Summonable,88241506)}
	end
	if HasID(Summonable,88240808) and JudgmentSummonable() then
		GlobalSummonedThisTurn = GlobalSummonedThisTurn + 1
		return {COMMAND_SUMMON,IndexByID(Summonable,88240808)}
	end
	if HasID(Summonable,14824019) and SpellbookSearchCheck() then
		GlobalSummonedThisTurn = GlobalSummonedThisTurn + 1
		return {COMMAND_SUMMON,IndexByID(Summonable,14824019)}
	end
	if HasID(Activatable,46448938) and UseJudgment() then
		JudgmentAlready = true
		JudgmentCount = 0
		return {COMMAND_ACTIVATE,IndexByID(Activatable,46448938)}
	end
	if HasID(Activatable,56321639) and UseStarHall() and (JudgmentAlready or not HasID(AIDeck(),46448938)) then
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,56321639)}
	end
	if HasID(Activatable,61592395) then
		EternityAlready = true
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,61592395)}
	end
	if HasID(Activatable,89739383) then
		SecretsAlready = true
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,89739383)}
	end
	if HasID(Activatable,56981417) and UsePower() and HasID(AIGrave(),25123082,true) then
		MasterAlready = true
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,56981417)}
	end
	if HasID(Activatable,25123082) and (UsePower() or (JudgmentCount == 2 and JudgmentAlready and SpellbookSearchCheck())) then
		PowerAlready = true
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,25123082)}
	end
	if HasID(Activatable,56981417) then
		MasterAlready = true
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,56981417)}
	end
	if HasID(Activatable,86585274,false,1385364385) and UsePriestess() then
		GlobalCardMode = 2
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,56321639) and (JudgmentAlready or not HasID(AIDeck(),46448938)) then
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,56321639)}
	end
	if HasID(Activatable,52628687) and UseLife() then
		LifeAlready = true
		GlobalCardMode = 1
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,52628687)}
	end
	if (JudgmentAlready or (#AIMon()>0 and not HasID(AIST(),33981008))) and HasID(Activatable,33981008) then
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SpSummonable,1249315) and SpSummonHeraldSpellbook() then
		return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,1249315)}
	end
	if HasID(Activatable,1249315) then
		return {COMMAND_ACTIVATE,IndexByID(Activatable,1249315)}
	end
	if HasID(Activatable,88616795) and JudgmentCount == 2 and JudgmentAlready and SpellbookSearchCheck() then
		JudgmentCount = JudgmentCount + 1
		return {COMMAND_ACTIVATE,IndexByID(Activatable,88616795)}
	end
	if not HasID(AIST(),97997309) and (AI.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed) and #AIMon()>0 and HasID(SetableST,97997309) then
		return {COMMAND_SET_ST,IndexByID(SetableST,97997309)}
	end
	if not HasID(AIST(),88616795) and (AI.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed) and #AIMon()>0 and HasID(SetableST,88616795) then
		return {COMMAND_SET_ST,IndexByID(SetableST,88616795)}
	end
	if HasID(Repositionable,14824019) and Repositionable[CurrentIndex].position == POS_FACEUP_ATTACK and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed) then
		return {COMMAND_CHANGE_POS,CurrentIndex}
	end
	if HasID(Repositionable,41855169) and Repositionable[CurrentIndex].position == POS_FACEUP_ATTACK and Repositionable[CurrentIndex].attack<Repositionable[CurrentIndex].defense then
		return {COMMAND_CHANGE_POS,CurrentIndex}
	end
	if HasID(Repositionable,41855169) and Repositionable[CurrentIndex].position == POS_FACEUP_DEFENCE and Repositionable[CurrentIndex].attack>Repositionable[CurrentIndex].defense then
		return {COMMAND_CHANGE_POS,CurrentIndex}
	end
	if HasID(SpSummonable,40908371) and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed) then
		return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,1249315)}
	end
end
function SpellbookOnSelectCard(cards, minTargets, maxTargets,ID,triggeringCard)
	if ID == 40230018 or ID == 14824019 or ID == 89739383 or ID == 61592395 then
		return SpellbookTarget(cards)
	end
	if ID == 88616795 then
		return WisdomTarget(cards)
	end
	if ID == 56981417 then
		return MasterTarget(cards)
	end
	if ID == 25123082 then
		return PowerTarget(cards)
	end
	if ID == 52628687 then
		return LifeTarget(cards)
	end
	if ID == 33981008 then
		return TowerTarget(cards)
	end
	if ID == 56321639 then
		return StarTarget(cards)
	end
	if ID == 97997309 then
		return FateTarget(cards,minTargets,maxTargets)
	end
	if ID == 86585274 then
		return PriestessTarget(cards,minTargets,maxTargets)
	end
	if ID == 1249315 then
		return HeraldSpellbookTarget(cards,minTargets,maxTargets)
	end
	if AI.GetCurrentPhase() == PHASE_END then
		return JudgmentTarget(cards,minTargets,maxTargets)
	end
	return nil
end
function AIHasMonster()
	local cards=OppMon()
	return #cards>0
end
function PowerTarget(cards)
	local result = nil
	if Duel.GetCurrentPhase()==PHASE_MAIN1 then
		result = Get_Card_Index(cards, 1, "Highest", TYPE_MONSTER, POS_FACEUP_ATTACK)
		if result == nil then
			result = Get_Card_Index(cards, 1, "Highest", TYPE_MONSTER, POS_FACEUP)
		end
	else
		result = SpellbookSearch(cards,1)
	end
	return result
end
bookbanish={}
function SetBookBanishPriority(cards)
	bookbanish[46448938]=0
	bookbanish[40230018]=0
	bookbanish[33981008]=0
	bookbanish[88616795]=0
	bookbanish[52628687]=0
	bookbanish[56981417]=0
	bookbanish[89739383]=0
	bookbanish[25123082]=0
	bookbanish[97997309]=0
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == 46448938 then
			c.prio = 22
			if bookbanish[c.id] == 1 then
				c.prio = c.prio + 7
			end
			bookbanish[c.id] = 1
		end
		if c.id == 40230018 then
			c.prio = 21
			if bookbanish[c.id] == 1 then
				c.prio = c.prio + 7
			end
			bookbanish[c.id] = 1
		end
		if c.id == 33981008 or c.id == 88616795 or c.id == 52628687 then
			c.prio = 20
			if bookbanish[c.id] == 1 then
				c.prio = c.prio + 7
			end
			bookbanish[c.id] = 1
		end
		if c.id == 56981417 then
			c.prio = 19
			if bookbanish[c.id] == 1 then
				c.prio = c.prio + 7
			end
			bookbanish[c.id] = 1
		end
		if c.id == 89739383 then
			c.prio = 18
			if bookbanish[c.id] == 1 then
				c.prio = c.prio + 7
			end
			bookbanish[c.id] = 1
		end
		if c.id == 25123082 then
			c.prio = 17
			if bookbanish[c.id] == 1 then
				c.prio = c.prio + 7
			end
			bookbanish[c.id] = 1
		end
		if c.id == 97997309 then
			c.prio = 16
			if bookbanish[c.id] == 1 then
				c.prio = c.prio + 7
			end
			bookbanish[c.id] = 1
		end
		if c.location == LOCATION_HAND then
			c.prio = c.prio - 14
		end
	end
end
function BookBanishCost(cards,count)
	local result=nil
	SetBookBanishPriority(cards)
	if cards and #cards>=count then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,count do
			result[i]=cards[i].index
		end
	end
	return result
end
function SetTowerPriority(cards)
	tower[97997309]=0
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == 97997309 then
			if tower[97997309] > 0 then
				c.prio = 7
			else
				tower[97997309] = tower[97997309] + 1
				c.prio = 5
			end
		end
		if c.id == 61592395 then
			c.prio = 6
		end
		if c.id == 56981417 then
			c.prio = 4
		end
		if c.id == 52628687 or c.id == 46448938 or c.id == 88616795 then
			c.prio = 3
		end
		if c.id == 25123082 then
			c.prio = 2
		end
		if c.id == 89739383 then
			c.prio = 1
		end
		if c.id == 41855169 then
			c.prio = 13
		end
		if c.id == 88241506 then
			c.prio = 12
		end
		if c.id == 88240808 then
			c.prio = 11
		end
	end
end
function TowerSelect(cards)
	local result={}
	SetTowerPriority(cards)
	if cards and #cards>0 then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function TowerTarget(cards)
	local result = nil
	result = TowerSelect(cards)
	if result == nil then
		result = {}
		for i=1,1 do
			result[i]=i
		end
	end
	return result
end
function SetStarSearchPriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = c.level
	end
end
function StarSearch(cards)
	local result={}
	SetStarSearchPriority(cards)
	if cards and #cards>0 then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function StarTarget(cards)
	local result = nil
	result = StarSearch(cards)
	if result == nil then
		result = {}
		for i=1,1 do
			result[i]=i
		end
	end
	return result
end
function SetLifeCostPriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == 14824019 then
			c.prio = 1
		end
	end
end
function SetLifePriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == 41855169 then
			c.prio = 2
		end
		if c.id == 86585274 then
			c.prio = 1
		end
	end
end
function LifeTarget(cards)
	local result = nil
	if GlobalCardMode == 1 then
		result = LifeCost(cards)
		GlobalCardMode = nil
	else
		result = LifeReborn(cards)
	end
	return result
end
function LifeCost(cards)
	local result=nil
	SetLifeCostPriority(cards)
	if cards and #cards>0 then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function LifeReborn(cards)
	local result=nil
	SetLifePriority(cards)
	if cards and #cards>0 then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function SetFatePriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if (c.id == 30459350 or c.id == 59305593 or c.id == 58921041 or c.id == 82732705) and (Duel.GetTurnPlayer()==player_ai or Duel.GetCurrentPhase()~=PHASE_MAIN1) then
			c.prio = 10000
		end
		if bit32.band(c.type,TYPE_MONSTER)>0 then
			c.prio = c.attack
		end
		if c.id == 99185129 then
			c.prio = 5000
		end
		if c.id == 14824019 then
			c.prio = 5000
		end
	end
end
function FateBanish(cards)
	local result=nil
	SetFatePriority(cards)
	if cards then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function FateTarget(cards,mi,ma)
	local result = nil
	if GlobalCardMode == 1 then
		result = BookBanishCost(cards,ma)
		GlobalCardMode = nil
	else
		result = FateBanish(cards)
	end
	return result
end
function SetHeraldSpellbookPriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == 41855169 then
			c.prio = 1
		end
		if c.id == 40230018 then
			c.prio = 2
		end
		if c.id == 89631139 then
			c.prio = 3
		end
		if c.id == 41855169 and JudgmentCount>2 then
			c.prio = 4
		end
	end
end
function HeraldSpellbookReturn(cards)
	local result=nil
	SetHeraldSpellbookPriority(cards)
	if cards then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function HeraldSpellbookTarget(cards,mi,ma)
	local result = nil
	result = HeraldSpellbookReturn(cards)
	return result
end
function MasterValue(cards)
	SetSpellbookPriority(cards,1)
	local result = 1
	if cards and #cards>0 then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result = cards[1].prio
	end
	return result
end
function MasterFilter(c)
	return c.setcode == 0x106e and (bit32.band(c.type,TYPE_SPELL)>0 or c.location == LOCATION_DECK)
end
function SetMasterPriority(cards)
	local sbook = SubGroup(AIDeck(),MasterFilter)
	local ebook = SubGroup(AIBanish(),MasterFilter)
	local sval = MasterValue(sbook)
	local eval = MasterValue(ebook)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == 25123082 and UsePower() then
			c.prio = 400
		end
		if c.id == 89739383 then
			c.prio = sval
		end
		if c.id == 61592395 then
			c.prio = eval
		end
	end
end
function MasterCopy(cards)
	local result=nil
	SetMasterPriority(cards)
	if cards then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,1 do
			result[i]=cards[i].index
		end
		GlobalMaster = cards[1].id
	end
	return result
end
function MasterTarget(cards)
	local result = nil
	if GlobalCardMode == 2 then
		if GlobalMaster ~= 25123082 then
			result = SpellbookSearch(cards,1)
		else
			result = Get_Card_Index(cards, 1, "Highest", TYPE_MONSTER, POS_FACEUP_ATTACK)
			if result == nil then
				result = Get_Card_Index(cards, 1, "Highest", TYPE_MONSTER, POS_FACEUP)
			end
		end
		GlobalCardMode = nil
	elseif GlobalCardMode == 1 then
		GlobalCardMode = 2
		result = MasterCopy(cards)
	else
		GlobalCardMode = 1
	end
	if result == nil then
		result = {}
		for i=1,1 do
			result[i]=i
		end
	end
	return result
end
function NotChainZero()
	local te = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
	if not te then
		return false
	end
	local p = te:GetHandlerPlayer()
	if p == player_ai then
		return false
	end
	return true
end
function SpellbookOnSelectChain(cards,only_chains_by_player)
  SpellbookResetOPT()
	if ((JudgmentAlready and HasID(OppMon(),99185129) or (not (Duel.GetTurnPlayer()==player_ai and AI.GetCurrentPhase()==PHASE_MAIN1 and HasID(AIHand(),25123802) and not PowerAlready and UsePower())) and (Duel.GetTurnPlayer()~=player_ai or AI.GetCurrentPhase()==PHASE_END or (HasID(AIST(),97997309) and HasID(AIHand(),97997309)) or NotChainZero()) and (OppHasMonster() or ((AI.GetCurrentPhase()~=MAIN1 or Duel.GetTurnPlayer()==player_ai) and (HasID(OppST(),30459350,true) or HasID(OppST(),59305593,true) or HasID(OppST(),58921041,true) or HasID(OppST(),82732705,true)))))) and HasID(cards,97997309,nil,1567956946)  then
		GlobalCardMode = 1
		JudgmentCount = JudgmentCount + 1
		return {1,CurrentIndex}
	end
	if ChainJudgment() and UseJudgment() and HasID(cards,46448938) then
		JudgmentAlready = true
		JudgmentCount = 0
		return {1,CurrentIndex}
	end
	if HasID(cards,88616795) and ChainWisdom() then
		JudgmentCount = JudgmentCount + 1
		return {1,CurrentIndex}
	end
	if HasID(cards,33981008) then
		return {1,CurrentIndex}
	end
	if HasID(cards,25123082) then
		return {1,CurrentIndex}
	end
	if HasID(cards,88241506) then
		return {1,CurrentIndex}
	end
	if HasID(cards,97997309,nil,1567956945) and ChainFateSecond() then
		GlobalCardMode = 1
		JudgmentCount = JudgmentCount + 1
		return {1,CurrentIndex}
	end
	if HasID(cards,84749824) and HasID(AIMon(),41855169,true) then
		return {1,CurrentIndex}
	end
	if HasID(cards,12607053) and SpellbookChainWaboku() and Global1PTWaboku ~= 1 then
	  	Global1PTWaboku = 1 
		return {1,CurrentIndex}
	end
	return nil
end
function SpellbookChainWaboku()
	local target = Duel.GetAttackTarget()
	if target and target:IsControler(player_ai) and target:IsCode(41855169) then
		return true
	end
	return false
end
function ChainFateSecond()
	local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(),CATEGORY_DESTROY)
	if ex then
		if cg:IsExists(function(c) return c:IsControler(player_ai) and c:IsCode(97997309) end,1,nil) and Duel.IsExistingMatchingCard(function(c) return c:IsCode(14824019) and c:IsFaceup() end,player_ai,LOCATION_MZONE,0,1,nil) then
			return true
		end
	end
	if Duel.GetCurrentPhase() == PHASE_BATTLE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
		if source and target and target:IsControler(player_ai) and target:IsFaceup() and target:IsCode(14824019) then
			return true
		end
	end
	return false
end
function SpellbookOnSelectEffectYesNo(id,triggeringCard)
	local result = nil
	if id == 33981008 or id == 25123082 or id == 88241506 or id == 56321639 then
		result = 1
	end
	return result
end
function ChainJudgment()
	local te = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
	if not te then
		return false
	end
	local tc = te:GetHandler()
	if tc:IsCode(86585274) then
		return true
	end
	return false
end
function FateCostFilter(c)
	return c.setcode == 0x106e
end
function FateFilter(c)
	return c.id == 97997309
end
function FatePlus()
	local cards=OppMon()
	local costs=SubGroup(AIGrave(),FateCostFilter)
	return #costs>1 and ((#costs>2 and AI.GetCurrentPhase()~=PHASE_MAIN1) or HasID(OppMon(),99185129)) and (#cards>1 or (#cards>0 and AI.GetCurrentPhase()==PHASE_END) or ((AI.GetCurrentPhase()~=PHASE_MAIN1 or Duel.GetTurnPlayer()==player_ai) and (HasID(OppST(),30459350,true) or HasID(OppST(),59305593,true) or HasID(OppST(),58921041,true) or HasID(OppST(),82732705,true)))) and JudgmentAlready and not FateAlready
end
function SetSpellbookPriority(cards,count)
	spellbook[25123082]=0
	spellbook[33981008]=0
	spellbook[40230018]=0
	spellbook[52628687]=0
	spellbook[56321639]=0
	spellbook[56981417]=0
	spellbook[61592395]=0
	spellbook[88616795]=0
	spellbook[89739383]=0
	spellbook[97997309]=0
	for i=1,#cards do
		local c=cards[i]
		c.index=i
		c.prio=0
		if c.id==40230018 then
			if count>1 and not (HasID(AIHand(),c.id,true) or HasID(AIHand(),89631139,true)) and count+Duel.GetFieldGroupCount(player_ai,LOCATION_HAND,0)-spellbook[40230018]>6 then
				c.prio=200
			end
		end
		if c.id==14824019 and (Duel.GetTurnCount()~=1 or not AIMon() or #AIMon()<1) and GlobalSummonedThisTurn<1 then
			c.prio=68
		end
		if c.id==46448938 then
			c.prio=48
			if JudgmentAlready or not UseJudgment() then
				c.prio=c.prio-26
			end
		end
		if c.id==89739383 then
			c.prio=46
			if SecretsAlready and AI.GetCurrentPhase()~=PHASE_END then
				c.prio=c.prio-26
			end
		end
		if c.id==56981417 then
			c.prio=44
			if (MasterAlready and AI.GetCurrentPhase()~=PHASE_END) or not CheckMaster() then
				c.prio=c.prio-26
			end
		end
		if c.id==25123082 then
			c.prio=42
			if (PowerAlready and AI.GetCurrentPhase()~=PHASE_END) or not UsePower() or not SpellbookHasSpellcaster() then
				c.prio=c.prio-26
			end
		end
		if c.id==52628687 then
			c.prio=40
			if (LifeAlready and AI.GetCurrentPhase()~=PHASE_END) or not UseLife() then
				c.prio=c.prio-26
			end
		end
		if c.id==97997309 then
			c.prio=38
			if FatePlus() and SpellbookHasSpellcaster() then
				c.prio=66
			end
			if HasID(UseLists({AIHand(),AIST()}),12607053,true) or HasID(UseLists({AIHand(),AIST()}),84749824,true) or not SpellbookHasSpellcaster() then
				c.prio=c.prio-26
			end
		end
		if c.id==33981008 then
			c.prio=34
		end
		if c.id==88616795 then
			c.prio=30
			if JudgmentAlready and JudgmentCount>2 then
				c.prio=36
			end
			if not SpellbookHasSpellcaster() then
				c.prio=c.prio-26
			end
		end
		if c.id==61592395 then
			c.prio=28
			if (LifeAlready and AI.GetCurrentPhase()~=PHASE_END) or not CheckEternity() then
				c.prio=c.prio-26
			end
		end
		if c.id==56321639 then
			c.prio=26
		end
		if HasID(AIST(),c.id,true) or HasID(AIHand(),c.id,true) then
			c.prio=c.prio-26
		end
		if c.location == LOCATION_DECK and (c.id==25123082 or c.id==33981008 or c.id==40230018 or c.id==52628687 or c.id==56321639 or c.id==56981417 or c.id==61592395 or c.id==88616795 or c.id==89739383 or c.id==97997309) then
			c.prio=c.prio-spellbook[c.id]*26
			spellbook[c.id]=spellbook[c.id]+1
		end
		if c.location == LOCATION_REMOVED then
			c.prio=c.prio+1
		end
		if c.id==56981417 and c.location == LOCATION_REMOVED and c.prio<44 then
			c.prio=32
		end
		if c.id == 41855169 and c.location == LOCATION_DECK then
			c.prio = 300
		end
		if c.id == 88241506 and c.location == LOCATION_DECK then
			c.prio = 200
		end
		if c.id == 88240808 and c.location == LOCATION_DECK then
			c.prio = 100
		end
		if c.id == 40230018 and c.location == LOCATION_HAND then
			c.prio = 400
		end
	end
end
function SpellbookSearch(cards)
	local result=nil
	SetSpellbookPriority(cards,1)
	if cards then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function SpellbookTarget(cards)
	local result=nil
	result=SpellbookSearch(cards)
	return result
end
function SetJudgmentPriority(cards,count)
	judgment[25123082]=0
	judgment[33981008]=0
	judgment[40230018]=0
	judgment[52628687]=0
	judgment[56321639]=0
	judgment[56981417]=0
	judgment[61592395]=0
	judgment[88616795]=0
	judgment[89739383]=0
	judgment[97997309]=0
	for i=1,#cards do
		local c=cards[i]
		c.index=i
		c.prio=0
		if c.id==40230018 then
			local ct=0
			if HasID(AIHand(),c.id,true) then
				ct=1
			end
			if HasID(AIHand(),c.id,89631139) then
				ct=ct+1
			end
			if count+Duel.GetFieldGroupCount(player_ai,LOCATION_HAND,0)-ct-judgment[40230018]>6 then
				c.prio=100
			end
		end
		if c.id==89739383 then
			c.prio=19
		end
		if c.id==61592395 and (HasID(AIST(),97997309,true) or HasID(AIBanish(),46448938,true)) then
			c.prio=18
		end
		if c.id==56321639 then
			c.prio=17
		end
		if c.id==56981417 then
			c.prio=16
		end
		if c.id==88616795 then
			c.prio=15
		end
		if c.id==25123082 then
			c.prio=14
		end
		if c.id==97997309 then
			c.prio=13
			if FatePlus() and SpellbookHasSpellcaster() then
				c.prio=28
			end
		end
		if c.id==52628687 then
			c.prio=12
		end
		if c.id==33981008 then
			c.prio=11
		end
		if c.id==89631139 then
			c.prio=10000
		end
		if (HasID(AIST(),c.id,true) and c.id~=56321639) or HasID(AIHand(),c.id,true) then
			c.prio=c.prio-10
		end
		if c.id==25123082 or c.id==33981008 or c.id==40230018 or c.id==52628687 or c.id==56321639 or c.id==56981417 or c.id==61592395 or c.id==88616795 or c.id==89739383 or c.id==97997309 then
			c.prio=c.prio-judgment[c.id]*10
			judgment[c.id]=judgment[c.id]+1
		end
		if c.id == 41855169 and c.location == LOCATION_DECK then
			c.prio = 300
		end
		if c.id == 88241506 and c.location == LOCATION_DECK then
			c.prio = 200
		end
		if c.id == 88240808 and c.location == LOCATION_DECK then
			c.prio = 100
		end
		if c.id == 40230018 and c.location == LOCATION_HAND then
			c.prio = 400
		end
	end
end
function JudgmentSearch(cards,count)
	local result=nil
	if count<3 then
		SetSpellbookPriority(cards,count)
	else
		SetJudgmentPriority(cards,count)
	end
	if cards and #cards>=count then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,count do
			result[i]=cards[i].index
		end
	end
	return result
end
function JudgmentTarget(cards,mi,ma)
	local result=nil
	result=JudgmentSearch(cards,ma)
	return result
end
function WisdomFilter(card)
	return card:IsControler(player_ai) and card:IsRace(RACE_SPELLCASTER) and card:IsLocation(LOCATION_MZONE) and card:IsPosition(POS_FACEUP)
end
function WisdomCodeFilter(card,code)
	return card:IsControler(player_ai) and card:IsRace(RACE_SPELLCASTER) and card:IsLocation(LOCATION_MZONE) and card:IsPosition(POS_FACEUP) and card:IsCode(code)
end
function ChainWisdom()
	local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(),CATEGORY_DESTROY)
	if ex then
		if cg:IsExists(function(c) return c:IsControler(player_ai) and c:IsCode(88616795) end,1,nil) then
			GlobalCardMode = 1
			return true
		end
	end
	local cc = Duel.GetCurrentChain()
	local e = Duel.GetChainInfo(cc,CHAININFO_TRIGGERING_EFFECT)
	if not e then
		return false
	end
	if e:GetHandler():GetCode()==88241506 then
		cc = cc - 1
	end
	local cardtype = Duel.GetChainInfo(cc,CHAININFO_EXTTYPE)
	local tg = Duel.GetChainInfo(cc,CHAININFO_TARGET_CARDS)
	local ex,cg = Duel.GetOperationInfo(cc,CATEGORY_DESTROY)
	local p = Duel.GetChainInfo(cc,CHAININFO_TRIGGERING_PLAYER)
	if e:GetHandler():GetCode()==88616795 then
		return false
	end
	if e:GetHandler():GetCode()==35480699 then
		GlobalCardMode = 1
		return true
	end
	local g
	if ex then
		if cg:IsExists(WisdomCodeFilter,1,nil,41855169) then
			GlobalWisdomID = 41855169
		elseif cg:IsExists(WisdomCodeFilter,1,nil,88241506) then
			GlobalWisdomID = 88241506
		else
			g = cg:Filter(WisdomFilter,nil):GetMaxGroup(Card.GetAttack)
		end
	elseif tg then
		if tg:IsExists(WisdomCodeFilter,1,nil,41855169) then
			GlobalWisdomID = 41855169
		else
			g = tg:Filter(WisdomFilter,nil):GetMaxGroup(Card.GetAttack)
		end
	end
	if (g or GlobalWisdomID) and bit32.band(cardtype, TYPE_SPELL+TYPE_TRAP)>0 and p ~= player_ai then
		GlobalWisdomType = cardtype
		if not GlobalWisdomID then
			GlobalWisdomID = g:GetFirst():GetCode()
		end
		return true
	end
	return false
end
function ChainWaboku()
	local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(),CATEGORY_DESTROY)
	if ex then
		if cg:IsExists(function(c) return c:IsControler(player_ai) and c:IsCode(12607053) end,1,nil) then
			GlobalCardMode = 1
			return true
		end
	end
	return false
end
function SetWisdomPriority(cards)
	for i=1,#cards do
		local c=cards[i]
		c.index=i
		c.prio=0
		if c.id == 41855169 then
			c.prio = 4
		end
		if c.id == 88241506 then
			c.prio = 3
		end
		if c.id == 86585274 then
			c.prio = 2
		end
		if c.id == 88240808 then
			c.prio = 1
		end
	end
end
function WisdomSelect(cards)
	local result=nil
	SetWisdomPriority(cards)
	if cards then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,1 do
			result[i]=cards[i].index
		end
	end
	return result
end
function WisdomTarget(cards)
	local result = {}
	if GlobalCardMode == 1 then
		GlobalCardMode = nil
		result = WisdomSelect(cards)
	else
		local filter = function(c) return c.id == GlobalWisdomID end
		result = RandomIndexFilter(cards,filter)
		GlobalWisdomID = nil
	end
	if result == nil then
		result = {math.random(#cards)}
	end
	return result
end
function SpellbookOnSelectOption(options)
	for i=1,#options do
		if options[i] == 1417868720 and (not GlobalWisdomType or bit.band(GlobalWisdomType, TYPE_TRAP) == 0) then
			GlobalWisdomType = nil
			return i
		end
		if options[i] == 1417868721 and GlobalWisdomType and bit.band(GlobalWisdomType, TYPE_TRAP) > 0 then
			GlobalWisdomType = nil
			return i
		end
	end
	return nil
end
SpellbookAtt={88241506,89631139,89631140,89631141,89631142,89631143,89631144}
SpellbookDef={1249315,41855169}
function SpellbookGetPos(id)
  result = nil
  for i=1,#SpellbookAtt do
    if SpellbookAtt[i]==id then return POS_FACEUP_ATTACK end
  end
  for i=1,#SpellbookDef do
    if SpellbookDef[i]==id then return POS_FACEUP_DEFENCE end
  end
	if id == 14824019 then
		return POS_FACEDOWN_DEFENCE
	end
  return result
end
function SpellbookOnSelectPosition(id, available)
  return SpellbookGetPos(id)
end
function PriestessTarget(cards,mi,ma)
  local result = nil
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
	result = BookBanishCost(cards,1)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    result = BestTargets(cards,1,true)
  end
  if result == nil then 
	result = {}
	for i=1,ma do
		result[i]=i
	end
 end
  return result
end
function EnableSpellbookCheck()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if not JudgmentAlready then
			return
		end
		local rc = re:GetHandler()
		local rcode = rc:GetCode()
		if rcode == 46448938 and rp == player_ai then
			return
		end
		if not rc:IsSetCard(0x106e) then
			JudgmentCount = JudgmentCount + 1
		end
	end)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_NEGATED)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local rc = re:GetHandler()
		local rcode = rc:GetCode()
		if rcode == 40230018 and rp == player_ai then
			CrescentAlready = false
		end
		if rcode == 46448938 and rp == player_ai then
			JudgmentAlready = false
		end
		if rcode == 89739383 and rp == player_ai then
			SecretsAlready = false
		end
		if rcode == 61592395 and rp == player_ai then
			EternityAlready = false
		end
		if rcode == 25123082 and rp == player_ai then
			PowerAlready = false
		end
		if rcode == 56981417 and rp == player_ai then
			MasterAlready = false
		end
		if rcode == 52628687 and rp == player_ai then
			LifeAlready = false
		end
		if not JudgmentAlready then
			return
		end
		if re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) then
			JudgmentCount = JudgmentCount - 1
		end
	end)
	Duel.RegisterEffect(e2,0)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e3:SetCountLimit(1)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		CrescentAlready = false
		JudgmentAlready = false
		SecretsAlready = false
		EternityAlready = false
		MasterAlready = false
		PowerAlready = false
		LifeAlready = false
	end)
	Duel.RegisterEffect(e3,0)
end
SpellbookTurn=0
function SpellbookResetOPT()
  if SpellbookTurn<Duel.GetTurnCount() 
  and not GlobalSpellbookCheck
  then
    SpellbookTurn=Duel.GetTurnCount()
    GlobalSpellbookCheck = true
    CrescentAlready = false
    JudgmentAlready = false
    SecretsAlready = false
    EternityAlready = false
    MasterAlready = false
    PowerAlready = false
    LifeAlready = false
    EnableSpellbookCheck()
  end
end
