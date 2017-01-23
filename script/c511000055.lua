--Ferocious Flora
function c511000055.initial_effect(c)
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetDescription(aux.Stringid(511000055,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_CAL)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000055.condition)
	e1:SetTarget(c511000055.target)
	e1:SetOperation(c511000055.operation)
	c:RegisterEffect(e1)
end
function c511000055.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (d~=nil and a:GetControler()==tp and a:IsRace(RACE_PLANT) and a:IsRelateToBattle())
		or (d~=nil and d:GetControler()==tp and d:IsRace(RACE_PLANT) and d:IsRelateToBattle())
end
function c511000055.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if chkc then return (a:GetControler()==tp and chkc==d) or (d:GetControler()==tp and chkc==a) end
	if chk==0 then
		if a:GetControler()==tp then
			return a:IsRace(RACE_PLANT) and d and d:IsCanBeEffectTarget(e)
		else return d:IsRace(RACE_PLANT) and a:IsCanBeEffectTarget(e) end
	end
	if a:GetControler()==tp then Duel.SetTargetCard(d)
	else Duel.SetTargetCard(a) end
end
function c511000055.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if not tc or not tc:IsRelateToEffect(e) or not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(-800)
	tc:RegisterEffect(e1)
end
