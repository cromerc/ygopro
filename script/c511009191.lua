--Lyrical Luscinia - Sapphire Sparrow
--fixed by MLD
function c511009191.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59708927,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c511009191.sptg)
	e1:SetOperation(c511009191.spop)
	c:RegisterEffect(e1)
end
function c511009191.spfilter(c,e,tp)
	return c:GetLevel()==1 and c:IsSetCard(0x1f8) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009191.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x1f8) and c:GetCode()~=511009191
end
function c511009191.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c511009191.filter,tp,LOCATION_MZONE,0,1,e:GetHandler(),e,tp)
		and Duel.IsExistingMatchingCard(c511009191.spfilter,tp,LOCATION_HAND,0,1,e:GetHandler(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND)
end
function c511009191.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009191.spfilter,tp,LOCATION_HAND,0,1,1,c,e,tp)
	if g:GetCount()>0 then
		g:AddCard(c)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
