--Damaging Hand
function c511002556.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c511002556.condition)
	e1:SetTarget(c511002556.target)
	e1:SetOperation(c511002556.activate)
	c:RegisterEffect(e1)
end
function c511002556.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(ep,LOCATION_MZONE,0)==0
end
function c511002556.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)*300)
end
function c511002556.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,Duel.GetFieldGroupCount(p,LOCATION_HAND,0)*300,REASON_EFFECT)
end
