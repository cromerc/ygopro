--ダークネス・ネクロスライム
function c100000706.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000706,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c100000706.cost)
	e1:SetTarget(c100000706.target)
	e1:SetOperation(c100000706.operation)
	c:RegisterEffect(e1)
end
function c100000706.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
c100000706.collection={
	[79182538]=true;[42071342]=true;[60417395]=true;[88264978]=true;[96561011]=true;
	[56647086]=true;[33655493]=true;[47297616]=true;[44330098]=true;[93709215]=true;
	[77121851]=true;[63120904]=true;[19153634]=true;[28933734]=true;
}
function c100000706.filter(c,e,tp)
	return (c:IsSetCard(0x316) or c100000706.collection[c:GetCode()]) and c:GetCode()~=100000706 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000706.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c100000706.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c100000706.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000706.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100000706.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
