--Deck Destruction Virus
function c37257834.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCategory(CATEGORY_DECKDES)
e1:SetCode(EVENT_BATTLE_END)
e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
e1:SetCondition(c37257834.condition)
e1:SetTarget(c37257834.target)
e1:SetOperation(c37257834.activate)
c:RegisterEffect(e1)
--Randomly Discard 10 cards
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetProperty(EFFECT_FLAG_DELAY)
e2:SetRange(LOCATION_SZONE)
e2:SetCode(EVENT_BATTLE_END)
e2:SetCondition(c37257834.condition)
e2:SetTarget(c37257834.target)
e2:SetOperation(c37257834.activate)
c:RegisterEffect(e2)
end
function c37257834.condition(e,tp,eg,ep,ev,re,r,rp)
local d=Duel.GetAttackTarget()
local a=Duel.GetAttacker()
if Duel.GetAttackTarget()==nil or Duel.GetAttacker()==nil then return end
return d:IsControler(tp) and d:IsAttribute(ATTRIBUTE_DARK) and d:IsRace(RACE_FIEND) and d:IsAttackBelow(500) and d:IsStatus(STATUS_BATTLE_DESTROYED)
or (a:IsControler(tp) and a:IsAttribute(ATTRIBUTE_DARK) and a:IsAttackBelow(500) and a:IsRace(RACE_FIEND)and a:IsStatus(STATUS_BATTLE_DESTROYED))
end
function c37257834.filter(c)
	return c:IsAbleToGrave()
end
function c37257834.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37257834.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	end
	function c37257834.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c37257834.filter,tp,0,LOCATION_DECK,nil):RandomSelect(tp,10)
	Duel.SendtoGrave(g,REASON_EFFECT)
end