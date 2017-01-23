--無限械アイン・ソフ
function c513000047.initial_effect(c)
	--Activate to Grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_END_PHASE+TIMING_DAMAGE_STEP)
	e1:SetCondition(c513000047.condition)
	e1:SetCost(c513000047.cost)
	e1:SetTarget(c513000047.target)
	c:RegisterEffect(e1)
	--your turn
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c513000047.spcon)
	e2:SetTarget(c513000047.sptg)
	e2:SetOperation(c513000047.spop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(0)
	c:RegisterEffect(e3)
end
function c513000047.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c513000047.costfilter(c)
	return c:IsFaceup() and c:IsCode(100000012) and c:IsAbleToGraveAsCost()
end
function c513000047.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000047.costfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c513000047.costfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c513000047.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c513000047.sptg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c513000047.spop)
		c513000047.sptg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c513000047.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c513000047.spfilter(c,e,tp)
	return c:IsLevelAbove(10) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000047.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c513000047.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c513000047.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if not e:GetHandler():IsRelateToEffect(e) or ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c513000047.spfilter,tp,LOCATION_HAND,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
