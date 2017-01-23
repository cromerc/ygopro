--Dark Mist
function c511002279.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetOperation(c511002279.activate)
	c:RegisterEffect(e1)
end
function c511002279.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c511002279.operation)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511002279.cfilter(c,lv)
	return c:GetLevel()==lv and c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToGraveAsCost()
end
function c511002279.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a then return end
	local lv=a:GetLevel()
	if Duel.IsExistingMatchingCard(c511002279.cfilter,tp,LOCATION_DECK,0,1,nil,lv) 
		and Duel.SelectYesNo(tp,aux.Stringid(92720564,0)) then
		Duel.Hint(HINT_CARD,0,511002279)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c511002279.cfilter,tp,LOCATION_DECK,0,1,1,nil,lv)
		Duel.SendtoGrave(g,REASON_COST)
		Duel.NegateAttack()
	end
end
