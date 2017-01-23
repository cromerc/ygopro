-- Necro Cycle
-- scripted by UnknownGuest
function c511000158.initial_effect(c)
	-- activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511000158.target)
	c:RegisterEffect(e1)
	-- special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000158,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511000158.spcon)
	e2:SetTarget(c511000158.sptg)
	e2:SetOperation(c511000158.spop)
	c:RegisterEffect(e2)
end
function c511000158.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c511000158.spcon(e,tp,eg,ep,ev,re,r,rp) and c511000158.sptg(e,tp,eg,ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c511000158.spop)
		c511000158.sptg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c511000158.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000157)
end
function c511000158.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000158.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511000158.filter(c,e,tp)
	return c:IsCode(511000157) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000158.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000158.filter,tp,LOCATION_DECK,0,1,nil,e,tp) 
		and e:GetHandler():GetFlagEffect(511000158)==0 end
	e:GetHandler():RegisterFlagEffect(511000158,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000158.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000158.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
