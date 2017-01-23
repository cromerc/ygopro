--Overlay Stopper
function c511002124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002124.condition)
	e1:SetTarget(c511002124.target)
	e1:SetOperation(c511002124.activate)
	c:RegisterEffect(e1)
end
function c511002124.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsType(TYPE_XYZ)
end
function c511002124.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chkc then return chkc==a end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) and a and a:IsOnField() and a:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(a)
end
function c511002124.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetAttacker()
	if not tg or not tg:IsRelateToEffect(e) or tg:IsStatus(STATUS_ATTACK_CANCELED)
		or not Duel.NegateAttack() then return end
	if not tg:IsImmuneToEffect(e) and c:IsRelateToEffect(e) then
		c:CancelToGrave()
		Duel.Overlay(tg,Group.FromCards(c))
	end
end
