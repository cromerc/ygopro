--Ａキャノン
function c100000444.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_END)
	e1:SetCondition(c100000444.atkcon)
	e1:SetTarget(c100000444.target)
	e1:SetOperation(c100000444.atkop)
	c:RegisterEffect(e1)
end
function c100000444.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return ((a:GetControler()==tp and a:IsSetCard(0x3013)) or (at:GetControler()==tp and at:IsSetCard(0x3013))) and at:IsRelateToBattle() 
	and not at:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED) and not a:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c100000444.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_MZONE,0,1,nil,0x314)
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,0)
end
function c100000444.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_MZONE,0,1,1,nil,0x314)
	if Duel.SendtoGrave(g,REASON_EFFECT)>0 then
		g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end