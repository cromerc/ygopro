--オーロラ・ドロー
function c100000038.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000038.ntcon)
	e1:SetTarget(c100000038.target)
	e1:SetOperation(c100000038.activate)
	c:RegisterEffect(e1)
end
function c100000038.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000038.cfilter2(c)
	return c:GetCode()==100000038
end
function c100000038.ntcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c==nil then return true end
	return Duel.IsExistingMatchingCard(c100000038.cfilter,tp,LOCATION_MZONE,0,1,nil) and (Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)==1 and Duel.IsExistingMatchingCard(c100000038.cfilter2,tp,LOCATION_HAND,0,1,nil))
	or Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)==0
end
function c100000038.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100000038.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
