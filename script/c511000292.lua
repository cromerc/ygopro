--Infernity Sage
function c511000292.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000292,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000292.target)
	e1:SetOperation(c511000292.operation)
	c:RegisterEffect(e1)
end
function c511000292.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsDiscardable,tp,LOCATION_HAND,0,nil)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==g:GetCount() end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,g:GetCount())
end
function c511000292.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_DISCARD+REASON_EFFECT)
	end
end
