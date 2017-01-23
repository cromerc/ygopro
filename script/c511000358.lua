--Miracle of Draconian Wrath
function c511000358.initial_effect(c)	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511000358.condition)
	e1:SetTarget(c511000358.target)
	e1:SetOperation(c511000358.operation)
	c:RegisterEffect(e1)
end
function c511000358.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsRace,1,nil,RACE_DRAGON)
end
function c511000358.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c511000358.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		and Duel.IsExistingTarget(c511000358.filter,tp,LOCATION_DECK,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	Duel.SelectTarget(tp,c511000358.filter,tp,LOCATION_DECK,0,2,2,nil)
end
function c511000358.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>1 then
		Duel.SSet(tp,g)
		Duel.ConfirmCards(1-tp,g)
	end
end
