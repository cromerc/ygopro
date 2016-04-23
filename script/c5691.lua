--ファーニマル・マウス
function c5691.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c5691.spcost)
	e1:SetTarget(c5691.sptg)
	e1:SetOperation(c5691.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(5691,ACTIVITY_SPSUMMON,c5691.counterfilter)
end
function c5691.counterfilter(c)
	return c:IsSetCard(0xad) or not c:IsLocation(LOCATION_EXTRA)
end
function c5691.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(5691,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c5691.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c5691.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0xad) and c:IsLocation(LOCATION_EXTRA)
end
function c5691.filter(c,e,tp)
	return c:IsCode(5691) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c5691.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c5691.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c5691.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c5691.filter,tp,LOCATION_DECK,0,1,2,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
