--coded by Lyris
--Common Sacrifice
function c511007018.initial_effect(c)
	--Activate only during your Main Phase while your opponent controls 3 or more monsters: Send 2 monsters your opponent controls with the lowest ATK to the Graveyard; Special Summon 1 Level 7 or higher monster from your hand.
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511007018.condition)
	e1:SetCost(c511007018.cost)
	e1:SetTarget(c511007018.target)
	e1:SetOperation(c511007018.activate)
	c:RegisterEffect(e1)
end
--Activate only during your Main Phase while your opponent controls 3 or more monsters.
function c511007018.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2) and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=3
end
--Send 2 monsters your opponent controls with the lowest ATK to the Graveyard.
function c511007018.cfilter1(c,g)
	local tg=g:Filter(c511007018.cfilter2,c,g)
	return c:IsAbleToGraveAsCost() and tg:GetCount()>0
end
function c511007018.cfilter2(c,g)
	return c:IsAbleToGrave() and g:GetMinGroup(Card.GetAttack):IsContains(c)
end
function c511007018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	if chk==0 then return g:IsExists(c511007018.cfilter1,1,nil,g) end
	local rg=g:GetMinGroup(Card.GetAttack)
	if rg:GetCount()>1 then
		local tg1=rg:Select(tp,2,2,nil)
		Duel.SendtoGrave(tg1,REASON_COST)
		return
	end
	local tc=rg:GetFirst()
	g:RemoveCard(tc)
	rg=g:GetMinGroup(Card.GetAttack)
	local tg=rg:FilterSelect(tp,Card.IsAbleToGraveAsCost,1,1,nil)
	tg:AddCard(tc)
	Duel.SendtoGrave(tg,REASON_COST)
end
--Special Summon 1 Level 7 or higher monster from your hand. [Ancient Rules]
function c511007018.filter(c,e,tp)
	return c:IsLevelAbove(7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511007018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511007018.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511007018.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511007018.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
