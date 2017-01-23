--バリアン・ボム
function c100000556.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_TOHAND)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetTarget(c100000556.target)
	e1:SetOperation(c100000556.operation)
	c:RegisterEffect(e1)
end
function c100000556.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c100000556.filter(c)
	return c:IsCode(47660516) or c:IsCode(92365601) or c:IsCode(100000286)
end
function c100000556.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000556.filter,tp,0,LOCATION_HAND,nil)
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,hg)
	if g:GetCount()>0 then
		Duel.SendtoGrave(hg,REASON_EFFECT+REASON_DESTROY)
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
	Duel.ShuffleHand(1-tp)
end
