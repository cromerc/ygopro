--Battle Claw Fox
function c511002145.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31173519,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c511002145.condition)
	e1:SetOperation(c511002145.operation)
	c:RegisterEffect(e1)
end
function c511002145.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and not tc:IsStatus(STATUS_BATTLE_DESTROYED) and tc:IsControler(1-tp)
end
function c511002145.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if not tc or not tc:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetOperation(c511002145.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	tc:RegisterEffect(e1)
end
function c511002145.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511002145)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
