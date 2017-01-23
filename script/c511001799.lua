--Exploding Cloud
function c511001799.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001799.target)
	e1:SetOperation(c511001799.activate)
	c:RegisterEffect(e1)
end
function c511001799.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsDestructable()
end
function c511001799.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001799.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001799.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511001799.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,g:GetFirst():GetAttack())
end
function c511001799.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local dam=tc:GetAttack()
		if dam<0 then return end
		Duel.Damage(tp,dam,REASON_EFFECT)
	end
end
