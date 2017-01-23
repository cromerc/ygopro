--Mind Monster
function c511000836.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000836.target)
	e1:SetOperation(c511000836.activate)
	c:RegisterEffect(e1)
end
function c511000836.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK+LOCATION_EXTRA)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,564)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c511000836.filter(c,code)
	return c:IsType(TYPE_MONSTER) and c:IsCode(code)
end
function c511000836.activate(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local sg=Duel.GetMatchingGroup(c511000836.filter,1-tp,LOCATION_DECK+LOCATION_EXTRA,0,nil,ac)
	Duel.ConfirmCards(tp,sg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=sg:Select(tp,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Damage(1-tp,tc:GetAttack()/2,REASON_EFFECT)
	end
end
