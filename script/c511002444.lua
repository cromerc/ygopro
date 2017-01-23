--ゴーゴンの眼
function c511002444.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Defense...
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsDefensePos))
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetProperty(0)
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_TRIGGER)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(48009503,0))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511002444.damcon)
	e5:SetTarget(c511002444.damtg)
	e5:SetOperation(c511002444.damop)
	c:RegisterEffect(e5)
end
function c511002444.filter(c,tp)
	return c:GetPreviousControler()==1-tp and c:IsPreviousPosition(POS_DEFENSE)
end
function c511002444.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002444.filter,1,nil,tp)
end
function c511002444.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c511002444.filter,nil,tp)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(g:GetSum(Card.GetDefense)/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetSum(Card.GetDefense)/2)
end
function c511002444.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
