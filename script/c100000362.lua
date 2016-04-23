--シャイニング・スライ
function c100000362.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c100000362.ccon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCost(c100000362.cost1)
	e2:SetValue(c100000362.damval)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CHANGE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetCost(c100000362.cost2)
	e3:SetValue(c100000362.damval)
	c:RegisterEffect(e3)
end
function c100000362.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c100000362.ccon(e)
	return Duel.IsExistingMatchingCard(c100000362.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c100000362.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_EFFECT)
end
function c100000362.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(1-tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(1-tp,nil,1,1,nil)
	Duel.Release(g,REASON_EFFECT)
end
function c100000362.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end
