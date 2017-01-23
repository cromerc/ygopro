--失楽園
function c100000084.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)	
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000084,2))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c100000084.drcon)
	e2:SetTarget(c100000084.drtg)
	e2:SetOperation(c100000084.drop)
	c:RegisterEffect(e2)
end
function c100000084.cfilter(c)
	return c:IsFaceup() and (c:IsCode(69890967) or c:IsCode(6007213) or c:IsCode(32491822))
end
function c100000084.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000084.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000084.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100000084.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
