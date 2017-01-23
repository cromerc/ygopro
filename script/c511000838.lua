--Infernity Burst
function c511000838.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000838.target)
	e1:SetOperation(c511000838.activate)
	c:RegisterEffect(e1)
end
function c511000838.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xb)
end
function c511000838.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000838.filter,tp,LOCATION_MZONE,0,1,nil) end
	local dam=Duel.GetMatchingGroupCount(c511000838.filter,tp,LOCATION_MZONE,0,nil)*800
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	if dam>0 then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam) end
end
function c511000838.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c511000838.filter,tp,LOCATION_MZONE,0,nil)*800
	Duel.Damage(p,dam,REASON_EFFECT)
end
