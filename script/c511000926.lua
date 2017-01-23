--武装再生
function c511000926.initial_effect(c)
	--effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000926.target)
	e1:SetOperation(c511000926.operation)
	c:RegisterEffect(e1)
end
function c511000926.tcfilter(tc,ec)
	return tc:IsFaceup() and ec:CheckEquipTarget(tc)
end
function c511000926.ecfilter(c)
	return c:IsType(TYPE_EQUIP) and Duel.IsExistingTarget(c511000926.tcfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,c)
end
function c511000926.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511000926.ecfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000926,0))
	local g=Duel.SelectTarget(tp,c511000926.ecfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local ec=g:GetFirst()
	e:SetLabelObject(ec)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000926,1))
	Duel.SelectTarget(tp,c511000926.tcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,ec:GetEquipTarget(),ec)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,ec,1,0,0)
end
function c511000926.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local ec=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==ec then tc=g:GetNext() end
	if ec:IsFaceup() and ec:IsRelateToEffect(e) then 
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			Duel.Equip(tp,ec,tc)
		end
	end
end
