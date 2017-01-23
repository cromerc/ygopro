--グランエルＡ
function c100000063.initial_effect(c)
	--selfdes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c100000063.sdcon2)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c100000063.piercecon)
	e2:SetOperation(c100000063.piercetg)
	c:RegisterEffect(e2)
end
function c100000063.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000063.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c100000063.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c100000063.piercecon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsControler(tp) and d:IsDefensePos() and a:IsSetCard(0x3013)
end
function c100000063.piercetg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
		if tc and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
