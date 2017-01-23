--Guts Master Fire
function c511002678.initial_effect(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511002678.sptg)
	e2:SetOperation(c511002678.spop)
	c:RegisterEffect(e2)
	--Protection
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c511002678.indtg)
	e2:SetValue(c511002678.valcon)
	e2:SetCountLimit(1)
	c:RegisterEffect(e2)
end
function c511002678.spfilter(c,e,tp)
	return c:IsSetCard(0x21c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002678.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002678.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002678.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002678.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511002678.indtg(e,c)
	return c:IsAttackPos() and  c~=e:GetHandler() and c:IsSetCard(0x21c)
end
function c511002678.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
