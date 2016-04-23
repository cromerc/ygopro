--Ancient Key
function c511000124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511000124.condition)
	e1:SetOperation(c511000124.operation)
	c:RegisterEffect(e1)
	--Add
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetDescription(aux.Stringid(511000124,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511000124.cost)
	e2:SetTarget(c511000124.target)
	e2:SetOperation(c511000124.operation2)
	c:RegisterEffect(e2)	
end

function c511000124.costfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCode(511000127)
end
function c511000124.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000124.costfilter,2,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511000124.costfilter,2,2,nil)
	Duel.Release(g,REASON_COST)
end

function c511000124.filter1(c)
	return c:IsCode(511000125) and c:IsAbleToHand() 
end
function c511000124.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000124.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c511000124.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000124.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c511000124.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()
	 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	 and Duel.IsExistingMatchingCard(c511000124.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp)
	 and Duel.IsExistingMatchingCard(c511000124.zfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp)
	 and Duel.IsExistingMatchingCard(c511000124.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end

function c511000124.filter(c,e,tp)
	return c:IsCode(511000127) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511000124.zfilter(c,e,tp)
	return c:IsCode(511000127) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511000124.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c511000124.zfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g1:GetCount()>0 then Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,true,true,POS_FACEUP_DEFENCE) end
	local g2=Duel.SelectMatchingCard(tp,c511000124.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g2:GetCount()>0 then Duel.SpecialSummonStep(g2:GetFirst(),0,tp,tp,true,true,POS_FACEUP_DEFENCE) end
	Duel.SpecialSummonComplete()
end
function c511000124.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000122)
end