--時械神 ラツィオン
function c513000041.initial_effect(c)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCondition(c513000041.damcon)
	e5:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e5)
	--s/t to deck
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetDescription(aux.Stringid(513000003,0))
	e6:SetCode(EVENT_BATTLED)
	e6:SetTarget(c513000041.tg)
	e6:SetOperation(c513000041.op)
	c:RegisterEffect(e6)
	--to deck
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(512000003,2))
	e7:SetCategory(CATEGORY_TODECK)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e7:SetProperty(EFFECT_FLAG_REPEAT)
	e7:SetCountLimit(1)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c513000041.tdcon)
	e7:SetTarget(c513000041.tdtg)
	e7:SetOperation(c513000041.tdop)
	c:RegisterEffect(e7)
	--damage
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_DAMAGE)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EVENT_DRAW)
	e8:SetCondition(c513000041.drcon)
	e8:SetTarget(c513000041.drtg)
	e8:SetOperation(c513000041.drop)
	c:RegisterEffect(e8)
	--disable summon
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetTargetRange(1,0)
	e9:SetTarget(c513000041.sumlimit)
	c:RegisterEffect(e9)
end
function c513000041.damcon(e)
	return e:GetHandler():IsAttackPos()
end
function c513000041.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_MZONE+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c513000041.op(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_MZONE+LOCATION_GRAVE,nil)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
end
function c513000041.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c513000041.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c513000041.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:IsAbleToDeck() then
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	end
end
function c513000041.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_DRAW
end
function c513000041.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c513000041.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c513000041.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not se:GetHandler():IsCode(100000013) and not se:GetHandler():IsCode(100000014)
end
