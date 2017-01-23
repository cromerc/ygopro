--Dodge Roll
function c511000839.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetOperation(c511000839.operation)
	c:RegisterEffect(e1)
end
function c511000839.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckEvent(EVENT_PRE_BATTLE_DAMAGE) then
		Duel.ChangeBattleDamage(tp,0)
		Duel.ChangeBattleDamage(1-tp,0)
	else
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		e1:SetCountLimit(1)
		e1:SetOperation(c511000839.nodamop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000839.nodamop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
	Duel.ChangeBattleDamage(1-tp,0)
end
