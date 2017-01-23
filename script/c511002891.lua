--Thousand Buster
function c511002891.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002891.cost)
	e1:SetTarget(c511002891.target)
	e1:SetOperation(c511002891.activate)
	c:RegisterEffect(e1)
end
function c511002891.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511002891.filter(c)
	return ((c:IsPosition(POS_FACEUP_DEFENSE) and c:IsDefenseBelow(1000)) or (c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttackBelow(1000))) 
		and c:IsDestructable()
end
function c511002891.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002891.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511002891.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,1000)
end
function c511002891.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002891.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Damage(1-tp,1000,REASON_EFFECT,true)
	Duel.Damage(tp,1000,REASON_EFFECT,true)
	Duel.RDComplete()
end
