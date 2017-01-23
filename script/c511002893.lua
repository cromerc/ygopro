--Ninjitsu Art of Mosquito Combustion
function c511002893.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002893.target)
	e1:SetOperation(c511002893.activate)
	c:RegisterEffect(e1)
end
function c511002893.filter(c)
	return c:GetCounter(0x1101)>0 and c:IsFaceup()
end
function c511002893.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002893.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511002893.activate(e,tp,eg,ep,ev,re,r,rp)
	local dam1=Duel.GetMatchingGroupCount(c511002893.filter,tp,LOCATION_MZONE,0,nil)*600
	local dam2=Duel.GetMatchingGroupCount(c511002893.filter,tp,0,LOCATION_MZONE,nil)*600
	Duel.Damage(tp,dam1,REASON_EFFECT,true)
	Duel.Damage(1-tp,dam2,REASON_EFFECT,true)
	Duel.RDComplete()
end
