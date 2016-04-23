--ドリームランド
function c5803.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,5803)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(5803,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c5803.drcon)
	e2:SetTarget(c5803.drtg)
	e2:SetOperation(c5803.drop)
	c:RegisterEffect(e2)
	--lv
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(5803,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c5803.lvcon)
	e3:SetTarget(c5803.lvtg)
	e3:SetOperation(c5803.lvop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(5803,2))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetCountLimit(1)
	e5:SetCondition(c5803.descon)
	e5:SetTarget(c5803.destg)
	e5:SetOperation(c5803.desop)
	c:RegisterEffect(e5)
end
function c5803.cfilter(c,type)
	return c:IsFaceup() and c:IsType(type)
end
function c5803.drcfilter()
	return c:IsPreviousLocation(LOCATION_HAND+LOCATION_MZONE) and c:IsType(TYPE_MONSTER) and c:IsReason(REASON_EFFECT)
end
function c5803.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5803.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_FUSION)
		and eg:IsExists(c5803.drcfilter,1,nil)
end
function c5803.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c5803.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c5803.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5803.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_SYNCHRO)
end
function c5803.lvfilter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c5803.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c5803.lvfilter,1,nil) end
	Duel.SetTargetCard(eg)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c5803.lvop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c5803.lvfilter,nil):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c5803.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5803.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_XYZ)
		and Duel.GetTurnPlayer()==tp
end
function c5803.desfilter(c,lv)
	return c:IsFaceup() and c:GetLevel()==lv and c:GetLevel()>0 and c:IsDestructable()
end
function c5803.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g,lv=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil):GetMaxGroup(Card.GetLevel)
	local dg=Duel.GetMatchingGroup(c5803.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,lv)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c5803.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g,lv=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil):GetMaxGroup(Card.GetLevel)
	local dg=Duel.GetMatchingGroup(c5803.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,lv)
	if dg:GetCount()>0 then
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
