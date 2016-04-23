function WizardStartup(deck)
	AI.Chat("Magician AI ver 0.9.99")
	AI.Chat("produced by Satone, Iroha, Postar, Nachk")
	deck.Init = WizardInit
	deck.Card = WizardCard
	deck.Chain = WizardChain
	deck.EffectYesNo = WizardEffectYesNo
	deck.ActivateBlacklist = WizardActivateBlacklist
	deck.SummonBlacklist = WizardSummonBlacklist
	deck.Unchainable = WizardUnchainable
	deck.PriorityList = WizardPriorityList
end
DECK_WIZARD = NewDeck("Wizard",72714461,WizardStartup)
function ScaleBetween(lv)
	local cards = AIST()
	local lsc = 0
	local rsc = 0
	for i=1,#cards do
		if bit32.band(cards[i].type,TYPE_PENDULUM)>0 then
			if lsc == 0 then
				lsc = Scale(cards[i])
			else
				rsc = Scale(cards[i])
			end
		end
	end
	if rsc == 0 then
		return false
	else
		return (lsc<lv and lv<rsc) or (lsc>lv and lv>rsc)
	end
end
function WizardPendulumSummonEx(lc,rc)
	local p = 0
	local l = 0
	local r = 0
	local lsc = 0
	local rsc = 0
	if lc == 51531505 then
		lsc = 8
	elseif lc == 15146890 then
		lsc = 1
	elseif lc == 16178681 then
		lsc = 4
	elseif lc == 71692913 then
		lsc = 3
	elseif lc == 14920218 or lc == 47075569 then
		lsc = 2
	elseif lc == 72714461 or lc == 88935103 then
		lsc = 5
	elseif lc == 57624336 then
		lsc = 7
	end
	if rc == 51531505 then
		rsc = 8
	elseif rc == 15146890 then
		rsc = 1
	elseif rc == 16178681 then
		rsc = 4
	elseif rc == 71692913 then
		rsc = 3
	elseif rc == 14920218 or rc == 47075569 then
		rsc = 2
	elseif rc == 72714461 or rc == 88935103 then
		rsc = 5
	elseif rc == 57624336 then
		rsc = 7
	end
	if HasID(AIST(),lc,true) then
		l = 1
	end
	if HasID(AIST(),rc,true) then
		r = 1
	end
	for i=1,#UseLists({AIHand(),AIExtra()}) do
		local c = UseLists({AIHand(),AIExtra()})[i]
		if c.id == lc and l == 0 and c.location == LOCATION_HAND then
			l = 1
		elseif c.id == rc and r == 0 and c.location == LOCATION_HAND then
			r = 1
		elseif ((lsc<c.level and c.level<rsc) or (lsc>c.level and c.level>rsc))
			and (GetPriority(c,PRIO_TOFIELD)>0
				or (GetPriority(c,PRIO_TOFIELD)+5>0 and c.location == LOCATION_EXTRA and FilterPosition(c,POS_FACEUP))) then
			p = p + 1
		end
	end
	return p>1
end
function WizardPendulumSummonExCheck(id)
	return ((id ~= 51531505 and ((HasID(AIHand(),51531505,true) and not ScaleCheck()) or HasID(AIST(),51531505,true)) and WizardPendulumSummonEx(id,51531505))
		or (id ~= 15146890 and ((HasID(AIHand(),15146890,true) and not ScaleCheck()) or HasID(AIST(),15146890,true)) and WizardPendulumSummonEx(id,15146890))
		or (id ~= 16178681 and ((HasID(AIHand(),16178681,true) and not ScaleCheck()) or HasID(AIST(),16178681,true)) and WizardPendulumSummonEx(id,16178681))
		or (id ~= 71692913 and ((HasID(AIHand(),71692913,true) and not ScaleCheck()) or HasID(AIST(),71692913,true)) and WizardPendulumSummonEx(id,71692913))
		or (id ~= 14920218 and ((HasID(AIHand(),14920218,true) and not ScaleCheck()) or HasID(AIST(),14920218,true)) and WizardPendulumSummonEx(id,14920218))
		or (id ~= 47075569 and ((HasID(AIHand(),47075569,true) and not ScaleCheck()) or HasID(AIST(),47075569,true)) and WizardPendulumSummonEx(id,47075569))
		or (id ~= 72714461 and ((HasID(AIHand(),72714461,true) and not ScaleCheck()) or HasID(AIST(),72714461,true)) and WizardPendulumSummonEx(id,72714461))
		or (id ~= 88935103 and ((HasID(AIHand(),88935103,true) and not ScaleCheck()) or HasID(AIST(),88935103,true)) and WizardPendulumSummonEx(id,88935103))
		or (id ~= 57624336 and ((HasID(AIHand(),57624336,true) and not ScaleCheck()) or HasID(AIST(),57624336,true)) and WizardPendulumSummonEx(id,57624336)))
		and Duel.GetTurnCount() ~= GlobalPendulum
end
function WizardOppHasReleaser()
	return HasID(OppMon(),99185129,true)
end
function UseEccentric(mode)
	if mode == 1 then
		return DestroyCheck(OppST(),true)>0 and OPTCheck(57624336)
	end
	return DestroyCheck(OppMon(),true)>0 and OPTCheck(57624337)
end
function UseDragonpitEff()
	local filter = function(c)
		return FilterPosition(c,POS_FACEDOWN)
			and DestroyFilter(c)
	end
	return CardsMatchingFilter(OppST(),filter)==1
end
function UseDragonPenEff(mode)
	return (HasID(AIHand(),88935103,true)
		or (HasID(UseLists({AIHand(),AIExtra()}),14920218,true) and ScaleBetween(6)
		and CardsMatchingFilter(AIHand(),MagiDragonFilter)>0)
	) and ((mode == 1 and DestroyCheck(OppST(),true)>0) or (mode == 2 and DestroyCheck(OppMon(),true)>0))
end
function MagiDragonFilter(c)
	return (c.setcode == 0x98 or c.setcode == 0x99) and c.id ~= 14920218
end
function WizardPendulumSummonFilter(c)
	c.prio = GetPriority(c,PRIO_TOFIELD)
	if c.location == LOCATION_EXTRA then
		if FilterPosition(c,POS_FACEUP) then
			c.prio = c.prio + 5
		else
			c.prio = -9999
		end
	end
	return c.prio>0 and ScaleBetween(c.level)
end
function WizardPendulumSummon()
	local x = CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),WizardPendulumSummonFilter)
	return x>0 or CardsMatchingFilter(AIHand(),FilterID,47075569)>1
end
function JokerFilter(c)
	return not FilterAffected(c,EFFECT_CANNOT_TO_HAND)
end
function SummonJoker()
	return CardsMatchingFilter(AIDeck(),JokerFilter)>0
end
function InsightFilter(c)
  return not FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
end
function UseInsight()
	return (((HasID(UseLists({AIHand(),AIST()}),51531505,true)
		or HasID(UseLists({AIHand(),AIST()}),15146890,true)
		or HasID(UseLists({AIHand(),AIST()}),71692913,true)
		or HasID(UseLists({AIHand(),AIST()}),14920218,true)
		or HasID(UseLists({AIHand(),AIST()}),47075569,true)
		or HasID(AIST(),72714461,true)
		or CardsMatchingFilter(AIHand(),FilterID,72614461)>1)
		and OPTCheck(53208660))
	or (HasID(UseLists({AIHand(),AIST()}),51531505,true)
	and (HasID(AIHand(),29587993,true) or HasID(UseLists({AIHand(),AIExtra()}),71692913,true)))
	or ((HasID(UseLists({AIHand(),AIExtra()}),47075569,true)
		and (HasID(UseLists({AIHand(),AIST()}),15146890,true)
			or HasID(UseLists({AIHand(),AIST()}),16178681,true)
			or HasID(UseLists({AIHand(),AIST()}),71692913,true)
			or HasID(UseLists({AIHand(),AIST()}),14920218,true)
		)
	)
	or (HasID(AIExtra(),47075569,true) and HasID(UseLists({AIHand(),AIST()}),47075569,true))
	or (HasID(AIHand(),47075569,true) and HasID(AIST(),47075569,true))
	or CardsMatchingFilter(AIHand(),FilterID,47075569)>1))
	and Duel.GetTurnCount() ~= GlobalPendulum
end
function UseDragonpit()
	return ((HasID(AIST(),72714461,true) and OPTCheck(53208660))
		or (HasID(AIHand(),29587993,true)
			and (HasID(UseLists({AIHand(),AIST()}),15146890,true)
				or HasID(UseLists({AIHand(),AIST()}),16178681,true)
				or HasID(UseLists({AIHand(),AIST()}),71692913,true)
				or HasID(UseLists({AIHand(),AIST()}),14920218,true)
				or HasID(UseLists({AIHand(),AIST()}),47075569,true)
				or HasID(UseLists({AIHand(),AIST()}),72714461,true)
				or HasID(AIHand(),88935103,true)
			)
		)
		or (HasID(UseLists({AIHand(),AIExtra()}),71692913,true)
			and (HasID(UseLists({AIHand(),AIST()}),15146890,true)
				or HasID(UseLists({AIHand(),AIST()}),16178681,true)
				or HasID(UseLists({AIHand(),AIST()}),14920218,true)
				or HasID(UseLists({AIHand(),AIST()}),47075569,true)
				or HasID(UseLists({AIHand(),AIST()}),72714461,true)
				or HasID(AIHand(),88935103,true)
			)
		)
		or (HasID(AIExtra(),71692913,true) and HasID(UseLists({AIHand(),AIST()}),71692913,true))
		or (HasID(AIHand(),71692913,true) and HasID(AIST(),71692913,true))
		or CardsMatchingFilter(AIHand(),FilterID,71692913)>1
		or (HasID(UseLists({AIHand(),AIExtra()}),47075569,true)
			and (HasID(UseLists({AIHand(),AIST()}),15146890,true)
				or HasID(UseLists({AIHand(),AIST()}),16178681,true)
				or HasID(UseLists({AIHand(),AIST()}),71692913,true)
				or HasID(UseLists({AIHand(),AIST()}),14920218,true)
			)
		)
		or (HasID(AIExtra(),47075569,true) and HasID(UseLists({AIHand(),AIST()}),47075569,true))
		or (HasID(AIHand(),47075569,true) and HasID(AIST(),47075569,true))
		or CardsMatchingFilter(AIHand(),FilterID,47075569)>1
	)
		and not HasID(AIST(),51531505,true)
		and Duel.GetTurnCount() ~= GlobalPendulum
end
function UseMagiUnder4()
	return ((HasID(AIST(),72714461,true) and OPTCheck(53208660)) or (HasID(AIST(),51531505,true) and (
		HasID(AIHand(),29587993,true)
		or (HasID(AIExtra(),71692913,true) and HasID(UseLists({AIHand(),AIST()}),71692913,true))
		or (HasID(AIHand(),71692913,true) and HasID(AIST(),71692913,true))
		or CardsMatchingFilter(AIHand(),FilterID,71692913)>1
		)
	)
	or ((HasID(AIST(),51531505,true) or HasID(AIST(),57624336,true) or HasID(AIST(),72714461,true)) and (
		(HasID(AIExtra(),47075569,true) and HasID(UseLists({AIHand(),AIST()}),47075569,true))
		or (HasID(AIHand(),47075569,true) and HasID(AIST(),47075569,true))
		or CardsMatchingFilter(AIHand(),FilterID,47075569)>1
		)
	))
		and Duel.GetTurnCount() ~= GlobalPendulum and not WizardOppHasReleaser()
end
function UseMagiOddEyes()
	return (HasID(AIST(),51531505,true) and (
		HasID(AIHand(),29587993,true)
		or (HasID(AIExtra(),71692913,true) and HasID(UseLists({AIHand(),AIST()}),71692913,true))
		or (HasID(AIHand(),71692913,true) and HasID(AIST(),71692913,true))
		or CardsMatchingFilter(AIHand(),FilterID,71692913)>1
		)
	)
		and Duel.GetTurnCount() ~= GlobalPendulum and not WizardOppHasReleaser()
end
function UseMagiEccentric()
	return ((HasID(UseLists({AIHand(),AIExtra()}),47075569,true)
			and (HasID(UseLists({AIHand(),AIST()}),15146890,true)
				or HasID(UseLists({AIHand(),AIST()}),16178681,true)
				or HasID(UseLists({AIHand(),AIST()}),71692913,true)
				or HasID(UseLists({AIHand(),AIST()}),14920218,true)
			)
		)
		or (HasID(AIExtra(),47075569,true) and HasID(UseLists({AIHand(),AIST()}),47075569,true))
		or (HasID(AIHand(),47075569,true) and HasID(AIST(),47075569,true))
		or CardsMatchingFilter(AIHand(),FilterID,47075569)>1
	)
		and Duel.GetTurnCount() ~= GlobalPendulum
end
function UseKiryu()
	return (HasID(UseLists({AIHand(),AIExtra()}),47075569,true)
			and (HasID(UseLists({AIHand(),AIST()}),15146890,true)
				or HasID(UseLists({AIHand(),AIST()}),16178681,true)
				or HasID(UseLists({AIHand(),AIST()}),71692913,true)
				or HasID(UseLists({AIHand(),AIST()}),14920218,true)
			)
		)
		or (HasID(AIExtra(),47075569,true) and HasID(UseLists({AIHand(),AIST()}),47075569,true))
		or (HasID(AIHand(),47075569,true) and HasID(AIST(),47075569,true))
		or CardsMatchingFilter(AIHand(),FilterID,47075569)>1
	or (HasID(AIST(),51531505,true) and (
		HasID(AIHand(),29587993,true)
		or (HasID(AIExtra(),71692913,true) and HasID(UseLists({AIHand(),AIST()}),71692913,true))
		or (HasID(AIHand(),71692913,true) and HasID(AIST(),71692913,true))
		or CardsMatchingFilter(AIHand(),FilterID,71692913)>1
		)
	)
		and Duel.GetTurnCount() ~= GlobalPendulum
end
function UsePCall()
	return not (HasID(AIST(),72714461,true) and
		(HasID(UseLists({AIHand(),AIST()}),51531505,true)
		or HasID(UseLists({AIHand(),AIST()}),15146890,true)
		or HasID(UseLists({AIHand(),AIST()}),71692913,true)
		or HasID(UseLists({AIHand(),AIST()}),14920218,true)
		or HasID(UseLists({AIHand(),AIST()}),47075569,true)
		or HasID(AIHand(),72714461,true)))
end
function SpSumAbsolute()
	return CardsMatchingFilter(AIMon(),TrapezeXFilter)>1 and HasID(AIExtra(),17016362,true) and not MP2Check()
end
function TrapezeXFilter(c)
	return FilterRace(c,RACE_SPELLCASTER) and FilterLevel(c,4)
end
function SpSumMagiSeven()
	return CardsMatchingFilter(AIMon(),FilterMagiSeven)>1
end
function FilterMagiSeven(c)
	return FilterLevel(c,7) and FilterPosition(c,POS_FACEUP) and c.id~=29587993
end
function SpSumTrapeze()
	return (HasID(AIMon(),16691074,true) or HasID(AIMon(),44405066)
		or (#AIMon()>3 and #OppMon()<2 and #AIMon() - 2 > CardsMatchingFilter(AIMon(),FilterID,29587993)))
		and not MP2Check()
end
function WizardInit(cards)
	local Act = cards.activatable_cards
	local Sum = cards.summonable_cards
	local SpSum = cards.spsummonable_cards
	local SetMon = cards.monster_setable_cards
	if HasIDNotNegated(Act,18144506) and DestroyCheck(OppST(),true)>1 then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,88935103,nil,nil,LOCATION_GRAVE) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,88935103,nil,nil,LOCATION_HAND) and ScaleCheck() == true then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,14920218,nil,nil,LOCATION_SZONE) and HasID(AIExtra(),72714461,true) then
		OPTSet(14920218)
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,14920218,nil,nil,LOCATION_HAND) and HasID(AIExtra(),72714461,true) and OPTCheck(14920218)
		and type(ScaleCheck())=="number" and ScaleCheck()>4 and not WizardOppHasReleaser() then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,57624336,nil,nil,LOCATION_MZONE) and UseEccentric(2) then
		OPTSet(57624337)
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,57624336,nil,nil,LOCATION_SZONE) and UseEccentric(1)
		and not (GlobalPendulum ~= Duel.GetTurnCount()
		and (HasID(UseLists({AIHand(),AIST()}),15146890,true)
			or HasID(UseLists({AIHand(),AIST()}),71692913,true)
			or HasID(UseLists({AIHand(),AIST()}),14920218,true)
			or HasID(UseLists({AIHand(),AIST()}),47075569,true)
		) and HasID(UseLists({AIHand(),AIExtra()}),47075569,true)
		and not HasID(AIHand(),51531505,true) and not HasID(AIHand(),72714461,true)) then
		OPTSet(57624336)
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasIDNotNegated(Act,72714461,nil,nil,LOCATION_SZONE,InsightFilter) and OPTCheck(53208660) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,72714461,nil,nil,LOCATION_HAND) and (UseInsight() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Sum,40318957) and SummonJoker() then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(Act,57624336,nil,nil,LOCATION_HAND) and UseEccentric(1) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,53208660) and UsePCall() then
		OPTSet(53208660)
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,15146890,nil,nil,LOCATION_SZONE) and WizardOppHasReleaser() then
		GlobalTargetSet(Duel.GetFirstMatchingCard(function(c)
			return c:IsDestructable() and c:IsCode(99185129)
		end,player_ai,0,LOCATION_MZONE,nil))
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,15146890,nil,nil,LOCATION_HAND) and CardsMatchingFilter(AIHand(),FilterType,TYPE_PENDULUM)>1 and WizardOppHasReleaser() and (not ScaleCheck() or (type(ScaleCheck())=="number" and ScaleCheck()>4)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,51531505,nil,nil,LOCATION_HAND) and (UseDragonpit() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,14920218,nil,nil,LOCATION_HAND) and (UseMagiUnder4() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,15146890,nil,nil,LOCATION_HAND) and (UseMagiUnder4() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,71692913,nil,nil,LOCATION_HAND) and (UseMagiUnder4() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,47075569,nil,nil,LOCATION_HAND) and (UseMagiUnder4() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,16178681,nil,nil,LOCATION_HAND) and (UseMagiOddEyes() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,57624336,nil,nil,LOCATION_HAND) and (UseMagiEccentric() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,88935103,nil,nil,LOCATION_HAND) and (UseKiryu() or WizardPendulumSummonExCheck(Act[CurrentIndex].id)) and not HasID(AIMon(),16178681,true) and ScaleCheck() then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,16178681,nil,nil,LOCATION_HAND) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,14920218,nil,nil,LOCATION_SZONE) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,51531505,nil,nil,LOCATION_SZONE) and UseDragonPenEff(1) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,15146890,nil,nil,LOCATION_SZONE) and UseDragonPenEff(2) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SpSum,80696379) and ScaleCheck() then
		GlobalMaterial = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSum,16691074) and SpSumAbsolute() then
		GlobalMaterial = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSum,17016362) and SpSumTrapeze() then
		GlobalMaterial = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(Act,96471335) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SpSum,96471335) and SpSumMagiSeven() and not MP2Check() and (OppGetStrongestAttDef()>2800 or Chance(50)) then
		GlobalMaterial = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSum,44405066) and SpSumMagiSeven() then
		GlobalMaterial = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSum,18326736) and MP2Check() then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	for i=1,#SpSum do
		if PendulumCheck(SpSum[i]) and WizardPendulumSummon() then
			if HasID(Act,51531505,true) and UseDragonpitEff() then
				GlobalTargetSet(Duel.GetFirstMatchingCard(function(c)
					return c:IsDestructable() and c:IsFacedown()
				end,player_ai,0,LOCATION_SZONE,nil))
				return {COMMAND_ACTIVATE,IndexByID(Act,51531505)}
			else
				GlobalPendulumSummoning = true
				GlobalPendulum = Duel.GetTurnCount()
				return {COMMAND_SPECIAL_SUMMON,i}
			end
		end
	end
	if HasID(Sum,57624336) and UseEccentric(2) then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(Sum,15146890) and #AIMon()<1 and #OppMon()>0 
		and 1800 >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(SetMon,88935103) and #AIMon()<1 then
		return {COMMAND_SET_MONSTER,CurrentIndex}
	end
	if HasID(SetMon,59438930) and #AIMon()<1 then
		return {COMMAND_SET_MONSTER,CurrentIndex}
	end
	if HasID(SetMon,57624336) and #AIMon()<1 then
		return {COMMAND_SET_MONSTER,CurrentIndex}
	end
	if HasID(Sum,47075569) and #AIMon()<1 and #OppMon()>0 
		and 1500 >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(SetMon,47075569) and #AIMon()<1 then
		return {COMMAND_SET_MONSTER,CurrentIndex}
	end
	if HasID(SetMon,72714461) and #AIMon()<1 and HasID(UseLists({AIHand(),AIST()}),14920218,true) then
		return {COMMAND_SET_MONSTER,CurrentIndex}
	end
	return nil
end
function SetTrapezeDestroyPriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = c.attack
		if c.owner == 1 and c.id == 29587993 then
			c.prio = -1000000
		end
		if c.owner == 2 then
			c.prio = -10000
		end
	end
end
function TrapezeDestroy(cards,count)
	local result=nil
	SetTrapezeDestroyPriority(cards)
	if cards and #cards>=count then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,count do
			result[i]=cards[i].index
		end
	end
	return result
end
function TrapezeTarget(cards,mi,ma)
	local result = nil
	if Duel.GetTurnPlayer() == player_ai then
		result = TrapezeDestroy(cards,mi)
	else
		result = BestTargets(cards,mi,true)
	end
	return result
end
function SetPtolemiMagiPriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == GlobalPtolemiMagi then
			c.prio = 1
		end
	end
end
function PtolemiMagiSpSum(cards,count)
	local result=nil
	SetPtolemiMagiPriority(cards)
	if cards and #cards>=count then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,count do
			result[i]=cards[i].index
		end
	end
	return result
end
function PtolemiMagiTarget(cards,mi,ma)
	local result = nil
	result = PtolemiMagiSpSum(cards,mi)
	return result
end
function SetWizardPriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = GetPriority(c,PRIO_TOGRAVE)
		if FilterLocation(c,LOCATION_SZONE) and FilterType(c,TYPE_PENDULUM) and OPTCheck(53208660) then
			c.prio = c.prio + 10
		end
	end
end
function WizardDestroy(cards,count)
	local result=nil
	SetWizardPriority(cards)
	if cards and #cards>=count then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result={}
		for i=1,count do
			result[i]=cards[i].index
		end
	end
	return result
end
function WizardTarget(cards,mi,ma)
	local result = nil
	result = WizardDestroy(cards,mi)
	return result
end
function DragonveinTarget(cards,ma)
	local result = nil
	result = GlobalTargetGet(cards,true)
	if result == nil then
		result = BestTargets(cards,ma,true)
	end
	return result
end
function DragonpitTarget(cards,ma)
	local result = nil
	result = GlobalTargetGet(cards,true)
	if result == nil then
		result = BestTargets(cards,ma,true)
	end
	return result
end
function WizardCard(cards,min,max,id,c)
	if GlobalPendulumSummoning then
		GlobalPendulumSummoning = nil
		local x = CardsMatchingFilter(cards,WizardPendulumSummonFilter)
		if CardsMatchingFilter(AIHand(),FilterID,47075569)>1 then
			x = x + 1
		end
		x = math.min(x,max)
		return Add(cards,PRIO_TOFIELD,x)
	end
	if id == 80696379 or (id == 16691074 and WizardCardMode == 1) then
		WizardCardMode = nil
		return Add(cards,PRIO_TOFIELD,max)
	end
	if (id == 16691074 or id == 51531505 or id == 15146890 or id == 53208660) and WizardCardMode == nil then
		WizardCardMode = 1
		return Add(cards,PRIO_TOGRAVE,min)
	end
	if id == 57624336 or id == 53262004 then
		return BestTargets(cards,max,true)
	end
	if id == 15146890 and WizardCardMode == 1 then
		WizardCardMode = nil
		return DragonveinTarget(cards,max)
	end
	if id == 51531505 and WizardCardMode == 1 then
		WizardCardMode = nil
		return DragonpitTarget(cards,max)
	end
	if id == 16178681 or id == 14920218 or id == 40318957 
		or ((id == 47075569 or id == 53208660) and WizardCardMode == 1) then
		return Add(cards,PRIO_TOHAND,max)
	end
	if id == 72714461 then
		return Add(cards,PRIO_DISCARD,max)
	end
	if id == 17016362 then
		return TrapezeTarget(cards,min,max)
	end
	if id == 71692913 then
		return GlobalTargetGet(cards,true)
	end
	if id == 18326736 then
		return PtolemiMagiTarget(cards,min,max)
	end
	if id == 47075569 and WizardCardMode == nil then
		WizardCardMode = 1
		return WizardTarget(cards,min,max)
	end
	return nil
end
function ChainAntithesis(card)
	local c = ChainCardNegation(card,true,false,FilterAttribute,ATTRIBUTE_LIGHT)
	if c then
		GlobalTargetSet(c,OppMon())
		return true
	end
	return false
end
function ChainPtolemiMagi(c)
	local cc = Duel.GetCurrentChain()
	if RemovalCheckCard(c) then
		local tg = Duel.GetChainInfo(cc,CHAININFO_TARGET_CARDS)
		if tg then
			GlobalPtolemiMagi = 73964868
		else
			local dx = Duel.GetOperationInfo(cc,CATEGORY_DESTROY)
			if dx then
				GlobalPtolemiMagi = 31386180
			else
				GlobalPtolemiMagi = 34945480
			end
		end
		return true
	end
	local te = Duel.GetChainInfo(cc,CHAININFO_TRIGGERING_EFFECT)
	if HasID(OppMon(),21565445,true) or HasID(OppMon(),95492061,true) or HasID(OppMon(),23401839,true)
		or (te and te:GetHandler():IsCode(21954587)) then
		GlobalPtolemiMagi = 34945480
		return true
	end
	if Duel.GetCurrentPhase() == PHASE_BATTLE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
		if source and target then
			if source:IsControler(player_ai) then
				target = Duel.GetAttacker()
				source = Duel.GetAttackTarget()
			end
		end
		if WinsBattle(source,target)
			and target:IsCode(18326736) and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT) then
			GlobalPtolemiMagi = 73964868
			return true
		end
	end
	return false
end
function TrapezeFilter(c)
	return c.id ~= 17016362 and c.id ~= 29587993
end
function ChainTrapeze()
	if Duel.GetTurnPlayer()==player_ai then
		return CardsMatchingFilter(AIMon(),TrapezeFilter)
	else
		return DestroyCheck(OppMon(),true)>0
	end
	return false
end
function WizardChain(cards)
	if HasIDNotNegated(cards,29587993,ChainNegation) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,71692913,ChainAntithesis) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,59438930,ChainNegation) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,53262004,ChainNegation) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,9272381,ChainNegation) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,18326736,nil,18326736*16+2) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,18326736,nil,18326736*16,ChainPtolemiMagi) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,56832966,ChainUtopiaLightning) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,16178681) then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,17016362,ChainTrapeze) then
		return {1,CurrentIndex}
	end
	return nil
end
function AbsoluteFilter(c)
	local cards = c.xyz_materials
	if cards and #cards then
		for i=1,#cards do
			if cards[i].setcode == 0x99 then
				return true
			end
		end
	end
	if Duel.GetTurnPlayer() ~= player_ai then
		return true
	end
	return false
end
function WizardEffectYesNo(id,card)
	local result = nil
	if id == 16178681 or id == 14920218 or id == 40318957 or id == 47075569 or id == 96471335
		or id == 18326736 or id == 53262004 then
		result = 1
	end
	if id == 16691074 and (CardsMatchingFilter(AIMon(),AbsoluteFilter) or not HasID(AIMon(),16691074,true)) then
		result = 1
	end
	return result
end
WizardActivateBlacklist=
{
29587993,
51531505,
15146890,
16178681,
71692913,
14920218,
40318957,
72714461,
47075569,
57624336,
88935103,
53208660,
59438930,
53262004,
80696379,
16691074,
44405066,
96471335,
9272381,
56832966,
17016362,
18326736,
18144506,
}
WizardSummonBlacklist=
{
29587993,
51531505,
15146890,
16178681,
71692913,
14920218,
40318957,
72714461,
47075569,
57624336,
88935103,
53208660,
59438930,
53262004,
80696379,
16691074,
44405066,
96471335,
9272381,
56832966,
17016362,
18326736,
}
WizardUnchainable=
{
29587993,
51531505,
15146890,
16178681,
71692913,
14920218,
40318957,
72714461,
47075569,
57624336,
88935103,
53208660,
59438930,
53262004,
80696379,
16691074,
44405066,
96471335,
9272381,
56832966,
17016362,
18326736,
}
function InsightCond(loc,c)
	if loc == PRIO_TOHAND then
		return not HasID(AIHand(),72714461,true)
	end
	return true
end
function DragonpitCond(loc,c)
	if loc == PRIO_TOHAND then
		return not HasID(UseLists{AIHand(),AIST()},51531505,true)
	end
	if loc == PRIO_DISCARD then
		return type(ScaleCheck())=="number" and ScaleCheck()<6
	end
	return true
end
function PeasantFilter(c)
	return (c.setcode == 0x98 or c.setcode == 0x99) and c.id ~= 14920218 and c.type == TYPE_PENDULUM
end
function PeasantPendFilter(c)
	return c.setcode == 0x98
end
function PeasantCond(loc,c)
	if loc == PRIO_TOHAND then
		return not HasID(UseLists{AIHand(),AIST()},14920218,true)
	end
	if loc == PRIO_TOFIELD then
		return CardsMatchingFilter(AIGrave(),PeasantFilter)
	end
	if loc == PRIO_DISCARD then
		return type(ScaleCheck())=="number" and ScaleCheck()>4 and not WizardOppHasReleaser()
	end
	return true
end
function AntithesisCond(loc,c)
	if loc == PRIO_TOHAND then
		return not HasID(UseLists{AIHand(),AIExtra()},71692913,true) and ScaleBetween(7)
	end
	if loc == PRIO_DISCARD then
		return type(ScaleCheck())=="number" and ScaleCheck()>4 and not WizardOppHasReleaser()
	end
	return true
end
function EccentricCond(loc,c)
	if loc == PRIO_TOFIELD then
		return DestroyCheck(OppMon(),true)>0 and OPTCheck(57624337)
	end
	return true
end
function DragonVeinCond(loc,c)
	if loc == PRIO_TOHAND or loc == PRIO_DISCARD then
		return CardsMatchingFilter(AIHand(),FilterType,TYPE_PENDULUM) and WizardOppHasReleaser() and (not ScaleCheck() or (type(ScaleCheck())=="number" and ScaleCheck()>4))
	end
	return true
end
function WizardCond(loc,c)
	if loc == PRIO_TOHAND then
		return not HasID(UseLists{AIHand(),AIExtra()},47075569,true) and ScaleBetween(7)
	end
	if loc == PRIO_TOFIELD then
		if HasID(AIExtra(),47075569,true) or CardsMatchingFilter(AIHand(),FilterID,47075569)>1 then
			return false
		end
	end
	return true
end
function KiryuCond(loc,c)
	if loc == PRIO_TOHAND then
		return HasID(UseLists({AIHand(),AIMon(),AIExtra()}),88935103,true)
	end
	return true
end
function MagiOddEyesCond(loc,c)
	if loc == PRIO_TOHAND then
		return not CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterSet,0x98)
			and not HasID(UseLists({AIHand(),AIST()}),47075569,true)
	end
	return true
end
WizardPriorityList={
[51531505] = {10,1,-2,1,-1,1,10,1,1,1,DragonpitCond},
[15146890] = {11,1,-1,1,-2,1,12,1,1,1,DragonVeinCond},
[29587993] = {1,1,12,1,-12,1,1,1,1,1,nil},
[16178681] = {13,1,1,1,2,1,1,1,1,1,MagiOddEyesCond},
[71692913] = {7,1,6,1,1,1,8,1,1,1,AntithesisCond},
[14920218] = {9,1,2,-3,-3,1,11,1,1,1,PeasantCond},
[40318957] = {1,1,-3,1,-6,1,1,1,1,1,nil},
[72714461] = {12,1,-4,1,-5,1,1,1,1,1,InsightCond},
[47075569] = {8,1,1,0,-4,1,1,1,1,1,WizardCond},
[57624336] = {1,1,1,-4,3,1,1,1,1,1,EccentricCond},
[88935103] = {7,1,-1,1,12,1,1,1,1,1,KiryuCond},
[53208660] = {1,1,1,1,4,1,1,1,1,1,nil},
}