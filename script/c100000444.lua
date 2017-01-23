--Ａキャノン
function c100000444.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_END)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c100000444.condition)
	e1:SetCost(c100000444.cost)
	e1:SetTarget(c100000444.target)
	e1:SetOperation(c100000444.activate)
	c:RegisterEffect(e1)
end
function c100000444.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return a:IsControler(tp) and a:IsSetCard(0x3013) and at:IsRelateToBattle() and not at:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED) 
		and not a:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c100000444.cfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost() and not c:IsStatus(STATUS_BATTLE_DESTROYED) and (c:IsCode(100000309) or c:IsCode(100000043) 
		or c:IsCode(100000048) or c:IsCode(100000045) or c:IsCode(100000063) or c:IsCode(100000052) or c:IsCode(100000058))
end
function c100000444.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000444.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000444.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000444.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100000444.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
