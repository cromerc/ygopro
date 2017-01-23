--Orchid Mantis
function c511000812.initial_effect(c)
	--discard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000812,0))
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000812.target)
	e1:SetOperation(c511000812.operation)
	c:RegisterEffect(e1)
end
function c511000812.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,g:GetCount())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c511000812.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	if g:GetCount()>0 then
		Duel.Damage(1-p,g:GetCount()*500,REASON_EFFECT)
	end
end
