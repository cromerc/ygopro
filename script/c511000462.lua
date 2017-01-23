--Valkyrion the Magna Warrior (Anime)
function c511000462.initial_effect(c)
	aux.AddFusionProcCode3(c,99785935,39256679,11549357,false,false)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511000462.splimit)
	c:RegisterEffect(e1)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511000462.spcon)
	e1:SetOperation(c511000462.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000462,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511000462.cost)
	e2:SetTarget(c511000462.target)
	e2:SetOperation(c511000462.operation)
	c:RegisterEffect(e2)
end
function c511000462.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c511000462.cfilter(c,code)
	return (c:IsFaceup() or c:IsLocation(LOCATION_HAND)) and c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c511000462.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c511000462.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil,99785935)
		and Duel.IsExistingMatchingCard(c511000462.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil,39256679)
		and Duel.IsExistingMatchingCard(c511000462.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil,11549357)
end
function c511000462.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c511000462.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil,99785935)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c511000462.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil,39256679)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g3=Duel.SelectMatchingCard(tp,c511000462.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil,11549357)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c511000462.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511000462.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000462.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingTarget(c511000462.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,99785935)
		and Duel.IsExistingTarget(c511000462.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,39256679)
		and Duel.IsExistingTarget(c511000462.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,11549357) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c511000462.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,99785935)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c511000462.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,39256679)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c511000462.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,11549357)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c511000462.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=3 or ft<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
