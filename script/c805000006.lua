--ＳＤロボ・ライオ
function c805000006.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000006,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1)
	e1:SetTarget(c805000006.target)
	e1:SetOperation(c805000006.activate)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(805000006,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c805000006.sptg)
	e2:SetOperation(c805000006.spop)
	c:RegisterEffect(e2)
end
function c805000006.sfilter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp
	 and (c:IsSetCard(0x88) or c:IsCode(71071546)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c805000006.sfilter,nil,e,tp)
	if chk==0 then return g:GetCount()~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=g:GetCount() end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c805000006.spfilter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp 
		and (c:IsSetCard(0x88) or c:IsCode(71071546)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and c:IsRelateToEffect(e)
end
function c805000006.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c805000006.spfilter,nil,e,tp)
	if g:GetCount()==0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<g:GetCount() then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
function c805000006.filter(c,e,tp)
	return (c:IsSetCard(0x88) or c:IsCode(71071546)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000006.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c805000006.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c805000006.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c805000006.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
