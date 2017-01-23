--カオス・テンペスト・ドロー
function c511001189.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001189.condition)
	e1:SetTarget(c511001189.target)
	e1:SetOperation(c511001189.activate)
	c:RegisterEffect(e1)
end
function c511001189.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296))
end
function c511001189.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001189.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(nil,tp,LOCATION_SZONE,0,1,e:GetHandler())
end
function c511001189.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511001189.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511001189.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c511001189.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,sg:GetCount())
end
function c511001189.opfilter(c)
	return not c:IsLocation(LOCATION_ONFIELD)
end
function c511001189.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001189.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
	sg=sg:Filter(c511001189.opfilter,nil)
	local g=Duel.GetDecktopGroup(tp,sg:GetCount())
	Duel.Draw(tp,sg:GetCount(),REASON_EFFECT)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
