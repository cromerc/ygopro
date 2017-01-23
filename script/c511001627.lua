--Galaxy Journey
function c511001627.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001627.activate)
	c:RegisterEffect(e1)
end
function c511001627.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCondition(c511001627.spcon)
	e1:SetOperation(c511001627.spop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511001627.filter(c,tp)
	return not c:IsType(TYPE_TOKEN) and c:IsType(TYPE_MONSTER) and c:IsControler(tp)
end
function c511001627.spcon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001627.filter,nil,tp)
	local tc=g:GetFirst()
	return g:GetCount()==1 and tc
end
function c511001627.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001627.filter,nil,tp)
	local tc=g:GetFirst()
	Duel.Hint(HINT_CARD,0,511001627)
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end
