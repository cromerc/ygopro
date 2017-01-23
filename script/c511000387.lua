--The Body's Hidden Mantra
function c511000387.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000387.condition)
	e1:SetTarget(c511000387.target)
	e1:SetOperation(c511000387.activate)
	c:RegisterEffect(e1)
end
function c511000387.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000380)
end
function c511000387.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000387.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c511000387.filter(c)
	return c:IsSetCard(0x201) and c:IsType(TYPE_MONSTER)
end
function c511000387.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c511000387.filter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000387.filter,tp,LOCATION_GRAVE,0,1,nil) 
	and Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c511000387.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
