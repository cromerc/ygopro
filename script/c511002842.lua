--Synchro Library
function c511002842.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002842.condition)
	e1:SetCost(c511002842.cost)
	e1:SetTarget(c511002842.target)
	e1:SetOperation(c511002842.activate)
	c:RegisterEffect(e1)
end
function c511002842.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511002842.cfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemoveAsCost()
end
function c511002842.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511002842.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511002842.cfilter,tp,LOCATION_GRAVE,0,1,nil) 
			and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511002842.cfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetTargetParam(g:GetCount())
end
function c511002842.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)*300)
		tc:RegisterEffect(e1)
	end
end
