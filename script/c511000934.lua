--Block Lock
function c511000934.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000934.condition)
	e1:SetTarget(c511000934.target)
	e1:SetOperation(c511000934.activate)
	c:RegisterEffect(e1)
end
function c511000934.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000934.filter(c,e)
	return c:IsCanBeEffectTarget(e) and c:IsSetCard(0x26)
end
function c511000934.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local ag=eg:GetFirst():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if chk==0 then return ag:IsExists(c511000934.filter,1,at,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=ag:FilterSelect(tp,c511000934.filter,1,1,at,e)
	Duel.SetTargetCard(g)
end
function c511000934.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
