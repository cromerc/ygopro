--Iron Draw
function c511001245.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511001245.condition)
	e1:SetTarget(c511001245.target)
	e1:SetOperation(c511001245.activate)
	c:RegisterEffect(e1)
end
function c511001245.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c511001245.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c511001245.cfilter,tp,LOCATION_MZONE,0,nil)==2
end
function c511001245.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511001245.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
