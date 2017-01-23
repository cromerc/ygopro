--Chronic Déjà Vu
function c511000730.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511000730.condition)
	e1:SetTarget(c511000730.target)
	e1:SetOperation(c511000730.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c511000730.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c511000730.filter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()~=tp
end
function c511000730.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511000730.filter,1,nil,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,eg:GetCount(),0,0)
end
function c511000730.filter2(c,e,tp)
	return c:IsFaceup() and c:GetSummonPlayer()~=tp and c:IsRelateToEffect(e) 
end
function c511000730.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000730.filter2,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetOriginalCode()
		local token=Duel.CreateToken(tp,code)
		Duel.SpecialSummonStep(token,0,tp,tp,true,false,tc:GetPosition())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_MONSTER)
		token:RegisterEffect(e1)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
