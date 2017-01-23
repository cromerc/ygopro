--coded by Lyris
--Cyber Phoenix (Anime)
function c511007022.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c511007022.distg)
	c:RegisterEffect(e1)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511007022.disop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511007022,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c511007022.condition)
	e3:SetTarget(c511007022.target)
	e3:SetOperation(c511007022.operation)
	c:RegisterEffect(e3)
end
function c511007022.disfilter(c,tp,n)
	if n~=0 and not c:IsLocation(LOCATION_MZONE) then return false end
	return c:IsControler(tp) and c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c511007022.distg(e,c)
	if not e:GetHandler():IsAttackPos() then return false end
	local tc=c:GetCardTarget()
	return tc:IsExists(c511007022.disfilter,1,nil,e:GetHandlerPlayer(),0)
end
function c511007022.disop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsAttackPos() or re:IsActiveType(TYPE_MONSTER) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g then return end
	if g:IsExists(c511007022.disfilter,1,nil,tp,1) and Duel.SelectYesNo(tp,aux.Stringid(511007022,1)) then
		Duel.NegateEffect(ev)
	end
end
function c511007022.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY)
end
function c511007022.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511007022.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
