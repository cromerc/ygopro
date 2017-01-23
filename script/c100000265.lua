--堕天使降臨
function c100000265.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c100000265.condition)
	e1:SetCost(c100000265.cost)
	e1:SetTarget(c100000265.target)
	e1:SetOperation(c100000265.activate)
	c:RegisterEffect(e1)
end
function c100000265.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c100000265.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,Duel.GetLP(tp)/2)
end
function c100000265.filter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_DARK) and c:GetAttack()==Duel.GetAttacker():GetAttack()
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000265.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()==tp and chkc:GetLocation()==LOCATION_GRAVE and c100000265.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingTarget(c100000265.filter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000265.filter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end
function c100000265.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()~=2 then return end
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
