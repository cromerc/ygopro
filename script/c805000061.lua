--異次元の古戦場－サルガッソ
function c805000061.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(805000061,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c805000061.damcon)
	e2:SetTarget(c805000061.damtg)
	e2:SetOperation(c805000061.damop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(805000061,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c805000061.damcon2)
	e3:SetTarget(c805000061.damtg2)
	e3:SetOperation(c805000061.damop2)
	c:RegisterEffect(e3)
end
function c805000061.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==1 and eg:GetFirst():GetSummonType()==SUMMON_TYPE_XYZ
end
function c805000061.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if rp==tp then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,500)
	else Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500) end
end
function c805000061.damop(e,tp,eg,ep,ev,re,r,rp)
	local ex,g,gc,dp,dv=Duel.GetOperationInfo(0,CATEGORY_DAMAGE)
	Duel.Damage(dp,500,REASON_EFFECT)
end
function c805000061.damcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(Card.IsType,Duel.GetTurnPlayer(),LOCATION_MZONE,0,nil,TYPE_XYZ)>0
end
function c805000061.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(Duel.GetTurnPlayer())
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,Duel.GetTurnPlayer(),500)
end
function c805000061.damop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetMatchingGroupCount(Card.IsType,Duel.GetTurnPlayer(),LOCATION_MZONE,0,nil,TYPE_XYZ)==0 then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
