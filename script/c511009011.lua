--Lira the Giver
function c511009011.initial_effect(c)
	
	--Give Counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98162021,0))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c511009011.addct2)
	e3:SetOperation(c511009011.addc2)
	c:RegisterEffect(e3)
end
function c511009011.addct2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x109,1,REASON_EFFECT)
		and Duel.IsExistingTarget(Card.IsCanAddCounter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),0x1109,1) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(98162021,1))
	Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler(),0x1109,1)
end
function c511009011.addc2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCounter(0x1109)==0 then return end
	c:RemoveCounter(tp,0x1109,1,REASON_EFFECT)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x1109,1)
	end
end
