--White Circle Reef
function c511009058.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009058.target)
	e1:SetOperation(c511009058.activate)
	c:RegisterEffect(e1)
end 
--White monster collection
c511009058.collection={
	[1571945]=true;[3557275]=true;[9433350]=true;[13429800]=true;
	[15150365]=true;[20193924]=true;[24644634]=true;[32269855]=true;
	[38517737]=true;[73398797]=true;[73891874]=true;[79473793]=true;
	[79814787]=true;[89631139]=true;[92409659]=true;[98024118]=true;
	[22804410]=true;[71039903]=true;[84812868]=true;
	[501000016]=true;
	[511002341]=true;
	[511001977]=true;[511001978]=true;[511001979]=true;[511001980]=true;
	[511001090]=true;[511001091]=true;	
	[95100846]=true;[95100847]=true;
	
}
function c511009058.filter(c,tp)
	return c:IsFaceup() and c:IsDestructable()
		and Duel.IsExistingMatchingCard(c511009058.nfilter1,tp,LOCATION_DECK,0,1,nil,c)
		and (c511009058.collection[c:GetCode()] or c:IsSetCard(0x202))
end
function c511009058.nfilter1(c,tc)
	return c:IsCode(tc:GetCode()) and c:IsAbleToHand()
end
function c511009058.nfilter2(c,tc)
	return c:IsCode(tc:GetPreviousCodeOnField()) and c:IsAbleToHand()
end
function c511009058.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009058.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009058.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009058.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511009058.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local g=Duel.SelectMatchingCard(tp,c511009058.nfilter2,tp,LOCATION_DECK,0,1,1,nil,tc)
		local hc=g:GetFirst()
		if hc then
			Duel.SendtoHand(hc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,hc)
		end
	end
end
