--Force of Four
function c511000315.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000315.activate)
	c:RegisterEffect(e1)
	--send
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_HANDES)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511000315.activate)
	c:RegisterEffect(e2)
end
function c511000315.activate(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if h1>4 then
		local ct=h1-4
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,ct,ct,nil)
		Duel.SendtoGrave(g1,REASON_EFFECT)
	end
	if h2>4 then
		local ct=h2-4
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local g2=Duel.SelectMatchingCard(1-tp,aux.TRUE,1-tp,LOCATION_HAND,0,ct,ct,nil)
		Duel.SendtoGrave(g2,REASON_EFFECT)
	end
end
