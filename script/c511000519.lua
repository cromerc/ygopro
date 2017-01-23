--Queen Butterfly Danaus
function c511000519.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000519,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511000519.cost)
	e1:SetTarget(c511000519.target)
	e1:SetOperation(c511000519.operation)
	c:RegisterEffect(e1)
end
function c511000519.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetAttack()>0 end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511000519.spfilter(c,e,tp)
	return c:IsRace(RACE_INSECT) and c:GetLevel()<=4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000519.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511000519.spfilter,tp,LOCATION_GRAVE,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_GRAVE)
end
function c511000519.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c511000519.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()<3 then return end
	local sg=g:Select(tp,3,3,nil)
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
