--ハーピィの羽根吹雪
function c100000296.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c100000296.condition)
	e1:SetTarget(c100000296.target)
	e1:SetOperation(c100000296.activate)
	c:RegisterEffect(e1)
end
function c100000296.filter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function c100000296.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000296.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():GetControler()~=tp
		and (Duel.GetAttacker():GetCode()==(76812113) or Duel.GetAttackTarget():GetCode()==(76812113))
end
function c100000296.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c100000296.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if Duel.GetTurnPlayer()~=tp then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	else
		Duel.SkipPhase(tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end