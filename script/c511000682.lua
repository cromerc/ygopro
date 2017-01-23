--Heat & Heal
function c511000682.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000682.target)
	e1:SetOperation(c511000682.activate)
	c:RegisterEffect(e1)
end
function c511000682.cfilter(c,rk)
	return c:IsFaceup() and c:GetRank()<rk
end
function c511000682.filter(c,tp)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsSetCard(0x48) and not Duel.IsExistingMatchingCard(c511000682.cfilter,tp,LOCATION_MZONE,0,1,nil,rk)
end
function c511000682.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000682.filter(chkc) end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingTarget(c511000682.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000682.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c511000682.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
		if c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			c:CancelToGrave()
			Duel.Overlay(tc,Group.FromCards(c))
		end
	end
end
