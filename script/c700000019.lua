--Scripted by Eerie Code
--Abyss Script - Opening Ceremony
function c700000019.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c700000019.target)
	e1:SetOperation(c700000019.activate)
	c:RegisterEffect(e1)	
end
function c700000019.filter(c)
	return c:IsSetCard(0x10ec) and c:IsPosition(POS_FACEUP_ATTACK)
end
function c700000019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700000019.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	local rec=Duel.GetMatchingGroupCount(c700000019.filter,tp,LOCATION_MZONE,0,nil)*500
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c700000019.activate(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.GetMatchingGroupCount(c700000019.filter,tp,LOCATION_MZONE,0,nil)*500
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,rec,REASON_EFFECT)
end
