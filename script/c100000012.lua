--虚无械アイン
function c100000012.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c100000012.target)
	c:RegisterEffect(e1)
	--to Grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(c100000012.drcost)
	e2:SetTarget(c100000012.drtg)
	e2:SetOperation(c100000012.drop)
	c:RegisterEffect(e2)
end
function c100000012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c100000012.drcost(e,tp,eg,ep,ev,re,r,rp,0) and c100000012.drtg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		e:SetCategory(CATEGORY_DRAW)
		e:SetOperation(c100000012.drop)
		e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		c100000012.drcost(e,tp,eg,ep,ev,re,r,rp,1)
		c100000012.drtg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c100000012.cfilter(c)
	return (c:IsSetCard(0x4a) or c:IsCode(74530899) or c:IsCode(8967776)) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c100000012.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000012.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c100000012.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c100000012.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and e:GetHandler():GetFlagEffect(100000012)==0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	e:GetHandler():RegisterFlagEffect(100000012,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c100000012.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
