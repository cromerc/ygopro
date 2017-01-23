--Xyz Drop
function c511002078.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002078.target)
	e1:SetOperation(c511002078.activate)
	c:RegisterEffect(e1)
end
function c511002078.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511002078.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingMatchingCard(c511002078.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511002078.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511002078.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
