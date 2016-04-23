--Ｎｏ．４４白天馬スカイ・ペガサス
function c800000028.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,4),2)
	c:EnableReviveLimit()
	--destroy&damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetLabel(0)
	e1:SetCost(c800000028.cost)
	e1:SetTarget(c800000028.target)
	e1:SetOperation(c800000028.operation)
	c:RegisterEffect(e1)
end
function c800000028.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c800000028.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c800000028.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c800000028.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c800000028.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c800000028.filter,tp,0,LOCATION_MZONE,1,1,nil)
	if Duel.CheckLPCost(1-tp,1000) and Duel.SelectYesNo(1-tp,aux.Stringid(110000000,10)) then 
		Duel.PayLPCost(1-tp,1000)
		e:SetLabel(1)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c800000028.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(1-tp) and e:GetLabel()==0 then
		Duel.Destroy(tc,REASON_EFFECT)
	elseif e:GetLabel()~=0 then
		Duel.NegateEffect(e:GetHandler())
	end
end
