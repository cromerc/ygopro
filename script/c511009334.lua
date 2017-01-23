--Odd-Eyes Accel
function c511009334.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetOperation(c511009334.activate)
	c:RegisterEffect(e1)
end
function c511009334.activate(e,tp,eg,ep,ev,re,r,rp)

		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetTargetRange(LOCATION_HAND,0)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetCondition(c511009334.ntcon)
		e1:SetTarget(c511009334.nttg)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
end
function c511009334.ntcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c511009334.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x99)
end
