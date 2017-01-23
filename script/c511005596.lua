--Masquerade
function c511005596.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511005596.condition)
	e1:SetOperation(c511005596.activate)
	c:RegisterEffect(e1)
end
function c511005596.filter(c)
	return c:IsFaceup() and (c:IsCode(20765952) or c:IsCode(29549364))
end
function c511005596.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511005596.filter,tp,LOCATION_SZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil)
end
function c511005596.activate(e,tp,eg,ep,ev,re,r,rp,chkc)
	if not Duel.IsExistingMatchingCard(c511005596.filter,tp,LOCATION_SZONE,0,1,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local tc=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
	if tc then Duel.GetControl(tc,tp) end
end