--Contingency Fee
function c511000557.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511000557.condition)
	e1:SetTarget(c511000557.target)
	e1:SetOperation(c511000557.activate)
	c:RegisterEffect(e1)
end
function c511000557.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)<6
end
function c511000557.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp) end
	Duel.SetTargetPlayer(1-tp)
	local ht=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
	local ct=6-ht
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*1000)
end
function c511000557.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ht=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
	local ct=6-ht
	if Duel.Draw(p,ct,REASON_EFFECT) then
		Duel.Recover(tp,ct*1000,REASON_EFFECT)
	end
end
