--Deck Destruction Virus
function c511001119.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetLabel(0)
	e1:SetCondition(c511001119.condition)
	e1:SetTarget(c511001119.target)
	e1:SetOperation(c511001119.activate)
	c:RegisterEffect(e1)
	--Randomly Discard 10 cards
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetLabel(1)
	e2:SetCondition(c511001119.condition)
	e2:SetTarget(c511001119.target)
	e2:SetOperation(c511001119.activate)
	c:RegisterEffect(e2)
end
function c511001119.spfilter(c,tp)
	return c:GetControler()==tp and c:IsRace(RACE_FIEND) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsAttackBelow(500)
end
function c511001119.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001119.spfilter,1,nil,tp)
end
function c511001119.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabel()==1 or Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c511001119.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_DECK,nil):RandomSelect(tp,10)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
