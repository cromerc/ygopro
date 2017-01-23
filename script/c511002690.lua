--Combat Wheel
function c511002690.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--adup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38180759,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002690.atkcon)
	e1:SetCost(c511002690.atkcost)
	e1:SetTarget(c511002690.atktg)
	e1:SetOperation(c511002690.atkop)
	c:RegisterEffect(e1)
	--target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetTarget(c511002690.tglimit)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c511002690.descon)
	e3:SetOperation(c511002690.desop)
	c:RegisterEffect(e3)
end
function c511002690.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and ph>=0x08 and ph<=0x20 
		and (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
end
function c511002690.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c511002690.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
end
function c511002690.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,c)
		local atk=g:GetSum(Card.GetAttack)
		if atk>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk/2)
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
		e:GetHandler():RegisterFlagEffect(511002690,RESET_PHASE+PHASE_END,0,1)
	end
end
function c511002690.tglimit(e,c)
	return c~=e:GetHandler()
end
function c511002690.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511002690)~=0
end
function c511002690.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511002690)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
