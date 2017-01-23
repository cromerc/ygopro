--クロック・リゾネーター
function c511002880.initial_effect(c)
	--battle des rep
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002880.reptg)
	c:RegisterEffect(e1)
end
function c511002880.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE) end
	return true
end
