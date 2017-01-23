--Fiendish Trap Hole
function c511000316.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511000316.target)
	e1:SetOperation(c511000316.activate)
	c:RegisterEffect(e1)
end
function c511000316.filter(c,tp)
	return c:IsFaceup() and c:IsDestructable()
end
function c511000316.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:IsExists(c511000316.filter,1,nil,tp) end
	local g=eg:Filter(c511000316.filter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c511000316.activate(e,tp,eg,ep,ev,re,r,rp)
	if eg:GetCount()>0 then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
