--Ｓｉｎ パラレルギア
function c513000072.initial_effect(c)
	--self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c513000072.descon)
	c:RegisterEffect(e2)
end
function c513000072.descon(e)
	return not Duel.IsEnvironment(27564031)
end

