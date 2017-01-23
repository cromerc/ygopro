--Summoning Clock
function c511000087.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000087.condition)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000087,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511000087.spcost)
	e2:SetTarget(c511000087.sptg)
	e2:SetOperation(c511000087.spop)
	c:RegisterEffect(e2)
	--turn
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511000087.turncount)
	c:RegisterEffect(e3)
end
function c511000087.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp
end
function c511000087.turncount(e,tp,eg,ep,ev,re,r,rp)
	if tp~=Duel.GetTurnPlayer() then return end
	e:GetHandler():AddCounter(0x1105,1)
end
function c511000087.spfilter(c,e,tp)
	return c:IsSummonableCard() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000087.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c:GetCounter(0x1105)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and Duel.CheckReleaseGroup(tp,nil,1,nil) 
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct and Duel.IsExistingMatchingCard(c511000087.spfilter,tp,LOCATION_HAND,0,ct,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,aux.TRUE,1,1,nil)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	Duel.Release(g,REASON_COST)
	e:SetLabel(ct)
end
function c511000087.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000087.spfilter,tp,LOCATION_HAND,0,ct,ct,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
	e:SetLabel(0)
end
function c511000087.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<g:GetCount() then return end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
