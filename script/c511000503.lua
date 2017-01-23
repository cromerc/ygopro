--Legacy of a HERO
function c511000503.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000503.con)
	e1:SetTarget(c511000503.target)
	e1:SetOperation(c511000503.activate)
	c:RegisterEffect(e1)
end
function c511000503.filter(c)
	return c:GetLevel()>=4 and c:IsSetCard(0x8)
end
function c511000503.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000503.filter,tp,LOCATION_GRAVE,0,5,nil)
end
function c511000503.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c511000503.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
