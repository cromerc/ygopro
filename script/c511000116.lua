--Spirit Shield
function c511000116.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000116.condition)
	e1:SetOperation(c511000116.operation)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511000116.condition)
	e2:SetOperation(c511000116.operation)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511000116.descon)
	c:RegisterEffect(e3)
end
function c511000116.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND+RACE_ZOMBIE)
end
function c511000116.descon(e)
	local c=e:GetHandler()
	return not Duel.IsExistingMatchingCard(c511000116.filter,c:GetControler(),LOCATION_GRAVE,0,1,c)
end
function c511000116.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511000116.operation(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000116.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511000116.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
function c511000116.cfilter(c)
	return c:IsRace(RACE_FIEND+RACE_ZOMBIE) and c:IsAbleToRemoveAsCost()
end
