--星読みの魔術師
function c511000997.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--negate and set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(511000997,1))
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c511000997.negcon)
	e2:SetTarget(c511000997.negtg)
	e2:SetOperation(c511000997.negop)
	c:RegisterEffect(e2)
	--sp summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000997.spcon)
	e3:SetTarget(c511000997.sptg)
	e3:SetOperation(c511000997.spop)
	c:RegisterEffect(e3)
end
function c511000997.negcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker()==nil then return end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return ((d~=nil and a:GetControler()==tp and a:IsType(TYPE_PENDULUM) and a:IsRelateToBattle())
		or (d~=nil and d:GetControler()==tp and d:IsFaceup() and d:IsType(TYPE_PENDULUM) and d:IsRelateToBattle()))
		and re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c511000997.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511000997.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsFaceup() or not c:IsRelateToEffect(e) then return end
	Duel.NegateActivation(ev)
	local g=eg:GetFirst()
	if re:GetHandler():IsRelateToEffect(re) and g:IsCanTurnSet() then
		Duel.BreakEffect()
		g:CancelToGrave()
		Duel.ChangePosition(g,POS_FACEDOWN)
		Duel.RaiseEvent(g,EVENT_SSET,e,REASON_EFFECT,1-tp,1-tp,0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		g:RegisterEffect(e1)
	end
end
function c511000997.filter(c)
	return not c:IsReason(REASON_RULE)
end
function c511000997.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsType(TYPE_PENDULUM) and tc:IsPreviousPosition(POS_FACEUP) and tc:GetPreviousControler()==tp
		and tc:IsPreviousLocation(LOCATION_MZONE)
end
function c511000997.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end
function c511000997.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
