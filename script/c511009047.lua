--Performapal Lizardraw (anime)
function c511009047.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009047.target)
	e2:SetOperation(c511009047.activate)
	c:RegisterEffect(e2)
	--drawp
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009047.drcon)
	e2:SetTarget(c511009047.drtg)
	e2:SetOperation(c511009047.drop)
	c:RegisterEffect(e2)
end
function c511009047.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511009047.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end


function c511009047.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
end
function c511009047.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009047.cfilter,1,nil,tp)
end
function c511009047.cfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c511009047.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	local ct=Duel.GetMatchingGroupCount(c511009047.cfilter2,tp,LOCATION_MZONE,0,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct)
end
function c511009047.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
