--Dragonic Unit Ritual
function c511000350.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000350.cost)
	e1:SetCondition(c511000350.condition)
	e1:SetTarget(c511000350.target)
	e1:SetOperation(c511000350.activate)
	c:RegisterEffect(e1)
end
function c511000350.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c511000350.filter(c,code)
	return c:IsCode(code) and c:IsFaceup() and c:IsAbleToGrave()
end
function c511000350.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000350.filter,tp,LOCATION_MZONE,0,1,nil,511002171) 
		and Duel.IsExistingMatchingCard(c511000350.filter,tp,LOCATION_MZONE,0,1,nil,511002255)
end
function c511000350.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonMonster(tp,38109772,0,0x21,2800,2300,7,RACE_DRAGON,ATTRIBUTE_FIRE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c511000350.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,38109772,0,0x21,2800,2300,7,RACE_DRAGON,ATTRIBUTE_FIRE) then return end
	local g1=Duel.GetMatchingGroup(c511000350.filter,tp,LOCATION_MZONE,0,nil,511002171)
	local g2=Duel.GetMatchingGroup(c511000350.filter,tp,LOCATION_MZONE,0,nil,511002255)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg2=g2:Select(tp,1,1,nil)
	sg1:Merge(sg2)
	if Duel.SendtoGrave(sg1,REASON_EFFECT)>0 then
		local tc=Duel.CreateToken(tp,38109772)
		if tc then
			Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
