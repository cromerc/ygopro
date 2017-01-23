--Coded by Lyris
--Double Evolution
function c511007029.initial_effect(c)
	--Double an equip spell effect.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511007029.target)
	e1:SetOperation(c511007029.operation)
	c:RegisterEffect(e1)
end
function c511007029.filter(c)
	return c:GetEquipTarget()~=nil-- and c:IsType(TYPE_EQUIP)
end
function c511007029.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511007029.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
end
function c511007029.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c511007029.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		tc:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000)
	end
end
