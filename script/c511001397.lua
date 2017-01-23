--Unequal Treaty
function c511001397.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511001397.con)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511001397.drop)
	c:RegisterEffect(e2)
end
function c511001397.con(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():IsControler(tp) and Duel.GetAttackTarget()==nil
end
function c511001397.drop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then
		Duel.Recover(tp,100,REASON_EFFECT)
		Duel.Damage(1-tp,100,REASON_EFFECT)
	end
end
