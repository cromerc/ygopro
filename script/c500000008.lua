--ショック・ウェーブ
function c500000008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c500000008.condition)
	e1:SetHintTiming(0,0x1e1)
	e1:SetTarget(c500000008.target)
	e1:SetOperation(c500000008.activate)
	c:RegisterEffect(e1)
end
function c500000008.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c500000008.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)-1
end
function c500000008.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c500000008.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c500000008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c500000008.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c500000008.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,atk,REASON_EFFECT,true)
			Duel.Damage(tp,atk,REASON_EFFECT,true)
			Duel.RDComplete()
		end
	end
end
