--Infestation
function c511001303.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001303.condition)
	e1:SetTarget(c511001303.target)
	e1:SetOperation(c511001303.activate)
	c:RegisterEffect(e1)
end
function c511001303.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001303.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511001303.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local sc=g:GetFirst()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(-100)
			sc:RegisterEffect(e1)
			sc=g:GetNext()
		end
		local dam1=Duel.GetMatchingGroupCount(nil,tp,LOCATION_MZONE,0,nil)*100
		local dam2=Duel.GetMatchingGroupCount(nil,tp,0,LOCATION_MZONE,nil)*100
		Duel.BreakEffect()
		Duel.Damage(tp,dam1,REASON_EFFECT,true)
		Duel.Damage(1-tp,dam2,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end