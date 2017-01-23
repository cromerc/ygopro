--White Prosperity
function c511009060.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009060.target)
	e1:SetOperation(c511009060.operation)
	c:RegisterEffect(e1)
end
--White monster collection
c511009060.collection={
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
function c511009060.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and (c511009060.collection[c:GetCode()] or c:IsSetCard(0x202)) 
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,c,c:GetCode()) and c:IsLevelBelow(4) 
end
function c511009060.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511009060.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c511009060.filter,tp,LOCATION_HAND,0,2,nil,e,tp) end	
end
function c511009060.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511009060.filter,tp,LOCATION_HAND,0,2,2,nil,e,tp)
	if tc:GetCount()~=2 then return end
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end