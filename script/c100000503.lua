--幻覚
function c100000503.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c100000503.condition)
	e1:SetTarget(c100000503.target)
	e1:SetOperation(c100000503.activate)
	c:RegisterEffect(e1)
end
function c100000503.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp)
end
function c100000503.spfilter(c)
	return c:IsSetCard(0x5008) 
end
function c100000503.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000503.spfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000503.spfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c100000503.spfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000503.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local a=Duel.GetAttacker()
	if a:IsOnField() and a:IsFaceup() then
		Duel.ChangeAttackTarget(tc)
	end
end
