--Panic Shuffle
function c511001065.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetCondition(c511001065.condition)
	e1:SetTarget(c511001065.target)
	e1:SetOperation(c511001065.activate)
	c:RegisterEffect(e1)
end
function c511001065.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsType(TYPE_XYZ)
end
function c511001065.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and eg:IsExists(c511001065.filter,1,nil,tp)
end
function c511001065.tdfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck() 
end
function c511001065.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAttackPos,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.GetMatchingGroup(c511001065.tdfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c511001065.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAttackPos,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,0,0)
	local sg=Duel.GetMatchingGroup(c511001065.tdfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	local tc=g:GetFirst()
	while tc do
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
