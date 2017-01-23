-- Flight of the duel dragon
function c511009144.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009144.descost)
	e1:SetTarget(c511009144.target)
	e1:SetOperation(c511009144.activate)
	c:RegisterEffect(e1)
end
function c511009144.cfilter(c)
	return c:IsFaceup() and (c:IsRace(RACE_DRAGON) or c511009144.collection[c:GetCode()] or c:IsSetCard(0x1045) or c:IsSetCard(0x1093))  and c:IsAbleToGraveAsCost()
end
c511009144.collection={
	[86240887]=true;[86805855]=true;[70681994]=true;[511000705]=true;[1546123]=true;
	[64599569]=true;[84243274]=true;[91998119]=true;[74157028]=true;[87751584]=true;
	[40418351]=true;[79229522]=true;[2111707]=true;[25119460]=true;[9293977]=true;
	[84058253]=true;[72959823]=true;[100000570]=true;[100000029]=true;[100000621]=true;
	[54752875]=true;[86164529]=true;[21435914]=true;[6021033]=true;[2403771]=true;
	[68084557]=true;[52145422]=true;[62560742]=true;[50321796]=true;[76891401]=true;
	[511001275]=true;[1639384]=true;[77799846]=true;[95992081]=true;[511001273]=true;
	[21970285]=true;[92870717]=true;[51531505]=true;[15146890]=true;[14920218]=true;
	[88935103]=true;[83980492]=true;[19474136]=true;[15146890]=true;[14920218]=true;
}
function c511009144.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009144.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511009144.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511009144.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanTurnSet()
end
function c511009144.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009144.filter,tp,LOCATION_ONFIELD,0,1,nil) end
end
function c511009144.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(c511009144.filter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	local tc=sg:GetFirst()
	while tc do
		tc:CancelToGrave()
		Duel.ChangePosition(tc,POS_FACEDOWN)
		tc=sg:GetNext()
	end
	Duel.RaiseEvent(sg,EVENT_SSET,e,REASON_EFFECT,1-tp,tp,0)
end
