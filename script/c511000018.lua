--Fleur de Vertige
function c511000018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511000018.target)
	e1:SetOperation(c511000018.activate)
	c:RegisterEffect(e1)
end
function c511000018.filter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()~=tp
		and c:IsAbleToRemove()
end
function c511000018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511000018.filter,1,nil,tp) end
	local g=eg:Filter(c511000018.filter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511000018.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c511000018.filter2(c,e,tp)
	return c:IsFaceup() and c:GetSummonPlayer()~=tp
		and c:IsRelateToEffect(e) and c:IsLocation(LOCATION_MZONE) and c:IsAbleToRemove()
end
function c511000018.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000018.filter2,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
