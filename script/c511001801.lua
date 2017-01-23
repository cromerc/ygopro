--Breakthrough
function c511001801.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001801.condition)
	e1:SetTarget(c511001801.target)
	e1:SetOperation(c511001801.activate)
	c:RegisterEffect(e1)
end
function c511001801.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511001801.filter(c,e)
	return c:IsDestructable() and (not e or c:IsRelateToEffect(e))
end
function c511001801.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511001801.filter,1,nil,nil) end
	local g=eg:Filter(c511001801.filter,nil,nil)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511001801.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001801.filter,nil,e)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
