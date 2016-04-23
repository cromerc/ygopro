--エクシーズ・チェンジ・タクティクス
function c101000005.initial_effect(c)
	c:SetUniqueOnField(1,0,101000005)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101000005,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c101000005.drcon)
	e2:SetTarget(c101000005.drtg)
	e2:SetOperation(c101000005.drop)
	c:RegisterEffect(e2)
end
function c101000005.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return tg:IsSetCard(0x7f) and tg:GetSummonType()==SUMMON_TYPE_XYZ
	and tg:IsControler(tp)
end
function c101000005.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
	and Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c101000005.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end