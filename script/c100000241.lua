--フォトン・エスケープ
function c100000241.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c100000241.condition)
	e1:SetTarget(c100000241.target)
	e1:SetOperation(c100000241.activate)
	c:RegisterEffect(e1)
end
function c100000241.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a:IsOnField() and d and d:IsFaceup() and d:IsControler(tp)
	 and (d:IsSetCard(0x55) or d:IsCode(31801517)) and d:IsAbleToRemove()
end
function c100000241.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.GetAttackTarget():CreateEffectRelation(e)
end
function c100000241.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttackTarget()
	if a:IsFaceup() and a:IsRelateToEffect(e) then
		Duel.Remove(a,POS_FACEUP,REASON_EFFECT)
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)		
	end
end
