--天啓の薔薇の鐘
function c100000411.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000411.target)
	e1:SetOperation(c100000411.activate)
	c:RegisterEffect(e1)
end
c100000411.collection={
	[49674183]=true;[96470883]=true;[31986288]=true;[41160533]=true;[51085303]=true;
	[41201555]=true;[75252099]=true;[58569561]=true;[96385345]=true;[17720747]=true;
	[98884569]=true;[23087070]=true;[1557341]=true;[12469386]=true;[2986553]=true;
	[51852507]=true;[44125452]=true;[61049315]=true;[79531196]=true;[89252157]=true;
	[32485271]=true;[33698022]=true;[73580471]=true;[4290468]=true;[25090294]=true;
	[45247637]=true;[71645243]=true;[73580471]=true;[4290468]=true;[25090294]=true;
}
function c100000411.filter(c)
	return (c:IsSetCard(0x218) or c100000411.collection[c:GetCode()]) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c100000411.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000411.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100000411.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c100000411.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
