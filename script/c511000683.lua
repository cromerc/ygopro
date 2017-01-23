--Number Frame
function c511000683.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000683.target)
	e1:SetOperation(c511000683.operation)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1500)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511000683.eqlimit)
	c:RegisterEffect(e3)
end
function c511000683.eqlimit(e,c)
	return (c:IsCode(65305468) or c:IsSetCard(0x7f))
end
function c511000683.filter(c)
	return c:IsFaceup() and (c:IsCode(65305468) or c:IsSetCard(0x7f))
end
function c511000683.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511000683.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000683.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511000683.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000683.afilter(c)
	return c:IsSetCard(0x48)
end
function c511000683.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		local g=Duel.GetMatchingGroup(c511000683.afilter,tp,LOCATION_EXTRA,0,nil)
		if g:GetCount()>=2 and Duel.SelectYesNo(tp,aux.Stringid(511000683,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local og=g:Select(tp,2,2,nil)
			Duel.Overlay(tc,og)
		end
	end
end
