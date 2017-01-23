--恋する乙女
function c100000139.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c100000139.sdcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetOperation(c100000139.ctop)
	c:RegisterEffect(e2)
end
function c100000139.sdcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c100000139.ctop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttackTarget() and Duel.GetAttackTarget()==e:GetHandler() then
		local tc=Duel.GetAttacker()
		if tc and tc:IsRelateToBattle() then
			tc:AddCounter(0x1090,1)
		end
	end
end
