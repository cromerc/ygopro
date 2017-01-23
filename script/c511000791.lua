--Void Chain
function c511000791.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c511000791.condition)
	e1:SetTarget(c511000791.target)
	e1:SetOperation(c511000791.operation)
	c:RegisterEffect(e1)
end
function c511000791.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker():GetControler()~=tp
end
function c511000791.filter(c,e,tp)
	return c:IsSetCard(0xb) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000791.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511000791.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000791.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp=Duel.SelectMatchingCard(tp,c511000791.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
		if sp:GetCount()>0 then
			Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
