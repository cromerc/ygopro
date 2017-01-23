--マスクドナイト ＬＶ７
function c100004003.initial_effect(c)
	c:EnableReviveLimit()
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100004003,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c100004003.target)
	e2:SetOperation(c100004003.operation)
	c:RegisterEffect(e2)
end
c100004003.lvupcount=1
c100004003.lvup={100004002}
c100004003.lvdncount=2
c100004003.lvdn={100004002,100004001}
function c100004003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1500)
end
function c100004003.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
