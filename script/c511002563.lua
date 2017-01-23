--Vector Change
function c511002563.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002563.condition)
	e1:SetTarget(c511002563.target)
	e1:SetOperation(c511002563.activate)
	c:RegisterEffect(e1)
end
function c511002563.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002563.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsDefensePos() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDefensePos,tp,0,LOCATION_MZONE,1,nil) 
		and a:IsAttackPos() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsDefensePos,tp,0,LOCATION_MZONE,1,1,nil)
	g:AddCard(a)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,2,0,0)
end
function c511002563.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=Duel.GetFirstTarget()
	if a and a:IsRelateToBattle() and a:IsAttackPos() and tc and tc:IsRelateToEffect(e) and not tc:IsAttackPos() then
		Duel.ChangePosition(a,POS_FACEUP_DEFENSE)
		Duel.ChangePosition(tc,0,0,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)
	end
end
