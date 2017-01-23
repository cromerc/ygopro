--Ｓｉｎ Ｐａｒａｄｉｇｍ Ｓｈｉｆｔ
function c100000092.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c100000092.condition)
	e1:SetCost(c100000092.cost)
	e1:SetTarget(c100000092.target)
	e1:SetOperation(c100000092.activate)
	c:RegisterEffect(e1)
end
function c100000092.cfilter(c,tp)
	return c:IsCode(8310162) and c:GetPreviousControler()==tp
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c100000092.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000092.cfilter,1,nil,tp)
end
function c100000092.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,Duel.GetLP(tp)/2)
end
function c100000092.filter(c,e,tp)
	return c:IsCode(37115575) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000092.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000092.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0x13)
end
function c100000092.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000092.filter,tp,0x13,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	end
end
