--Dragon Cry
function c511002168.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCondition(c511002168.condition)
	e1:SetOperation(c511002168.activate)
	c:RegisterEffect(e1)
end
function c511002168.cfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(4) and c:IsRace(RACE_DRAGON)
end
function c511002168.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return tp~=Duel.GetTurnPlayer() and bit.band(ph,PHASE_MAIN2+PHASE_END)==0 
		and Duel.IsExistingMatchingCard(c511002168.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002168.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(0,1)
	Duel.RegisterEffect(e1,tp)
end
