--White Mirror
function c511009059.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009059.target)
	e1:SetOperation(c511009059.activate)
	c:RegisterEffect(e1)
end
--White monster collection
c511009059.collection={
	[1571945]=true;[3557275]=true;[9433350]=true;[13429800]=true;
	[15150365]=true;[20193924]=true;[24644634]=true;[32269855]=true;
	[38517737]=true;[73398797]=true;[73891874]=true;[79473793]=true;
	[79814787]=true;[89631139]=true;[92409659]=true;[98024118]=true;
	[22804410]=true;[71039903]=true;[84812868]=true;
	[501000016]=true;
	[511002341]=true;
	[511001977]=true;[511001978]=true;[511001979]=true;[511001980]=true;
	[511001090]=true;[511001091]=true;	
}
function c511009059.filter(c,e,tp)
	return (c511009059.collection[c:GetCode()] or c:IsSetCard(0x202)) and Duel.IsExistingMatchingCard(c511009059.thfil,tp,LOCATION_DECK,0,1,nil,c:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009059.spfilter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009059.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and c83764718.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511009059.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511009059.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511009059.thfil(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c511009059.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		if Duel.IsExistingMatchingCard(c511009059.thfil,tp,LOCATION_DECK,0,1,nil,tc:GetCode()) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g=Duel.SelectMatchingCard(tp,c511009059.thfil,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode())
			Duel.SendtoHand(g,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
