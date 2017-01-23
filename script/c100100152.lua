--スピード・エッジ
function c100100152.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetCondition(c100100152.condition)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c100100152.condition2)
	e2:SetTarget(c100100152.damtg)
	e2:SetOperation(c100100152.damop)
	c:RegisterEffect(e2)
end
function c100100152.afilter(c)
	return c:IsFaceup() and c:GetCode()==100100152
end
function c100100152.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c100100152.afilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c100100152.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100100152.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldCard(tp,LOCATION_SZONE,5) and 
		Duel.GetFieldCard(1-tp,LOCATION_SZONE,5) end
	local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,5):GetCounter(0x91)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5):GetCounter(0x91)
	local dam=0
	Duel.SetTargetPlayer(1-tp)
	if tc1>tc2 then dam=(tc1-tc2)*200
	else return end
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c100100152.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
