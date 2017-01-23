--Mirror Bind
function c511000943.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000943.condition)
	e1:SetTarget(c511000943.target)
	e1:SetOperation(c511000943.activate)
	c:RegisterEffect(e1)
end
function c511000943.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511000943.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000943.cfilter,tp,LOCATION_ONFIELD,0,1,nil,511000936)
		and Duel.IsExistingMatchingCard(c511000943.cfilter,tp,LOCATION_ONFIELD,0,1,nil,511000937)
		and tp~=Duel.GetTurnPlayer()
end
function c511000943.filter(c,atk)
	return c:IsFaceup() and c:IsDestructable() and c:GetBaseAttack()<=atk
end
function c511000943.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=Duel.GetAttacker():GetAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000943.filter,tp,0,LOCATION_MZONE,1,nil,atk) end
	local g=Duel.GetMatchingGroup(c511000943.filter,tp,0,LOCATION_MZONE,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511000943.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetAttacker():GetAttack()
	local g=Duel.GetMatchingGroup(c511000943.filter,tp,0,LOCATION_MZONE,nil,atk)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
