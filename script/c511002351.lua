--E・HERO ボルテック
function c511002351.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71107816,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002351.retcon)
	e1:SetTarget(c511002351.rettg)
	e1:SetOperation(c511002351.retop)
	c:RegisterEffect(e1)
end
function c511002351.retcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511002351.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(nil,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c511002351.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
end
