--The World of True Darkness
function c511002451.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(c511002451.damval)
	c:RegisterEffect(e2)
	--no damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e3:SetOperation(c511002451.op)
	c:RegisterEffect(e3)
end
function c511002451.damval(e,re,val,r,rp,rc)
	return 0
end
function c511002451.op(e,tp,eg,ep,ev,re,r,rp)
	if ep==1-tp then
		Duel.Hint(HINT_CARD,0,511002451)
		Duel.ChangeBattleDamage(1-tp,0)
		Duel.Recover(tp,ev,REASON_EFFECT)
	end
end
