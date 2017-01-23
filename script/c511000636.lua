--時計型麻酔銃
function c511000636.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000636.target)
	e1:SetOperation(c511000636.activate)
	c:RegisterEffect(e1)
end
function c511000636.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 or c:GetRank()>0
end
function c511000636.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000636.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c511000636.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c511000636.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(c511000636.val)
		tc:RegisterEffect(e1)
	end
end
function c511000636.val(e,c)
	if c:GetLevel()>0 then
		return c:GetLevel()*-100
	else
		return c:GetRank()*-200
	end
end
