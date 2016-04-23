--武神逐
function c805000075.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c805000075.cost)
	e1:SetTarget(c805000075.target)
	e1:SetOperation(c805000075.operation)
	c:RegisterEffect(e1)
end
function c805000075.cosfilter(c)
	return c:IsSetCard(0x86) and c:IsRace(RACE_BEASTWARRIOR)
end
function c805000075.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c805000075.cosfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c805000075.cosfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c805000075.filter(c,e,tp)
	return c:IsSetCard(0x86) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000075.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c805000075.filter(chkc,e,tp) end
	local ex=e:GetLabelObject()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c805000075.filter,tp,LOCATION_GRAVE,0,1,ex,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c805000075.filter,tp,LOCATION_GRAVE,0,1,1,ex,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c805000075.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
