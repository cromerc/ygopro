--Noble Knight Borz
function c108060083.initial_effect(c)
	--Attribute Dark
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c108060083.eqcon1)
	e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
	c:RegisterEffect(e1)
	--Attribute Dark
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c108060083.eqcon2)
	e2:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_LEVEL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c108060083.eqcon2)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--spsummon	
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(108060083,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c108060083.eqcon2)
	e4:SetCost(c108060083.thcost)
	e4:SetTarget(c108060083.thtg)
	e4:SetOperation(c108060083.thop)
	c:RegisterEffect(e4)
end
function c108060083.eqcon1(e)
	local eg=e:GetHandler():GetEquipGroup()
	return not eg or not eg:IsExists(Card.IsSetCard,1,nil,0x207a)
end
function c108060083.eqcon2(e)
	local eg=e:GetHandler():GetEquipGroup()
	return eg and eg:IsExists(Card.IsSetCard,1,nil,0x207a)
end
function c108060083.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,108060083)==0 end
	Duel.RegisterFlagEffect(tp,108060083,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c108060083.thfilter(c)
	return c:IsType(TYPE_EQUIP) and c:IsSetCard(0x207a) and c:IsAbleToHand()
end
function c108060083.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c108060083.thfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c108060083.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.GetMatchingGroup(c108060083.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>=3 then
		local sg=g:Select(tp,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)		
		Duel.ShuffleDeck(tp)
		local tg=sg:Select(1-tp,1,1,nil)
		local tc=tg:GetFirst()		
		if tc:IsAbleToHand() then 
		sg:RemoveCard(tc)
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.SendtoGrave(sg,REASON_EFFECT) end
	end
end