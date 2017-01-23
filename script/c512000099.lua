--Magic Removal Virus Cannon
function c512000099.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c512000099.target)
	e1:SetOperation(c512000099.activate)
	c:RegisterEffect(e1)
end
function c512000099.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGrave()
end
function c512000099.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c512000099.filter,tp,0,LOCATION_DECK+LOCATION_HAND,1,nil) end
	local sg=Duel.GetMatchingGroup(c512000099.filter,tp,0,LOCATION_DECK+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
end
function c512000099.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c512000099.filter,tp,0,LOCATION_DECK+LOCATION_HAND,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
	local p=e:GetHandler():GetControler()
	end