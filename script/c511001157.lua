--Decisive Power of Absolute Destiny
function c511001157.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001157.target)
	e1:SetOperation(c511001157.activate)
	c:RegisterEffect(e1)
end
function c511001157.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001157.filter,tp,0,LOCATION_DECK,1,nil,e,tp) end
end
function c511001157.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001157.spfilter(c,e,tp,code)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsCode(code)
end
function c511001157.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,564)
	local code=Duel.AnnounceCard(tp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(1-tp,c511001157.spfilter,1-tp,LOCATION_DECK,0,1,1,nil,e,tp,code)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
	else
		local dg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
		Duel.ConfirmCards(tp,dg)
		Duel.ShuffleDeck(1-tp)
	end
end
