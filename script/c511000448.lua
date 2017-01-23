--Powerless Sphere
function c511000448.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000448.target)
	e1:SetOperation(c511000448.activate)
	c:RegisterEffect(e1)
end
function c511000448.filter(c)
	return c:IsFaceup() and c:GetAttack()~=c:GetBaseAttack()
end
function c511000448.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511000448.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c511000448.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511000448.filter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetBaseAttack())
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(tc:GetBaseDefense())
		tc:RegisterEffect(e2)
	end
end
