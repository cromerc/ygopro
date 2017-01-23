--Numeron Storm
function c511001667.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001667.condition)
	e1:SetTarget(c511001667.target)
	e1:SetOperation(c511001667.activate)
	c:RegisterEffect(e1)
end
function c511001667.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x200)
end
function c511001667.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001667.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001667.filter(c)
	return c:GetSequence()<5 and c:IsDestructable()
end
function c511001667.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511001667.filter,tp,0,LOCATION_SZONE,1,c) end
	local sg=Duel.GetMatchingGroup(c511001667.filter,tp,0,LOCATION_SZONE,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511001667.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001667.filter,tp,0,LOCATION_SZONE,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
