--Law of Food Conservation
function c511001087.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c511001087.condition)
	e1:SetTarget(c511001087.target)
	e1:SetOperation(c511001087.activate)
	c:RegisterEffect(e1)
end
function c511001087.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and not c:IsReason(REASON_RULE)
end
function c511001087.cfilter2(c)
	return c:IsFaceup() and c:IsCode(511001086)
end
function c511001087.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001087.cfilter,1,nil,1-tp)
end
function c511001087.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:Filter(c511001087.cfilter,nil,1-tp):GetCount()
	if chk==0 then return Duel.IsExistingMatchingCard(c511001087.cfilter2,tp,LOCATION_SZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_DECK,0,ct,nil,0x205) end
end
function c511001087.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:Filter(c511001087.cfilter,nil,1-tp):GetCount()
	if not Duel.IsExistingMatchingCard(c511001087.cfilter2,tp,LOCATION_SZONE,0,1,nil) 
		or ct<=0 then return end
	local fc=Duel.SelectMatchingCard(tp,c511001087.cfilter2,tp,LOCATION_SZONE,0,1,1,nil):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,ct,ct,nil,0x205)
	if g:GetCount()>0 then
		Duel.HintSelection(Group.FromCards(fc))
		Duel.Overlay(fc,g)
	end
end
